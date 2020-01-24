Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1832071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BQ8W0a2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbgAXR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:27:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36520 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389900AbgAXR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:27:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so241014wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfsK3S//OLjHPSyGGvTCMElHrE5UBNkPhmdUVYDRntA=;
        b=BQ8W0a2H3qdk8IKbEo02PvHTnFOQsgN99xFRDxml3YtbW8/bRPwyaYe6pO5CqNZNKJ
         fpb+dWx8xgO8BFCsfTr/MU0QjLUl5cuMiFt2sq5XXiTNDY8zAEi8PFhsphUHP4M3M2uF
         adkrcLsnN9mQIPTcw3ePZeQhsKz1TcGsjRtGvM/ks6Pr7LfGyR5K3VeG2hNkyOQvHoZj
         XUQtDVHfPmt8uH/F4mFSEoApaZFi4XtnlfJ3oHfeEH8IFFJ16Xa9QYTKyg9ZW5BjZ99u
         j7L5eXRUuv3wRanL9GofejY8XLO029FFF7AGSVMHu0DFcex6pH5rrld4sg2SudiL976F
         /xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfsK3S//OLjHPSyGGvTCMElHrE5UBNkPhmdUVYDRntA=;
        b=QgZg2ni0qVzsTyVEJU46hrrXJa5i+AZjcA02O9ryrSEMbQJmnoNtNntsW3FAgV37rw
         3JM3FWPlABcJ7H4F8zFCPNKssIF+N6jUmcDLSpznkpmYQxc8EMxAvdhjIe+1Q1fM2czz
         /ovDSbYWLWqUmO27HGAIltO+KWFTM71/x1FML6+K0u815eyJlVt+L4e6mVp3fxzJN1pm
         VZCFL2/QrmgNamVLU4CFH2Zf5BYt0i3XYCjdOmdz8T1WE870DOupbjMu3zmHAKBkwAjv
         Ke9bhqAp016lS2fe6QXEk2Fqv4oGKjxqnstQgcDkTXQo+L3igrz+4T+j2bORA+pamdiK
         4vuQ==
X-Gm-Message-State: APjAAAWGNCrpjd8fzs00n0uxuv5ivykiZhuYxmNvW3Gbaq70SuixEnuD
        NJBJq1gmGq2BM/qLHGeeemJRxg==
X-Google-Smtp-Source: APXvYqx87jYt0rZPhyllJ/jXOTN+ICf+iQKO3HMBkYIMFH64HZ/uQyDnKYaXzQUodfAIprrDd5EoCg==
X-Received: by 2002:a1c:5ac2:: with SMTP id o185mr215292wmb.179.1579886839603;
        Fri, 24 Jan 2020 09:27:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t8sm8358585wrp.69.2020.01.24.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 09:27:19 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 3/7] gpiolib: rework the locking mechanism for lineevent kfifo
Date:   Fri, 24 Jan 2020 18:27:06 +0100
Message-Id: <20200124172710.20776-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200124172710.20776-1-brgl@bgdev.pl>
References: <20200124172710.20776-1-brgl@bgdev.pl>
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
index 5999bab3ba91..66df06a24cfd 100644
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
2.23.0

