Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F615C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233E220716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvT9MU4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgC0QLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:11:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33951 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0QLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:11:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so4737916pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djKR0437aV8fBKTeU6cbLJKnQcuQ5gNp6e0NZxQFdj8=;
        b=lvT9MU4pN6sHkB4AAn6KKUw6kJGwQXj2gd08QrQDsoUo6Tl1YS8oS7YHhNi8zmtCA6
         TpNe1dl0DDUuHJ+yw+vmEvNPUwnkz9dYatA5StzIkYFskzp0njNobc9nX3pfPRch7IGW
         +kjrtkjtuTUMX76Rv5PkTkRvlwZdlzWnEpBqNa55xuli4yFqfZRB0ccKOlUkbMGgU/mx
         2jcMNTmOUBFKmjADaruHRJxn/VjHjH4/evpnrKk99PE1wFYW7cLAtSG22WD5wnCcXx5S
         4Vng7IlqoNCEedS3R8HX31zhm6sm3FDLx0cAMUVKA38wefJfuBldKqbpKAKhg6Xlusx4
         R3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djKR0437aV8fBKTeU6cbLJKnQcuQ5gNp6e0NZxQFdj8=;
        b=JLq/qBaFJeBem3SOu9DDEfw5YFlNYNbyxzz+6yQvrZpgMs5izdaBL6wYYNzYr6DDuB
         q5BSXTsdsZiGA1JIcpJknASbT+lcyOCskhzSNth7M4qyo2mGJSHmav7SBnQhcQvWx6H6
         pdJ0KBS5UY5FbqTt4KGYLZSp/XIpN27nyIVsXasueCqB6aOOBMdLTBeeALiBiHpiAKRB
         1N4bql5mgbANyG3B4a23pcn5blX9FINovqUSMlRQceqjNVD7XAbtFlaSyh68F5TIBT1J
         cifZyedSiU+eDSSdS+4RKe6czodCQBRJBqNdLZV7EzSr6CXBEbK9MhUyliT/Q43EgU1g
         JHUg==
X-Gm-Message-State: ANhLgQ1mQPlSWYc2HPr9kNlf04loS9YQwsGEmXd99EKNemV94k6LNH01
        JEOHoXS2WfZUxEca3BOC7FU13sxr
X-Google-Smtp-Source: ADFU+vsBTHw3T/rclAtR5IQYxWrDQoYryg61J1cmhH6rwmB76f7CmfOQpA/6dKUm1sYPx02oXpdW3w==
X-Received: by 2002:a62:502:: with SMTP id 2mr15505779pff.324.1585325478873;
        Fri, 27 Mar 2020 09:11:18 -0700 (PDT)
Received: from localhost ([49.207.55.57])
        by smtp.gmail.com with ESMTPSA id p9sm4156700pgs.50.2020.03.27.09.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:11:18 -0700 (PDT)
Date:   Fri, 27 Mar 2020 21:41:16 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 6/6] genirq: Remove setup_irq() and remove_irq()
Message-ID: <0aa8771ada1ac8e1312f6882980c9c08bd023148.1585320721.git.afzal.mohd.ma@gmail.com>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
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

v5:
 * No change
v4-v3:
 * Non-existent
v2:
 * Add tags

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

