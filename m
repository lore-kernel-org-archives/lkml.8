Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1839FC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4BA20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgEEOTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730050AbgEEOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMY-0001zI-Bf; Tue, 05 May 2020 16:15:58 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D7539FFC8D;
        Tue,  5 May 2020 16:15:57 +0200 (CEST)
Message-Id: <20200505135314.426347351@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 11/24] x86/mce: Use untraced rd/wrmsr in the MCE
 offline/crash check
References: <20200505134926.578885807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mce_check_crashing_cpu() is called right at the entry of the MCE
handler. It uses mce_rdmsr() and mce_wrmsr() which are wrappers around
rdmsr() and wrmsr() to handle the MCE error injection mechanism, which is
pointless in this context, i.e. when the MCE hits an offline CPU or the
system is already marked crashing.

The MSR access can also be traced, so use the untraceable variants. This
is also safe vs. XEN paravirt as these MSRs are not affected by XEN PV
modifications.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/mce/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1108,7 +1108,7 @@ static noinstr bool mce_check_crashing_c
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
-		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
 
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
 			if (mcgstatus & MCG_STATUS_LMCES)
@@ -1116,7 +1116,7 @@ static noinstr bool mce_check_crashing_c
 		}
 
 		if (mcgstatus & MCG_STATUS_RIPV) {
-			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+			__wrmsr(MSR_IA32_MCG_STATUS, 0, 0);
 			return true;
 		}
 	}

