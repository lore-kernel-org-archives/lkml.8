Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4003EC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D618208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3BRxQnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEAU6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:58:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF6C061A0C;
        Fri,  1 May 2020 13:58:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so1108064wmg.1;
        Fri, 01 May 2020 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpsHhU0SIZ/znnjv1B1lxEbVrbiH03IPfJBbSjteEyU=;
        b=s3BRxQnw1+qZ2GyUuNOKwNAvWrLqPkJ5Z98fCI1oNTmROwlwkl5oV+7JeKKryu0DjL
         VZIB6AnBXUX0AKKmFgfusyNJoV1yJeTUUeSnaLLqrumL/ljx1Kb2zK9tzpg18kTG5SY3
         FwHrNo+GDVRRcXaZ8G98OJ5KCvWLf2wFFWwtXtATwH9LnuDPJFobU73lq0XyXu+yEZUz
         7diIaQO5Yyn6gSvWsdDX2bIESs140QWnZdIxuVmKl52F7JBlCOLk0Hl08qewcuv9K24x
         lIzSki+NOBSnCCjwkeWBt882NPj3Ne5259Xwhlt5y3SrKwWyZCxOarCn6EYRdA2kgWA3
         OdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpsHhU0SIZ/znnjv1B1lxEbVrbiH03IPfJBbSjteEyU=;
        b=TKOVaS6OpzgCudXTM+h4jDtWExxWHVtrhUzdFsJMzba3/FGOMVVaNXzBTQl8RATBLr
         ZNpFRGrFGUj6/0g5lTobzBHpp1PtPSSOhJ+0TkqFwguzBLoTV0oGlk360vti0P9L4/zS
         g/q7ot9Uz88ZPjqYQKqKvGVvYIGc4/vlr/+icIRDdPwJHKAe0e6ibyECJzchyT/pt/1m
         MNmtNYcWrtDJlTsffFYgToSDOYpNJPkelyXPKFaxSFjg8497WMhLJcxXll13KLXsrrQI
         YpUirJS7CzfygO9QbV1auVfv8CG/zbwOINYozj4b3FC7wMUuKM0kadjI9PvzFBscyvvl
         O1Ug==
X-Gm-Message-State: AGi0PubSRMaKHaJ6Od/XSCJ+ycqtQqN77CvIpJlwyhjmC8rY+drhLqfU
        9i71u2fFZ2a+cb1Se2IDwN1Dr9uSgB/Mag==
X-Google-Smtp-Source: APiQypL1PBjgFM4mmLYaOX9AErO++/0aW/UBHfvEyZeLvY6DjfEmLrgHSAulihmSd1ef+5Cq56Hduw==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr1314179wmj.136.1588366679153;
        Fri, 01 May 2020 13:57:59 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id k14sm5970446wrp.53.2020.05.01.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:57:58 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: clock: rpmcc: Document MSM8936 compatible
Date:   Fri,  1 May 2020 22:57:27 +0200
Message-Id: <20200501205728.152048-2-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501205728.152048-1-konradybcio@gmail.com>
References: <20200501205728.152048-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Knecht <vincent.knecht@mailoo.org>

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index 90a1349bc7135..51d1ef62c7450 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -13,6 +13,7 @@ Required properties :
 			"qcom,rpmcc-msm8660", "qcom,rpmcc"
 			"qcom,rpmcc-apq8060", "qcom,rpmcc"
 			"qcom,rpmcc-msm8916", "qcom,rpmcc"
+			"qcom,rpmcc-msm8936", "qcom,rpmcc"
 			"qcom,rpmcc-msm8974", "qcom,rpmcc"
 			"qcom,rpmcc-msm8976", "qcom,rpmcc"
 			"qcom,rpmcc-apq8064", "qcom,rpmcc"
-- 
2.26.1

