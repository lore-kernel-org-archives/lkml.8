Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9C4206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHhYBkJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405234AbgFYUv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405182AbgFYUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:51:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB14C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:51:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so7499259wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ju1U+tPndCh0ArRsOyQQP1OuDrYeOK89CttbwD+tA2w=;
        b=SHhYBkJiwdDam4QgitQRrlJfKsdLwmI7uPhVCNqSaOV5WVwl3dCAW4UlsO4aFnymiy
         Ly9hBiXqNGFi8qSWwCfpJLQanD3/FB/mSdYlIZL7hEhDi9HEgRVOiMxryU4HUKaDZAOH
         qoB3RuIvQV4MoUZ4/UwqleSRJFVp88zMKIo+QFQuQ+6P4tnn87vhdXnOkikNTY5XYL32
         lAxXNQLKzg/qeuUUZmdc/7Hv1MNNnhfEAtlynSuaupW45OTPZjzr1j6A6567GodiiRBC
         IVdkHGyreyxu6WiHWPKv6Tq08d0FEaKnHG4UOMOq3itViht9CfIC/b1tXSdd5+LumZ/2
         EjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ju1U+tPndCh0ArRsOyQQP1OuDrYeOK89CttbwD+tA2w=;
        b=auKeOEv6cJBe5mNBdXXD1IVs8oaRCy1CXP3WkLU1hWbVL9VY0QS51hjAuO742v+Fdq
         gL81mqwy5BOmafi6rJZwjLN/kmgrHjXbpYhvuynzH7fo66qpxmrADyNA7Bmau8+ky+Aj
         XMjbcA7G3ZKa96t0jeXf2BGa9qGG5QE/Jr3XCqdk5laKgcHZ4AJ2k+VfDr9GTxistyDm
         NiPuqSExkzTrs+IVtuCIU2pFzfj9+l2OjuT8+BZz5YpL33KLiZU+BDfO1CeZgbsNV9PN
         RwPjUPcLK+LDihEbPf1ll95tIfXJgjNHr0dpY97PIo21OZhOkG/gYHBGj2A9DiQ7+Xg/
         UdCQ==
X-Gm-Message-State: AOAM533SIQn7ta0wcE2l3qRhJ5dCW2IHj9k0z62AiK+SahfbM5EuL6rX
        N0iuIxApRVd84P9JWFOy0X17Ng==
X-Google-Smtp-Source: ABdhPJxbJCYoIUbP86SyUwiFATrrWaKC2ZDlF8UdEPr7tYWahscflEno7v16wZ9J7yJXIYTaNLBepQ==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr5493720wmk.149.1593118285933;
        Thu, 25 Jun 2020 13:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id r3sm13960263wrg.70.2020.06.25.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:51:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] regulator: devres: Standardise on function documentation headers
Date:   Thu, 25 Jun 2020 21:50:53 +0100
Message-Id: <20200625205053.4191910-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line up descriptions, start description with a lower-case character and
omit old definitions such as quoting the old argument "consumer".

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/devres.c | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3f73ce8590007..3091210889e31 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -41,8 +41,8 @@ static struct regulator *_devm_regulator_get(struct device *dev, const char *id,
 
 /**
  * devm_regulator_get - Resource managed regulator_get()
- * @dev: device for regulator "consumer"
- * @id: Supply name or regulator ID.
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
  *
  * Managed regulator_get(). Regulators returned from this function are
  * automatically regulator_put() on driver detach. See regulator_get() for more
@@ -56,8 +56,8 @@ EXPORT_SYMBOL_GPL(devm_regulator_get);
 
 /**
  * devm_regulator_get_exclusive - Resource managed regulator_get_exclusive()
- * @dev: device for regulator "consumer"
- * @id: Supply name or regulator ID.
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
  *
  * Managed regulator_get_exclusive(). Regulators returned from this function
  * are automatically regulator_put() on driver detach. See regulator_get() for
@@ -72,8 +72,8 @@ EXPORT_SYMBOL_GPL(devm_regulator_get_exclusive);
 
 /**
  * devm_regulator_get_optional - Resource managed regulator_get_optional()
- * @dev: device for regulator "consumer"
- * @id: Supply name or regulator ID.
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
  *
  * Managed regulator_get_optional(). Regulators returned from this
  * function are automatically regulator_put() on driver detach. See
@@ -130,9 +130,9 @@ static void devm_regulator_bulk_release(struct device *dev, void *res)
 /**
  * devm_regulator_bulk_get - managed get multiple regulator consumers
  *
- * @dev:           Device to supply
- * @num_consumers: Number of consumers to register
- * @consumers:     Configuration of consumers; clients are stored here.
+ * @dev:           device to supply
+ * @num_consumers: number of consumers to register
+ * @consumers:     configuration of consumers; clients are stored here.
  *
  * @return 0 on success, an errno on failure.
  *
@@ -173,9 +173,9 @@ static void devm_rdev_release(struct device *dev, void *res)
 
 /**
  * devm_regulator_register - Resource managed regulator_register()
- * @dev:  device to supply
+ * @dev:            device to supply
  * @regulator_desc: regulator to register
- * @config: runtime configuration for regulator
+ * @config:         runtime configuration for regulator
  *
  * Called by regulator drivers to register a regulator.  Returns a
  * valid pointer to struct regulator_dev on success or an ERR_PTR() on
@@ -259,10 +259,10 @@ static void devm_regulator_destroy_supply_alias(struct device *dev, void *res)
  * devm_regulator_register_supply_alias - Resource managed
  * regulator_register_supply_alias()
  *
- * @dev: device that will be given as the regulator "consumer"
- * @id: Supply name or regulator ID
+ * @dev:       device to supply
+ * @id:        supply name or regulator ID
  * @alias_dev: device that should be used to lookup the supply
- * @alias_id: Supply name or regulator ID that should be used to lookup the
+ * @alias_id:  supply name or regulator ID that should be used to lookup the
  * supply
  *
  * The supply alias will automatically be unregistered when the source
@@ -300,8 +300,8 @@ EXPORT_SYMBOL_GPL(devm_regulator_register_supply_alias);
  * devm_regulator_unregister_supply_alias - Resource managed
  * regulator_unregister_supply_alias()
  *
- * @dev: device that will be given as the regulator "consumer"
- * @id: Supply name or regulator ID
+ * @dev: device to supply
+ * @id:  supply name or regulator ID
  *
  * Unregister an alias registered with
  * devm_regulator_register_supply_alias(). Normally this function
@@ -327,12 +327,12 @@ EXPORT_SYMBOL_GPL(devm_regulator_unregister_supply_alias);
  * devm_regulator_bulk_register_supply_alias - Managed register
  * multiple aliases
  *
- * @dev: device that will be given as the regulator "consumer"
- * @id: List of supply names or regulator IDs
+ * @dev:       device to supply
+ * @id:        list of supply names or regulator IDs
  * @alias_dev: device that should be used to lookup the supply
- * @alias_id: List of supply names or regulator IDs that should be used to
- * lookup the supply
- * @num_id: Number of aliases to register
+ * @alias_id:  list of supply names or regulator IDs that should be used to
+ *             lookup the supply
+ * @num_id:    number of aliases to register
  *
  * @return 0 on success, an errno on failure.
  *
@@ -377,9 +377,9 @@ EXPORT_SYMBOL_GPL(devm_regulator_bulk_register_supply_alias);
  * devm_regulator_bulk_unregister_supply_alias - Managed unregister
  * multiple aliases
  *
- * @dev: device that will be given as the regulator "consumer"
- * @id: List of supply names or regulator IDs
- * @num_id: Number of aliases to unregister
+ * @dev:    device to supply
+ * @id:     list of supply names or regulator IDs
+ * @num_id: number of aliases to unregister
  *
  * Unregister aliases registered with
  * devm_regulator_bulk_register_supply_alias(). Normally this function
@@ -423,7 +423,7 @@ static void devm_regulator_destroy_notifier(struct device *dev, void *res)
  * regulator_register_notifier
  *
  * @regulator: regulator source
- * @nb: notifier block
+ * @nb:        notifier block
  *
  * The notifier will be registers under the consumer device and be
  * automatically be unregistered when the source device is unbound.
@@ -460,7 +460,7 @@ EXPORT_SYMBOL_GPL(devm_regulator_register_notifier);
  * regulator_unregister_notifier()
  *
  * @regulator: regulator source
- * @nb: notifier block
+ * @nb:        notifier block
  *
  * Unregister a notifier registered with devm_regulator_register_notifier().
  * Normally this function will not need to be called and the resource
-- 
2.25.1

