Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14389C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4624206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao7NeAXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393340AbgDOFhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390387AbgDOFhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:37:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:37:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so1003944pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DpqNkdYjp7AgN19jz89WzdaX519p2fuqV9ZKi1SZTY=;
        b=ao7NeAXe4q3XDw6YGwRybqHsHu2QW4/Y8cg7FlC7rb8QxWa00kb6DCprkSDhE1dPTX
         3WCb03iGwMABjglJG7//2Q2BSLwUluLqq1ibb5bnwbRGMkiSCXGKasXQuT736bSLoPco
         Xm3R+uZIwkR34Jz7FQH5r3AyCrNe9hKNd8oX8d99Lbibv8n2WjuWWxwNa1diYbVzWJ1H
         BrJtNb+rz+BjUJ6WtjZheapF4FAane+hwxCknlW0HBwQAVhWtlB55OIizjlmAoCMnaPh
         t+sjFgucKAUGyIMBAoTucJF6wFQ7wmklLkLFvzMg3b/XTc/2HFEUdKXlfRuUJEs8fMvA
         tQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DpqNkdYjp7AgN19jz89WzdaX519p2fuqV9ZKi1SZTY=;
        b=kItcm9vjsANTnqhspYRiGQNKb2+Cj9scaFAWLzv7c7pLCldMSQMlbvc2DISGZROedT
         oBMSEs25QaxHWGwE7KXro3BYAN4U3bZTLdzXQ52xFNsf5sQsXoPQ+6Vj42vZ2PeKd826
         E5VT8AmrE6APnDeVsMG/h06OMPFoG1J7+LlPbitkOOVhjeA/cwBNfOOJb3vPwHpWw+JI
         bUWh+AxFS5K8GH1hT32iOKZ0HuA2UROizpZmtP85Oev0NFuzJoXmM+n4c6qebxUzjXQB
         qT5Gfj2MkWiKieQBd0upw6ojoXM3RHA9adMrseR934iY/Ea31kf/rGNm6IpNrhBcHA6z
         jr0Q==
X-Gm-Message-State: AGi0PuZJJgnvNeG584kA6rm+0p5vjRuXDHyOjNU7pF7Jxuo0Rxwixueo
        0A84Xlvo4Z0jrrjYy/OxUBAzVg==
X-Google-Smtp-Source: APiQypIMWPJtUkcJE17271ZDMIVp+P6naL6E573ldPQmsDBDbUKcgvvfTthqRoPrNcYScClx78nA4g==
X-Received: by 2002:a63:513:: with SMTP id 19mr26340845pgf.48.1586929051430;
        Tue, 14 Apr 2020 22:37:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 18sm12839178pfv.118.2020.04.14.22.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:37:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] regulator: qcom-rpmh: Fix typos in pm8150 and pm8150l
Date:   Tue, 14 Apr 2020 22:37:08 -0700
Message-Id: <20200415053708.717623-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in pm8150 l13/l16/l17 and pm8150l ldo8 supplies.

Fixes: 06369bcc15a1 ("regulator: qcom-rpmh: Add support for SM8150")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index c86ad40015ce..c88cfa8952d6 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -832,11 +832,11 @@ static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l2-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,      "vdd-l1-l8-l11"),
 	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l6-l17"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
 	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
 	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
-	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l6-l17"),
-	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l6-l17"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
 	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
 	{},
 };
@@ -857,7 +857,7 @@ static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
 	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
 	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l1-l8-l11"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l1-l8"),
 	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
-- 
2.24.0

