Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F459C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 05:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5156420716
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 05:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="h/871z55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHAFsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 01:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgHAFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 01:48:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 22:48:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so18352049ply.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 22:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POumBk13CPH0dUQmyWgim9XfmA1z0aTQvKVzqNybP+Q=;
        b=h/871z55lK78mthvhjhIgxZNOX+vA3pmZ7chEYfpUfKyWm39vrJF501KEeiBGbOUt1
         z39esDr8DE6Nul3HjrQms+ryS5Vm7uCP6ZkbbnZHNBhwlmeQYsM/4xpMVOzKMeuzJkAA
         FN1l4OnKFZgjPLopHgyqd0rXgqrGYa4+RsFrDhSBdXTLqVSmpQchXH0sTaSWBGdG75vS
         ZYZVhrit2dC0qyuGasuBw1S+WRwMC7JxlT19qkHQpGgVU1Q6uHMAvfJwIEYaGkT2e7+b
         O2Bee1hHNPhBH7ya2BPwQ0rViKKo9Cxjw4dOj/KHrBpqwkk9F3ja8mkjAiTg/hY0zV7G
         MUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POumBk13CPH0dUQmyWgim9XfmA1z0aTQvKVzqNybP+Q=;
        b=i1yq4vdDkd0NIAhY5xpOfNFOX/cVeitQITxMvKaxZ+xvtW/7qJ8VKC2xG4S+cFNxyf
         5PM/CjaamfER1UOAlsORrYyfb0J0s5O9WvSmddOsaUQoDyDUu4InQKUAVLLQqmBVydFW
         iQRjxmWpGQDL1R4ApY8xequqieZmHNH3d1Cr4rGD3rEJnqe6BYsAsXJh23Hl/jYfFB1v
         Tyopc1jlPr/l80xsi+sXF68bP4EYJC1vpFAUYLx5kagiQMzCJ1mi0fRj9b1tHhVV0gIg
         rDjwb9i94GTlflKf2JyqXlW194V8KE4pmlETa30a2ZVpK+8uqxQem4GKXxTFT0BPQi/y
         PBlg==
X-Gm-Message-State: AOAM533UPAf2rmiW1nvYZ9Xf/QHVm7rhOQjgKq/iO5yBQJuhfHIgnt5B
        SIpu0UPAVRZAF3QffuERzdLACA==
X-Google-Smtp-Source: ABdhPJzTlWXl4SEzLe9uK/gLg7d5Wp5BkpVJH7m3m1Z8esJ8hkMWw4tOyoA2gw/rAiT+AV/z7aHByA==
X-Received: by 2002:a17:90a:740e:: with SMTP id a14mr7004833pjg.165.1596260913797;
        Fri, 31 Jul 2020 22:48:33 -0700 (PDT)
Received: from localhost.localdomain (118-171-128-242.dynamic-ip.hinet.net. [118.171.128.242])
        by smtp.gmail.com with ESMTPSA id q73sm11462978pjc.11.2020.07.31.22.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 22:48:33 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Angelo G . Del Regno" <kholk11@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: qcom_spmi: Improve readability for setting up enable/mode pin control
Date:   Sat,  1 Aug 2020 13:48:20 +0800
Message-Id: <20200801054820.134859-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By checking data->pin_ctrl_enable / data->pin_ctrl_hpm flags first, then
use switch-case to improve readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 70 ++++++++++++-------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 5ee7c5305d95..05080483fe1b 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1633,45 +1633,43 @@ static int spmi_regulator_init_registers(struct spmi_regulator *vreg,
 		return ret;
 
 	/* Set up enable pin control. */
-	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
-	     || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO
-	     || type == SPMI_REGULATOR_LOGICAL_TYPE_VS)
-	    && !(data->pin_ctrl_enable
-			& SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT)) {
-		ctrl_reg[SPMI_COMMON_IDX_ENABLE] &=
-			~SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
-		ctrl_reg[SPMI_COMMON_IDX_ENABLE] |=
-		    data->pin_ctrl_enable & SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
+	if (!(data->pin_ctrl_enable & SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT)) {
+		switch (type) {
+		case SPMI_REGULATOR_LOGICAL_TYPE_SMPS:
+		case SPMI_REGULATOR_LOGICAL_TYPE_LDO:
+		case SPMI_REGULATOR_LOGICAL_TYPE_VS:
+			ctrl_reg[SPMI_COMMON_IDX_ENABLE] &=
+				~SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
+			ctrl_reg[SPMI_COMMON_IDX_ENABLE] |=
+				data->pin_ctrl_enable & SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
+			break;
+		default:
+			break;
+		}
 	}
 
 	/* Set up mode pin control. */
-	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
-	    || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO)
-		&& !(data->pin_ctrl_hpm
-			& SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
-		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
-			~SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
-		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
-			data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
-	}
-
-	if (type == SPMI_REGULATOR_LOGICAL_TYPE_VS
-	   && !(data->pin_ctrl_hpm & SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
-		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
-			~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
-		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
-		       data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
-	}
-
-	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS
-		|| type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS
-		|| type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO)
-		&& !(data->pin_ctrl_hpm
-			& SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
-		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
-			~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
-		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
-		       data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+	if (!(data->pin_ctrl_hpm & SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
+		switch (type) {
+		case SPMI_REGULATOR_LOGICAL_TYPE_SMPS:
+		case SPMI_REGULATOR_LOGICAL_TYPE_LDO:
+			ctrl_reg[SPMI_COMMON_IDX_MODE] &=
+				~SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
+			ctrl_reg[SPMI_COMMON_IDX_MODE] |=
+				data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
+			break;
+		case SPMI_REGULATOR_LOGICAL_TYPE_VS:
+		case SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS:
+		case SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS:
+		case SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO:
+			ctrl_reg[SPMI_COMMON_IDX_MODE] &=
+				~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+			ctrl_reg[SPMI_COMMON_IDX_MODE] |=
+				data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+			break;
+		default:
+			break;
+		}
 	}
 
 	/* Write back any control register values that were modified. */
-- 
2.25.1

