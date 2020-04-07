Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F406DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669720771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1hIVeMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDGVM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:12:56 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48182 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDGVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:12:52 -0400
Received: by mail-vk1-f201.google.com with SMTP id g7so1830142vkk.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MaBweOlch11HKb9t7GCZeN/zarBri4qPTIweTTR7A04=;
        b=U1hIVeMgswPvziZ0ENUZYnzyWBhSCYX1bi1rARPXO57w/nzGQOlElGD5smfdBFlgwG
         gXCN6YdCQeatvDTyqJdkgZuBP8CiZ+Hj3VRJHszvMVDyns+C/E9Q8C/y6yxRFeTTGWoM
         GG1+jjyR0teAgUt91n/wzDszB+8msDgtD7ByUeko2Qpj4m22zRPp5ALbgoPr/uVvFgbQ
         TTfUs8RpRc30TRfkI6SzWRYi6WgM/NLDDnXf7s3wFlY60H6B93LrYlmWtMw04W7Vrb+T
         g4C1jYezUSJ/DNkuS09urOiqpdkeYzOib6zl5qhTxluDPNqAVmIR11J75YVKeTCRsxBW
         LM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MaBweOlch11HKb9t7GCZeN/zarBri4qPTIweTTR7A04=;
        b=KlHIuS72IEIdmxosYoE/D/wlouNFPh6lL80craloTh89HzT4RzNxQ1yWITh5TsEs4Z
         fICyLr3+sxTGBpybMRICvCIT1ic5LZhRzuro9kMjn/HikIhwCt+/KdRGI3DOJjNspjzg
         mcnt8pmA0lPfV5G2qCMD2Jn+x5M+b0VkIZX4iezUajA4XmOlAOyOCaqzFUFhCLyIdi8z
         SwelwNJSgGiM/p/1q9LRvfh0LCs7qmHvuGmSoGmhzQ5MGsYOnRNNMhHmxlwG2f2E32fH
         96/jiFJdv+7GxiJzLuZh9xy5FSMGuq0L4x2lGL4ExQnkX/9pGM3T242sP3uhcKfMaIx6
         kw7g==
X-Gm-Message-State: AGi0Pua0ShRsmgJfMHCdjFlA7AkMBK4n/bM8j3Nsd2R/72ZozNQCZvCy
        9lsnTVoxtqaJJLL444xc53GB2anj978=
X-Google-Smtp-Source: APiQypK5y0nSomIW5VQaxOMuV0GGky2G/aipZdtaQUPbQUivIeAbJmE6e/0rAFwdiqwLJNImOtnXxJ/ZUpM=
X-Received: by 2002:ab0:764a:: with SMTP id s10mr3176845uaq.1.1586293969257;
 Tue, 07 Apr 2020 14:12:49 -0700 (PDT)
Date:   Tue,  7 Apr 2020 14:12:43 -0700
Message-Id: <20200407211243.247362-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v1] power_supply: Add a helper function to retrieve psy array
 from phandle
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

power_supply_get_by_phandle retrieves power_supply object based on
phandle. However, when multiple power_supply objects are registered
by the same parent device the first power_supply object's reference
is returned. This varies according to probe order. Add a helper to
return all the power_supply object's reference.

The caller has to provide the power_supply pointer array.
-EOVERFLOW is returned when the size of the array is not enough to
pass back all the power_supply objects.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/power/supply/power_supply_core.c | 78 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  9 +++
 2 files changed, 87 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1a9a9fae73d32..e7bab4661ba13 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -32,6 +32,13 @@ EXPORT_SYMBOL_GPL(power_supply_notifier);
 
 static struct device_type power_supply_dev_type;
 
+struct match_device_node_array_param {
+	struct device_node *parent_of_node;
+	struct power_supply **psy;
+	ssize_t psy_size;
+	ssize_t psy_count;
+};
+
 #define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
 
 static bool __power_supply_is_supplied_by(struct power_supply *supplier,
@@ -522,6 +529,77 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
 
+static int power_supply_match_device_node_array(struct device *dev,
+						void *data)
+{
+	struct match_device_node_array_param *param =
+		(struct match_device_node_array_param *)data;
+	struct power_supply **psy = param->psy;
+	ssize_t size = param->psy_size;
+	ssize_t *count = &param->psy_count;
+
+	if (!dev->parent || dev->parent->of_node != param->parent_of_node)
+		return 0;
+
+	if (*count >= size)
+		return -EOVERFLOW;
+
+	psy[*count] = dev_get_drvdata(dev);
+	atomic_inc(&psy[*count]->use_cnt);
+	(*count)++;
+
+	return 0;
+}
+
+/**
+ * power_supply_get_by_phandle_array() - Similar to
+ * power_supply_get_by_phandle but returns an array of power supply
+ * objects which are associated with the phandle.
+ * @np: Pointer to device node holding phandle property.
+ * @property: Name of property holding a power supply name.
+ * @psy: Array of power_supply pointers provided by the client which is
+ * filled by power_supply_get_by_phandle_array.
+ * @size: size of power_supply pointer array.
+ *
+ * If power supply was found, it increases reference count for the
+ * internal power supply's device. The user should power_supply_put()
+ * after usage.
+ *
+ * Return: On success returns the number of power supply objects filled
+ * in the @psy array.
+ * -EOVERFLOW when size of @psy array is not suffice.
+ * -EINVAL when @psy is NULL or @size is 0.
+ * -ENODEV when matching device_node is not found.
+ */
+int power_supply_get_by_phandle_array(struct device_node *np,
+				      const char *property,
+				      struct power_supply **psy,
+				      ssize_t size)
+{
+	struct device_node *power_supply_np;
+	int ret;
+	struct match_device_node_array_param param;
+
+	if (psy == NULL || size == 0)
+		return -EINVAL;
+
+	power_supply_np = of_parse_phandle(np, property, 0);
+	if (!power_supply_np)
+		return -ENODEV;
+
+	param.parent_of_node = power_supply_np;
+	param.psy = psy;
+	param.psy_size = size;
+	param.psy_count = 0;
+	ret = class_for_each_device(power_supply_class, NULL, &param,
+				    power_supply_match_device_node_array);
+
+	of_node_put(power_supply_np);
+
+	return param.psy_count;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_by_phandle_array);
+
 static void devm_power_supply_put(struct device *dev, void *res)
 {
 	struct power_supply **psy = res;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index dcd5a71e6c677..8c1478a480674 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -366,12 +366,21 @@ extern void power_supply_put(struct power_supply *psy);
 #ifdef CONFIG_OF
 extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 							const char *property);
+extern int power_supply_get_by_phandle_array(struct device_node *np,
+					     const char *property,
+					     struct power_supply **psy,
+					     ssize_t size);
 extern struct power_supply *devm_power_supply_get_by_phandle(
 				    struct device *dev, const char *property);
 #else /* !CONFIG_OF */
 static inline struct power_supply *
 power_supply_get_by_phandle(struct device_node *np, const char *property)
 { return NULL; }
+static int power_supply_get_by_phandle_array(struct device_node *np,
+					     const char *property,
+					     struct power_supply **psy,
+					     int size)
+{ return 0; }
 static inline struct power_supply *
 devm_power_supply_get_by_phandle(struct device *dev, const char *property)
 { return NULL; }
-- 
2.26.0.292.g33ef6b2f38-goog

