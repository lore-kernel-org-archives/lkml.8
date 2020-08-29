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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75374C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7C52076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKLaRb5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgH2WLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgH2WLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFDC061239
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r69so579183lff.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2yM7tJOxm+9ie++926s5AjX0g3sZ1+LVptGnduOqVo=;
        b=nKLaRb5LmKBqkxA7mUFW9CnMQgGcAwgRQjwkNjIEieyDvk+gpSoo3xMNc/4LgqZpkd
         9eNC4w4XYFqRpa4KYu4+A4Juw6/m+QBW66oRgOvBUquuDyIIBnkSu1OVS5PbZKnuP5E3
         ahQSsZhrcOR2rNpVoQ/DHHgZXxl7jl0MCTIiajNi4ygJcCSuBldgjd0Yf8GyZ6DslmRe
         Ef28YF1mOpb+rkpLQDPt2W3Tx4V4z4aPZww5vZNL6GrvEY2LqVNeTcVy2Axigyrkalx2
         I00PqfBZpI35a5+72wfS/dNz5G3KVGJ685enJvT3TpXVUN1W2g+lOInxbn6peZIG+NAb
         ktCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2yM7tJOxm+9ie++926s5AjX0g3sZ1+LVptGnduOqVo=;
        b=UMaRKkJHnRmPS6WQZMLrhCOUYKzbFnS7AUgV3h5FlxoRXfwZc58XM+3Z+udP5/17K2
         N5N/UaqAtayi7Tu6H676uRSVcSDVLiZPHMDnWgoIfiR7v0278QmN6/BzWLm2HsYjNnxn
         NkDa9f2V+ZaQicV/1xR274j+6RvB9L+kAqGB5JK1tCKCmmslm3xCYEFSIorQRtcAtJZN
         u/5S61HCyYSnMAOSddRtymdFIkD3Ubmo+S41AlJXfZX659QMM7mfRoaeX2eoQv1dW+Sl
         0ejGviXyj7h4XrK6j1ZDqZokxgQm/RutDDzMYhbfak8baVj3Ro2XETx7hkBqjTRbGR+a
         b6kQ==
X-Gm-Message-State: AOAM5317uaxD6R3W8q0YyaH6XXu6zmA1PofqGN8QjN5OmG6VwOe9I4Qs
        whXXm+/VDvhod+0ADE1Acp+YTV5mJis=
X-Google-Smtp-Source: ABdhPJxUrmCskTNMtu1OtW3VWd7PUOIlh0C0t55t33y/0RgA271fhqbpyc+JiFGEdFhUbf4b95JCLg==
X-Received: by 2002:a19:5503:: with SMTP id n3mr2327531lfe.91.1598739077938;
        Sat, 29 Aug 2020 15:11:17 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:17 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 5/8] regulator: tps65090: constify static regulator_ops
Date:   Sun, 30 Aug 2020 00:11:01 +0200
Message-Id: <20200829221104.20870-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usages of these are to assign their address to the ops field in
the regulator_desc struct, which is a const pointer. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps65090-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index f0b660e9f15f..1d2e04f452d4 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -47,7 +47,7 @@ struct tps65090_regulator {
 	int			overcurrent_wait;
 };
 
-static struct regulator_ops tps65090_ext_control_ops = {
+static const struct regulator_ops tps65090_ext_control_ops = {
 };
 
 /**
@@ -167,19 +167,19 @@ static int tps65090_fet_enable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps65090_reg_control_ops = {
+static const struct regulator_ops tps65090_reg_control_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops tps65090_fet_control_ops = {
+static const struct regulator_ops tps65090_fet_control_ops = {
 	.enable		= tps65090_fet_enable,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops tps65090_ldo_ops = {
+static const struct regulator_ops tps65090_ldo_ops = {
 };
 
 #define tps65090_REG_DESC(_id, _sname, _en_reg, _en_bits, _nvolt, _volt, _ops) \
-- 
2.28.0

