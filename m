Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D701720663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iL/tiCXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgFOKrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:47:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33814 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgFOKrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:47:21 -0400
Received: from zn.tnic (p200300ec2f063c00a9ba54d750d72537.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:a9ba:54d7:50d7:2537])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3ADD41EC035B;
        Mon, 15 Jun 2020 12:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592218040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MHpggwvr0BvKUJlLLSPpdNMqETzjB0UWRAJLzGCSE/s=;
        b=iL/tiCXidPNan8giRcIyigGQx5uElNnFHtoi8CPJqgTD1GDpCflOrn0nAU3x/BFR1MKsr9
        /FbVAxLKXMjzZ9eB8hrm/0c/bc8xDsoB5bbHqdA5bOB1ooC7cz3ft3Luc/KTbs/VQQOdaw
        5J1XrRalyY763xRL08Jx9Q9rnTD72K4=
Date:   Mon, 15 Jun 2020 12:47:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>
Subject: Re: [PATCH] x86/speculation/srbds: do not try to turn mitigation off
 when not supported
Message-ID: <20200615104713.GE14668@zn.tnic>
References: <20200609174313.2600320-1-cascardo@canonical.com>
 <20200615082858.GC14668@zn.tnic>
 <20200615102738.GZ4342@mussarela>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615102738.GZ4342@mussarela>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 07:27:38AM -0300, Thadeu Lima de Souza Cascardo wrote:
> It was booted without the microcode update. There was microcode available, but
> systems may be booted without it, thus causing warnings due to the MSR
> read/write.

Right.

> That's exactly the fix in the patch I sent, right? Do you want me to resend
> with a comment, then?

Your patch replaced

-       if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)

Thinking about this more, I think the proper thing to do is this:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b71970d2d3d..ce2931563f8f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -432,14 +432,14 @@ void update_srbds_msr(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
 
-	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
+	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED ||
+	    srbds_mitigation == SRBDS_MITIGATION_TSX_OFF)
 		return;
 
 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	switch (srbds_mitigation) {
 	case SRBDS_MITIGATION_OFF:
-	case SRBDS_MITIGATION_TSX_OFF:
 		mcu_ctrl |= RNGDS_MITG_DIS;
 		break;
 	case SRBDS_MITIGATION_FULL:
---

because looking at:

  7e5b3c267d25 ("x86/speculation: Add Special Register Buffer Data Sampling (SRBDS) mitigation")

it says:

    While it is present on all affected CPU models, the microcode mitigation
    is not needed on models that enumerate ARCH_CAPABILITIES[MDS_NO] in the
    cases where TSX is not supported or has been disabled with TSX_CTRL.

which could be also understood as "there won't be microcode for those
CPUs and thus MSR_IA32_MCU_OPT_CTRL won't be there."

Because if that is the case, then SRBDS_MITIGATION_TSX_OFF means the MSR
is not there and therefore we should not touch it.

And you've actually shown that without the microcode loaded, you
can have a system which is MDS_NO and which hasn't generated
MSR_IA32_MCU_OPT_CTRL (because the microcode is not loaded) and thus
can't touch said MSR.

Mark?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
