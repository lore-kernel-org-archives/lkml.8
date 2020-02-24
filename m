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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13AC35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA1E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD4asOnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgBXAxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:53:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45960 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:53:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so3324267pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oRM6UBdbATulHnQYcsdVIGDvoGaSAWtDaTsLfdNkwSk=;
        b=SD4asOncXpzZUWKu8pM3OL1iaBkAB7eFBXDvx4syXI+Fzkw0v3by0EuSDZt8wXqPAF
         crfkBNTX8hYdEhaqjLaSnXLlJKfDQ9nJvUUhUMrbyTr1DvKZhgiVwIq2q8Xu8c1Q/XrR
         lOcBViln2Ur7C+BfFdE0obzc0AiXzTqEjfmHJDW8SJg+7Xy71rXF1KK6uG7opqLjUc8e
         RQY3dV/N0845afjYyj2hUaNkGggFZLL8+lD7xYjAcEkk6rsHsVFs3I7Pmh5V/5uEt3n+
         ltfkQLL/9y5gqAEYbXKeQccHsCBamw6s7UAd6tIPKJp0hHgLSGWrEVO2rmAM+sADXGiS
         jqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oRM6UBdbATulHnQYcsdVIGDvoGaSAWtDaTsLfdNkwSk=;
        b=b+4U0XA+nAdKCLwPvhri9zjeHxgudQVFFq7PSpkXN9n0LuTrdS1wjKaRVl06Qrg1xN
         PIsshpMXKKlQpgv1PaShj0KqLv3L7idTWvr1fzjct4VHMMLjdCZ21e+vbPANnirwf0hA
         LGTZylFI58OJyCbpB9BnPKKMpzUE7Dho36OAm/XnpJdL7lP8EaDpO5dt7WV28GFC0P9q
         rYoLpCAZdDbDGd5LjY2V211bPKPeTuJRSHC1fpD/On3EkV+ST1ZKPs5Jv0nLztvpIfw9
         mLcRrXB3NP1JsiLKUvwg1pe6JWfgAdK19rTdFAoNd5CrVz9jyFcanz20Bg9IIs3aknYo
         3kJw==
X-Gm-Message-State: APjAAAW/q+G5qeNV86b3hxlpvFYVp6DwPb6qRwL1xUqcEED27qO3fOPA
        Z+aRS7Ekqi160bP8/XI1FZpWBKXkjLQ=
X-Google-Smtp-Source: APXvYqx+a7z8Y1LyL8WKts/CuTer3QBtkOzG1k3rgY+gEmOjfGiHKumDDZGoyXYkwEmfY3kcWrTBvQ==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr17826184pjn.59.1582505618293;
        Sun, 23 Feb 2020 16:53:38 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id r9sm10584489pfl.136.2020.02.23.16.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:53:37 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:23:36 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>,
        Brian Masney <masneyb@onstation.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 18/18] genirq: Remove setup_irq() and remove_irq()
Message-ID: <dc400fd159374a38ea69f742fb67ca5df01a7ec6.1582471508.git.afzal.mohd.ma@gmail.com>
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

Now that all the users of setup_irq() & remove_irq() has been replaced
by request_irq() & free_irq() respectively, delete them.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

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
2.25.1

