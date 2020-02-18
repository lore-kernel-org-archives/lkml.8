Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B2C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE622B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aD2gLUaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBRRb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:31:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRRb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:31:56 -0500
Received: from zn.tnic (p200300EC2F0C1F0014C3F76BBACA8B76.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:14c3:f76b:baca:8b76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E759B1EC0CE8;
        Tue, 18 Feb 2020 18:31:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582047114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=hZ73zgkwiCIFv2pKr7M3n6S8JUBMDjCXg5lIsGiQJTM=;
        b=aD2gLUaUS6aOiCdkfsfhp1I7wX10dRjWKc1NABLvNUD+qeP+CUV+fEH9B+LUmYnuVvu1HF
        fuG/eRNTBmpcE42kG9mWxhnZm1i9NRWrxW2VZlCTUHKSLoyCHFt5VDORHt94bvkc9pAMmf
        puzJhHj9Nhkg6Lqmd9r4l6GkUZG7wQw=
Date:   Tue, 18 Feb 2020 18:31:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] #MC mess
Message-ID: <20200218173150.GK14449@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

so Peter raised this question on IRC today, that the #MC handler needs
to disable all kinds of tracing/kprobing and etc exceptions happening
while handling an #MC. And I guess we can talk about supporting some
exceptions but #MC is usually nasty enough to not care about tracing
when former happens.

So how about this trivial first stab of using the big hammer and simply
turning off stuff? The nmi_enter()/nmi_exit() thing still needs debating
because ist_enter() already does rcu_nmi_enter() and I'm not sure
whether any of the context tracking would still be ok with that.

Anything else I'm missing? It is likely...

Thx.

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949611e4..6dff97c53310 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1214,7 +1214,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
  * MCE broadcast. However some CPUs might be broken beyond repair,
  * so be always careful when synchronizing with others.
  */
-void do_machine_check(struct pt_regs *regs, long error_code)
+void notrace do_machine_check(struct pt_regs *regs, long error_code)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1251,6 +1251,10 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	if (__mc_check_crashing_cpu(cpu))
 		return;
 
+	hw_breakpoint_disable();
+	static_key_disable(&__tracepoint_read_msr.key);
+	tracing_off();
+
 	ist_enter(regs);
 
 	this_cpu_inc(mce_exception_count);
@@ -1360,6 +1364,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	ist_exit(regs);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
+NOKPROBE_SYMBOL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
