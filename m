Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF006C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8487D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="M45+4iAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAWOFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:05:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37159 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:05:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2673262wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=M45+4iAd/+so2uPjQePCigx7UoGTuLYGKSenM9uGxUtckyFOJjElOUJxoiKVrJNRUN
         2gqepqxrBfH5dPejaSBDW1yuf5y97jJdD+qt1bvlfxR9hxDBbDQ0zZTH1WzrTU3rm7kV
         PPI6jmoKG1ailpQ57whCSDVbj3DxT6rDqgUWyxCgtTGSkwoqD+GYsuSCcQbYW9vxJJDP
         9lgIGV0XL2WkfNz1r4RKnOHMc2hhAPJ+DyYdyTUf0Hs3tUGgM6uX+GH9/w9Sw2L1B/Br
         NSN8kXuNplpCzDqggd24rgugepc21nxiILx2PdE/r53zvrT7mNoZpNwNLz39mIsuIXqa
         rFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3tKF/sG1li0TNgHDm/zaOCBiB+0gN/tDFvNC2uEQ+I=;
        b=GxVWoU81aftHo7Ap/YxNwFO5EtQsEVLsT0LH6FHhT90HKYCJJXd+qY/yWyaIflSj/+
         S89RASO8TUymoEFVal1eCOnC4UXr7eun9ARGWqdBNzPknTiXf/2hsefMNn8YrenNbC1+
         PsJslcsKf1wyeMC1gumfO19SKKpVrzD7DDyeWSmJIcqiJyXLKlpZggEPbdwImRmvwTtJ
         IQqajxG8pfLq3vR6Dx82ZrszQxLkBpBEUa/tl6owOv6AXLPPmKDu5G+1GZrkXibgPbzi
         LkzaGsBMnk6n944tGDLbp8LyukErNI1IcjB60H5lZHdwzqYpEyv02cM/gJOnUNlhzBlv
         3BNA==
X-Gm-Message-State: APjAAAU5Ir1jFNHNkoFgaaWIdwdKmjnXANj+sg2kylnFAbAdd9BEsVf2
        82DpedPzHWQyTLS2mto3wP6o3w==
X-Google-Smtp-Source: APXvYqzgRoWJ/oQdJZsSS4fRPBaJ7vR9DWyEx17TRO9JFNLK4Ww1iOuMfcttEUdy/2yBNu3UKk8Kng==
X-Received: by 2002:a1c:7e0b:: with SMTP id z11mr4472464wmc.88.1579788318282;
        Thu, 23 Jan 2020 06:05:18 -0800 (PST)
Received: from localhost.localdomain (amontpellier-652-1-53-230.w109-210.abo.wanadoo.fr. [109.210.44.230])
        by smtp.gmail.com with ESMTPSA id n16sm3100963wro.88.2020.01.23.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 06:05:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefani Seibold <stefani@seibold.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 1/7] kfifo: provide noirqsave variants of spinlocked in and out helpers
Date:   Thu, 23 Jan 2020 15:05:00 +0100
Message-Id: <20200123140506.29275-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200123140506.29275-1-brgl@bgdev.pl>
References: <20200123140506.29275-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide variants of spinlocked kfifo_in() and kfifo_out() routines which
don't disable interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/kfifo.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index fc4b0b10210f..123c200ed7cb 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -517,6 +517,26 @@ __kfifo_uint_must_check_helper( \
 	__ret; \
 })
 
+/**
+ * kfifo_in_spinlocked_noirqsave - put data into fifo using a spinlock for
+ * locking, don't disable interrupts
+ * @fifo: address of the fifo to be used
+ * @buf: the data to be added
+ * @n: number of elements to be added
+ * @lock: pointer to the spinlock to use for locking
+ *
+ * This is a variant of kfifo_in_spinlocked() but uses spin_lock/unlock()
+ * for locking and doesn't disable interrupts.
+ */
+#define kfifo_in_spinlocked_noirqsave(fifo, buf, n, lock) \
+({ \
+	unsigned int __ret; \
+	spin_lock(lock); \
+	__ret = kfifo_in(fifo, buf, n); \
+	spin_unlock(lock); \
+	__ret; \
+})
+
 /* alias for kfifo_in_spinlocked, will be removed in a future release */
 #define kfifo_in_locked(fifo, buf, n, lock) \
 		kfifo_in_spinlocked(fifo, buf, n, lock)
@@ -569,6 +589,28 @@ __kfifo_uint_must_check_helper( \
 }) \
 )
 
+/**
+ * kfifo_out_spinlocked_noirqsave - get data from the fifo using a spinlock
+ * for locking, don't disable interrupts
+ * @fifo: address of the fifo to be used
+ * @buf: pointer to the storage buffer
+ * @n: max. number of elements to get
+ * @lock: pointer to the spinlock to use for locking
+ *
+ * This is a variant of kfifo_out_spinlocked() which uses spin_lock/unlock()
+ * for locking and doesn't disable interrupts.
+ */
+#define kfifo_out_spinlocked_noirqsave(fifo, buf, n, lock) \
+__kfifo_uint_must_check_helper( \
+({ \
+	unsigned int __ret; \
+	spin_lock(lock); \
+	__ret = kfifo_out(fifo, buf, n); \
+	spin_unlock(lock); \
+	__ret; \
+}) \
+)
+
 /* alias for kfifo_out_spinlocked, will be removed in a future release */
 #define kfifo_out_locked(fifo, buf, n, lock) \
 		kfifo_out_spinlocked(fifo, buf, n, lock)
-- 
2.23.0

