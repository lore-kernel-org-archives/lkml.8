Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD5C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB97420661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYOjJ/m+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgBLIFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:05:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46024 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLIFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so649875pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FZfa1ntXH/LJudRBtNOhayVMjjFYZbRf83XEbL/qtd0=;
        b=LYOjJ/m+Ftmip5MezRU4MNIxQdV1fJuaEXlIoCSw0GzUInk8kM76L43Iilb9VU1P2a
         HTYl5XAfEFJu07YFBjkE6DIhdVjE6UDYhTbgHepAi00+Xdddgw+RE2eCdyF2jFZuJjXZ
         eTANg9AVD0rd5pE6KQvHMcp+IjXGP789SguOvfYOsml3iYTECK672BOMzQqcNbiyW2EU
         1E/zQPIo5Uh8EtfhCCLUZ2NHIX2IzYTfq9RZZuhziM1RMmJrWu2TOgIbKp/JkMtDzfrQ
         AeKWqjBuyhKspCxyXwn7P8awsAVrsDWuFH6L+4SQRELrF3fxjwEU+HHqe4L7c6JjtK+K
         PpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FZfa1ntXH/LJudRBtNOhayVMjjFYZbRf83XEbL/qtd0=;
        b=sZDG+nwpcVRJB7AQjpq708Uq5gsY1udwSRMxruj69EpfksEZag5AIg92xFu6euAKl9
         J27w4cZrKARzuSLMYxOnGcmIWsOAb3GruS0zxVqX9e/vh8nHajeP5eZ0DTOi7/lSm3mw
         gVLiMzp6ZFynLSk9YRoKTvH7GHjBmJIrlJ/5rH7+aLFOntJ/sXaYYU+Kq0HUvQH8DRAH
         YYHh+wv2ubNDtockIA+Rlh8UnXpjXDornHO5nK7Ia4XmP2LjFCCFlczOCWH2J2+XdMHZ
         +mdM9pdQXNZqxxJd68C/+wHxURMYtyAOeilvj33rf/JtBqpGvr9FmvdrGUkDHhZrr3fv
         aE0w==
X-Gm-Message-State: APjAAAVTEYAUg5+OnAbVgDqPe+NeSS6yONORTZpMtn5y/YYlCGdDdWD4
        /lPSgmJf9Eo5Vsbm/XNd3CVYlArEZGU=
X-Google-Smtp-Source: APXvYqxVlLTQIwkBZrNIFkHxbO53KW7eGPwaTRkzW0vo3BRPJTdjuWzTkZ9f0K9vyHimFTvbgM6DKQ==
X-Received: by 2002:a62:790e:: with SMTP id u14mr10834140pfc.174.1581494717874;
        Wed, 12 Feb 2020 00:05:17 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id k4sm7033045pfg.40.2020.02.12.00.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:05:17 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:35:15 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 14/18] x86: Replace setup_irq() by request_irq()
Message-ID: <a3116b3b1a03a943cd89efd57d2db32284c3a574.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/x86/kernel/irqinit.c | 18 +++++++-----------
 arch/x86/kernel/time.c    | 10 +++-------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 16919a9671fa..8147075238bf 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -44,15 +44,6 @@
  * (these are usually mapped into the 0x30-0xff vector range)
  */
 
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
 DEFINE_PER_CPU(vector_irq_t, vector_irq) = {
 	[0 ... NR_VECTORS - 1] = VECTOR_UNUSED,
 };
@@ -104,6 +95,11 @@ void __init native_init_IRQ(void)
 	idt_setup_apic_and_irq_gates();
 	lapic_assign_system_vectors();
 
-	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs())
-		setup_irq(2, &irq2);
+	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
+		/*
+		 * IRQ2 is cascade interrupt to second interrupt controller
+		 */
+		if (request_irq(2, no_action, IRQF_NO_THREAD, "cascade", NULL))
+			pr_err("request_irq() on %s failed\n", "cascade");
+	}
 }
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index d8673d8a779b..0f9cb386d71f 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -62,19 +62,15 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq0  = {
-	.handler = timer_interrupt,
-	.flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER,
-	.name = "timer"
-};
-
 static void __init setup_default_timer_irq(void)
 {
 	/*
 	 * Unconditionally register the legacy timer; even without legacy
 	 * PIC/PIT we need this for the HPET0 in legacy replacement mode.
 	 */
-	if (setup_irq(0, &irq0))
+	if (request_irq(0, timer_interrupt,
+			IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER, "timer",
+			NULL))
 		pr_info("Failed to register legacy timer interrupt\n");
 }
 
-- 
2.24.1

