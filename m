Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB7C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7695F206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQOyM7/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgDCS46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:56:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36506 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCS4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:56:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id d202so8879858wmd.1;
        Fri, 03 Apr 2020 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txVIaesih13l/9cul7wiESTE+lC3qiPDoOtfFDGAAi0=;
        b=cQOyM7/B7NukrYmRDzzGJbcWOBuW355ZrRkxEDYHxgLT6huwUbScssTa2csuN8eg2g
         zx34eJ1qorupuPLhC0BPtajBXN17hQQAeP128xTRY7CHiaK/HpGnHYXN06lSKIVnIJVQ
         IN3nTpAiexx2xvHy3TlBYfcPdU/9y95p4DRQz05KIKJ9V5wbWrFgG62VCj+Hz6B27snP
         QivB/Gzl4hFzYsRSd4FdjMVPVUQut6KohrJRWThHKmquC1/rfr8vOue5bmeotwBKfFKq
         P4kQvpyvAJLwcqz3grcnAkmdv/kWREycNYqRI9YwVrGsNshIpyK/lFnjCJ3OLpouEwC9
         N7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txVIaesih13l/9cul7wiESTE+lC3qiPDoOtfFDGAAi0=;
        b=rr23D/hxYjRNIFUTOM5lR5Hflkwew9XkIsENolgcW/sDKLr/XnTBS5CkqUru0kqpjE
         JeKahZPSDsT38RbU18CQcxxyHK0OOXjt84LnqyHNfm+78e004WKG63f5A8U9Xr0Bww+H
         WIhuEA3RiNzjTKNa6e473pknfP0adZW8Ph3ffDdxJ4n2y8JkQzy6iR4+NMMTgKWZitEm
         IAuydIwJruq/IaDwSK+/I7FHgqQsYoNVzx57Il1hOsoo22IBIO5zgDqWNLYEYArj+deT
         m6cY/ge+ENz4l/mAyc9/PpDhC/Yu9J4p+eTXobfW1tbKwkovAbrfQJItk+DSf7OY9w3x
         Yf/w==
X-Gm-Message-State: AGi0PuYNsILnyUNBfIAkSnR1wKdUButCZbd7AgdYvo0nGhK2I/Xt1l/q
        5fZ2tWOvn04ZbmokYHEDT8s=
X-Google-Smtp-Source: APiQypJlElUmRpe8S2/GgPXLMEBdQ0BSwLhNR3MQaRa7vNDVPhtCN5mhA4DI6PDPdvuYav/r5poGgQ==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr9893043wmg.20.1585940212599;
        Fri, 03 Apr 2020 11:56:52 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id n7sm12592296wmf.4.2020.04.03.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:56:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] of: reserved-memory: Support lookup of regions by name
Date:   Fri,  3 Apr 2020 20:56:39 +0200
Message-Id: <20200403185640.118569-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403185640.118569-1-thierry.reding@gmail.com>
References: <20200403185640.118569-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add support for looking up memory regions by name. This looks up the
given name in the newly introduced memory-region-names property and
returns the memory region at the corresponding index in the memory-
region(s) property.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/of_reserved_mem.c    | 19 +++++++++++++++++++
 include/linux/of_reserved_mem.h | 11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 62a35422c28d..dae70b147552 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -360,6 +360,25 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_by_idx);
 
+/**
+ * of_reserved_mem_device_init_by_name() - assign named reserved memory region
+ *					   to given device
+ * @dev: pointer to the device to configure
+ * @np: pointer to the device node with 'memory-region(s)' property
+ * @name: name of the selected memory region
+ *
+ * Returns: 0 on success or a negative error-code on failure.
+ */
+int of_reserved_mem_device_init_by_name(struct device *dev,
+					struct device_node *np,
+					const char *name)
+{
+	int idx = of_property_match_string(np, "memory-region-names", name);
+
+	return of_reserved_mem_device_init_by_idx(dev, np, idx);
+}
+EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_by_name);
+
 /**
  * of_reserved_mem_device_release() - release reserved memory device structures
  * @dev:	Pointer to the device to deconfigure
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 60f541912ccf..a1b427ac291b 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -33,6 +33,9 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
+int of_reserved_mem_device_init_by_name(struct device *dev,
+					struct device_node *np,
+					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
 
 void fdt_init_reserved_mem(void);
@@ -45,6 +48,14 @@ static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 {
 	return -ENOSYS;
 }
+
+static inline int of_reserved_mem_device_init_by_name(struct device *dev,
+						      struct device_node *np,
+						      const char *name)
+{
+	return -ENOSYS;
+}
+
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
 static inline void fdt_init_reserved_mem(void) { }
-- 
2.24.1

