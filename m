Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A384C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66148207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS4A2h3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgFIKsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgFIKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:47:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B0C08C5C5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 03:47:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so1831577ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/5WnBa7fJn+pPKP5P8jfdYigZEMgAeAJ+nmAq9FbnZM=;
        b=hS4A2h3J+Pci4Lw+anaXS2PuQgAH2hIHxpqd0ezXZxBZ9me+hfgdQg5mvHjcq8SUiO
         EuY6p0NBvRb45UuQrdbwSLXcPmCxwBvC1lHF5LyVoiaJ8Sx7LThvB+VK7ZsHRno9Y2uz
         6SBK2Nd8vb3GB5GOe8DWi6HPJvQeRk3hvhBy5OICiWc0tGOHQHpN2pIM2xv/FIUgpWI6
         D+4lRUw0r9eb4u0Y5WU5nkzEVplGGsS2HlRlIsldw/wj3Ik+gd67w1NVDuyHJGq/QF/p
         77MD86DPubivo8gbrQsAWCFwqMs/4ctENZres/LCUYw3JixwjJNmIkS6ZdOBqPwqK80t
         UO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/5WnBa7fJn+pPKP5P8jfdYigZEMgAeAJ+nmAq9FbnZM=;
        b=dVaDYOp9CdnLEIAjS96ZCtSImc8KoZyGCnNMdYPNoHj9WfSkUWLdgqV+pTw23LsiYw
         iML+eSvbCHFrtAYyl27pmcsddTtZ3x06Z+OmofQrh47sumK6neSx1XBaFppGzH//CVAg
         T3LMV5KrB7gYNZfEeEoST46lOXT5TrOxeu1MzGqwGSQZfGFIlcLAiQmGhqjmGQLxC/Nc
         QQDKUBcgBh7waWoZ5RiqyX/16UOVs36ihsfjl8wRlDgCnpsjjih+hmjNKWZr57ZdB0Lx
         RmzhcAXTNsCYVVpqnm43gQbhH3MSaS/3I6QVHuUMKpcDxjjlDDNIMvw8aA86H6WXq5o7
         4wdw==
X-Gm-Message-State: AOAM532UtQl5ZETHpXEjPkAzgFreA6kDxMT/dyt6Lf7S/LhRYrlosyow
        RKWO81P0/VWHs4hG1XTZKqHtkw==
X-Google-Smtp-Source: ABdhPJzH/K2NQQ2rv61OJWPAnFYGeM8y8y32U0bjShreSrArNp7+PSoZt2khzLblWMU0Eg0n23fgQA==
X-Received: by 2002:a17:907:ab9:: with SMTP id bz25mr24488816ejc.39.1591699659825;
        Tue, 09 Jun 2020 03:47:39 -0700 (PDT)
Received: from localhost.localdomain (hst-221-69.medicom.bg. [84.238.221.69])
        by smtp.gmail.com with ESMTPSA id qt19sm12267763ejb.14.2020.06.09.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 03:47:39 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 3/7] dev_printk: Add dev_dbg_level macro over dynamic one
Date:   Tue,  9 Jun 2020 13:46:00 +0300
Message-Id: <20200609104604.1594-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dev_dbg_level macro wrapper over dynamic debug one for
dev_dbg variants.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 include/linux/dev_printk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 7b50551833e1..d639dc60d84d 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -112,15 +112,24 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define dev_dbg(dev, fmt, ...)						\
 	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_dbg_level(dev, lvl, fmt, ...)				\
+	dynamic_dev_dbg_level(dev, lvl, dev_fmt(fmt), ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg(dev, fmt, ...)						\
 	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_dbg_level(dev, lvl, fmt, ...)				\
+	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #define dev_dbg(dev, fmt, ...)						\
 ({									\
 	if (0)								\
 		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
 })
+#define dev_dbg_level(dev, lvl, fmt, ...)				\
+({									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+})
 #endif
 
 #ifdef CONFIG_PRINTK
-- 
2.17.1

