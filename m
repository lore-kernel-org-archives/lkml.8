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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B00C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AD020B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q146FF/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgFQWdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgFQWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:33:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE907C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:33:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so4887785lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTnN1Qd9XL+Q3/Xzr6hJSAyMU91ZuAFYJQwbqBZtvcY=;
        b=Q146FF/nq+MAfYccQR1kIs3GUWuAZhEsgx/HXcUtPrQMLg1Mg+RNA1fdwxHS5lAAfy
         sOgFjmEORhNl/CAOWc2VoMk2jb7+G/ZZ+niOE3QFW59Tkhv28PrKnJdBMmqd+U4Y4Ls5
         gOwUlgTH0vNGwifLM1MJ3DqN9LE34Hpsc1D1GOuTPnm66OBvduKxB5I1UJ5RtlUiWWal
         hAZMNnJOBOx5/mgn2CqyT0efglskibG8HEv992ExsXGs+UpTO4EecVH6O2394mgNbXgW
         p8iay6e/Pz3O2DrTynxTy2JlHHVpFnhHHJAt86iRJ/8zYWjlVUC0vN5CZEbRHKwlhgdb
         pSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTnN1Qd9XL+Q3/Xzr6hJSAyMU91ZuAFYJQwbqBZtvcY=;
        b=SY5FxaSyS5Bp8X0/HHQ4pCZm0hmQbnft+P/T7lIcZsrgKfI20NEZJP7kriOyj+T4RI
         4IAz5R9iuvGOoP74+TieKMPAmCKaSunyl51RlTCZU9pVGwBGkfmjU4B77hMNc9tkJix4
         RADHJj74mOhzUc9ZB5Co9Hs9nonGGCp4pRYLoPw/g+OptsJqVsUKWOLBB0xo/VgRsXew
         MDaXDEFmmd1GF6crN6cd0PzMtTJskT8UDP6lD6Z1qYo+HC2G8BKNXjlV1Izazua1R4mK
         AtWE/IjtA+CQNDi7SLorQVSKi+xU9Ic1a+HEbwx4NXzaFTsJ0GaPCQU804vSQ/A6SB6w
         H6lA==
X-Gm-Message-State: AOAM5330A1wVjRsEFrT0hY0kLf6Xl/Wynsqpk9GRdUVYe73RlKbt+PIS
        3Bu2sGiniLCNjCG/RMqryII=
X-Google-Smtp-Source: ABdhPJwhdCwN/f8LHIFgMw6Cx073H+VGydeUleO2xclVyfEpe7ig5C+oVXkIvyVsSCcrLw3kJmNuyg==
X-Received: by 2002:a2e:a16a:: with SMTP id u10mr697169ljl.222.1592433179424;
        Wed, 17 Jun 2020 15:32:59 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id 203sm226079lfh.19.2020.06.17.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:32:58 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/5] regulator: max8907: Constify static structs
Date:   Thu, 18 Jun 2020 00:32:46 +0200
Message-Id: <20200617223247.25566-5-rikard.falkeborn@gmail.com>
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
   2753    7328       0   10081    2761 drivers/regulator/max8907-regulator.o

After:
   text    data     bss     dec     hex filename
   9405     684       0   10089    2769 drivers/regulator/max8907-regulator.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/max8907-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 96dc0eea7659..1a6fd68f3fb1 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -109,7 +109,7 @@ struct max8907_regulator {
 static const struct regulator_ops max8907_mbatt_ops = {
 };
 
-static struct regulator_ops max8907_ldo_ops = {
+static const struct regulator_ops max8907_ldo_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -128,7 +128,7 @@ static const struct regulator_ops max8907_fixed_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
-static struct regulator_ops max8907_out5v_ops = {
+static const struct regulator_ops max8907_out5v_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -145,7 +145,7 @@ static const struct regulator_ops max8907_bbat_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_desc max8907_regulators[] = {
+static const struct regulator_desc max8907_regulators[] = {
 	REG_MBATT(),
 	REG_LDO(SD1, "in-v1", MAX8907_REG_SDCTL1, 650000, 2225000, 25000),
 	REG_LDO(SD2, "in-v2", MAX8907_REG_SDCTL2, 637500, 1425000, 12500),
-- 
2.27.0

