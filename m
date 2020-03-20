Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA26C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7B920A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCTWEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:04:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgCTWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:04:13 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFPk2-0004TV-5V; Fri, 20 Mar 2020 23:03:46 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9E74CFFC8D;
        Fri, 20 Mar 2020 23:03:45 +0100 (CET)
Message-Id: <20200320180032.799569116@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 19:00:00 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [RESEND][patch V3 04/23] kprobes: Prevent probes in .noinstr.text section
References: <20200320175956.033706968@linutronix.de>
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
Message-ID: <20200320180000.yPE36zypOEVUzd0NDpyxTLS7XhMHNWPpb-WKVsrDwXA@z>

Instrumentation is forbidden in the .noinstr.text section. Make kprobes
respect this.

This lacks support for .noinstr.text sections in modules, which is required
to handle VMX and SVM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/kprobes.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1443,10 +1443,21 @@ static bool __within_kprobe_blacklist(un
 	return false;
 }
 
+/* Functions in .noinstr.text must not be probed */
+static bool within_noinstr_text(unsigned long addr)
+{
+	/* FIXME: Handle module .noinstr.text */
+	return addr >= (unsigned long)__noinstr_text_start &&
+	       addr < (unsigned long)__noinstr_text_end;
+}
+
 bool within_kprobe_blacklist(unsigned long addr)
 {
 	char symname[KSYM_NAME_LEN], *p;
 
+	if (within_noinstr_text(addr))
+		return true;
+
 	if (__within_kprobe_blacklist(addr))
 		return true;
 

