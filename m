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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955620873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyU1lRlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgBLIF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:05:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBLIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so650740pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRwkd5KZdgVkHY9WaSqu+jWLqpoO/HfIGrJrLlk0Vtw=;
        b=cyU1lRltzHrAtC8eblQynmola//TBb3NrNAcFcM74ktC6yz5vxdA2boBqC9Jm8vIYO
         tK5ae6Os2q0V/B0z96vY6EN1N4j0URbyAX8VDzoLdzIFgBMA/NivKOmxvbgk6w/wGdjj
         qpby4HgGPQFBY58ZsekSf1JF3S+7VN9skVFcs1bPCT8QH5jp307U8NkIesP1/3lyY1zC
         NGMaYrw/PhcWyXMXUkYvSo0Rd8ns5hZE30QoiDiDg7mPN1zKIVF/IcflbgSp6QFcrKYO
         x3MIe7hBXNY9/MhyiNy5U1eYyivTC5yGunaRO95Vx2Lle0R3z9D53QJ/R7XhTJ+TRN8v
         BaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRwkd5KZdgVkHY9WaSqu+jWLqpoO/HfIGrJrLlk0Vtw=;
        b=Zd0y1SVe04lMj4bwtPfQ1QsZP3nhMoHrl8eNgggf9vzU5q7o0aPNxA8a6szIH5GOFQ
         TK4TfiWmqd09vFsm/RYY5DOnKwWZR2CvZ9hfk0SIZFWf6uKYf+cPgebB6sRBtfEYfu3Y
         ewGa7wizQRAJMjqFrrO9DAehkG8apwtLHeslLYAVRjnWawHotw6IelAdxzQ7d3Rrt3zE
         Co8pVS6KJ0vTKv6MeHLN6+EXVsKsEOjz+vRWlDR3ly/x64C3MQUX8eUkdDODAs+QbmXr
         eVhLxZfv6VtWHjVl9AX/eZU1uesYmGkR8M8rnPom9e26cYp1UW79UMBOx0fsa1zuql6j
         H87g==
X-Gm-Message-State: APjAAAX9NIBcSw40OPVeJ9ZS2I3J+aWLRdOC9joAg9IOSLkhHURPycUY
        PMpnpNG/ofQAx9CaKhf/dpp4EU3S86Y=
X-Google-Smtp-Source: APXvYqwZX49pycZgp0y4ivjdw8SJjAzApQa2D1m4MIYlZ6ItB2Ou8JxEw/Nn9/W7GMl+C1hogmXLlg==
X-Received: by 2002:a63:d44e:: with SMTP id i14mr7449334pgj.417.1581494755638;
        Wed, 12 Feb 2020 00:05:55 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id r145sm7298586pfr.5.2020.02.12.00.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:05:55 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:35:53 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 17/18] irqchip: Replace setup_irq() by request_irq()
Message-ID: <8e00874d072f32496c2d0da05423bda1cadd6975.1581478324.git.afzal.mohd.ma@gmail.com>
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

 drivers/irqchip/irq-i8259.c   |  9 +++------
 drivers/irqchip/irq-ingenic.c | 11 +++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index d000870d9b6b..e9798d02b256 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -271,11 +271,6 @@ static void init_8259A(int auto_eoi)
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
 
 static struct resource pic1_io_resource = {
 	.name = "pic1",
@@ -323,7 +318,9 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 	if (!domain)
 		panic("Failed to add i8259 IRQ domain");
 
-	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	if (request_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, no_action,
+			IRQF_NO_THREAD, "cascade", NULL))
+		pr_err("request_irq() on %s failed\n", "cascade");
 	register_syscore_ops(&i8259_syscore_ops);
 	return domain;
 }
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index c5589ee0dfb3..5b20a0f0ece8 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -58,11 +58,6 @@ static irqreturn_t intc_cascade(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction intc_cascade_action = {
-	.handler = intc_cascade,
-	.name = "SoC intc cascade interrupt",
-};
-
 static int __init ingenic_intc_of_init(struct device_node *node,
 				       unsigned num_chips)
 {
@@ -130,7 +125,11 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	setup_irq(parent_irq, &intc_cascade_action);
+	if (request_irq(parent_irq, intc_cascade, 0,
+			"SoC intc cascade interrupt", NULL)) {
+		pr_err("request_irq() on %s failed\n",
+		       "SoC intc cascade interrupt");
+	}
 	return 0;
 
 out_domain_remove:
-- 
2.24.1

