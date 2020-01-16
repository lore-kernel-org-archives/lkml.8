Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5233AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30724217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197983;
	bh=6s4DY5vFuk1MPXt3XMN5fXF/0e2WZmccWRzMKMvYnYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FA+panWsfHO5eCMyzyVYbox6C7WpmlOeEbY5AY3mPgeWyOJshtQ8j87O+XNGzciHT
	 Ie06DIOQ3Dq55ti1xgxMXYcbEosIF1Wx/Xq2+FUxHd1u92tVPYxrFZOA+b5opQvl3W
	 wf7IOnF+c2knBkCMUF5WWwkJXlvnAUt2Aq/0mgGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgAPSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393503AbgAPRjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C292471B;
        Thu, 16 Jan 2020 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196382;
        bh=6s4DY5vFuk1MPXt3XMN5fXF/0e2WZmccWRzMKMvYnYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRbPZFqruD6exky69w4eAarPx/Obmr32XezfgacgD7vMNDz6bvOpBCTmdb0J1GmM9
         ZbVf3HTzMtKecQ20XFTlVx+9sdcTLATHzoJgyLWtiZGIHMj9pDB5uPm5lR4Jb9YFRm
         KhBgkMoVZA96L69AY4wz0JtLVKhLPLVbijAiHPas=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 165/251] devres: allow const resource arguments
Date:   Thu, 16 Jan 2020 12:35:14 -0500
Message-Id: <20200116173641.22137-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index 8d732965fab7..eb865b461acc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -682,7 +682,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res);
 
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/lib/devres.c b/lib/devres.c
index cb1464c411a2..38912892053c 100644
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

