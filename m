Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D3CC35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F992067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fle8tjwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBXAw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:52:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40299 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgBXAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:52:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so4221192pgk.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txZN9KmbopBmkJvhdnoVNctn9VXaIF+Ey3OgfvgPR7Q=;
        b=fle8tjwUST5X9j1a+XqgJteR20V7X6mekReAIZZPD9M5tJ3N/SjAGPhDKj+VrEUj6h
         GW8XOL1HYWP3TxxqdMRK3NhfWrGWfk3bT+/wbeKXFML7LP8JvG78mNfbLvjPS/SFJht1
         tMkql4cE54iggSShOGFX58N1YU0mrYlkPzgEfmEZ/+QIVcAKY4n76WPkR+qvbOlnXPez
         JYcdxAF721ZOxl2SVmp6xanxEdMPv5kkxL2CfNp3/5s5qt72IN/WsvqbJ+GD9+E/KIA/
         tuta6SMAllfu6XZt4AL4MgLIikw6JrwPDlhGi3s+w0qYhSN3E343d44WOt9aQTspKEGz
         G9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txZN9KmbopBmkJvhdnoVNctn9VXaIF+Ey3OgfvgPR7Q=;
        b=IkKG4AwpZC59htCtUxjJzJzuV6ZMPO/ZVKMhjHOOXksqoISKXp9dXwP1AAycMXdV7M
         H/lJOpEQkfXEfjQvPSGGS3Pz9iW0pscY3Wva1JkD59lHoBpcPjsfO1UyBzAedeexe/MA
         wAHwNTfuex6a7bsyjOXtasK2ahHz2ylLxd4BsApR1l0kGyGu9rx8L+XM23kUNxJHETXy
         YMA8KmFTy44VmHjTDBiGpN1elnYjF0OYMpccQc8m2xJjkVmFhdt7aGYtu+5a4QENuG92
         3wYHQ/he2xE3jFLSV9Wysmq+fDx2NYUTz1bWItmTNyWkL+oedA+aWCTiLqbkJywWhOMc
         pYHg==
X-Gm-Message-State: APjAAAWlJk1yDqzv2gAV18oXGpnczFv3GpdDvpicu+A+H9Srxiadx3jT
        rB0rZzeAuWC2GfYKfQa1MpDKXwxKOck=
X-Google-Smtp-Source: APXvYqzsN6vruvmWL82OpL/6tjJXfEg75T0D8VkwlFjvcw2I0ap7XPOw55pndLRv8kdWkorHyF9gPA==
X-Received: by 2002:a63:ad0c:: with SMTP id g12mr49696757pgf.228.1582505547974;
        Sun, 23 Feb 2020 16:52:27 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id e7sm10367215pfj.114.2020.02.23.16.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:52:27 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:22:26 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 14/18] x86: Replace setup_irq() by request_irq()
Message-ID: <17f85021f6877650a5b09e0212d88323e6a30fd0.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/x86/kernel/irqinit.c | 18 +++++++-----------
 arch/x86/kernel/time.c    | 10 +++-------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 16919a9671fa..8b5ee03d3e25 100644
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
+			pr_err("%s: request_irq() failed\n", "cascade");
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
2.25.1

