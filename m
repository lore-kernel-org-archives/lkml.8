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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA39120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh1VM54M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgBLIEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:04:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39219 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgBLIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:04:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id 84so835411pfy.6;
        Wed, 12 Feb 2020 00:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VazWXQKFOJPYrMIALdJBICKDTFlDK0zzZf0JU/T8ZLY=;
        b=Jh1VM54MnQuEX4cbyD0qNCqDPVLqx2Tc1YXT9XptIZovAMgIxhKNQ4xpcalKAqKH5l
         qaGRjv9NS2lkkDavR5qncBYwHp6xTCViyrSa/oIcdhCJu4ZQarRYVUp+GGLIImDeSSUC
         CvgB5XkZ0DKPdht+epax8z6/KiJCWEqVATaYdzmolMvZkp90AsQVXtvBbhDUqjOte8by
         jawgd0w6c4no5qjWyKSEuNDVkUhhWTUHB/ihz55uKeZlYfgVLe9OmG3sKmYwtC8atP4a
         yG5k1i1SgqHRdTLfUn5VnCaSUfXRPXdtRr7CXqo4isTmKdonvLl97YtiRgkCBaM1XllW
         Ikjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VazWXQKFOJPYrMIALdJBICKDTFlDK0zzZf0JU/T8ZLY=;
        b=h7h2xnBQB/3UohaSzS0Ly8QbxiFAQhWB3zhyzP7/QLGxXhdAIuIifyEnOc+VNnImzy
         0mt/6qd1NHoChMxRhdpI8VHHf+uCTgkygJX3GYhU8HPilcudnK4feNJpJQeuh+405EGW
         4zkfDHN+uG51t2rQ5wV/5+BiqbY1yWO5vUpCG6KmLP6nZsn/HHXmV3y81T8cZePmEANv
         p0FqR8WF4bTXDZGN+d5N/uB7jRqO7NFTgY3xzV4R/OuZgqVZmsx2mcU2IIFPKOTwsjTT
         g9iHaccwEyR8lFTmA32V173HtzxnwCBqkc0K9E1fEzt8MDC/pQbq+rFtS8L6PXGJUqiT
         8pHQ==
X-Gm-Message-State: APjAAAWbucGZ5NeuOm3N6eE+vD72f04N0JQBEX9t5bos6Q2ESMKQTMrm
        y+NrRopqWVPUpW3aV11MABt1Vk3AlE4=
X-Google-Smtp-Source: APXvYqwwF+0KNFHXd7S6XUMM4QFhDoiuWzRxMGCtzeS0yIqpsGvGZ5cDzRVjSu8nOHHX2GmWEIg7Yg==
X-Received: by 2002:a62:e411:: with SMTP id r17mr6935100pfh.119.1581494690602;
        Wed, 12 Feb 2020 00:04:50 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id c10sm6636434pgj.49.2020.02.12.00.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:04:50 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:34:48 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/18] sh: replace setup_irq() by request_irq()
Message-ID: <557ac61def897b99d1c21164ad422a67a68003aa.1581478324.git.afzal.mohd.ma@gmail.com>
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

 arch/sh/boards/mach-cayman/irq.c | 18 ++++++------------
 arch/sh/drivers/dma/dma-pvr2.c   |  9 +++------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index 3b6ea2d99013..de65b15206a2 100644
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
+		pr_err("request_irq() on %s failed\n", "Cayman SMSC Mux");
+	if (request_irq(PCI2_IRQ, cayman_interrupt_pci2, 0, "Cayman PCI2 Mux",
+			NULL))
+		pr_err("request_irq() on %s failed\n", "Cayman PCI2 Mux");
 }
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index b5dbd1f75768..171348016995 100644
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
+		pr_err("request_irq() on %s failed\n", "pvr2 DMA handler");
 	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade");
 
 	return register_dmac(&pvr2_dma_info);
-- 
2.24.1

