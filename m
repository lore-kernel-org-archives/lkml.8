Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568D02065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgEOJSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:18:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgEOJSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:18:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BE5B2F;
        Fri, 15 May 2020 02:18:20 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5222B3F71E;
        Fri, 15 May 2020 02:18:17 -0700 (PDT)
Date:   Fri, 15 May 2020 10:16:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, harb@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, steven.price@arm.com,
        will@kernel.org
Subject: Re: [PATCH v3 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
Message-ID: <20200515091612.GA23671@bogus>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200515075032.5325-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515075032.5325-1-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:50:32AM +0200, Etienne Carriere wrote:
> > From: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Hi,
> >
> > This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
> > This doesn't add other changes added in SMCCC v1.2 yet. They will
> > follow these soon along with its first user SPCI/PSA-FF.
> >
> > This is tested using upstream TF-A + the patch[2] fixing the original
> > implementation there.
> >
> >
> > v1[0]->v2[1]:
> > - Incorporated comments from Steven Price in patch 5/5
> > - Fixed build for CONFIG_PSCI_FW=n on some arm32 platforms
> > - Added Steven Price's review tags
> >
> > v2[1]->v3:
> > - Incorporated additional comments from Steven Price in patch 5/5
> >  and added his review tags
> > - Refactored SMCCC code from PSCI and moved it under
> >  drivers/firmware/smccc/smccc.c
> > - Also moved soc_id.c under drivers/firmware/smccc
> >
> > Regards,
> > Sudeep
> 
> Hello Sudeep,
> 
> In case it helps. I have successfully tested the 7 patches series
> on some platforms, playing a bit with few configurations.
> Qemu emulator for arm64/cortex-a57 with TF-A (v2.x) as secure firmware.
> Qemu emulator for arm/cortex-a15. OP-TEE (v3.x) as secure firmware.
> A stm32mp15 device (arm/cortex-a7), tested both TF-A (v2.x) and
> OP-TEE (3.7.0, 3.9.0-rc) as runtime secure firmware.
> 
> Helper functions arm_smccc_1_1_get_conduit()/arm_smccc_1_1_invoke() 
> works as expected AFAICT. No regression seen with older secure
> firmwares.
> 
> For the patches 1 to 6, as I poorly tested [v3,7/7] soc ids,
> based on tag next-20200505 [1]:
> Tested-by: Etienne Carriere <etienne.carriere@st.com>
> Reviewed-by: Etienne Carriere <etienne.carriere@st.com>
> 
> For [v3,7/7] firmware: smccc: Add ARCH_SOC_ID support
> Acked-by: Etienne Carriere <etienne.carriere@st.com>
> 
> [1] 7def1ef0f72c ("Add linux-next specific files for 20200505")
> 

Thanks for review and testing Etienne. Much appreciated!

-- 
Regards,
Sudeep
