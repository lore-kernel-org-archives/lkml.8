Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC3EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7DB207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lkl3brpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgFRTCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgFRTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:02:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531F2C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HqWhugkNcuHTkcVoxACwIvltwDirOkNSFlB5IbsYt2c=; b=lkl3brply6htcKMLsnHAmGjKo5
        Y43LdJ1K7R4ymOm0L56Mda4Gn8SYEdraTHRwdo3v2N2sEY4leUDGkbs+Pw6o2w+TKA/vfmeM4JQ8D
        hIuCkuAYbrUV6UUi9I2d1DtE1mXOWRLfR1fPsQEbsdhPcIm3fOejnDsQ7SrN69vabdAiwsnSNlhkg
        AOeomP04WOCIfB0Os04tkz563nKL3V8d1uyDfc16cf844gOyQPEbBIWwAad7vp9GDSe6Qlx1ypkYN
        pIGCCC7jg4iE5wLp63xmuy8hX7caqT+Q3tjDdTS50woHrBAdAc57jEq9VU86NOq5jEm42+zF7y0zW
        yiVUL8lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlznd-000331-IQ; Thu, 18 Jun 2020 19:02:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EF90301A32;
        Thu, 18 Jun 2020 21:02:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F66C21288468; Thu, 18 Jun 2020 21:02:07 +0200 (CEST)
Date:   Thu, 18 Jun 2020 21:02:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
Message-ID: <20200618190207.GO576905@hirez.programming.kicks-ass.net>
References: <20200618144801.642309720@infradead.org>
 <70455B9B-0952-4E03-B2CE-EEAE1E110C5B@amacapital.net>
 <20200618155017.GK576905@hirez.programming.kicks-ass.net>
 <CALCETrWvrmuuTqZzhGswsFSCWxO3tuVBiJ+M4a=Negqwo1dyNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWvrmuuTqZzhGswsFSCWxO3tuVBiJ+M4a=Negqwo1dyNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:36:53AM -0700, Andy Lutomirski wrote:

> I wasn't imagining going far down the rabbit hole at all -- I think
> that, at most, we should cover the path for when the fault wasn't a
> BUG/WARN in the first place.  I admit that, for #UD in particular,
> this isn't a big deal, but if it were a different vector, this could
> matter.

Right, so there's 3 cases for ud2:

 - WARN;  ud2,  bug_entry, recovers
 - BUG;   ud2,  bug_entry, dies
 - UBSAN; ud2, !bug_entry, dies

Nothing else should be generating ud2 instructions, any other #UD goes
into handle_invalid_op() -> do_error_trap() -> ... -> die().

[ while there, we should probably restructure do_trap() to have
  cond_local_irq_enable() _after_ do_trap_no_signal(). ]

We could probably change is_valid_bugaddr() to not use
probe_kernel_address(), because if it couldn't read the instruction,
we'd not be getting #UD in the first place.

If we've gotten rid of probe_kernel_address() we can noinstr/inline that
and then we can only call into report_bug() IFF ud2.

Does that make things 'better' ? This can only go realy bad if there's a
1 byte instruction that triggers #UD, but I think that was ruled out.


---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c26751e303f1..275a621f1aff 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -91,10 +91,7 @@ int is_valid_bugaddr(unsigned long addr)
 	if (addr < TASK_SIZE_MAX)
 		return 0;
 
-	if (probe_kernel_address((unsigned short *)addr, ud))
-		return 0;
-
-	return ud == INSN_UD0 || ud == INSN_UD2;
+	return *(unsigned short *)addr == INSN_UD2;
 }
 
 static nokprobe_inline int
@@ -220,15 +217,17 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
 
-	/*
-	 * All lies, just get the WARN/BUG out.
-	 */
-	instrumentation_begin();
-	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
-		regs->ip += LEN_UD2;
-		handled = true;
+	if (is_valid_bugaddr(regs->ip)) {
+		/*
+		 * All lies, just get the WARN/BUG out.
+		 */
+		instrumentation_begin();
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += LEN_UD2;
+			handled = true;
+		}
+		instrumentation_end();
 	}
-	instrumentation_end();
 
 	return handled;
 }
