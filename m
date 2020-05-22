Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46379C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07930206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgEVTe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbgEVTe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:34:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C30C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:34:56 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcDQw-0003eL-4L; Fri, 22 May 2020 21:34:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7C99C100F17; Fri, 22 May 2020 21:34:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <20200521202118.796915981@linutronix.de>
References: <20200521200513.656533920@linutronix.de> <20200521202118.796915981@linutronix.de>
Date:   Fri, 22 May 2020 21:34:17 +0200
Message-ID: <87v9knrcg6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> +	.align 8
> +SYM_CODE_START(irq_entries_start)
> +    vector=FIRST_EXTERNAL_VECTOR
> +    pos = .
> +    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
> +	UNWIND_HINT_IRET_REGS
> +	.byte	0x6a, vector
> +	jmp	common_interrupt
> +	.nops (pos + 8) - .

Boris pointed out that .nops requires binutils >=2.31 ... Sigh!

The below delta patch works for the purpose.

Thanks,

        tglx

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -475,7 +475,9 @@ SYM_CODE_START(irq_entries_start)
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
-	.nops (pos + 8) - .
+	nop
+	/* Ensure that the above is 8 bytes max */
+	. = pos + 8
     pos=pos+8
     vector=vector+1
     .endr
@@ -490,7 +492,9 @@ SYM_CODE_START(spurious_entries_start)
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
-	.nops (pos + 8) - .
+	nop
+	/* Ensure that the above is 8 bytes max */
+	. = pos + 8
     pos=pos+8
     vector=vector+1
     .endr


