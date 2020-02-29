Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4823C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ED0246A3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id76VelG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgB2MzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:55:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33281 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgB2MzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:55:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so2994776pgk.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=grQb0SecaP10rK9YMRSAAshJjlKnEEO50orrf8tjJlM=;
        b=Id76VelGQQeqyi/+y3LvqBVC+ZSPj7XB3mrxAtxJSvPRbHZRR5Zs8JwfYaUWdvgruN
         gnRFaQby+o3AyQ91Ydx5QD7y0BRjFtF228hVVCmpZrTCUzJVft1wiYvBWMipeHo6Qoku
         Umy+azkOGvorEn/q/bKQLYUFXohzGWQYrYhPGG9RaDuCPloPZcu4bfg2us/kQrPveo4d
         NEPF9ZWeyZywXutvZSVxXWf11T3+vifX+m3ACvnjR5bjWoyB8PBLcdePGDkxH7VRYWSd
         xjB9Zer5YAytko7SqNruDK0y/rNqrjOiKq8dGFqUymPzYvitPee9k+S6XSaxL6gIkUyH
         f7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=grQb0SecaP10rK9YMRSAAshJjlKnEEO50orrf8tjJlM=;
        b=N+HkLQXE3X2z/t+6+ozm8Mlc4mu7JXQfeeqv8dE2JHFr0lcWCXNtBUVCrQBaaJHIHv
         H1bRCQCv9cSJ2c3ualjLoc3U/GvDHwqpZm6OB3c1mq463RuK7x4iFFDkuk5/0B4GTGRg
         ULuBjvDHT2yYWQI8e7Fn84jIpvfUAqHz9XhU5QfxEzyQlnWcJ3G7LO3qGeBJyIytsQht
         /0qnOxfg10uze4EhsJ7GGYoIRnjQg3ZiuzxQGyEru2UhyvNngkg3aBzm3XY2h5RzOORF
         J5zzYe34ua/EW3ks9uRWTjPmFmN5bwrySc2Xz+51ERRC9WNKs6dD7RpHKbr8JuF1chMl
         NXmQ==
X-Gm-Message-State: APjAAAVrY3G/qoRBEp2Ke3CyCV14UhJn4Xe8Az4wYzksHduWL4ILvf0u
        TrdUjjYYou/LGASyXJwgW1A=
X-Google-Smtp-Source: APXvYqw3hy6y61ndxRLO7uim3dwdVGW2PVMzIFsjEbMw3Gs4Q0cHrlOabABc6wQXkbuFK1R4YC3/GQ==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr9351934pfi.105.1582980922912;
        Sat, 29 Feb 2020 04:55:22 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 76sm14785326pfx.97.2020.02.29.04.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 04:55:22 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] x86: Replace setup_irq() by request_irq()
Date:   Sat, 29 Feb 2020 18:25:07 +0530
Message-Id: <20200229125510.2897-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v3:
 * Instead of tree wide series, arch specific patch
 * Strip irrelevant portions & more tweaking in commit message
 * Remove name indirection in pr_err string & modify to the form
	"Failed to request irq 2 (cascade)\n"
 * Use local variable for flags to improve readability
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/x86/kernel/irqinit.c | 18 +++++++-----------
 arch/x86/kernel/time.c    | 10 +++-------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 16919a9671fa..d750178fc192 100644
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
+			pr_err("Failed to request irq 2 (cascade)\n");
+	}
 }
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index d8673d8a779b..6acc1baa4a52 100644
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
+	unsigned long flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER;
+
 	/*
 	 * Unconditionally register the legacy timer; even without legacy
 	 * PIC/PIT we need this for the HPET0 in legacy replacement mode.
 	 */
-	if (setup_irq(0, &irq0))
+	if (request_irq(0, timer_interrupt, flags, "timer", NULL))
 		pr_info("Failed to register legacy timer interrupt\n");
 }
 
-- 
2.25.1

