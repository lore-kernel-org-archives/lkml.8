Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16334C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5C320842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bvlde9/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBKJUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:20:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36516 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgBKJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:19:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2530153wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6ZLNj2Gq0W0Yaf5OErI6mxsCNdT2eS8KG7ezcB9dY0=;
        b=bvlde9/BYWUt6yX6B3axWW/EXQmlMl7L/is9C1EKF8Nx4zE9fM88462YL3CmM28ioo
         GH3iIhRZllHSdtjSSov1oy10smvIWwyQQi3cpc8C/meYywWKxyeTfPrd27JSUgJngcxP
         cP5cvQhg1dsawZLIQCnMJ3tJNGV5LakxTH6BY5YHtAoek2x0s8fek2tx0fY+SkmKg3Ux
         mH6Vj1sPdc9YxdMCamsUNWTxV1j75xySd/ke1LMmwx+VfDj4HjwGlMi4h5WxQQX/kjIZ
         oxdMXoto6p+tODUU5saArZQ6thjikM1uE4x1cirtB9sKiVeVYoPVwUfutJkZbcavbaaz
         Ab2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6ZLNj2Gq0W0Yaf5OErI6mxsCNdT2eS8KG7ezcB9dY0=;
        b=YzcmnQwrpzVofNgUmt32qdtMKMSskdg5BlYmvFKFKlu4pVF8qMhzmm27un+/EMS+1C
         6/jE+7azIY8dUrATWxYldCPQ/my4E2RLTJqxJQG2Px0K3L9lfKZdxs8xJLkv1BKinDRe
         +8ybyw+pUav0sbhRTQjsp8kRboxDDq2rXNDoGRPRnWekWfzgTZRgAtidZ3mXCKWPP8Q8
         niScV7dLTUZWWtyH6fd5OxJwYf97Dko8XX8Ax3SQxuONY2QDYNJUqZKPNbDVvqv66WSF
         7H9aExRStnN8NVJQiWKh1d5Js9mXwclmEWx1MLXRJBKWnZX1IMFVqlQ2UuH8i2inbQ4k
         eDPQ==
X-Gm-Message-State: APjAAAUZyZsAD/NMRk9ryT3OIkLkzO15GrSqwKohuWDIHRddaUGDjFU5
        7IOSqlQcEzg2fHemxUdNNK3brA==
X-Google-Smtp-Source: APXvYqxHjKZdZWKhZS3AoeVyH3NMEieAbdcgVVvcmpoGXTu4vuIZJaP8GCNGxLmznkRrQAzrQ9SNuA==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr4689065wmg.151.1581412787259;
        Tue, 11 Feb 2020 01:19:47 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id y131sm2958622wmc.13.2020.02.11.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 01:19:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Stefani Seibold <stefani@seibold.net>
Subject: [RESEND PATCH v6 2/7] kfifo: provide kfifo_is_empty_spinlocked()
Date:   Tue, 11 Feb 2020 10:19:32 +0100
Message-Id: <20200211091937.29558-3-brgl@bgdev.pl>
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

Provide two spinlocked versions of kfifo_is_empty() to be used with
spinlocked variants of kfifo_in() and kfifo_out().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Stefani Seibold <stefani@seibold.net>
---
 include/linux/kfifo.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 123c200ed7cb..86249476b57f 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -246,6 +246,37 @@ __kfifo_int_must_check_helper(int val)
 	__tmpq->kfifo.in == __tmpq->kfifo.out; \
 })
 
+/**
+ * kfifo_is_empty_spinlocked - returns true if the fifo is empty using
+ * a spinlock for locking
+ * @fifo: address of the fifo to be used
+ * @lock: spinlock to be used for locking
+ */
+#define kfifo_is_empty_spinlocked(fifo, lock) \
+({ \
+	unsigned long __flags; \
+	bool __ret; \
+	spin_lock_irqsave(lock, __flags); \
+	__ret = kfifo_is_empty(fifo); \
+	spin_unlock_irqrestore(lock, __flags); \
+	__ret; \
+})
+
+/**
+ * kfifo_is_empty_spinlocked_noirqsave  - returns true if the fifo is empty
+ * using a spinlock for locking, doesn't disable interrupts
+ * @fifo: address of the fifo to be used
+ * @lock: spinlock to be used for locking
+ */
+#define kfifo_is_empty_spinlocked_noirqsave(fifo, lock) \
+({ \
+	bool __ret; \
+	spin_lock(lock); \
+	__ret = kfifo_is_empty(fifo); \
+	spin_unlock(lock); \
+	__ret; \
+})
+
 /**
  * kfifo_is_full - returns true if the fifo is full
  * @fifo: address of the fifo to be used
-- 
2.25.0

