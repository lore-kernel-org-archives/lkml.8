Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57480C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F1720714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbMoMN09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgGWNJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgGWNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:09:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8051C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:09:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so5150655wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+kCNiTjOgccPUFcK1QBTuSbaCk+Ae80CxJOPhO94oQ=;
        b=zbMoMN09R+vY0MKqBYUY4Ifemnd2nzZZvHl+95cXAe78RLLF2G2UppaXYhhvSLTQJg
         Hqr0gKmVIC1OcZJ72G4vVROqzIUMHMKJ2f1fTHRQAJ0cpXqL6WENgXfBqcMvmJYpKVoz
         O6KaabT7Ij0HmN6qUIw6K/Mb9rRtGkFjWlZ1FwVVFHrjo9z4Kl2a8B1yc06Bm/utwnKE
         VrvVigWXNWjauqL1agdbmmL+i53g3wgJAuGOn+ZPqH+691U5gFvpmUYPY9+eoSHXamhN
         QHwaqGGgzso2dLu0a/5Uz5JlUmcn+mlrToCre3bFOq7l1kFCvzoYFptU/eieNrRvNBsS
         inMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+kCNiTjOgccPUFcK1QBTuSbaCk+Ae80CxJOPhO94oQ=;
        b=m+OA6VD1imKD/SfbXTsb14HEyUw8/QRCSLgxbG0b1uAPYTQJfiiyzLe9nOiKdYXTmt
         rUKphQjEYtL/rF4bmJf6T/K+W+6jmN/CRuiDgMwexI9Wj7bWJHz4qGEcCgfzLXpi/0Qu
         aO/RRGkPTcrcg/Y/dRKTJe7G5AY3mRnIgfmB0l9aymFU6UstEJAE86fdwIEqOV2zMy/w
         73yM38XAX2KMlyrS5Z+RvfoUTYCrUeTBfANxCajHmmcZXa8cgA1k3ft1gVjHTXL+EW6d
         AmMTV0lhE2h9uWImnTJTaIO+6xL4sn3k2A2e+65qv71IROaVEIgQEC9bCRoBdOlF3wAo
         lg6w==
X-Gm-Message-State: AOAM533OHT3+cNafnPKmDyu9JzVLnkVwgiF0sRB9pkSJNzwGdBqc1xTB
        m4P1m+nWcqLFO4GkiFpl2VsGKQ==
X-Google-Smtp-Source: ABdhPJz4e0aJewPYy7uh/Xs3tFu1upX0paTP2HOAXmVWvLuRADqRHfPWlicum4l/jqi4R0EhZGqWKg==
X-Received: by 2002:a1c:acc9:: with SMTP id v192mr3976604wme.164.1595509783572;
        Thu, 23 Jul 2020 06:09:43 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w7sm3594632wmc.32.2020.07.23.06.09.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:09:43 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] interconnect: Introduce xlate_extended() callback
Date:   Thu, 23 Jul 2020 16:09:37 +0300
Message-Id: <20200723130942.28491-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723130942.28491-1-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is the xlate() callback, which is provider-specific is
used for mapping the nodes from phandle arguments. This is fine for simple
mappings, but the phandle arguments could contain an additional data, such
as tag information. Let's create another callback xlate_extended() for the
cases where providers want also populate the tagging data.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 73 ++++++++++++++++++---------
 include/linux/interconnect-provider.h | 17 ++++++-
 2 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index befd111049c0..6ccf55818e68 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -336,12 +336,13 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Looks for interconnect provider under the node specified by @spec and if
  * found, uses xlate function of the provider to map phandle args to node.
  *
- * Returns a valid pointer to struct icc_node on success or ERR_PTR()
+ * Returns a valid pointer to struct icc_node_data on success or ERR_PTR()
  * on failure.
  */
-struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node_data *data = NULL;
 	struct icc_provider *provider;
 
 	if (!spec)
@@ -349,14 +350,33 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	mutex_lock(&icc_lock);
 	list_for_each_entry(provider, &icc_providers, provider_list) {
-		if (provider->dev->of_node == spec->np)
-			node = provider->xlate(spec, provider->data);
-		if (!IS_ERR(node))
-			break;
+		if (provider->dev->of_node == spec->np) {
+			if (provider->xlate_extended) {
+				data = provider->xlate_extended(spec, provider->data);
+				if (!IS_ERR(data)) {
+					node = data->node;
+					break;
+				}
+			} else {
+				node = provider->xlate(spec, provider->data);
+				if (!IS_ERR(node))
+					break;
+			}
+		}
 	}
 	mutex_unlock(&icc_lock);
 
-	return node;
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	if (!data) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return ERR_PTR(-ENOMEM);
+		data->node = node;
+	}
+
+	return data;
 }
 EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
@@ -403,7 +423,7 @@ EXPORT_SYMBOL_GPL(devm_of_icc_get);
 struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 {
 	struct icc_path *path;
-	struct icc_node *src_node, *dst_node;
+	struct icc_node_data *src_data, *dst_data;
 	struct device_node *np;
 	struct of_phandle_args src_args, dst_args;
 	int ret;
@@ -441,39 +461,46 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 
 	of_node_put(dst_args.np);
 
-	src_node = of_icc_get_from_provider(&src_args);
+	src_data = of_icc_get_from_provider(&src_args);
 
-	if (IS_ERR(src_node)) {
-		if (PTR_ERR(src_node) != -EPROBE_DEFER)
+	if (IS_ERR(src_data)) {
+		if (PTR_ERR(src_data) != -EPROBE_DEFER)
 			dev_err(dev, "error finding src node: %ld\n",
-				PTR_ERR(src_node));
-		return ERR_CAST(src_node);
+				PTR_ERR(src_data));
+		return ERR_CAST(src_data);
 	}
 
-	dst_node = of_icc_get_from_provider(&dst_args);
+	dst_data = of_icc_get_from_provider(&dst_args);
 
-	if (IS_ERR(dst_node)) {
-		if (PTR_ERR(dst_node) != -EPROBE_DEFER)
+	if (IS_ERR(dst_data)) {
+		if (PTR_ERR(dst_data) != -EPROBE_DEFER)
 			dev_err(dev, "error finding dst node: %ld\n",
-				PTR_ERR(dst_node));
-		return ERR_CAST(dst_node);
+				PTR_ERR(dst_data));
+		kfree(src_data);
+		return ERR_CAST(dst_data);
 	}
 
 	mutex_lock(&icc_lock);
-	path = path_find(dev, src_node, dst_node);
+	path = path_find(dev, src_data->node, dst_data->node);
 	mutex_unlock(&icc_lock);
 	if (IS_ERR(path)) {
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
-		return path;
+		goto free_icc_data;
 	}
 
+	if (src_data->tag && src_data->tag == dst_data->tag)
+		icc_set_tag(path, src_data->tag);
+
 	path->name = kasprintf(GFP_KERNEL, "%s-%s",
-			       src_node->name, dst_node->name);
+			       src_data->node->name, dst_data->node->name);
 	if (!path->name) {
 		kfree(path);
-		return ERR_PTR(-ENOMEM);
+		path = ERR_PTR(-ENOMEM);
 	}
 
+free_icc_data:
+	kfree(src_data);
+	kfree(dst_data);
 	return path;
 }
 EXPORT_SYMBOL_GPL(of_icc_get_by_index);
@@ -975,7 +1002,7 @@ int icc_provider_add(struct icc_provider *provider)
 {
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
-	if (WARN_ON(!provider->xlate))
+	if (WARN_ON(!provider->xlate && !provider->xlate_extended))
 		return -EINVAL;
 
 	mutex_lock(&icc_lock);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 4735518de515..4d535fddd5d3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -14,6 +14,17 @@
 struct icc_node;
 struct of_phandle_args;
 
+/**
+ * struct icc_node_data - icc node data
+ *
+ * @node: icc node
+ * @tag: tag
+ */
+struct icc_node_data {
+	struct icc_node *node;
+	u32 tag;
+};
+
 /**
  * struct icc_onecell_data - driver data for onecell interconnect providers
  *
@@ -39,6 +50,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @pre_aggregate: pointer to device specific function that is called
  *		   before the aggregation begins (optional)
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
+ * @xlate_extended: vendor-specific callback for mapping node data from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
  * @inter_set: whether inter-provider pairs will be configured with @set
@@ -52,6 +64,7 @@ struct icc_provider {
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
+	struct icc_node_data* (*xlate_extended)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
 	bool			inter_set;
@@ -105,7 +118,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
-struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
+struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -157,7 +170,7 @@ static inline int icc_provider_del(struct icc_provider *provider)
 	return -ENOTSUPP;
 }
 
-static inline struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+static inline struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
