Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA79FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE40320882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="diXBgKOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAURSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:18:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35157 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAURSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:18:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1615236plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSn6IN20MoxHzB1lD/ErRIjslXyhsYmChtFm+zIPC88=;
        b=diXBgKOh4Idku6RcLKqFkHKtFMXMGeaBB7DPqqf3iq4/C8gd2kBGtYCXEYTwIG03om
         cygQ5c/bRvNU4uT9uWW1Q12fHjoW5O+M2unn4TeDYZEkhnISBxAy+0lmOXZPiMDwXSkw
         aRgF4GJ4tCD6g9lPO/X9Ed0wFetF18IPGVOQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSn6IN20MoxHzB1lD/ErRIjslXyhsYmChtFm+zIPC88=;
        b=BIWOeD4fUjF+xTaQqwknYfIekWMcRaOgcPJPpE0nl7Yk93Jj8qY25LMuWuK5U4OLwx
         MK6xGMZYJ+hDJoZ/MFJaI5GDsN3F1SDb3ztLbqdupw5y2QWm4TYOwKcuD2ZchnBerU9N
         w3O/JYQxEgWYRdGe+hca/4QgkhatuQnpxOVtgbWae5A/4Th06GxkK8SOZ8a6xBXERxzg
         PsKAjh2o17Y/f7AvsFReZnTQm6Bk2n+WhcgUNZ4jfLI32wM1rHAwVKFuf6miF9vYgWbd
         maolz8erM55RYrpIdVuvroPXADkl2xhX+3tmS5Dl3+3H4OQBPZHsMHm3WW6S8fpuljU+
         OuRQ==
X-Gm-Message-State: APjAAAXHqBeYlmw/1WgGIVCWlYBE8ddodFLHV6tmPUgSAjzHJCOSiDNh
        TwA7SiZARjbxwUa0n7wrrhsTmA==
X-Google-Smtp-Source: APXvYqyJTuPxJLESIg2AAVO+0Qu5kY6kIoqlJxipUD6b6CiCisvbmld+Jtvzj9GY+rYdMIBu198z3g==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr6607027plo.282.1579627087560;
        Tue, 21 Jan 2020 09:18:07 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j8sm27044pjb.4.2020.01.21.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 09:18:07 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Disable pwrkey on Cheza
Date:   Tue, 21 Jan 2020 09:18:06 -0800
Message-Id: <20200121171806.9933-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use the power key from the PMIC on Cheza. Disable this node so
that we don't probe the driver for this device.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi       | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index dc2ce23cde05..67283d60e2ac 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -45,7 +45,7 @@ pm8998_pon: pon@800 {
 			mode-bootloader = <0x2>;
 			mode-recovery = <0x1>;
 
-			pwrkey {
+			pm8998_pwrkey: pwrkey {
 				compatible = "qcom,pm8941-pwrkey";
 				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
 				debounce = <15625>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 7b53b3c7ffe6..a8e9f639a2bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -626,6 +626,10 @@ &mdss_mdp {
 	status = "okay";
 };
 
+&pm8998_pwrkey {
+	status = "disabled";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
Sent by a computer, using git, on the internet

