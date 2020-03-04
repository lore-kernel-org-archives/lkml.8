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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6720675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvMWVXFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgCDAv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:51:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52905 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgCDAv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:51:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id lt1so110361pjb.2;
        Tue, 03 Mar 2020 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lloNdMClJUSkvGhdIQ2BDntfP0IRWiqdPxWclRqCiGw=;
        b=RvMWVXFvSBYEeHr9ldSCUeTVDLSVZq2zLb5lJkMCPfhbvAnve8mbBBK6ETIJoYU/El
         aZ0eFdltzmbf+2ZhrDxZ5EPXSwV6A6oBvhu977alMLc17gGlIvf2eT+Kmmrn2nfatSCG
         Crxegw5BKcntlWzGXtmChqscDoxQiX7HOunteg8hHBVW2tH6iDJtahv/NSk9RvzJj7tv
         7JaESdmc0lZPr74DGby2AajKCpgcDDD2Z3v/LbJ79vuwl6HkJqs74u8wP4KaSe+YjQEW
         OJHB+MpRx4NqTRM99laoYugpAMhz7FosJHzSa6fz+hDJC2G6YoA9Np/kO7H/s+vdqPu9
         2qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lloNdMClJUSkvGhdIQ2BDntfP0IRWiqdPxWclRqCiGw=;
        b=e7qmoWzRKenMBE6CZy81EtUKMo1pjkLFEMB5ALvH08OerDOh0a3Avsvw3mL0bn8MPN
         rnqmXgEWIm+b8K5Hh9eWv3jBx/1EBGko5q+QBtsTfbR7pWkx5rNmEdl9jUCGNk9hj6/F
         L2uwWrAlwzdffgrlYvyjD5FpXTBxI7LJFIWxnNrY27D9I0/N7eghp5lI5y6fIcVWhwfI
         Yx+iLoW+C+khuNbjz7CI+KnXSUGAe+k8LOC/7KEb0rXiD1QE4uZa4O2sJTLJ3lX4/fy0
         7YYfckRv3B5GUUhsUwmNqrumttHguNIby9Kmx9NB+QBhjqQaSWzByVtQONYpWWj4yznu
         OTMA==
X-Gm-Message-State: ANhLgQ1ZP5sxyG0WhwOYS78LjUp14sa1IhgbY2vc9aC5VaiSMH4rqMBm
        tRaEz/xSkKDk2RwxHuumIiOcphNT
X-Google-Smtp-Source: ADFU+vsPClorgsn7Ak9F7F8JQ/7j80VJj5SsOnphgb90r20BaUoie/KqjAmU48aPRABYEPe4YRLZzQ==
X-Received: by 2002:a17:90a:328f:: with SMTP id l15mr275722pjb.55.1583283085004;
        Tue, 03 Mar 2020 16:51:25 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id y197sm27259685pfc.79.2020.03.03.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:51:24 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH v3] sh: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:21:19 +0530
Message-Id: <20200304005120.5403-1-afzal.mohd.ma@gmail.com>
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
Hi sh maintainers,

if okay w/ this change, please consider taking it thr' your tree, else please
let me know.

Regards
afzal

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

 arch/sh/boards/mach-cayman/irq.c | 18 ++++++------------
 arch/sh/drivers/dma/dma-pvr2.c   |  9 +++------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index 3b6ea2d99013..0305d0b51730 100644
--- a/arch/sh/boards/mach-cayman/irq.c
+++ b/arch/sh/boards/mach-cayman/irq.c
@@ -40,16 +40,6 @@ static irqreturn_t cayman_interrupt_pci2(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction cayman_action_smsc = {
-	.name		= "Cayman SMSC Mux",
-	.handler	= cayman_interrupt_smsc,
-};
-
-static struct irqaction cayman_action_pci2 = {
-	.name		= "Cayman PCI2 Mux",
-	.handler	= cayman_interrupt_pci2,
-};
-
 static void enable_cayman_irq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
@@ -149,6 +139,10 @@ void init_cayman_irq(void)
 	}
 
 	/* Setup the SMSC interrupt */
-	setup_irq(SMSC_IRQ, &cayman_action_smsc);
-	setup_irq(PCI2_IRQ, &cayman_action_pci2);
+	if (request_irq(SMSC_IRQ, cayman_interrupt_smsc, 0, "Cayman SMSC Mux",
+			NULL))
+		pr_err("Failed to register Cayman SMSC Mux interrupt\n");
+	if (request_irq(PCI2_IRQ, cayman_interrupt_pci2, 0, "Cayman PCI2 Mux",
+			NULL))
+		pr_err("Failed to register Cayman PCI2 Mux interrupt\n");
 }
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index b5dbd1f75768..21c347543e19 100644
--- a/arch/sh/drivers/dma/dma-pvr2.c
+++ b/arch/sh/drivers/dma/dma-pvr2.c
@@ -64,11 +64,6 @@ static int pvr2_xfer_dma(struct dma_channel *chan)
 	return 0;
 }
 
-static struct irqaction pvr2_dma_irq = {
-	.name		= "pvr2 DMA handler",
-	.handler	= pvr2_dma_interrupt,
-};
-
 static struct dma_ops pvr2_dma_ops = {
 	.request	= pvr2_request_dma,
 	.get_residue	= pvr2_get_dma_residue,
@@ -84,7 +79,9 @@ static struct dma_info pvr2_dma_info = {
 
 static int __init pvr2_dma_init(void)
 {
-	setup_irq(HW_EVENT_PVR2_DMA, &pvr2_dma_irq);
+	if (request_irq(HW_EVENT_PVR2_DMA, pvr2_dma_interrupt, 0,
+			"pvr2 DMA handler", NULL))
+		pr_err("Failed to register pvr2 DMA handler interrupt\n");
 	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade");
 
 	return register_dmac(&pvr2_dma_info);
-- 
2.25.1

