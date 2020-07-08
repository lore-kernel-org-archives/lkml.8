Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932F620775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmZE8U6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgGHMsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgGHMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:48:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1AC08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:48:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so2969738wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ju1U+tPndCh0ArRsOyQQP1OuDrYeOK89CttbwD+tA2w=;
        b=CmZE8U6JMFvEbaF1mdhxBfgzcr7GQfHNKIw47f56/KfdBLEDkPkp5aXevwh2/fwpqp
         qH4JCQ8xU5I3z11yd/eA9+9x2AiYHu3vP/Jm8XTHfCeYxcd+y9wKf8Wp15AluwstiKzp
         xaQFZg75gZY0qVrJ0CsfKvdilEiKx25PCKAa0D9B23x7BPxzGL9Vr9FZrU2KgAUe0c6O
         ttnztCfPPTs8C6BQFBLfU354WjthOXbXMmcQVajhZDyd+YXpALuUiqjKQG0EB5iLqROZ
         1UyhbxAAFz6XmjS3T3c3Cz3GShjjBDUHvpzqRnmd2fdD5cgarWHZRYDgqYlkHPwHZbjD
         EQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ju1U+tPndCh0ArRsOyQQP1OuDrYeOK89CttbwD+tA2w=;
        b=T6silA4fcSCp4Qw/eSXaBvGz/rYTktAsLFGcv1PCFSc5hBGM9wRifb7/8S/kC7Un7W
         BMR3vyLIwpqQq4MsGNOdzL+tDRnpbexL9t1szIfWpLdXE34FLdgKaBRv+ruX/k4khAQw
         G5+bBLiuDTnwgardc2ixk6Y6i7gouEamNmfF5ln9BJ9WvKzASYW9eiO+4cnxq24B/Liq
         sRxiBEy7Q0zkiTtIseMuARVLZEb6CSVyf4ZwoOIlRXuuXosDjZyIELeeICA1/3i/reVg
         0UTNd9G39SRYEtjGcSK32F8CSlawzeaAO+m4MayUZlHWArh3IxW2MCyIairLOxjKFD78
         Z+Eg==
X-Gm-Message-State: AOAM531+h8UPQsu8ZeYZtMWoxK4CmFK4JP9ljVdZjsPBJPKWOhIyixx7
        u+OMnahJMOK/l/CpxG0D5qWRzg==
X-Google-Smtp-Source: ABdhPJyqjhuRZ3Y2R/8SmtMA8Aa88Y2cHC2hsbm8Xtpp885Ab/SC3VAlW7++EJuxzylKFlOmzYy+7g==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr8726585wmh.108.1594212518674;
        Wed, 08 Jul 2020 05:48:38 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id x1sm5745408wrp.10.2020.07.08.05.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:48:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/3] regulator: devres: Standardise on function documentation headers
Date:   Wed,  8 Jul 2020 13:48:32 +0100
Message-Id: <20200708124832.3441649-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708124832.3441649-1-lee.jones@linaro.org>
References: <20200708124832.3441649-1-lee.jones@linaro.org>
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

