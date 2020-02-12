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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DA4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B9420661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCjeNWLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgBLIEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:04:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37941 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgBLIEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:04:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so542300pjz.3;
        Wed, 12 Feb 2020 00:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zuDNKH5NHt/i5nd0z3Pcz2o0VZtvfQqEQkILfY6Q8DY=;
        b=dCjeNWLtgR4h2tDSrDBiR6MfWAAAlRbx8lVVjJqMl3KWeT3IN9WOJBLTtYs21f7Rvz
         jVdygF5K1YGdQ7KMVGy2N+/U1WUn3uZtd3Fg/jBkK2MOa/uSP9lpV50wTAsdwS96IQGa
         MOTRROOPa6VjOTrKzgBI0uKC2Raar0zbOntQxKWh/KJm5uWXW1c/IsgqxrUKg9tJSqut
         Z0VQhNcwyQ8bSN2zhIYirbXkk1NKo6YSKe6PNWET5mIXDfpLYbauR/M4Smnac24MH4ty
         DS2JUV/SUWS3AuDzjyt3uAHoOpP6Ez4iGNxbKOV/Vdgn8QtGy3w6mzpn9BOejcblxXQT
         mbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zuDNKH5NHt/i5nd0z3Pcz2o0VZtvfQqEQkILfY6Q8DY=;
        b=DJFenv3UQANj8wWvPA1qr+20ACELXXNSfS9KOTlCfvviG9aG2FjETwlYII1WkqxrhI
         /JPyvnD3v2U8iiXQGo2JW6lR0cGzQsPyxYJy1WlhRKl3B1JiMwktnZjP8Qqy7Y9B5WDy
         Wu5qsImStWz6DPZe+L3sgQIAzE6/HckaDTHcKKQdZ1yaI6EzFnNK4UBECPKptlh5M/Fz
         iiZO7aNVuzJdB895q7SyHD+sa16jl93uMlxHCExpuxCOxu2+jYlNk4EEAAH92DIyP8SY
         tzUtWrbRbAEPAk9yI+VgzMIEzId+IkYZ64ZaSPigFcln9MidNvaV5+5nkfAuW1BR7h8u
         YUZA==
X-Gm-Message-State: APjAAAWSqprT1J3UxKtGVW0odpgicdhrcBITmV1lDcDx/RUpkJh1ahLm
        L5LL0KoZE0B9Hs2z1oRcK/POjhbNG+o=
X-Google-Smtp-Source: APXvYqxBonpb9HwbQnG/rIa/EHjfEzZfVBfto5KwMVrGHcxv8qqE5WwXZg2yOqxrU3NWqDOfrx/slA==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr8656701pjv.142.1581494679235;
        Wed, 12 Feb 2020 00:04:39 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id i64sm6749888pgc.51.2020.02.12.00.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:04:38 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:34:37 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/18] s390: replace setup_irq() by request_irq()
Message-ID: <30f6d47f87ec794ea3fb91387d43d19016fa10bc.1581478324.git.afzal.mohd.ma@gmail.com>
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

 arch/s390/kernel/irq.c  | 8 ++------
 drivers/s390/cio/airq.c | 8 ++------
 drivers/s390/cio/cio.c  | 8 ++------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 8371855042dc..6dd90e8d4e3a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -294,11 +294,6 @@ static irqreturn_t do_ext_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction external_interrupt = {
-	.name	 = "EXT",
-	.handler = do_ext_interrupt,
-};
-
 void __init init_ext_interrupts(void)
 {
 	int idx;
@@ -308,7 +303,8 @@ void __init init_ext_interrupts(void)
 
 	irq_set_chip_and_handler(EXT_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(EXT_INTERRUPT, &external_interrupt);
+	if (request_irq(EXT_INTERRUPT, do_ext_interrupt, 0, "EXT", NULL))
+		pr_err("request_irq() on %s failed\n", "EXT");
 }
 
 static DEFINE_SPINLOCK(irq_subclass_lock);
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index 427b2e24a8ce..773208a3bb68 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -105,16 +105,12 @@ static irqreturn_t do_airq_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction airq_interrupt = {
-	.name	 = "AIO",
-	.handler = do_airq_interrupt,
-};
-
 void __init init_airq_interrupts(void)
 {
 	irq_set_chip_and_handler(THIN_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(THIN_INTERRUPT, &airq_interrupt);
+	if (request_irq(THIN_INTERRUPT, do_airq_interrupt, 0, "AIO", NULL))
+		pr_err("request_irq() on %s failed\n", "AIO");
 }
 
 static inline unsigned long iv_size(unsigned long bits)
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 18f5458f90e8..1b87e2e84007 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -563,16 +563,12 @@ static irqreturn_t do_cio_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction io_interrupt = {
-	.name	 = "I/O",
-	.handler = do_cio_interrupt,
-};
-
 void __init init_cio_interrupts(void)
 {
 	irq_set_chip_and_handler(IO_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(IO_INTERRUPT, &io_interrupt);
+	if (request_irq(IO_INTERRUPT, do_cio_interrupt, 0, "I/O", NULL))
+		pr_err("request_irq() on %s failed\n", "I/O");
 }
 
 #ifdef CONFIG_CCW_CONSOLE
-- 
2.24.1

