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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F6C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA922076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAKZIj7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgH2WLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgH2WLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7953C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so2648590ljn.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiLY8yo0HWRBKsqXzUV3cs7crSuoNAJrrXrn0txeTW0=;
        b=rAKZIj7y5z4iV3NtO3T65FyvkUyvcTpsIIiL6KwC44nIjfJfoOB+46BvWax4ENxE/C
         3tSFpNVR+aAafoQIpqumEeca3Ij7a4GptoxGB/IWBWMlIJ8vUZpd9SYjbe71iTt+FMO2
         H42qg6BmRWZO1GzyntS5O/bia50OIGYwUEzaftOcgHNuuM/aFIJ6wgfFC11vHIpmURbJ
         zeJmdczYsqvq8CubDLNSJtJ13XYZ+bziBwgudY1ElB8I965eHrrohY//r9GHLGbSBhgF
         lsLUYzgzlimyyUmvr/D3QFmrqEAcNOAXS+DRqX2OsHRKYdnF/h5fWK7xtOvY9biEMZPE
         r1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiLY8yo0HWRBKsqXzUV3cs7crSuoNAJrrXrn0txeTW0=;
        b=RTsD14yTrWTKkB0+PQFwHBGLQgRL4j8Gg6F8RbIz1BcFDANOU7zs0nPtnuUz+DG1N+
         AIdF5BdmUL0aIwM4JMVLlEg5dR4U9hoJuHKSj+FwxzhT+zKeyCW2lZ0h/prJc80uWEWL
         sHnD/5CpIwH52gAIBZeV/zqvSIzm7RriS2pBDIW0DeMwUA+3mZ6a8RSGUCRRPXZI6Qfd
         dMFY54xBVXt0ZmXHda8a17iPeZGq6tS5cSS1phc67X2L7dpp2la0gBgzmYrfyzY5GxuU
         TgfPYW+ceC0QabhEnt3REwSecsJfWz8ziAILs/qyAVw5Ge7Q/6jrX7m5kl9IqFXcKDQ5
         1iBA==
X-Gm-Message-State: AOAM533lrNeAZGm5I0c5ZU+sBlaN+R4FRSwnZV43FD9GNRHERz4HDXBG
        9KUOs13+WAVV+FaSmvBbeGA=
X-Google-Smtp-Source: ABdhPJz6gdr2quWTXwENB/6dAEXwoVY7tEKwJ0N/bnv//lbT77DkuiOOmFlxzbqDBmVhCS4A40ilmw==
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr2066338ljj.343.1598739075038;
        Sat, 29 Aug 2020 15:11:15 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:14 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/8] regulator: tps6105x: Constify tps6105x_regulator_ops
Date:   Sun, 30 Aug 2020 00:10:58 +0200
Message-Id: <20200829221104.20870-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of tps6105x_regulator_ops is to assign its address to the
ops field in the regulator_desc struct, which is a const pointer. Make it
const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps6105x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index f8939af0bd2c..a6469fe05635 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -26,7 +26,7 @@ static const unsigned int tps6105x_voltages[] = {
 	5000000, /* There is an additional 5V */
 };
 
-static struct regulator_ops tps6105x_regulator_ops = {
+static const struct regulator_ops tps6105x_regulator_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
-- 
2.28.0

