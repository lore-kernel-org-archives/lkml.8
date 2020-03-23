Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74ECC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CDB20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soYPO72n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCWQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:06:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33745 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgCWQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:06:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so6846130pgo.0;
        Mon, 23 Mar 2020 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vadeapgvAVIS4ucGk0m/TsoQZJykoxM6aQhRpzbLpw=;
        b=soYPO72n5SO8kgJCLxgG8itEzeFgkOfpEXVZxPLFCzKRDrbdeJx1GcM8Dm5Chce4uX
         CqtHHc3BPOecv71LBZ7J543GBadGiOi758/nbdK23igXDSYorWRLUeaD7tnXnLxc6XmJ
         WtEkSIYWe3LgANdjX9wCaITuqQanE4YG/InEHtc7S5DFdxFZYi5C2/qFgBHnqNWj/iLi
         4PsiqmfJuaZEaxQIH3Cp+/j0tPqi3J6aEJccVrv1E+GswGryK1nV5h1UdRB2FNRHAlGK
         /EXFuf8cNFMpmaISK+XlrWmXHnzBNRenB0Hmw+DcD86fvjf7kc3Iy26QCwfjO8U+Hacw
         99gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vadeapgvAVIS4ucGk0m/TsoQZJykoxM6aQhRpzbLpw=;
        b=b8L73q0PW4tL1dEgmOlqr9FyuFzgWBzLhYqoUF94RKisjyqp5MJkJ4TsIyqLDl+asf
         aTYuVZ1N4SGoD8vGT2enXl0YN5fudYt9VuzdJDS+wCFwFwKgGtNX7qK4MrOsUxtVBgmy
         i+P1NIny6c5E0yV7YImTJWdTwQKz951rMiw5iQrbgOhFMuNjKKNrDf5eNdVgHloT8rm6
         yN9p7YjHuzJansRzxs3N0naTmRNPGIrJLL75qV4UIfZsiHSm8TfPckSrqWCBjvrq7Ezv
         DvFTbVVvIghzr2SI+qczPTS6XKMV+oLkm9H5U5BOidlQBTk0S873/Y84EUv1F6hWDqQj
         UZHw==
X-Gm-Message-State: ANhLgQ07C73q8Z0uigGqFU7Fw+tNqAymDk8s6ZMy5lk2pD82gNZ7qTKP
        0+MeJ7VaZLPWcadA+NvqHuI=
X-Google-Smtp-Source: ADFU+vvYMzvc0GXLzvLyRT7VWz418J6d/bFrjdluY2NCNGq2loprCmphIcNLM4Z6hVXEByZiL6HKfw==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr22236847pgc.226.1584979587402;
        Mon, 23 Mar 2020 09:06:27 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id a13sm20660pjh.7.2020.03.23.09.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:06:26 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert+renesas@glider.be, tomas.winkler@intel.com,
        tglx@linutronix.de, hdegoede@redhat.com, treding@nvidia.com,
        suzuki.poulose@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v4 1/5] drivers: provide devm_platform_get_and_ioremap_resource()
Date:   Tue, 24 Mar 2020 00:06:08 +0800
Message-Id: <20200323160612.17277-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323160612.17277-1-zhengdejin5@gmail.com>
References: <20200323160612.17277-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "drivers: provide devm_platform_ioremap_resource()",
it was wrap platform_get_resource() and devm_ioremap_resource() as
single helper devm_platform_ioremap_resource(). but now, many drivers
still used platform_get_resource() and devm_ioremap_resource()
together in the kernel tree. The reason can not be replaced is they
still need use the resource variables obtained by platform_get_resource().
so provide this helper.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v3 -> v4:
	- modified the description of the parameter res in this patch.
v2 -> v3:
	- rename the function to
	  devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
	- make the last parameter res as optional by Geert's suggestion.

v1 -> v2:
	- No change.

 drivers/base/platform.c         | 22 ++++++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..3e8a9fb91dcd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
 #ifdef CONFIG_HAS_IOMEM
+/**
+ * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
+ *					    platform device and get resource
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ * @res: optional output parameter to store a pointer to the obtained resource.
+ */
+void __iomem *
+devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (res)
+		*res = r;
+	return devm_ioremap_resource(&pdev->dev, r);
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
+
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8e83c6ff140d..8aa6b448450f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -55,6 +55,9 @@ extern struct device *
 platform_find_device_by_driver(struct device *start,
 			       const struct device_driver *drv);
 extern void __iomem *
+devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res);
+extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
-- 
2.25.0

