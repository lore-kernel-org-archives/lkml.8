Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3FC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E4120842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RRWqZF2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBKJTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:19:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36516 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgBKJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:19:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2530244wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jd3S0c8oA3FFZV9WYz5wV0vL9kX1A3olT9RSfev+u3s=;
        b=RRWqZF2QleHRJYHTupUycqYxN5RoZOHkwrgj8XMplYZomMJxnj3IQUN4FhQGnhEkOz
         16SGpPp8tmKQ+ASQag/DpHkC6W2u3LFAqnjEcQc2Dy2dicVFPGWUQklPlFrzqQ5S9uv3
         aWI+t7dBqVHLt7M9D13V27i9Ilpv4AAoeoBVpEpXoOYZkJgoeY7OoCZu2XxyGd34Ir0D
         ytkWsFV2/RZCKEeoAEsf/Nch9wbxMLx2B9huSKfjmJkCQrS/yxEYG0K5nPnRWgl4BHu6
         ezCb6xyFu/bas2ruVI0lq7UHgvIDrAh48smsrHjBBYYnJmkSpDQWUWIzIopk0aOSCKyH
         sWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jd3S0c8oA3FFZV9WYz5wV0vL9kX1A3olT9RSfev+u3s=;
        b=lVWYlv+VviQM81DeDS18iquU0JKeE80DTivrof8jJZXUa/gSXb3Tsp9xJsVMmJtuGq
         l8hRUVg1qo7hnWY7PGjr4R6G2Op+6WslUW1FtUHH9o3gRh4bvvaeEUzs/iVt07kRBtx3
         5FDnFJoj7tkDR+D0S3ihctqt2YxQbRMslL5otqaaB8sr2Bm6JlKKhGNtU7KJzMuwchtp
         +bRI6by7OjPVRMUYFjYsB0KQ1SIcylO4KMAQdujOimaDuiXREjOsfueP8lKPH4Kmhe7U
         GGdBwrHFP7E9IFZgfWsv2/QcBXAAkjdo1RsB7P1A0U/gIIM8oBDyfWD/1tq7IQoU+9GK
         xQ2Q==
X-Gm-Message-State: APjAAAVFutoBG6vSn88LKxpiNDt1XlYaExP1FeqgQ6QMhFZOtFHy8syx
        Yx1StQ3UWtSnVfg4uSBOq1Peeg==
X-Google-Smtp-Source: APXvYqy6UQ0/Kcf5UNG3fpwsmKw07e5CgntivWbZjkM07gymFgx74M/lqUP46rbfMq2eqSr7n73AhA==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr4322106wmg.136.1581412788561;
        Tue, 11 Feb 2020 01:19:48 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id y131sm2958622wmc.13.2020.02.11.01.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 01:19:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 3/7] gpiolib: rework the locking mechanism for lineevent kfifo
Date:   Tue, 11 Feb 2020 10:19:33 +0100
Message-Id: <20200211091937.29558-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211091937.29558-1-brgl@bgdev.pl>
References: <20200211091937.29558-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The read_lock mutex is supposed to prevent collisions between reading
and writing to the line event kfifo but it's actually only taken when
the events are being read from it.

Drop the mutex entirely and reuse the spinlock made available to us in
the waitqueue struct. Take the lock whenever the fifo is modified or
inspected. Drop the call to kfifo_to_user() and instead first extract
the new element from kfifo when the lock is taken and only then pass
it on to the user after the spinlock is released.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 64 +++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 753283486037..43d98309e725 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -787,8 +787,6 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @wait: wait queue that handles blocking reads of events
  * @events: KFIFO for the GPIO events
- * @read_lock: mutex lock to protect reads from colliding with adding
- * new events to the FIFO
  * @timestamp: cache for the timestamp storing it between hardirq
  * and IRQ thread, used to bring the timestamp close to the actual
  * event
@@ -801,7 +799,6 @@ struct lineevent_state {
 	int irq;
 	wait_queue_head_t wait;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
-	struct mutex read_lock;
 	u64 timestamp;
 };
 
@@ -817,7 +814,7 @@ static __poll_t lineevent_poll(struct file *filep,
 
 	poll_wait(filep, &le->wait, wait);
 
-	if (!kfifo_is_empty(&le->events))
+	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
 		events = EPOLLIN | EPOLLRDNORM;
 
 	return events;
@@ -830,43 +827,52 @@ static ssize_t lineevent_read(struct file *filep,
 			      loff_t *f_ps)
 {
 	struct lineevent_state *le = filep->private_data;
-	unsigned int copied;
+	struct gpioevent_data event;
+	ssize_t bytes_read = 0;
 	int ret;
 
-	if (count < sizeof(struct gpioevent_data))
+	if (count < sizeof(event))
 		return -EINVAL;
 
 	do {
+		spin_lock(&le->wait.lock);
 		if (kfifo_is_empty(&le->events)) {
-			if (filep->f_flags & O_NONBLOCK)
+			if (bytes_read) {
+				spin_unlock(&le->wait.lock);
+				return bytes_read;
+			}
+
+			if (filep->f_flags & O_NONBLOCK) {
+				spin_unlock(&le->wait.lock);
 				return -EAGAIN;
+			}
 
-			ret = wait_event_interruptible(le->wait,
+			ret = wait_event_interruptible_locked(le->wait,
 					!kfifo_is_empty(&le->events));
-			if (ret)
+			if (ret) {
+				spin_unlock(&le->wait.lock);
 				return ret;
+			}
 		}
 
-		if (mutex_lock_interruptible(&le->read_lock))
-			return -ERESTARTSYS;
-		ret = kfifo_to_user(&le->events, buf, count, &copied);
-		mutex_unlock(&le->read_lock);
-
-		if (ret)
-			return ret;
-
-		/*
-		 * If we couldn't read anything from the fifo (a different
-		 * thread might have been faster) we either return -EAGAIN if
-		 * the file descriptor is non-blocking, otherwise we go back to
-		 * sleep and wait for more data to arrive.
-		 */
-		if (copied == 0 && (filep->f_flags & O_NONBLOCK))
-			return -EAGAIN;
+		ret = kfifo_out(&le->events, &event, 1);
+		spin_unlock(&le->wait.lock);
+		if (ret != 1) {
+			/*
+			 * This should never happen - we were holding the lock
+			 * from the moment we learned the fifo is no longer
+			 * empty until now.
+			 */
+			ret = -EIO;
+			break;
+		}
 
-	} while (copied == 0);
+		if (copy_to_user(buf + bytes_read, &event, sizeof(event)))
+			return -EFAULT;
+		bytes_read += sizeof(event);
+	} while (count >= bytes_read + sizeof(event));
 
-	return copied;
+	return bytes_read;
 }
 
 static int lineevent_release(struct inode *inode, struct file *filep)
@@ -968,7 +974,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 		return IRQ_NONE;
 	}
 
-	ret = kfifo_put(&le->events, ge);
+	ret = kfifo_in_spinlocked_noirqsave(&le->events, &ge,
+					    1, &le->wait.lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
 
@@ -1083,7 +1090,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 
 	INIT_KFIFO(le->events);
 	init_waitqueue_head(&le->wait);
-	mutex_init(&le->read_lock);
 
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(le->irq,
-- 
2.25.0

