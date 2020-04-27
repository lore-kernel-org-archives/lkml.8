Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD35FC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC862084D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbQaEPW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD0Fmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbgD0Fmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:42:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57977C061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 22:42:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j7so8164433pgj.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7iDJl+P8l2tDxO1XbtmVx7feXA+RtlRnZQzWbR1KCQ=;
        b=BbQaEPW/zDNX8G8dA8Cjp6b7T5/J4+qeFvDgjuUj/mN9iX1CMi6K4/+hHjTLJ0nLXM
         jTovYFZWpVZtdbTkLUL7pG9dJTnpR8t7AX88lZPVo9qhcdWJFFCyMRuSSMo97qVWhSKD
         7V6rGfTyEAlaqocyU23aZD78ieLI/fun5WsVDeFO9zLauAISoY0aAejvxwKKx6CyCGva
         aCKb5/5VC+ai4a8aPhJXmDbj7t/2lQiRGf5YfTezg3D8dKiyS5S4MO0oAZydNwOrGtDk
         rxnIhDb1D73YfujxVT8f1mcd7HmSoF+psE8wYdyqYmD9yyI3KWswzJwhdQVHUzy6h2g3
         ZSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7iDJl+P8l2tDxO1XbtmVx7feXA+RtlRnZQzWbR1KCQ=;
        b=p1JFqubHQ/arsDLsUqkBc42dUhjBQMnqfcVuqjvKsSj6FEaBxEUvi1M1+VVp/KP8y8
         sPz3CxYL9/QwiIKYNpgWJ9ZySdLTSTryvDAoKWjF4tCGXA6IES9oNastjt/OzmKYXUYY
         5U6KHfKYHBr+J+jJ1+qZRtt2xf0K81HD55LIZFjkEIiyTtQxaJzadkOu5vam/Q7OVxTk
         hYX4R1CKY/ny3Vgvzl0GlKD8u/ItCSOBH3/jiLI7p/d1IBpM+kSzyy3aScgHMufuFwQT
         DJpHk2PlM0WNzXd1tdEgh6HfNbFugg09E1GWtSwO+0/n/xF8DAFkyfhxBA+Js1/nvzl9
         P5ww==
X-Gm-Message-State: AGi0PubqSy4Oqi8KYXcxuJMGiLkd1zwCgGHGEXs4ekjuFz8jrF0IfJ2I
        Q6uznS6dnloOKak+lX6DqK8rMSxekxs=
X-Google-Smtp-Source: APiQypIPQJak3AVIzrbXaNSFwIn3GL2iOHSkQBPm+c3nVnIMeJ3QrdBl1RQ4owlASd3uL25gnBkUbQ==
X-Received: by 2002:a65:4b8d:: with SMTP id t13mr20292240pgq.388.1587966155786;
        Sun, 26 Apr 2020 22:42:35 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f3sm10172355pjo.24.2020.04.26.22.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 22:42:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: aoss: Add SM8250 compatible
Date:   Sun, 26 Apr 2020 22:42:02 -0700
Message-Id: <20200427054202.2822144-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8250 compatible to the qcom_aoss binding and driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 1 +
 drivers/soc/qcom/qcom_aoss.c                                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
index 4fc571e78f01..953add19e937 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -19,6 +19,7 @@ power-domains.
 		    "qcom,sc7180-aoss-qmp"
 		    "qcom,sdm845-aoss-qmp"
 		    "qcom,sm8150-aoss-qmp"
+		    "qcom,sm8250-aoss-qmp"
 
 - reg:
 	Usage: required
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index f43a2e07ee83..ed2c687c16b3 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -599,6 +599,7 @@ static const struct of_device_id qmp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-aoss-qmp", },
 	{ .compatible = "qcom,sdm845-aoss-qmp", },
 	{ .compatible = "qcom,sm8150-aoss-qmp", },
+	{ .compatible = "qcom,sm8250-aoss-qmp", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qmp_dt_match);
-- 
2.24.0

