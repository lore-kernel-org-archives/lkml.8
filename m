Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D859C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A7222522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA2vPBq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAUHX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:23:58 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54427 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUHX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:23:58 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so929030pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 23:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mlCaxydkOgZv4ICsJLgzeMxdhOBrk2+0L4LhoOYBItQ=;
        b=YA2vPBq0mvDVXP8id2Mt+w6fhK+0j+w96F+sTtR46ecrXWWm5mihMNdZA0EBwrxV5W
         T48gHL/VukRPT0lY0JDHqc85r9U9TVwS3pK/EytkWy6PzFgod7I0J/kygHhxCb82K6cR
         MgY6eXsdO6BLOnxHwfKKiYer/PjvxC90hiygpj0qZUgNmAvTkAtX85gBk1KxNObDFy8A
         YP1t0c0RyG1xCX0GmabiEt7hNp84d4+SNrZh1v3cN9iBaS55hdxKvjbFhZP0025kRkxT
         rOAC7VuqnvTQsJBQvIQlzhe1MfUt+7Qi3zskvjw8gVAYT6WWhCCx3zRFu0LAv81aXO0U
         NwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mlCaxydkOgZv4ICsJLgzeMxdhOBrk2+0L4LhoOYBItQ=;
        b=NmEY2LNAPU+CUG/AwUYh4mq3uDkrm+OO0doT1H1kA2H8XEWGKP6NKNtFaHmLOE71AG
         pOwbXbsTf5NWo4gejceggLiA14N3qemvLbkVN7JZJHRPsN7rvfX+ysTO/mua3l0YvDMc
         N1ZAUvuNIrNc6EiNNKLcsUuqvD1TJd5Vjzxqfc8GYJz+pDuv7EVSwxIOY9Azw7eU3y4H
         IJIb6RrsiV8+ceqycieF96JsSIeGpreDr4g9lu8siEY6Sz9kVzwGF7R8gJT+06waiPNm
         1eH6y+/01noXm2O6UG/Xgn+sVEvEiQo5QKTl5JapGyQ/MHJYG5R2cf1RqvPTg5dNyKuY
         txFg==
X-Gm-Message-State: APjAAAU+lpUQugrm5vad7h/7aa19yRWpDCRIgALS/PkJ+rMAC+Q9XaG2
        NHz/HP2I+M95bRlmtjsE0Og=
X-Google-Smtp-Source: APXvYqxH90T8L70K8dJA329+Zf1S8Be+Rn1LWaWxcGb0IEj638DwpurPkx5Mc1G8s06NbyFGNq0xAA==
X-Received: by 2002:a17:90b:8b:: with SMTP id bb11mr3865357pjb.27.1579591437792;
        Mon, 20 Jan 2020 23:23:57 -0800 (PST)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a9sm41495866pfn.38.2020.01.20.23.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jan 2020 23:23:57 -0800 (PST)
From:   Orson Zhai <orson.unisoc@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, baolin.wang@unisoc.com,
        chunyan.zhang@unisoc.com, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH V5] mfd: syscon: Add arguments support for syscon reference
Date:   Tue, 21 Jan 2020 15:09:38 +0800
Message-Id: <1579590578-8709-1-git-send-email-orson.unisoc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

There are a lot of similar global registers being used across multiple SoCs
from Unisoc. But most of these registers are assigned with different offset
for different SoCs. It is hard to handle all of them in an all-in-one
kernel image.

Add a helper function to get regmap with arguments where we could put some
extra information such as the offset value.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
Tested-by: Baolin Wang <baolin.wang@unisoc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Change V5:
	Removed unexpected preceding spaces replaced by email system.
	The patch has been tested for local mailing and applying.

 drivers/mfd/syscon.c       | 29 +++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h | 14 ++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index e22197c..2918b05 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -224,6 +224,35 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);

+struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
+					const char *property,
+					int arg_count,
+					unsigned int *out_args)
+{
+	struct device_node *syscon_np;
+	struct of_phandle_args args;
+	struct regmap *regmap;
+	unsigned int index;
+	int rc;
+
+	rc = of_parse_phandle_with_fixed_args(np, property, arg_count,
+			0, &args);
+	if (rc)
+		return ERR_PTR(rc);
+
+	syscon_np = args.np;
+	if (!syscon_np)
+		return ERR_PTR(-ENODEV);
+
+	regmap = syscon_node_to_regmap(syscon_np);
+	for (index = 0; index < arg_count; index++)
+		out_args[index] = args.args[index];
+	of_node_put(syscon_np);
+
+	return regmap;
+}
+EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 112dc66..714cab1 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -23,6 +23,11 @@ extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
+extern struct regmap *syscon_regmap_lookup_by_phandle_args(
+					struct device_node *np,
+					const char *property,
+					int arg_count,
+					unsigned int *out_args);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -45,6 +50,15 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static struct regmap *syscon_regmap_lookup_by_phandle_args(
+					struct device_node *np,
+					const char *property,
+					int arg_count,
+					unsigned int *out_args)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif

 #endif /* __LINUX_MFD_SYSCON_H__ */
--
2.7.4

