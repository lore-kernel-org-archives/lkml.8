Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDABAC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE712312A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgELWXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731668AbgELWXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdI4-0004b4-3X; Wed, 13 May 2020 00:22:21 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8171A100605;
        Wed, 13 May 2020 00:22:19 +0200 (CEST)
Message-Id: <20200512213809.492016025@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:00 +0200
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V5 01/38] x86/kvm/svm: Use uninstrumented wrmsrl() to restore GS
References: <20200512210059.056244513@linutronix.de>
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

On guest exit MSR_GS_BASE contains whatever the guest wrote to it and the
first action after returning from the ASM code is to set it to the host
kernel value. This uses wrmsrl() which is interesting at least.

wrmsrl() is either using native_write_msr() or the paravirt variant. The
XEN_PV code is uninteresting as nested SVM in a XEN_PV guest does not work.

But native_write_msr() can be placed out of line by the compiler especially
when paravirtualization is enabled in the kernel configuration. The
function is marked notrace, but still can be probed if
CONFIG_KPROBE_EVENTS_ON_NOTRACE is enabled.

That would be a fatal problem as kprobe events use per-CPU variables which
are GS based and would be accessed with the guest GS. Depending on the GS
value this would either explode in colorful ways or lead to completely
undebugable data corruption.

Aside of that native_write_msr() contains a tracepoint which objtool
complains about as it is invoked from the noinstr section.

As this cannot run inside a XEN_PV guest there is no point in using
wrmsrl(). Use native_wrmsrl() instead which is just a plain native WRMSR
without tracing or anything else attached.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/kvm/svm/svm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3306,7 +3306,7 @@ static noinstr void svm_vcpu_enter_exit(
 	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
 
 #ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
+	native_wrmsrl(MSR_GS_BASE, svm->host.gs_base);
 #else
 	loadsegment(fs, svm->host.fs);
 #ifndef CONFIG_X86_32_LAZY_GS

