Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D383CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0710208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh4b6uVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgH2WLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgH2WLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE25C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:21 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c15so1553676lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwc27TU1AmJMesmEsUpevGnqM8uwPQusAeh31eKDsFw=;
        b=qh4b6uVwMBiTMg2/Kv4jPRieK1XNy+HXUfpWKEkkANYS+IZbtXvPX9Ou3K6PydsuqZ
         Sb/Bs3LCIbyNE04Ui42IVm0YOG12xXw6RWT+uOk23TL6Y+4TKos5l0xiC276BDVvOOWP
         DYv2KrvBto4CBaTEA+qraay/pUf2X11+O5q89m/4vT5EjqqsXZvFHo80qr4DGsPVZtGp
         VQL8ceNCWTmeKjEKrnJFX+gZlm9dnxxqjWHbunralYfPiIhGEIgtVf8swdxkU1QvchBh
         2dCITT7A7aggK/vU21Xh2MirSgcy4I+GsPoNRBCKIePGtjecKzVCl3/SrqhLOIYp29fc
         tBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwc27TU1AmJMesmEsUpevGnqM8uwPQusAeh31eKDsFw=;
        b=IXYmOeWzEQ2ba/0VoP+Bd//TYlt7c7FEHGiwrt9rpi6E/hmAw6z//aQGXxMsGbDPo3
         igEyCi28n2H6ppODTRayrdcDVK/rZBFsW82EOmdcsLG7YcHcHN7xy4vyEB+40s/y01SZ
         n6NKTimIa34ZT3+KNLosEV1n2/AR24WJWdbewbIt9uVzQDt2VTZ9c80V7H98FOmotLEb
         Du0NLaIjf193iFjt+d9c1qU818J5XkKx6JDrqhP0JXOpgcX2QIwfPPWiGYPlgNI5fMdo
         spg3OOoTkq4q7mSMkdjJfYseSqiX6EhScZ7Gy96yVTRdKCokK47tMNFiqSB89lMx9HlB
         O7eQ==
X-Gm-Message-State: AOAM532jZcztQhb45ZJJmpA+L6SAhYBcJNtlPY6WGfZJ26Iyzi7SkjIw
        WaEPOFS4be5HZ0nzff0HIZw=
X-Google-Smtp-Source: ABdhPJyt/kXxksxIlWux0QUaL5coupYTEX3Nv+h0m/UShbpdAqpuUpryFpYdz6TICtIhBenvCWLmJA==
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr2329708lfk.108.1598739079885;
        Sat, 29 Aug 2020 15:11:19 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:19 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 7/8] regulator: tps65912: Constify static regulator_ops
Date:   Sun, 30 Aug 2020 00:11:03 +0200
Message-Id: <20200829221104.20870-8-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of tps65912_ops_dcdc and tps65912_ops_ldo is to assign
their address to the ops field in the regulator_desc struct, which is a
const pointer. Make them const to allow the compiler to put them in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps65912-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65912-regulator.c b/drivers/regulator/tps65912-regulator.c
index 63d6bbd4969b..b52d4f2874b7 100644
--- a/drivers/regulator/tps65912-regulator.c
+++ b/drivers/regulator/tps65912-regulator.c
@@ -57,7 +57,7 @@ static const struct linear_range tps65912_ldo_ranges[] = {
 };
 
 /* Operations permitted on DCDCx */
-static struct regulator_ops tps65912_ops_dcdc = {
+static const struct regulator_ops tps65912_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -67,7 +67,7 @@ static struct regulator_ops tps65912_ops_dcdc = {
 };
 
 /* Operations permitted on LDOx */
-static struct regulator_ops tps65912_ops_ldo = {
+static const struct regulator_ops tps65912_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.28.0

