Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDB4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218AD2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVcobcRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHYTLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:11:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A60C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:11:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so15069670ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqg/AVsJ1oT2dhhuL1pGToPQlBX2/1COi4hiuERTnjA=;
        b=kVcobcRSSbSwtArpkequCFg/jJ8T8FsgtVMPimpf6wOhWqq2/Hr5kRE1Yg6BwYr0UA
         u7ysR2Efssagz6ZUOk0bL32r4e+n7hetOE99CvYwOGifEqDmV77B0i0ujKWezdmds8ec
         S+Vm+7O3HyyI0CFW88D2upgwbRZL92pXrqclUJMcxNhmXAzNBwQ05/dxoHRvgLicg1Xr
         PtYw651eXyLcjWYvXHNNqa+aw2OZzurp/+y4ddaFVKkn5Qda8IB4W/JBwPUZV7AYoVfe
         djrTzvHgMN0SDBrc3ft5i+Bumjr8XezO69qr5rk98ZjjCy3guO17BPMnhGyZS+zWBcl+
         s0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqg/AVsJ1oT2dhhuL1pGToPQlBX2/1COi4hiuERTnjA=;
        b=UCoDs+1K1FDm0flF9aezqeSPDNI0fEfLCwRpjW7kg5TIWOhJHIadSpUHTL5emlfTd5
         mH24tw355uikQ586S1pvGWbrTD0xuTSLG83yEplg4TGg6hJaoyp+NvXwQ9wBGxZzkWoe
         bE4XbrtBcfzijDZogONy1rN754kl5GW0a785KXc+XJliMIDyOuzxtaKSBlqQw/HdthuQ
         2IwtIiSxw2TcQcsNvuwwx0SlbNjMRFh0RhoYVVZq2SdoOOHpJNC1a0OMExCn7+5nfPZ1
         fG9w3gcsehcOBHbQeY8OrVWxOqd9u9XHKz40gk+rOc75Zv1MmXWpb4Da6ZZAOz2LbcLE
         6OLw==
X-Gm-Message-State: AOAM53192BcDMa5IL+7p3uAU+DBXAr85gVzgD4SDhdRRGXOPyR1QlXrL
        vF2MLldwr/8CLmRXQh3jwEMgjoK1xFBPwg==
X-Google-Smtp-Source: ABdhPJz+OTacs8Xwj814WKp5+Cw9J+NxKBiS1siquss8/CzHeiONjrJOKY1MqArLFW8bS5WLf28ZEA==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr5742369lji.83.1598382690090;
        Tue, 25 Aug 2020 12:11:30 -0700 (PDT)
Received: from nero.bb.dnainternet.fi (dyn9cmyyyyyyyyyyyyyft-3.rev.dnainternet.fi. [2001:14ba:2fa:2500::9])
        by smtp.gmail.com with ESMTPSA id q20sm3016553ljj.42.2020.08.25.12.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:11:29 -0700 (PDT)
From:   Pekka Enberg <penberg@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Enberg <penberg@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH] x86/mm/fault: Inline page fault paths to reduce kernel text size
Date:   Tue, 25 Aug 2020 22:11:26 +0300
Message-Id: <20200825191126.289713-1-penberg@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@kernel.org>

The commit 92181f190b649f7ef2b79cbf5c00f26ccc66da2a ("x86: optimise
x86's do_page_fault (C entry point for the page fault path)") from 2009
shows significant stack savings when infrequent page fault handling
paths are moved out of line with the "noinline" annotation, with some increase
in kernel text size.

However, a decade of GCC improvements (and changes in the code) has
eliminated such wins in stack usage:

With "noinline":

0000000000000b30 <do_user_addr_fault>:
     b30:       41 57                   push   %r15
     b32:       41 56                   push   %r14
     b34:       41 55                   push   %r13
     b36:       49 89 d5                mov    %rdx,%r13
     b39:       41 54                   push   %r12
     b3b:       49 89 fc                mov    %rdi,%r12
     b3e:       55                      push   %rbp
     b3f:       48 89 f5                mov    %rsi,%rbp
     b42:       53                      push   %rbx
     b43:       65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
     b4a:       00 00
     b4c:       48 83 ec 18             sub    $0x18,%rsp

With "inline":

00000000000008a0 <do_user_addr_fault>:
     8a0:       41 57                   push   %r15
     8a2:       41 56                   push   %r14
     8a4:       41 55                   push   %r13
     8a6:       49 89 d5                mov    %rdx,%r13
     8a9:       41 54                   push   %r12
     8ab:       49 89 fc                mov    %rdi,%r12
     8ae:       55                      push   %rbp
     8af:       48 89 f5                mov    %rsi,%rbp
     8b2:       53                      push   %rbx
     8b3:       65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
     8ba:       00 00
     8bc:       48 83 ec 18             sub    $0x18,%rsp

So all we're left with is the increase in kernel text:

  add/remove: 1/5 grow/shrink: 2/1 up/down: 1049/-1144 (-95)
  Function                                     old     new   delta
  spurious_kernel_fault.part                     -     559    +559
  do_user_addr_fault                           988    1446    +458
  do_kern_addr_fault                           103     135     +32
  bad_area_nosemaphore                          13       -     -13
  bad_area                                      66       -     -66
  pgtable_bad                                  107       -    -107
  mm_fault_error                               199       -    -199
  bad_area_access_error                        226       -    -226
  spurious_kernel_fault                        553      20    -533
  Total: Before=7359, After=7264, chg -1.29%

Therefore, let's inline the page fault handling paths to reduce kernel
text size.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 arch/x86/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498e9832..b8893684d80c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -533,7 +533,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 	dump_pagetable(address);
 }
 
-static noinline void
+static inline void
 pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	    unsigned long address)
 {
@@ -577,7 +577,7 @@ static void set_signal_archinfo(unsigned long address,
 	tsk->thread.cr2 = address;
 }
 
-static noinline void
+static inline void
 no_context(struct pt_regs *regs, unsigned long error_code,
 	   unsigned long address, int signal, int si_code)
 {
@@ -788,7 +788,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	no_context(regs, error_code, address, SIGSEGV, si_code);
 }
 
-static noinline void
+static inline void
 bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		     unsigned long address)
 {
@@ -809,7 +809,7 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
 }
 
-static noinline void
+static inline void
 bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
 	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
@@ -832,7 +832,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 	return false;
 }
 
-static noinline void
+static inline void
 bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 		      unsigned long address, struct vm_area_struct *vma)
 {
@@ -905,7 +905,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-static noinline void
+static inline void
 mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	       unsigned long address, vm_fault_t fault)
 {
@@ -971,7 +971,7 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
  * See Intel Developer's Manual Vol 3 Section 4.10.4.3, bullet 3
  * (Optional Invalidation).
  */
-static noinline int
+static inline int
 spurious_kernel_fault(unsigned long error_code, unsigned long address)
 {
 	pgd_t *pgd;
-- 
2.26.2

