Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC0C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D9520746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588695768;
	bh=MuVnf+TV/GNJ81ENNjRDqKXEElG+aVV1/V7k40ViqEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2i3OoIns7+GIIoJuTVsGlogBzR4lvEGmvyFvdl+vVd/PB2Q/jhGe7F9CAT8js12G8
	 PlhgTvzaZoqOH5kmxAWmO1s4WoAXFf7TfC/TjLuEa9NShCvoMtH15wPKwFNc1SmjtI
	 WJwrTxMV2hOxOLV1f2j/6Er/m9XJeFU4o6ceXFUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgEEQWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgEEQWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:22:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68A4206B9;
        Tue,  5 May 2020 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588695766;
        bh=MuVnf+TV/GNJ81ENNjRDqKXEElG+aVV1/V7k40ViqEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHPGy/ufSY83Te9rXBrxY0sFocIR3kj0FCu7j+vGP2gBRjS/iMYxkmXbNATGqnkv8
         7HB3vYiDouk4gLgFsP6esGyIFaUBY9rbPvb8Dg3pW7dbQgt+f5t/UnOzqy/hIYpW1T
         Nob8NVbvHzMBt98GhNj7aq8r8gSmBdbUGVEUkmEs=
Date:   Tue, 5 May 2020 17:22:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix psci dependency
Message-ID: <20200505162241.GH24239@willie-the-truck>
References: <20200505140820.536615-1-arnd@arndb.de>
 <20200505150421.GA23612@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505150421.GA23612@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:04:21PM +0100, Sudeep Holla wrote:
> On Tue, May 05, 2020 at 04:08:08PM +0200, Arnd Bergmann wrote:
> > When CONFIG_ARM_PSCI_FW is disabled but CONFIG_HAVE_ARM_SMCCC is enabled,
> > arm-scmi runs into a link failure:
> >
> > arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/smc.o: in function `smc_send_message':
> > smc.c:(.text+0x200): undefined reference to `arm_smccc_1_1_get_conduit'
> >
> > Use an inline helper to default to version v1.0 in the absence of psci.
> >
> 
> Thanks for fixing this. I was thinking if we can separate PSCI and SMCCC
> quickly as a fix for this but I think he needs to be discussed in detail.
> 
> I am fine with this fix as is and happy to apply to my tree if no one
> objects.
> 
> Sorry but taking this patch as opportunity to discuss how to carry the
> dependency in future. Just a proposal,
> 
> 1. Introduce a DT node for SMCCC v1.2+
> 2. The new SMCCC driver(strictly speaking library/few APIs) can probe 
>    independent of PSCI if DT node is present
> 3. Else we fallback on PSCI and detect the SMCCC version for v1.1 and
>    v1.2
> 4. Assume v1.0 if
> 	a. PSCI FEATURE returns NOT_SUPPORTED for ARM_SMCCC_VERSION_FUNC_ID
> 	b. CONFIG_ARM_PSCI{,_FW} is not defined
> 
> Mark/Will/Marc,
> 
> Any other use-case config missed above ?

Do we really gain much by separating PSCI from SMCCC? In other words, why
do we care about allowing them to be selected independently?

Will
