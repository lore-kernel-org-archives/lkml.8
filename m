Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D3BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC5206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3aichfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgCDAsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:48:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33117 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCDAsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:48:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id m5so144290pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ry3JaErmJ9lopYlpE33S9kkyyccbBBJWwEdUZjnIcow=;
        b=O3aichfmYWKZsuPd0eojEEFvFiT4kMPBBJoq2r1P+dmBL7BxWQBIjcMDqpneAO5HFQ
         CEMBISYKvmFraXpFZRDo8kzxlcFHqB5zekjKI+SGJGdOsyBDRJhNmWr/rrv6sf1sfca2
         +A49TOLbebIIqkm8go7y+3r09bQbHKstbU6ep3XNgsnarOX/aKgT60IXmCYA3kv2CM1d
         PpAi39H6VGiRIZbQS10WUKK2L0NqYdsf+vDeY9SB0XcAPBhJ55txqpNea/Vawlx+FA88
         yfCkjN/d5a0UjocZROC7GzMQRa+ZtzV4VQJuUk9rt9Ob0pilCNwm/bCkko2w4v+f+p2a
         5whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ry3JaErmJ9lopYlpE33S9kkyyccbBBJWwEdUZjnIcow=;
        b=Ietdn34Pvqk2ip929IE+dygzBSN1M1E3HjXOPyg6Db+kLvIR7wG7aINVEgc4/I9tsw
         vLDPyhZBibjhI6ZqU8OlmouTUvs+avMiLYyTfEtNxP6fSGglcncwfWpZsEcfBYTdXnwT
         htieu/Mlc+6qrefOprHG9UKO9tzlXOpZcaTNfEhtiUuvYZoD5cHukXi+bDCtXTAcGA6R
         PKhSP2IaUmQlytgly1LOyXU5bJDy83VvcyoDI1xptthJYaKPIfAReCehokXVjMDOrp6v
         xB8fm08mtTcv4q08IMzwH49rJ9OHoO8TeWSChDw6YvXeHmR7zr3ciab34HWcr7zhgI8z
         Etgg==
X-Gm-Message-State: ANhLgQ1u/jxilYRfxi0YEqSCzuvmVl9X/kM4mw1FssznE2hn+/zMnLC6
        6HoHdke/F+Izu2k575/ccOQKNbo3
X-Google-Smtp-Source: ADFU+vt+OWRIzO2ZUuiXSacnAu+7bsnR+DofgFPwYGwG0biqrBokY7Iia+qH9F/pV8zYztzN3xLT/Q==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr145847pgi.374.1583282924708;
        Tue, 03 Mar 2020 16:48:44 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id x7sm22910947pgp.0.2020.03.03.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:48:44 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3] irqchip: Replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:18:38 +0530
Message-Id: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
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

Link to v2 & v1,
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 drivers/irqchip/irq-i8259.c   | 16 ++++++----------
 drivers/irqchip/irq-ingenic.c |  9 +++------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index d000870d9b6b..b6f6aa7b2862 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -268,15 +268,6 @@ static void init_8259A(int auto_eoi)
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
 static struct resource pic1_io_resource = {
 	.name = "pic1",
 	.start = PIC_MASTER_CMD,
@@ -311,6 +302,10 @@ static const struct irq_domain_ops i8259A_ops = {
  */
 struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 {
+	/*
+	 * PIC_CASCADE_IR is cascade interrupt to second interrupt controller
+	 */
+	int irq = I8259A_IRQ_BASE + PIC_CASCADE_IR;
 	struct irq_domain *domain;
 
 	insert_resource(&ioport_resource, &pic1_io_resource);
@@ -323,7 +318,8 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 	if (!domain)
 		panic("Failed to add i8259 IRQ domain");
 
-	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	if (request_irq(irq, no_action, IRQF_NO_THREAD, "cascade", NULL))
+		pr_err("Failed to register cascade interrupt\n");
 	register_syscore_ops(&i8259_syscore_ops);
 	return domain;
 }
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index c5589ee0dfb3..9f3da4260ca6 100644
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
@@ -130,7 +125,9 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	setup_irq(parent_irq, &intc_cascade_action);
+	if (request_irq(parent_irq, intc_cascade, 0,
+			"SoC intc cascade interrupt", NULL))
+		pr_err("Failed to register SoC intc cascade interrupt\n");
 	return 0;
 
 out_domain_remove:
-- 
2.25.1

