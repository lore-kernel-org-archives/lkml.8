Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0B9206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P8OISsXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgFZQ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgFZQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:55:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA635C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:55:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so2092924wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwLPHUiUd7u8i6DlgTqpUvjVOFN4vpyWhbccIRdmj5g=;
        b=P8OISsXa/l4EX27H6DX2GeRuI7OsQIMd2NP+uFFYiaautFiYCDjrQ/jnPipqUwr1mt
         uFC8WZaN3b1HYPWEXLjvO42FShpnGs/xqt70CjD7VuO4w33auwI6QzJuWPxsMqio/7Dd
         BGkv68viVX1g5PHlqiE0GA/8pmJ6KfG6TUbI92TYy6io+WwM7LLm4Q6BZbxd3IJu+fdM
         v/qdKZRhFJLU5LM6Fw5tiKfF7pYjBDJNHJBnD4oAYw8+m4MO+Z66auejVSVaOtkpGSxL
         mdXHbU9+cH+nw2X6tmTG0RuCHf/VAoLIcdPKJyqtZZuIOSx09/h1EB0eYthkNiO6TOr9
         3xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwLPHUiUd7u8i6DlgTqpUvjVOFN4vpyWhbccIRdmj5g=;
        b=Dx95mZCMtqJos1W4Xvk32l9tndyuqF7ML0Np7b/ffim2GUp2QGEftcbgyZMyklgISv
         uyS6kToVSj40HPBG13pK0LEHg1BxhBoGgtwM9Bqa4mDmL2++aWTVzFoW2QOn5ZnfmvHB
         KOIKmgrgtYJdtFzFaOOnzmDvQL7QC1DgNWT3y3dysA6XJEaN6sKVKQfz1t3A3n2YyIgw
         oFKlf3qHBh9buptZyG8txLPhL+PxeUSg8l8/ueP8ensED9fzHG49rYEEH0gxZqon9SiX
         Lh6UKgiYchfrb7QexXboGkXqt85nG5iZ9MdtBC9Q3zqMy7EIWq3Qp/ojBJC2+S+HWbtZ
         31Mw==
X-Gm-Message-State: AOAM530E/guigAaE2k9Z2OOBsNuMIXy7SWL/klkKY6TS7uyptRaX/YAX
        85Uiafmi9wN2Y6Adozgs4aaAWg==
X-Google-Smtp-Source: ABdhPJz7Z3lbibvn2eFNKQQVtNher7YiK3Ofc/8i1HS+2vEqMXpOmSAwue/dzldCRTy5t7UVFKYj5w==
X-Received: by 2002:adf:f842:: with SMTP id d2mr5069407wrq.55.1593190557481;
        Fri, 26 Jun 2020 09:55:57 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id x5sm18654706wmg.2.2020.06.26.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:55:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/5] devres: provide devm_krealloc()
Date:   Fri, 26 Jun 2020 18:55:34 +0200
Message-Id: <20200626165535.7662-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200626165535.7662-1-brgl@bgdev.pl>
References: <20200626165535.7662-1-brgl@bgdev.pl>
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
 drivers/base/devres.c                         | 42 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 45 insertions(+)

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
index 1df1fb10b2d9..baf41a290356 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -834,6 +834,48 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
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
+	if (unlikely(!ptr))
+		return devm_kmalloc(dev, new_size, gfp);
+
+	if (!check_dr_size(new_size, &tot_size))
+		return NULL;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (WARN_ONCE(!old_dr, "Memory chunk not managed or managed by a different device"))
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

