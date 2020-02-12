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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8940AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620A9206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnGAP8EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgBLIGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:06:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35239 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgBLIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:06:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so549844pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OwKDzqn2HiRpDvoxE1289+C8+MFagoq+3krqe4nSdpY=;
        b=mnGAP8EGsrn3qSLO+Dr/JY+kR/KeRydVkPjmhMtAT8H90XYUaRg91jgm1cjHMnsPSp
         OsrjgOhOo0WFAas+7aEuS9R6ZIQzBB/PF/VxG4zjcLiIh3LstxQvBJq/GyRejMXfr6IV
         1btksM7bP8AzpmzDAPTTrnK15RQX8YkzOHqHBaVKRQPqc/75Tf11dxLrcXv/VLWkYcf3
         myIDqGPsN+wI7RYyY5ZxkPB+GJGHoV0C6g16wnE9xUcpIdIFbMXIPU+RoQL8nMSCT9Sh
         fZrzcYAcLP3thsehc4cE1XiRz20qMgBwSjNs6qWDCjjd2bex7nFbmu58PR7USEq1jW59
         7g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OwKDzqn2HiRpDvoxE1289+C8+MFagoq+3krqe4nSdpY=;
        b=my8eIU9YpKw9zKqAMmB2j2vAX1NSM48HDZN1dghejjMWT9i9Yuk4hFN2wYk65uPHJS
         PysPSP1STV03eUk+InsJBofYrbZyHx4xqGiULSML8dqX0Yv3ecMl+qi2d3U/oKtyXKGy
         Nja4rWu+1Cwdh84Yfyr7qa5S4+uqNVXYkTXG6xi1/xsFltVOIcx2p7DG62uhXeJa8tBS
         CQdVDrbuXiKDgvYskJ72lwj47j8+F0v6qTmTBU6m+zdIvJqfECf1663dx+MKExH6jPXy
         7XkyoAaFNUfYURHeLdpKxrxuq10WIIUvU7EC0J2CxLm7OBoDLP7FTimKg5wA0c+NTyzY
         90/Q==
X-Gm-Message-State: APjAAAVBEq21Jn93qXkeTnwqiRLRxKUhZaxKKhoRC5RsssvwNS2VWX6P
        hMY63UojFg3scFfmLymf096LliFhCe0=
X-Google-Smtp-Source: APXvYqxw48ECNXRtTCOHVHQ1BEdNg5YY+BnBDXZAqonr/rn6xvp8MJxbcysfwAhCzoX+sNFVClsi4g==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr23077583plt.10.1581494765881;
        Wed, 12 Feb 2020 00:06:05 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id t11sm1426390pgi.15.2020.02.12.00.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:06:05 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:36:03 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>,
        Brian Masney <masneyb@onstation.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 18/18] genirq: Remove setup_irq() and remove_irq()
Message-ID: <0570d4c790f89fa070835fbaa4a106ec07ae6b76.1581478324.git.afzal.mohd.ma@gmail.com>
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

Now that all the users of setup_irq() & remove_irq() has been replaced
by request_irq() & free_irq() respectively, delete them.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 include/linux/irq.h |  2 --
 kernel/irq/manage.c | 44 --------------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3ed5a055b5f4..29f5bad87eb3 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -560,8 +560,6 @@ enum {
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
 
 struct irqaction;
-extern int setup_irq(unsigned int irq, struct irqaction *new);
-extern void remove_irq(unsigned int irq, struct irqaction *act);
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
 extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3089a60ea8f9..aa03b64605d3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1697,34 +1697,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	return ret;
 }
 
-/**
- *	setup_irq - setup an interrupt
- *	@irq: Interrupt line to setup
- *	@act: irqaction for the interrupt
- *
- * Used to statically setup interrupts in the early boot process.
- */
-int setup_irq(unsigned int irq, struct irqaction *act)
-{
-	int retval;
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		return -EINVAL;
-
-	retval = irq_chip_pm_get(&desc->irq_data);
-	if (retval < 0)
-		return retval;
-
-	retval = __setup_irq(irq, desc, act);
-
-	if (retval)
-		irq_chip_pm_put(&desc->irq_data);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(setup_irq);
-
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1865,22 +1837,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	return action;
 }
 
-/**
- *	remove_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@act: irqaction for the interrupt
- *
- * Used to remove interrupts statically setup by the early boot process.
- */
-void remove_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc && !WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		__free_irq(desc, act->dev_id);
-}
-EXPORT_SYMBOL_GPL(remove_irq);
-
 /**
  *	free_irq - free an interrupt allocated with request_irq
  *	@irq: Interrupt line to free
-- 
2.24.1

