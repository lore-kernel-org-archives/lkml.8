Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BD92098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVqy3Kjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgFQWdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgFQWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:33:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A43C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:33:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x18so4887823lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elMpiHvJWsjYoN8PlQbYu4ErKElFdKXtWgkUy15ZXZk=;
        b=gVqy3KjhCAZKxJJIp7EGn1cJPoT+yzjHlMx5EffGgIfTktO7nC0K88SmU0eiypqG5R
         NPZDvpEEsu8xUnG0hyC4UDrFL5+MDw0YKORoJVmUufM9R79D7WyJTz+TKGo/crxJjgGn
         GVjWRuM0ahmxsUOLvbDtNNEaIqYkHNgWfl4T1Bi/gsSIuP8bnFhPga/XHV33ghwBIj2T
         xCGQ5gMe93LCCQHV1xaB91Z8vpPpYokCZ7beroWrzLq5kw0sX3FvnNW6jMaJapQ7WYM7
         HPAttOY/wPjRPGja29aEFzgtEE1lwDg9oUrn72KfqazoT6XAVZFJrzMjXJ12V1KEpbSA
         UVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elMpiHvJWsjYoN8PlQbYu4ErKElFdKXtWgkUy15ZXZk=;
        b=WmfK+Y/glRVcijHOBlIWrDcCYek5BSUXVfiMvMDh+cdeor5QX5JKftmNhajEhQQPQt
         pJ0cy2G4dZx46kfMvBVoOs3xTl1EWTAZnpOl2o1vcrCY4MexyZpSkjSGR+Bqix7/ckAt
         fBCBh4uNF+3L3h9DP42o780tzeHWc3GBzjW/GUvjFOmSsXkoV2ivX+8hQ2gh+Ua5vuId
         oTsMyvd/fnd65rNFD7P1zbOUPx7/BYXDbMcHZcqBj688z1BFLnTwO05+nwDN72TFmfYt
         8GCrk3ek2ElL2QQ2eH6YKVQM2th6eevJKlTuG9HKFGd5/7mR60h8Q5vVJA8yqFAq5uGo
         m5xw==
X-Gm-Message-State: AOAM531n4S/JSVdFl4FTQl97qQn0VYhKQWQId5fSJnCcm8T/eGA9WJ4Y
        yZdsMAyVaVv8WDQ33vV67Uk=
X-Google-Smtp-Source: ABdhPJy7a8w9Su6nTUzLVWfm2I09oqawqmOLV1R+ZS9Qd5m273T0pNUEoEiQJQJaQaPITjhDzqc4Tw==
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr681249ljp.89.1592433180426;
        Wed, 17 Jun 2020 15:33:00 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id 203sm226079lfh.19.2020.06.17.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:32:59 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 5/5] regulator: max8997: Constify struct regulator_ops
Date:   Thu, 18 Jun 2020 00:32:47 +0200
Message-Id: <20200617223247.25566-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
References: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not modified so make them const to allow the compiler to put
them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  13114    8596       0   21710    54ce drivers/regulator/max8997-regulator.o

After:
   text    data     bss     dec     hex filename
  14038    7672       0   21710    54ce drivers/regulator/max8997-regulator.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/max8997-regulator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 4d2487279a0a..ba47a5e2fbcb 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -732,7 +732,7 @@ static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
 	return max8997_update_reg(i2c, reg, ~pattern, mask);
 }
 
-static struct regulator_ops max8997_ldo_ops = {
+static const struct regulator_ops max8997_ldo_ops = {
 	.list_voltage		= max8997_list_voltage,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -742,7 +742,7 @@ static struct regulator_ops max8997_ldo_ops = {
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_buck_ops = {
+static const struct regulator_ops max8997_buck_ops = {
 	.list_voltage		= max8997_list_voltage,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -753,7 +753,7 @@ static struct regulator_ops max8997_buck_ops = {
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_fixedvolt_ops = {
+static const struct regulator_ops max8997_fixedvolt_ops = {
 	.list_voltage		= max8997_list_voltage,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -761,7 +761,7 @@ static struct regulator_ops max8997_fixedvolt_ops = {
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_safeout_ops = {
+static const struct regulator_ops max8997_safeout_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -771,7 +771,7 @@ static struct regulator_ops max8997_safeout_ops = {
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_fixedstate_ops = {
+static const struct regulator_ops max8997_fixedstate_ops = {
 	.list_voltage		= max8997_list_voltage_charger_cv,
 	.get_voltage_sel	= max8997_get_voltage_sel,
 	.set_voltage		= max8997_set_voltage_charger_cv,
@@ -805,7 +805,7 @@ static int max8997_get_current_limit(struct regulator_dev *rdev)
 	return max8997_list_voltage(rdev, sel);
 }
 
-static struct regulator_ops max8997_charger_ops = {
+static const struct regulator_ops max8997_charger_ops = {
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
 	.disable		= max8997_reg_disable,
@@ -813,7 +813,7 @@ static struct regulator_ops max8997_charger_ops = {
 	.set_current_limit	= max8997_set_current_limit,
 };
 
-static struct regulator_ops max8997_charger_fixedstate_ops = {
+static const struct regulator_ops max8997_charger_fixedstate_ops = {
 	.get_current_limit	= max8997_get_current_limit,
 	.set_current_limit	= max8997_set_current_limit,
 };
-- 
2.27.0

