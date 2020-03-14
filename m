Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E88C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08E32071B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxS94f2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCOB6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:58:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46804 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgCOB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:58:33 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so13604187iom.13;
        Sat, 14 Mar 2020 18:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSELmPcfJ7GZk6iuqy9bvAzOT2E/K3mgaQgMY60UuWc=;
        b=CxS94f2uz3d3wbzHTc7w0dwEryWR83xfJqmGN12gtM+yTzChjKb3z2ExrRZGQosZOL
         pJqYviClFLHtERFl9qB2/xzo3+ldCeacoXaMBakTKo7IWKTYr52P8B1Cwt+YnUMBGIbC
         pbB1hNyhl6UTZUuuhkYcPuDXy/JJBaI7m95+uHixL/oGVWMXTAN+j5U9zoK+WzDlWWww
         rSnEYUeVQ0dH8k9CDyiRChKgaoromlv+u57c1FQkYJBs6d9opZYEdFpGTzjaQSjrPh16
         Et639k4MaRaaQ9CBq+ST1xCYS7Eda1nxNIzxHaaqVO7F8DNlT+PXoKtGvkUFxHHdMqih
         Hjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSELmPcfJ7GZk6iuqy9bvAzOT2E/K3mgaQgMY60UuWc=;
        b=Ps4f1khyuxH9lsQHA9HZ/cfxzqv+IsKIJh1IT9jJldpNi8S+1Fo2ZHHgUSwgRu/sxk
         ClLgrV1APMPHHc8RNm3JC7bHbd4c4o3JFTPv5z/wSC+B9M6hPTggrwwzd5QFx88xix30
         OKzZFpz6Gd1hCAZ7fNvXTF0c0zldlkiL9Dmu5YT8r6/gcOXSuS3x/muAYW4DE6nUC7UX
         TvSMOEcovKwfBg4ybwl8Q/yMGqy6QLRWTA067VYAdzxAM5OD6Hou+3Xhmbu+hpcXfMPV
         t51vOhwK/A3mPJIHK1o97c2ooZIPbfzOtDIcNJmbB+ayhQ05wOhcmtyypJnlkO0ULIK1
         5Qaw==
X-Gm-Message-State: ANhLgQ2ViD2NQEZHUY8fe0DptyJNOwc8MxwuASVQLXj0SDtUGKhv/6fA
        5IEqV1jsZ10Wj2eXRT4QLTqNiu+7
X-Google-Smtp-Source: ADFU+vvQKs0h9RIxP0ffPnpQ86QE+/b+ZMvImSCM5t+dNQ/D+DPOb37qd06aUPgXK56mCYhZkJsGaQ==
X-Received: by 2002:a63:7c0f:: with SMTP id x15mr16552303pgc.173.1584163615702;
        Fri, 13 Mar 2020 22:26:55 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id o128sm26760063pfg.5.2020.03.13.22.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 22:26:55 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert@linux-m68k.org, mchehab+samsung@kernel.org,
        treding@nvidia.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        hdegoede@redhat.com, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 1/4] drivers: provide devm_platform_ioremap_and_get_resource()
Date:   Sat, 14 Mar 2020 13:26:35 +0800
Message-Id: <20200314052638.6008-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200314052638.6008-1-zhengdejin5@gmail.com>
References: <20200314052638.6008-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "drivers: provide devm_platform_ioremap_resource()",
It was wrap platform_get_resource() and devm_ioremap_resource() as
single helper devm_platform_ioremap_resource(). but now, many drivers
still used platform_get_resource() and devm_ioremap_resource()
together in the kernel tree. The reason can not be replaced is they
still need use the resource variables obtained by platform_get_resource().
so provide this helper.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..b3e2409effae 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -62,6 +62,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
 #ifdef CONFIG_HAS_IOMEM
+/**
+ * devm_platform_ioremap_and_get_resource - call devm_ioremap_resource() for a
+ *					    platform device and get resource
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ * @res: get the resource
+ */
+void __iomem *
+devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res)
+{
+	*res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource(&pdev->dev, *res);
+}
+EXPORT_SYMBOL_GPL(devm_platform_ioremap_and_get_resource);
+
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 276a03c24691..5fd1977e3eaf 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -55,6 +55,9 @@ extern struct device *
 platform_find_device_by_driver(struct device *start,
 			       const struct device_driver *drv);
 extern void __iomem *
+devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res);
+extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
-- 
2.25.0

