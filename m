Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D197AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFDD20736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588768278;
	bh=O3I3Jq8U9Mm/K4aGuDavCDPQbee/VahNNCbOqVSXyT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HXULv5aMWdd8rA31H3Y2HqscasLID8OdmJRzAQaGwoF9yg1khmAbZmKj+TV17aJXT
	 Mwdckl9pi2ouZBcy2d136YBKu5sttZoDJhiJ/VgCFk8KZ3nECpfEPeJ8JDVmE/z//G
	 FDWT5d06brP7VMH/aAlz/DnYr6KVY1GKpgZBcno8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEFMbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgEFMbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:31:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50FF206D5;
        Wed,  6 May 2020 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588768277;
        bh=O3I3Jq8U9Mm/K4aGuDavCDPQbee/VahNNCbOqVSXyT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VY2AeqrDHqC376XgYjNf+vNJ9IeFxGVRDFKHxQrDa+tmTkPjKQmXtjoTWbyQUMOF3
         thH76ZQCRBAxU2Mf2J0I6tDZSVOBhbjA2CGXsC6O+Znja2F9iXHNb7F6Jo0jC0oo81
         vmfG42QBFTaI1SVU8XWH0zt8xvaJ6AkYaxRK/FZA=
Date:   Wed, 6 May 2020 13:31:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Amit Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
Message-ID: <20200506123112.GF8043@willie-the-truck>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <20200504171741.GD1833@willie-the-truck>
 <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:32:56PM +0530, Amit Kachhap wrote:
> On 5/4/20 10:47 PM, Will Deacon wrote:
> > On Mon, Apr 27, 2020 at 11:55:01AM +0530, Amit Daniel Kachhap wrote:
> > > diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> > > index eece20d..32d5900 100644
> > > --- a/arch/arm64/include/asm/compiler.h
> > > +++ b/arch/arm64/include/asm/compiler.h
> > > @@ -19,6 +19,9 @@
> > >   #define __builtin_return_address(val)					\
> > >   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
> > > +#else  /* !CONFIG_ARM64_PTR_AUTH */
> > > +#define	ptrauth_user_pac_mask()		0ULL
> > > +#define	ptrauth_kernel_pac_mask()	0ULL
> > 
> > This doesn't look quite right to me, since you still have to take into
> > account the case where CONFIG_ARM64_PTR_AUTH=y but the feature is not
> > available at runtime:
> 
> Yes agree with you here. However the config gaurd is saving some extra
> computation for __builtin_return_address. There are some compiler
> support being added in __builtin_extract_return_address to mask the PAC.
> Hopefully that will improve this code. In the meantime let it be like this.

Does the extra computation matter? Isn't it just a couple of instructions?

Will
