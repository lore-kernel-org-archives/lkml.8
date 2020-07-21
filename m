Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA23AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F76208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apmv1SMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGUFpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUFpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:45:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFC3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 22:45:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i3so13096650qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 22:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TREar1MO2dsLwpnPrx9gwj7yD63VFVL8bjf4tFYmBsU=;
        b=apmv1SMniLyVP9DP8KpPXG7RQHOGN/fSC0pWUwKU4iyWw1wJHLTBLr9qo+HGEHWvT1
         swKqZoFolFmggo4Cc+ufeVeyFR7xB6wibB068ZGt6DKq3tBcTW1dh+5sYnKZHVvEjQUO
         6rhy03ouhnuF6qOdmivW9gN/97XA4291+spP/i1Gk0AU3ieZHacv1G+9YY8t3KxFZTCU
         qQLqLUgapsMx7zZ/Gk59hAi8urEfOijeVxZBHqWeRkOyuUt/DQ4m/1QepoFDGzz7s0z+
         97bo2KFXq2HYguOxwI+3RkyuCwf0CL06WAfuMBue657xdx/IxQYRuNhM2vlTQQ62CDBG
         AVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TREar1MO2dsLwpnPrx9gwj7yD63VFVL8bjf4tFYmBsU=;
        b=YR9Obs4Ouu3MOT647cQBb4agtKDnmzsJd87VB+4vQauem5cOLP8luRkUz2ApWXd9eY
         btq43PdXGcIsXKoMVqpBxR3jeCQtsIfGBjK8dHrgsLsAkEjJ99COtfEr27SGfrw7o7Rm
         KTBGZTwkmt5TWmEg84VDrGDO9qCFbZIh4RafqnpCK36eLKXZyuSAEbXyCTKrzXbGuRol
         a7Fkj2SFIzqjiUjPT7rKfXqCb630o6ODqTrNig2AqWEaqp7JM8IDAT3RQ6PR+wEfpO2P
         JBppQsSc+XwLjnsH9HAOlJU3LrsdrMMgFpyFF132cneFfTAZz3kwz1WsC3xMobS4s3fH
         jJYg==
X-Gm-Message-State: AOAM531OXJ162UKhF59BV4XZE5JTlCofhxyVzEVLx7icVv1Zj8vpmbYy
        fvrDgmlPq4VfLmeYG04sEkUN6bM0MPGhDA==
X-Google-Smtp-Source: ABdhPJz9eYdF6Y8P16PshMHLBCfnnfJcQ+KbbT0G2k1BgzIqZJH7K+ErSTQxW2A37QxhMw2uUlIqOn2gw+wz3A==
X-Received: by 2002:a0c:b712:: with SMTP id t18mr25194014qvd.205.1595310336945;
 Mon, 20 Jul 2020 22:45:36 -0700 (PDT)
Date:   Mon, 20 Jul 2020 22:45:28 -0700
Message-Id: <20200721054528.2556267-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [RFC PATCH] platform: ioremap: Build iomap functions even without HAS_IOMEM
From:   David Gow <davidgow@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Dike <jdike@addtoit.com>, rafael@kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of drivers use devm_platform_ioremap_resource(), but do not (or
did not) explicitly depend on IOMEM[1,2]. Given that the only platform
without HAS_IOMEM seems to be UML, and it has sufficient stubs for
devm_platform_ioremap_resource() and its dependencies to build, we can
remove the HAS_IOMEM requirement here, rather than playing whack-a-mole
with different drivers which don't try to build against ARCH=um.

The reason this works at the moment is that stub ioremap and iounmap
functions were added to UML to support this sort-of thing[3]. This
particular change doesn't require adding any additional stubs, but there
is possibly room in the future to stub out the remaining iomem functions
(or to provide mock implementations for testing), and get rid of
HAS_IOMEM entirely.

[1]: https://lkml.org/lkml/2020/6/30/176
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e7468bd9d30a21e059af477106dc5588ae52dff
[3]:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1405627.html

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/base/platform.c | 2 --
 lib/Makefile            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c0d0a5490ac6..628dde6675cf 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -61,7 +61,6 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-#ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
  *					    platform device and get resource
@@ -135,7 +134,6 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, res);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
-#endif /* CONFIG_HAS_IOMEM */
 
 /**
  * platform_get_irq_optional - get an optional IRQ for a device
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..35c21af33b93 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -115,7 +115,7 @@ obj-y += math/ crypto/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
-obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
+obj-y += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

