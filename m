Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F249C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AC24681
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197148;
	bh=URLMyFA5OyAqy8XaRhkLkiQrA0i64bDb8l7lyFP+zeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmNv7Bofd/cptQJHzzxdkGRT0j40cUe93vp4A9nTEj1gVHqxzg/A6IcwxnQfh+glT
	 sztLI25zqyy8R/KrjidQ8ug8vZeQUPQz7z+Q9fW7C8AGRUxzAqEtvhbnkH/Cje+Zjk
	 BjWSfboRLby1vOWZuXR4Eb63a4+2UcVp2kAr8z9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406393AbgAPRw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgAPRpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0BC24785;
        Thu, 16 Jan 2020 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196722;
        bh=URLMyFA5OyAqy8XaRhkLkiQrA0i64bDb8l7lyFP+zeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgXmD9l2u4t8pd3qeCzkPOVYzbmOqlPZpYg/kJfDlbs64pX2CVu0QdGJBy3223ZQj
         S6R8EHY5r+CBLCm+7L/1nQnumVryNmOBddRmTSZa+Q8D4VUi9XkiSzNZ0vA8I/W58w
         nx8Y6kc4dtyfhmOJlfN0u8s8Fqs9uCMRzG+37fAE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 108/174] devres: allow const resource arguments
Date:   Thu, 16 Jan 2020 12:41:45 -0500
Message-Id: <20200116174251.24326-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9dea44c91469512d346e638694c22c30a5273992 ]

devm_ioremap_resource() does not currently take 'const' arguments,
which results in a warning from the first driver trying to do it
anyway:

drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
drivers/gpio/gpio-amd-fch.c:171:49: error: passing argument 2 of 'devm_ioremap_resource' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
                                                 ^~~~~~~~~~~~~~~~~~~

Change the prototype to allow it, as there is no real reason not to.

Fixes: 9bb2e0452508 ("gpio: amd: Make resource struct const")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20190628150049.1108048-1-arnd@arndb.de
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviwed-By: Enrico Weigelt <info@metux.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device.h | 3 ++-
 lib/devres.c           | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 834000903525..eb891c9c4b62 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -677,7 +677,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res);
 
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/lib/devres.c b/lib/devres.c
index 8c85672639d3..9d18ccd00df5 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -131,7 +131,8 @@ EXPORT_SYMBOL(devm_iounmap);
  *	if (IS_ERR(base))
  *		return PTR_ERR(base);
  */
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res)
 {
 	resource_size_t size;
 	const char *name;
-- 
2.20.1

