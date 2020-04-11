Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ED22078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxOOHnwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgDKQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:05:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35349 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDKQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:05:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id a13so2426078pfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qaXuipGpNAwtT15Gw/73NYnzW7gSNQe0tYUSy2wwZUQ=;
        b=DxOOHnwbG3FCJus7TLzKqEH9xH4NfH32qqjnxs0mEx3nbqUHk84b//cOipjGUQZTIg
         sCH8SDgjtlc5/PLnPaT/8JuZPfdWGHCQTkSCPKrLRMbbSazk87wSV5P1y4vZjM/aYBu2
         f1ZHlX6NOmJok41bhZW4EM9w/UW5fsXvowqXjMAmS/de9ElTgaf02i0yC4uYaqU4wWTa
         3Y/OUfYKSjH40r5aABaR5FM0jD/5WTZN9uokM+LJD0EgpdGbPE7ClRqeW7S6mUh589rx
         9VfzghWR7WmMD8t2vLruLlvEL/inZaB2GQ6JxLqqGBnTNEpTjn4hZNcTpPeaTO+5vdp0
         orcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qaXuipGpNAwtT15Gw/73NYnzW7gSNQe0tYUSy2wwZUQ=;
        b=QElt9+6Bv/2+BsGW7LpwMkml8eXY+lEEk7SNrvCym0+KUy+JonbnW4wNDQinxSzNJZ
         SzLXEAJWLxBNdJjMWgcAZTDbiXPUsacMR792skTtNKIwrX8JFJnMd6btNM5hpGOdS3t+
         7fDN8CBI4IVDKReqM/LOSfKc/jJovW1k38VYX5QmOgO9StPl/u7z68VIkgXTRO3y4lRk
         6lupidZyEzG/Q40CvQum9RwtASpFYhQOyMh2bSd6+hT6WKBTw0XUcOMz08Qm08Qd10kv
         3XWgPOmhWKVhKmM2+rLT40Qb/XO1EdUATIRgvhHUl5NGzw+GFWi0dL7ecqGnoG/x3czy
         n9OA==
X-Gm-Message-State: AGi0PubJbazKQwStcS1ftXY6YLCwOfrf18bmTKmyB2bCRUpQTVvct0vA
        3pr2xXDjtXqrvglnRcRc7+I=
X-Google-Smtp-Source: APiQypI4f/U2tMxOKvTUwMkJG4iZVRdf43/PidyW7L1M7/cTNGxPgepHHY9DbXnzgJl7UmUbJjfmZQ==
X-Received: by 2002:a65:5548:: with SMTP id t8mr6664009pgr.124.1586621118602;
        Sat, 11 Apr 2020 09:05:18 -0700 (PDT)
Received: from localhost ([183.82.183.27])
        by smtp.gmail.com with ESMTPSA id y5sm4548144pfg.141.2020.04.11.09.05.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 09:05:18 -0700 (PDT)
Date:   Sat, 11 Apr 2020 21:35:16 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] genirq: Remove setup_percpu_irq() and remove_percpu_irq()
Message-ID: <3cb7a9b45dff3665920c95144de8c2eacfae9659.1586434781.git.afzal.mohd.ma@gmail.com>
References: <cover.1586434781.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586434781.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only users of setup_percpu_irq() were in MIPS, they have been converted
to use request_percpu_irq() variants. Also remove_percpu_irq() have no
users.

Hence remove setup_percpu_irq() as well as remove_percpu_irq().

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 include/linux/irq.h |  2 --
 kernel/irq/manage.c | 42 ------------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 29f5bad87eb3..156995ab5d6e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -560,8 +560,6 @@ enum {
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
 
 struct irqaction;
-extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
-extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
 extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index aa03b64605d3..22aaa6895c42 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2324,21 +2324,6 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	return NULL;
 }
 
-/**
- *	remove_percpu_irq - free a per-cpu interrupt
- *	@irq: Interrupt line to free
- *	@act: irqaction for the interrupt
- *
- * Used to remove interrupts statically setup by the early boot process.
- */
-void remove_percpu_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc && irq_settings_is_per_cpu_devid(desc))
-	    __free_percpu_irq(irq, act->percpu_dev_id);
-}
-
 /**
  *	free_percpu_irq - free an interrupt allocated with request_percpu_irq
  *	@irq: Interrupt line to free
@@ -2377,33 +2362,6 @@ void free_percpu_nmi(unsigned int irq, void __percpu *dev_id)
 	kfree(__free_percpu_irq(irq, dev_id));
 }
 
-/**
- *	setup_percpu_irq - setup a per-cpu interrupt
- *	@irq: Interrupt line to setup
- *	@act: irqaction for the interrupt
- *
- * Used to statically setup per-cpu interrupts in the early boot process.
- */
-int setup_percpu_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	int retval;
-
-	if (!desc || !irq_settings_is_per_cpu_devid(desc))
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
-
 /**
  *	__request_percpu_irq - allocate a percpu interrupt line
  *	@irq: Interrupt line to allocate
-- 
2.18.0

