Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B9EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DABA2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mFbbTkus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbgAXR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:27:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51139 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbgAXR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:27:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so241599wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJjGrvg3mOwAKVCibupA56dSZoCmNQpaCvrxwBxCbkI=;
        b=mFbbTkusJM1h2k2a+IS4yzllB9ot90bMcuamF2QcPW9Pvlgh3nARvTHgSw8CSQdPsI
         NPXQ1vPyIGLafpGSyt+zZiJiGF5FYtqP9GeWFDbHlvVCdsZkqsyB1Xr2iyu62V+xece/
         KXKv6Ty/a7F3RiYjm1yvjYxdRDuGKtBhaqcA5yr2zwKdNYpn8TsidQX5Egj/2/p1uWYA
         iE4gd6oP6UElJgUa9RvSVfPGydB22yLGDviG5bztfywAXjpH8otc4kXzy6kaWW4PGixz
         nDNKiTWdQ/6p5so/wKHvMTsq17NHHPqtK4y0fVmNHQ4nGfuWfKZ25KH6Tjs5dFBq0iBB
         EKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJjGrvg3mOwAKVCibupA56dSZoCmNQpaCvrxwBxCbkI=;
        b=VRrCbxC1Q+gGkDx6f+7qrU63d2+bBQfs8GfIlhUNWD6gc/9NOTljf32SiyJ/Dvczl0
         86AzprbcSF8w8D3DCskxI4BE26ut3taaNX2j1yduHM5iYZXsmyO8MLPETwJGzbOBzTJQ
         C275f8JEedleL5ITkIeTzNWCsMmT9SlqMCHVwx+RBG9vglfl35HT8vAqfWzQR59wJEZ0
         dSCIR6F5vWezw+i7lwN5TX7srNTnq5M/AH/nOnqcDcNihv9ZVCjY/rYdY3GEqpw7Ol/b
         emtMyfUmm+EGwi47x/yFZ7Odp4PH1sV3HQPv9TL0tKqrX4NcbsLICw8mkEBjIt3FBcR6
         dmdw==
X-Gm-Message-State: APjAAAUCmynVGEd8IKhEruVOYA8/FwXg8CODl/qUmB0F2KsIfUGyTKI1
        LtrPjUJT40ECH+rMLJf3qbr/Jg==
X-Google-Smtp-Source: APXvYqxAAhN/LBVU89VSmwcW1dRuEvPfLVB1wwzNte3lzf/a9AR7CI7QWj6jF1hiJ438so/l2mgvrA==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr249273wmd.158.1579886837536;
        Fri, 24 Jan 2020 09:27:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t8sm8358585wrp.69.2020.01.24.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 09:27:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Stefani Seibold <stefani@seibold.net>
Subject: [PATCH v6 1/7] kfifo: provide noirqsave variants of spinlocked in and out helpers
Date:   Fri, 24 Jan 2020 18:27:04 +0100
Message-Id: <20200124172710.20776-2-brgl@bgdev.pl>
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

Provide variants of spinlocked kfifo_in() and kfifo_out() routines which
don't disable interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Stefani Seibold <stefani@seibold.net>
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

