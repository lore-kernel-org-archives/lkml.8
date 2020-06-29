Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B974C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C54120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FYmhjDIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbgF2Use (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbgF2TNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E9C08ECB1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so15320696wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQLZ+jko03ajYiEU9tKzGTq9iSv1zZX+07bBcjYcbLA=;
        b=FYmhjDIXqE+19n161Ij01cT38yTbnnKTVcBm5nfxvt0mQoxdX8jT5GCNuSmoKGQ2il
         zlOMuHkFhRAhof+11xURpM5Ke9pgsEcriQuwBOd7e7VKbccssUwJ9KxNsQDeqO4m5yuT
         CgkHnWe1BxhBEASU/SLGzD8cRrDNVjdIEF+BGPRnD7hDJ2xzsV1jeWo7vkuqUQmaNAZ6
         Gm84ZPAyV54o4Y60vwDt0COyyKKs3duQp77LiMGGjUsxBO+z7tCOdsozVT9eEkf+ahFl
         Idog53/4Cl4F2ELArDr6T+/8gsp/dA2WV2zXGEzT00o2WxhlEeOg4DIy1JjL+7hu6hvP
         BimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQLZ+jko03ajYiEU9tKzGTq9iSv1zZX+07bBcjYcbLA=;
        b=FshWzkF8sp3XvJ4WyiflLWgml5keywgg0al2vEafjIJrSrQfuwIY+sPRIqjnjQRsCw
         jC1tm36iCmGlcH7z6bYfMFM39o5cMeS/BS6hr5+N7I6nWTunf6oLBXX3BpmrZkA3PMhg
         sdwF/Lcs+A/8kTiH7KebJ1PU4Del/Y+FVrEZA25PTTkYez53argtrKYJbgjoLYoA2MfV
         bJhLujw/uccdSjeaDOZXqsFvO48kyS9NchrGKHDNpBRck0FfElTIx8XTUCh0XCzsLtu+
         Vd6WH3oh82LKg2CdiIKCIpJWIngS1Im2ZU0clnoWEHbER512aZ/Pg9uCTSaJhXMOQpj8
         /k+Q==
X-Gm-Message-State: AOAM531B7eGEVgHKfJA8SPi4jrt2BjSOcQiAYLVG6NgnHwiIHB40pp97
        KG6rtvsEOvyf0h46/K4vlSV31Q==
X-Google-Smtp-Source: ABdhPJx4pF05M7pSnBLMBSCCL5/gux2FQqGxkWxH+G1Fjsdujj7JidMEWyZnEHhaT+WmVt1X6gqXvg==
X-Received: by 2002:adf:f8d1:: with SMTP id f17mr15609276wrq.59.1593413420219;
        Sun, 28 Jun 2020 23:50:20 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id z25sm26400850wmk.28.2020.06.28.23.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:50:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/6] devres: provide devm_krealloc()
Date:   Mon, 29 Jun 2020 08:50:07 +0200
Message-Id: <20200629065008.27620-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629065008.27620-1-brgl@bgdev.pl>
References: <20200629065008.27620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement the managed variant of krealloc(). This function works with
all memory allocated by devm_kmalloc() (or devres functions using it
implicitly like devm_kmemdup(), devm_kstrdup() etc.).

Managed realloc'ed chunks can be manually released with devm_kfree().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 50 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 53 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e0b58c392e4f..0a2572c3813c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -352,6 +352,7 @@ MEM
   devm_kfree()
   devm_kmalloc()
   devm_kmalloc_array()
+  devm_krealloc()
   devm_kmemdup()
   devm_kstrdup()
   devm_kvasprintf()
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ed615d3b9cf1..4b8870ef6a3f 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -837,6 +837,56 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kmalloc);
 
+void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
+{
+	struct devres *old_dr, *new_dr;
+	struct list_head old_head;
+	unsigned long flags;
+	void *ret = NULL;
+	size_t tot_size;
+
+	if (unlikely(!new_size)) {
+		devm_kfree(dev, ptr);
+		return ZERO_SIZE_PTR;
+	}
+
+	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
+		return devm_kmalloc(dev, new_size, gfp);
+
+	if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
+		/*
+		 * We cannot reliably realloc a const string returned by
+		 * devm_kstrdup_const().
+		 */
+		return NULL;
+
+	if (!check_dr_size(new_size, &tot_size))
+		return NULL;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (WARN_ON(!old_dr))
+		/* Memory chunk not managed or managed by a different device. */
+		goto out;
+
+	old_head = old_dr->node.entry;
+
+	new_dr = krealloc(old_dr, tot_size, gfp);
+	if (!new_dr)
+		goto out;
+
+	if (new_dr != old_dr)
+		list_replace(&old_head, &new_dr->node.entry);
+
+	ret = new_dr->data;
+
+out:
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_krealloc);
+
 /**
  * devm_kstrdup - Allocate resource managed space and
  *                copy an existing string into that.
diff --git a/include/linux/device.h b/include/linux/device.h
index 9cadb647cacc..228063c6392c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -201,6 +201,8 @@ int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
 void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+void *devm_krealloc(struct device *dev, void *ptr, size_t size,
+		    gfp_t gfp) __must_check;
 __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
 				     const char *fmt, va_list ap) __malloc;
 __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
-- 
2.26.1

