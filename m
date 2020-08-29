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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEEDC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF142076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWwjHAUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgH2WLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgH2WLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A058C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so2642956ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIAcjfcjSRRtfK3tD81KW4l+/Y68i1r84BSQhmAOVQo=;
        b=BWwjHAUko9g1RHLQ2DA5M1wkTS8IJipFYRSm9VNaYvAWQpCtTjBehZpvV7CChxevnv
         bMVlJs97aTI7npmRxrnLyj1edbP1OSzX03r1MfdDXvi3XOx5vopgywc4I17KjoGovPqa
         cH0/LTAczSYM7g/gWbOWVLev4U4aQpPxljt6RUZPHFQLPtGV9R9aBwJiBRyzQjBYmcL9
         HVGjz6aPmnQSAWGvp2ziabD6lNaDEhNWEpfmizOJsbpmR0KEgehJUiVAUe9cSZqvioRP
         7vx1ol91OLzq41ZXPnFmoSUYllA38Ygq7+pGXmJAkwZ3LLjI8aobH3BuCZvzN/LhGxIP
         X4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIAcjfcjSRRtfK3tD81KW4l+/Y68i1r84BSQhmAOVQo=;
        b=BZara0ktJBpGSfX2LA1bc/P7O7PbRwuxmVopqzASWkj2aiB1bS0trUppfrDM44IZxn
         M5AsBfhTIlfKMXzkqp3t64ajSWFqJ6ySMXSzX8WXEmNxIvk5jDEDJFkxgecb8R1Qosc0
         hVFGnS0FkEIjYhS3sTM0FD2z92UHs8ThGZ2zS854mGa5YeM64ibiZE6gpFjHLmgrfFFM
         DaRWg+Ojz+gBZX74R4EIvO0ectHG5/N8pq7xF9S+SFqUZqrM9jQJ6JDR12bSaCL9dtfI
         1gH6Qs0H5POa0IGAqqBSuumgXDlch7N5n1PMzSGup5g4FN4RgnyvBvxapzyRlyBVd3op
         br9A==
X-Gm-Message-State: AOAM530POFrg3TEQmTvpQHKkvf5xtxydVg8RsAJmyicd+YjsANJRmcKH
        WM/+nf5S3qJOnRFH8mmUlt4=
X-Google-Smtp-Source: ABdhPJx+il0c25Qr0MJmq/JLOPLJykjymUcn+ETIk9hVT4JX7oY2UA+/m2T1FsLfASF3Vqr9/CHyKA==
X-Received: by 2002:a2e:b5c3:: with SMTP id g3mr2472328ljn.63.1598739076011;
        Sat, 29 Aug 2020 15:11:16 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/8] regulator: tps62360: Constify tps62360_dcdc_ops
Date:   Sun, 30 Aug 2020 00:10:59 +0200
Message-Id: <20200829221104.20870-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of tps62360_dcdc_ops is to assign its address to the ops
field in the regulator_desc struct, which is a const pointer. Make it
const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps62360-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index f6a6d36a6533..315cd5daf480 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -233,7 +233,7 @@ static unsigned int tps62360_get_mode(struct regulator_dev *rdev)
 				REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops tps62360_dcdc_ops = {
+static const struct regulator_ops tps62360_dcdc_ops = {
 	.get_voltage_sel	= tps62360_dcdc_get_voltage_sel,
 	.set_voltage_sel	= tps62360_dcdc_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear,
-- 
2.28.0

