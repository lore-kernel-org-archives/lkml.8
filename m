Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22ADC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42F020663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyUKc0Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCRFqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:46:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46536 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgCRFqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:46:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id c19so13277432pfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP5msWs+H65dtiCoHZMzY1KxEhCfiPf43beyeK96JJo=;
        b=DyUKc0WoN764jAONlN34IdUIF+JaIJ/8zjaKAOm62CXLomzbzdcCvDBbscthJO+/4/
         HUQc5JeCIlCKeDJVSNGIztS+uufYFrp0cNZ9um/3WnFzpTchsPxWJ3X7Dt6YWGIPCuIh
         lopK9XbixgTN7jbqM7R8gah+p0UmkOXGLsBlHi53U+nSXKrTf9DcyKdStD4Bk/vZR+5n
         62E4hBBBKmbeuU+9U0SSm2hVD12MwJHDVQxwE/lj3Y+nBEQ7oZKeEwxhko2qBkX1TZVq
         Wctb6+M6NBIsjTnYIRYV/jOIMAUXnrZGNPWNEBAyoojAA5goIXBO970mvCRMnrEDA/a5
         DkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP5msWs+H65dtiCoHZMzY1KxEhCfiPf43beyeK96JJo=;
        b=HwKWDcUZLLuSAcrgj8cAZK1oEaKuBd28gjiJjJGE0Fn64RRRSJW7Vm74bdxvlm8sfG
         0cu+sl3hhyrB60lJoq39vl1RPUuBW2bWkWgIZ0hukPFEzEHkkSph9dmo+YVAuHAwiatL
         6qhDDnHpRZDoYW82pO7g15JCbgeMaZ3V0BPDtaGLI21yoU4LrRKGM7Asl4M31sDDDBIv
         6UDHSJku5X1cvCCjhdRV6f7gaQ8aE8ZXNUEKExomoDhj5En7Ry6RGPnqSSkGqSEKe02k
         9Mul7fT0uGcdi1aVi3lMffKV6dpjp2TsdY0BwgWSf/Er2H5X2ouh7GJGpbFA6orqLOTn
         Y0Aw==
X-Gm-Message-State: ANhLgQ2eZ7ug2OL3kix5KE6Us79JOMQuG07K6O6ftTcarTh+NkgRmWSB
        wGqC7SQwT8a2tztkNApVs1xJbw==
X-Google-Smtp-Source: ADFU+vuDWULEK8ztlmXQd1G6mb8a4Xbgj98e4GwLuLlGS8GYoD7fM220tTPWyUhythBWGnl8atQ+9g==
X-Received: by 2002:a62:cdcc:: with SMTP id o195mr2579575pfg.323.1584510380719;
        Tue, 17 Mar 2020 22:46:20 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u5sm5128686pfb.153.2020.03.17.22.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 22:46:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: Reduce vdd_apc voltage
Date:   Tue, 17 Mar 2020 22:44:42 -0700
Message-Id: <20200318054442.3066726-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some msm8996 based devices are unstable when run with VDD_APC of 1.23V,
which is listed as the maximum voltage in "Turbo" mode. Given that the
CPU cluster is not run in "Turbo" mode, reduce this to 0.98V - the
maximum voltage for nominal operation.

Fixes: 7a2a2231ef22 ("arm64: dts: apq8096-db820c: Fix VDD core voltage")
Cc: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index af87350b5547..4692b7ad16b7 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -658,8 +658,8 @@ s10 {
 	s11 {
 		qcom,saw-leader;
 		regulator-always-on;
-		regulator-min-microvolt = <1230000>;
-		regulator-max-microvolt = <1230000>;
+		regulator-min-microvolt = <980000>;
+		regulator-max-microvolt = <980000>;
 	};
 };
 
-- 
2.24.0

