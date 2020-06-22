Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA652073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgFVSq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:46:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:51786 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgFVSq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:46:59 -0400
IronPort-SDR: ff0Tlzxxgec2bOha4H8GWyCPPxqddjsoy3w4fkW3HufCsLZ8yW8krqUl+d2SSvMQg3nIa27ID5
 Plul8tRq20bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123500360"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123500360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 11:46:57 -0700
IronPort-SDR: fUvQXFGIprQ0Ie5IoxMVgI7gb9xOkbTmDVmp65OhnPgKTkd6Wj2y5BQ8h7R9GnuEt8JQAOsWqA
 X4gGKGuYg5FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="311019119"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2020 11:46:57 -0700
Received: from [10.251.30.218] (kliang2-mobl.ccr.corp.intel.com [10.251.30.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0DA20580342;
        Mon, 22 Jun 2020 11:46:54 -0700 (PDT)
Subject: Re: [PATCH 17/21] x86/fpu: Use proper mask to replace full
 instruction mask
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, yu-cheng.yu@intel.com,
        bigeasy@linutronix.de, gorcunov@gmail.com, hpa@zytor.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-18-git-send-email-kan.liang@linux.intel.com>
 <20200619193140.GI576888@hirez.programming.kicks-ass.net>
 <aa3d239b-6ffe-261e-e70a-ffd17b8b506b@linux.intel.com>
 <c95b6ade-2cc9-e065-01ab-b449dd846c50@intel.com>
 <56653932-4c11-60f9-1541-a19ea307c0a9@linux.intel.com>
 <5223f714-87eb-947e-e65c-886431cc7655@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ca901df8-5765-9483-1898-a27efb5b87a2@linux.intel.com>
Date:   Mon, 22 Jun 2020 14:46:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5223f714-87eb-947e-e65c-886431cc7655@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2020 2:05 PM, Dave Hansen wrote:
> On 6/22/20 10:47 AM, Liang, Kan wrote:
>>> I'm wondering if we should just take these copy_*regs_to_*() functions
>>> and uninline them.  Yeah, they are basically wrapping one instruction,
>>> but it might literally be the most heavyweight instruction in the
>>> whole ISA.
>> Thanks for the suggestions, but I'm not sure if I follow these methods.
>>
>> I don't think simply removing the "inline" key word for the
>> copy_xregs_to_kernel() functions would help here.
>> Do you mean exporting the copy_*regs_to_*()?
> The thing that worries me here is exporting "internal" FPU state like
> xfeatures_mask_all.  I'm much happier exporting a function with a much
> more defined purpose.
> 
> So, yes, I'm suggesting exporting the functions,*not*  the data structures.
> 

I think maybe we should just export the copy_fpregs_to_fpstate() as 
below, because
- KVM directly invokes this function. The copy_xregs_to_kernel() is 
indirectly invoked via the function. I think we should export the 
function which is directly used by other modules.
- The copy_fpregs_to_fpstate() is a bigger function with many checks. 
Uninline the function should not impact the performance.
- it's also a function. It's a safer way than exporting the "internal" 
FPU state. No one except the FPU can change the state 
intentionally/unintentionally.


diff --git a/arch/x86/include/asm/fpu/internal.h 
b/arch/x86/include/asm/fpu/internal.h
index 0388c792..d3724dc 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -411,43 +411,7 @@ static inline int copy_kernel_to_xregs_err(struct 
xregs_state *xstate, u64 mask)
  	return err;
  }

-/*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
- *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
- */
-static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
-{
-	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
-
-		/*
-		 * AVX512 state is tracked here because its use is
-		 * known to slow the max clock speed of the core.
-		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-			fpu->avx512_timestamp = jiffies;
-		return 1;
-	}
-
-	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
-		return 1;
-	}
-
-	/*
-	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
-	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
-
-	return 0;
-}
+extern int copy_fpregs_to_fpstate(struct fpu *fpu);

  static inline void __copy_kernel_to_fpregs(union fpregs_state 
*fpstate, u64 mask)
  {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 06c8189..1bb7532 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -82,6 +82,45 @@ bool irq_fpu_usable(void)
  }
  EXPORT_SYMBOL(irq_fpu_usable);

+/*
+ * These must be called with preempt disabled. Returns
+ * 'true' if the FPU state is still intact and we can
+ * keep registers active.
+ *
+ * The legacy FNSAVE instruction cleared all FPU state
+ * unconditionally, so registers are essentially destroyed.
+ * Modern FPU state can be kept in registers, if there are
+ * no pending FP exceptions.
+ */
+int copy_fpregs_to_fpstate(struct fpu *fpu)
+{
+	if (likely(use_xsave())) {
+		copy_xregs_to_kernel(&fpu->state.xsave);
+
+		/*
+		 * AVX512 state is tracked here because its use is
+		 * known to slow the max clock speed of the core.
+		 */
+		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+			fpu->avx512_timestamp = jiffies;
+		return 1;
+	}
+
+	if (likely(use_fxsr())) {
+		copy_fxregs_to_kernel(fpu);
+		return 1;
+	}
+
+	/*
+	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
+	 * so we have to mark them inactive:
+	 */
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_fpregs_to_fpstate);
+
  void kernel_fpu_begin(void)
  {
  	preempt_disable();
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9c0541d..ca20029 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -58,7 +58,6 @@ static short xsave_cpuid_features[] __initdata = {
   * XSAVE buffer, both supervisor and user xstates.
   */
  u64 xfeatures_mask_all __read_mostly;
-EXPORT_SYMBOL_GPL(xfeatures_mask_all);

  static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... 
XFEATURE_MAX - 1] = -1}; static unsigned int xstate_sizes[XFEATURE_MAX] 
  = { [ 0 ... XFEATURE_MAX - 1] = -1};
