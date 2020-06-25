Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C69C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597B920775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zIdULsYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406332AbgFYQgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406302AbgFYQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F89C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so6516025wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFHpX6/JfOmiOR17NB/0ktU3gvi4o0iTMP6vlrr3mrk=;
        b=zIdULsYKpkHXr1aYsS3j6Xbz6bEtRdY77wQUWfADIEdlrFH814frioWaPTHfsdfU5b
         dNCw6owykLKBXa6ui/3kaRPIGMM5A8Mi6I1dx2jA6uL3Zzp6qnh9nNGMBc0o9KQfQkXp
         SOriJULBMs+vPwT0nkuoedTH1my15z7bXbF9bB8Fj6yz/XHU/uS4U+GRUUZdlwFUHhz6
         VPmtzXG+UZMR3ux79lxpyIJfFDtKo84VS21PkapYzRu7bbA1dQEY7bwIBx+e6h8AP212
         UDW+70PAMEw+yFN1b+FWcbYbzDVmQ0KzpFaq6PanhIxKdczKLkqQgf6RUTCpswiEr6aL
         3ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFHpX6/JfOmiOR17NB/0ktU3gvi4o0iTMP6vlrr3mrk=;
        b=f8s1Ly7XaRXcQT5N4ydzjaL4PL72j0YFLjkcnAiN+Ph8DLTJjalH4mj1DS7IurcPiy
         k9QiGlazVUt4E3z/gHiH2+4Ixg5acKVbxbn5M/IScOn3sbA4zkZcF6TjwREdh8trF6+q
         b3r3BiHZp6CMvWxM89ugKLBHOm58bUgtpGWTIn/mVUKS4WgODLdvc2bpUgiIDPjhMmX7
         Nenbd6nGLxKeXSIwBUbBaNILPi8BinyMHky91IKtvb1jZz47tJvmHw8RPxZyWyuCZ2Z0
         WyCDNZNW5OkWh/jDHE8qBToCDhqZjjBMtINKkWNaQ7T6j7c2K+yGMEbpTAJvWlOPQGTn
         SaEQ==
X-Gm-Message-State: AOAM532Jv7C3kS7WrbXV9F+IlQl7CZ7V33G89k6Do5lMK8KtteyH6UoH
        V+UVuudGGd7OrueSC87Z/HLr3A==
X-Google-Smtp-Source: ABdhPJy+4PviXw5CFNHqNwfxVVngNozT+a0WUquCVyiwMtCTrMt2dTadyjRihV9XXUnNG0NGbrRmQg==
X-Received: by 2002:adf:f209:: with SMTP id p9mr36231294wro.86.1593102991088;
        Thu, 25 Jun 2020 09:36:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/10] regulator: cpcap-regulator: Remove declared and set, but never used variable 'ignore'
Date:   Thu, 25 Jun 2020 17:36:11 +0100
Message-Id: <20200625163614.4001403-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's okay to not check the return value that you're not conserned
about, however it is not okay to assign a variable and not check or
use the result.

Fixes W=1 warnings(s):

 drivers/regulator/cpcap-regulator.c:172:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
 172 | int error, ignore;
 | ^~~~~~
 drivers/regulator/cpcap-regulator.c: In function ‘cpcap_regulator_disable’:
 drivers/regulator/cpcap-regulator.c:196:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
 196 | int error, ignore;
 | ^~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/cpcap-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index f80781d58a282..fbf823b830308 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -169,7 +169,7 @@ enum cpcap_regulator_id {
 static int cpcap_regulator_enable(struct regulator_dev *rdev)
 {
 	struct cpcap_regulator *regulator = rdev_get_drvdata(rdev);
-	int error, ignore;
+	int error;
 
 	error = regulator_enable_regmap(rdev);
 	if (error)
@@ -180,7 +180,7 @@ static int cpcap_regulator_enable(struct regulator_dev *rdev)
 					   regulator->assign_mask,
 					   regulator->assign_mask);
 		if (error)
-			ignore = regulator_disable_regmap(rdev);
+			regulator_disable_regmap(rdev);
 	}
 
 	return error;
@@ -193,7 +193,7 @@ static int cpcap_regulator_enable(struct regulator_dev *rdev)
 static int cpcap_regulator_disable(struct regulator_dev *rdev)
 {
 	struct cpcap_regulator *regulator = rdev_get_drvdata(rdev);
-	int error, ignore;
+	int error;
 
 	if (rdev->desc->enable_val & CPCAP_REG_OFF_MODE_SEC) {
 		error = regmap_update_bits(rdev->regmap, regulator->assign_reg,
@@ -204,9 +204,9 @@ static int cpcap_regulator_disable(struct regulator_dev *rdev)
 
 	error = regulator_disable_regmap(rdev);
 	if (error && (rdev->desc->enable_val & CPCAP_REG_OFF_MODE_SEC)) {
-		ignore = regmap_update_bits(rdev->regmap, regulator->assign_reg,
-					    regulator->assign_mask,
-					    regulator->assign_mask);
+		regmap_update_bits(rdev->regmap, regulator->assign_reg,
+				   regulator->assign_mask,
+				   regulator->assign_mask);
 	}
 
 	return error;
-- 
2.25.1

