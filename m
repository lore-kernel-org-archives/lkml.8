Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35756207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MrzRYyfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIJGE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIJGEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:04:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD7C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:04:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so4021218pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPCDwGmcreej0UTgOvHeud65Ck7ttZheB3Tpbe5Ii+k=;
        b=MrzRYyfYrdUOluPQ3Hd8mzad54wNbNurcjisgU8OBBFvRllFdb+ZenK6Rje7u5gB6A
         yxjiA72pi2YvkME0vYjHX9aKq8lFNqwKGfCC+2FiX0BGgvMxlr5cc5GfKJNeU5hENKhh
         odYukto3kXbOSf804FXWHdJhdPUrpzHjDD2pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPCDwGmcreej0UTgOvHeud65Ck7ttZheB3Tpbe5Ii+k=;
        b=Hk0uCrQFjhAwuZSPJRgwIN0CejuQ12Atg4ccGnAyZIRDML/TxNqMWUYapxKNEDdyWK
         kXswHPcQAdSbdPpceb7HfHIyfFRMhHNGyHpYvf8ikh8vgBwpa6P7jDOJXIqvUmiKhwmB
         y8kgfGCbXRgW2ZQRkBnD890o22wppnbez4FQVpKx98kxjsiCZ5GL+ECDc90fERcWcO1P
         nxXHUk/uzuGzoeulnxTFTyTDAokvxFw5tWbQP7OG6if5j55MENPDyjJCmc5aHdN+qBjT
         +2pHronTVpVK+/kbYZOEG51e3tjDFUTjSjjhNIi+ThgUL6gmcYivqh8H+l3PcJpUszG0
         6nAw==
X-Gm-Message-State: AOAM5312XCq2ZIi3cDmKiZjzrMlOdphqC45tfrqbXUIEg8lzbMzkcUNp
        KipHtU5s40actMakzvjg5vTfaw==
X-Google-Smtp-Source: ABdhPJxTCipQzSP5KOrtWtUPu+ui70YGHVVLP7khWBM647UJ1fytRm0k/5NVDQ4ws1WnqFF3794bKw==
X-Received: by 2002:a62:92ca:0:b029:13e:d13d:a07e with SMTP id o193-20020a6292ca0000b029013ed13da07emr3813251pfd.21.1599717881579;
        Wed, 09 Sep 2020 23:04:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y6sm987739pjl.9.2020.09.09.23.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:04:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] driver core: platform: Document return type of more functions
Date:   Wed,  9 Sep 2020 23:04:40 -0700
Message-Id: <20200910060440.2302925-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't always remember the return values of these functions, and so I
usually jump to the function to read the kernel-doc and see that it
doesn't tell me. Then I have to spend more time reading the code to jump
to the function that actually tells me the return values. Let's document
it here so that we don't all have to spend time digging through the code
to understand the return values.

Cc: <linux-doc@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/platform.c | 14 ++++++++++++++
 lib/devres.c            | 18 ++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e5d8a0503b4f..4b3dc6813714 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -45,6 +45,8 @@ EXPORT_SYMBOL_GPL(platform_bus);
  * @dev: platform device
  * @type: resource type
  * @num: resource index
+ *
+ * Return: a pointer to the resource or NULL on failure.
  */
 struct resource *platform_get_resource(struct platform_device *dev,
 				       unsigned int type, unsigned int num)
@@ -70,6 +72,9 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  *        resource management
  * @index: resource index
  * @res: optional output parameter to store a pointer to the obtained resource.
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
  */
 void __iomem *
 devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
@@ -91,6 +96,9 @@ EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
  * @pdev: platform device to use both for memory resource lookup as well as
  *        resource management
  * @index: resource index
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
  */
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
@@ -106,6 +114,9 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
  * @pdev: platform device to use both for memory resource lookup as well as
  *        resource management
  * @index: resource index
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
  */
 void __iomem *devm_platform_ioremap_resource_wc(struct platform_device *pdev,
 						unsigned int index)
@@ -124,6 +135,9 @@ void __iomem *devm_platform_ioremap_resource_wc(struct platform_device *pdev,
  * @pdev: platform device to use both for memory resource lookup as well as
  *	  resource management
  * @name: name of the resource
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
  */
 void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
diff --git a/lib/devres.c b/lib/devres.c
index ebb1573d9ae3..a289b9d2f742 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -162,13 +162,15 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
  * region and ioremaps it. All operations are managed and will be undone
  * on driver detach.
  *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example:
+ * Usage example:
  *
  *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  *	base = devm_ioremap_resource(&pdev->dev, res);
  *	if (IS_ERR(base))
  *		return PTR_ERR(base);
+ *
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
  */
 void __iomem *devm_ioremap_resource(struct device *dev,
 				    const struct resource *res)
@@ -183,8 +185,8 @@ EXPORT_SYMBOL(devm_ioremap_resource);
  * @dev: generic device to handle the resource for
  * @res: resource to be handled
  *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example:
+ * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
  */
 void __iomem *devm_ioremap_resource_wc(struct device *dev,
 				       const struct resource *res)
@@ -207,8 +209,8 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
  * @node:       The device-tree node where the resource resides
  * @index:	index of the MMIO range in the "reg" property
  * @size:	Returns the size of the resource (pass NULL if not needed)
- * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
- * error code on failure. Usage example:
+ *
+ * Usage example:
  *
  *	base = devm_of_iomap(&pdev->dev, node, 0, NULL);
  *	if (IS_ERR(base))
@@ -219,6 +221,8 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
  * two drivers try to map the same memory, the of_iomap() function will succeed
  * but the the devm_of_iomap() function will return -EBUSY.
  *
+ * Return: a pointer to the requested and mapped memory or an ERR_PTR() encoded
+ * error code on failure.
  */
 void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
 			    resource_size_t *size)
@@ -256,6 +260,8 @@ static int devm_ioport_map_match(struct device *dev, void *res,
  *
  * Managed ioport_map().  Map is automatically unmapped on driver
  * detach.
+ *
+ * Return: a pointer to the remapped memory or NULL on failure.
  */
 void __iomem *devm_ioport_map(struct device *dev, unsigned long port,
 			       unsigned int nr)
-- 
Sent by a computer, using git, on the internet

