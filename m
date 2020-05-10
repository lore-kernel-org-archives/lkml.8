Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB8DC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B3220731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TBIWjP52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgEJItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:49:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F7C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:49:18 -0700 (PDT)
Received: from zn.tnic (p200300EC2F286200C518754118B553FE.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:6200:c518:7541:18b5:53fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C971E1EC0295;
        Sun, 10 May 2020 10:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589100556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cJt3m43Tte7FIktTGVo2OqFin9YPSmlkRprr/ESg6qo=;
        b=TBIWjP52EboyBR1qt+2U/JYq624Wsx8uQ9JGEn0yB05PrxC+jMWxyKPJtIqDR2XNCkpcHC
        hZYBkIn3+L78iKWq1e3AYI496znRpqbt8qDmlKPhA+u7wuNx78WjdyjoZJNBJwPhdS22F0
        Iwy2LHvNF8zRUnbTErLBabpZEBL9gK4=
Date:   Sun, 10 May 2020 10:49:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 10/10] x86/fpu/xstate: Restore supervisor states for
 signal return
Message-ID: <20200510084917.GB19352@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
 <20200328164307.17497-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328164307.17497-11-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:43:07AM -0700, Yu-cheng Yu wrote:
> v3:
> - Change copy_xregs_to_kernel() to copy_supervisor_to_kernel(), which is
>   introduced in a previous patch.
> - Update commit log.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/fpu/signal.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Took Sebastian and me a while to grok the whole situation so pls add the
comments below to that patch when sending it in your next revision.

Thx.

---
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 4dad5afc938d..06e88d6ebb07 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -347,7 +347,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
-			/* Restore supervisor states */
+
+			/*
+			 * Restore supervisor states: previous context switch
+			 * etc has done XSAVES and saved the supervisor states
+			 * in the kernel buffer from which they can be restored
+			 * now.
+			 *
+			 * We cannot do a single XRSTORS here - which would
+			 * be nice - because the rest of the FPU registers are
+			 * being restored from a user buffer directly. The
+			 * single XRSTORS happens below, when the user buffer
+			 * has been copied to the kernel one.
+			 */
 			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
 			    xfeatures_mask_supervisor())
 				copy_kernel_to_xregs(&fpu->state.xsave,
@@ -369,15 +381,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	}
 
 	/*
-	 * Supervisor states are not modified by user space input.  Save
-	 * current supervisor states first.
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
 	 * not modified on context switch and that the xstate is considered
 	 * to be loaded again on return to userland (overriding last_cpu avoids
 	 * the optimisation).
 	 */
 	fpregs_lock();
+
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+
+		/*
+		 * Supervisor states are not modified by user space input. Save
+		 * current supervisor states first and invalidate the FPU regs.
+		 */
 		if (xfeatures_mask_supervisor())
 			copy_supervisor_to_kernel(&fpu->state.xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
@@ -405,6 +421,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+
 		/*
 		 * Restore previously saved supervisor xstates along with
 		 * copied-in user xstates.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
