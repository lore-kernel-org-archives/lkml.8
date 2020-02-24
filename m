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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3BC35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D2C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N23VItJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBXAvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:51:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgBXAvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:51:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so4456817pfn.4;
        Sun, 23 Feb 2020 16:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VsG4BeuVio7/IOcNePuekG7++39/uybEVsFZxG/8vQI=;
        b=N23VItJ61aSj1MCeDYlg10QYF0y3CMgpIojPPayY5qEj83Tuw3SW7a6YSJSt797PnT
         j5noqvGTh2W9YQJqBBKPgZ12bVjrOAof4ox3n6c8xcNA9UXw2V4+PFmerRdl6Abx80wD
         zS5T7PlMn18L0E1Zc25oDv/SK2AZHmOWx2heFIUNTIJbOXxIV6BtcyireVicc7FQ/NeK
         GO7jEWFvYrY+DZQ5LqR8nFTnzu/Oz9QoM6SoT8ZULTnCobaLAYfNxlvHy05RJK/TAuhi
         XnWps2MerkhrTd1xKOpJf1e2qA4JszViIgn5cX/1lToyzHsG2fzdVLTSnFHxZxBnE0Wh
         C6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VsG4BeuVio7/IOcNePuekG7++39/uybEVsFZxG/8vQI=;
        b=ud6Y4Y11dD3Pf8jEGM74PJFGeQwHuNL5VlhHAYuOagFQkMqpViIF1SWpyVT6nsDyPh
         wId4uEz9ov7bZgfZ+Rg4Tz/LnykWYhTg65sY9mF/Yn5Yof+i7kOvRb+Q4c35edvnSrjy
         ES7eDSoemE4TXcTCamrsFKrIi34qiOZk3xSCdgSDViw7lqLvAH87uPGbTzkKsUtSogC4
         AWDOtJMR51xWBxVhWpoegQa0ZVeBPshqcJ5K8AIQdJkcc8hk/Uon+QUa8LcwfSu9B7Gu
         nisdDwobwbg/esphYG4d2ExwLWqSJeue+LEsexhgZme/+nZfwpSZAAOE0DDTfwEpI+EJ
         z9ew==
X-Gm-Message-State: APjAAAWBIjBzZgQ+je1qoAI6q/cm2YmrJcaGRLa4sfHIHoi8OTPalBiF
        KnerAazIST7Ax5qPVj4FAF3CQEP2ZeQ=
X-Google-Smtp-Source: APXvYqwTODQUNFGcjpNBYdU3UGo0LmYiK+k1AlOtmFEreGarXuk9vWPcgNPXZt8t4tMJQzzJyXK66g==
X-Received: by 2002:aa7:9a42:: with SMTP id x2mr49346060pfj.71.1582505503702;
        Sun, 23 Feb 2020 16:51:43 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id i27sm9957493pgn.76.2020.02.23.16.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:51:43 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:21:41 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 11/18] s390: replace setup_irq() by request_irq()
Message-ID: <463586b1fb5ca6dd60b4b5264312f86924281552.1582471508.git.afzal.mohd.ma@gmail.com>
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

 arch/s390/kernel/irq.c  | 8 ++------
 drivers/s390/cio/airq.c | 8 ++------
 drivers/s390/cio/cio.c  | 8 ++------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 8371855042dc..2cbe7296f069 100644
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
+		pr_err("%s: request_irq() failed\n", "EXT");
 }
 
 static DEFINE_SPINLOCK(irq_subclass_lock);
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index 427b2e24a8ce..8d062d8ff669 100644
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
+		pr_err("%s: request_irq() failed\n", "AIO");
 }
 
 static inline unsigned long iv_size(unsigned long bits)
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 18f5458f90e8..703265786756 100644
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
+		pr_err("%s: request_irq() failed\n", "I/O");
 }
 
 #ifdef CONFIG_CCW_CONSOLE
-- 
2.25.1

