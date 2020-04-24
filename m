Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB4EC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32F32063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EaiRysTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDXPvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgDXPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:51:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEFFC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:51:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so3295108pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5PlYrTAxuP4jdGGCfhHHIkEJ7U7EkPwrECQq1/CaMg=;
        b=EaiRysTHCtPodQ5fxFggQe3OinZ9fgf3lzjpO+Ink3q+dKHjSSGbaKMXLVP65Y7nyq
         TaxOzbgnqWXRtkAaFjxJD3pHXfoxRhIcx6M97qzDbeTTiJjX7kFSf5g0kH5SlZzTIhQU
         hY2fZ5eO5EVxTyLMtxw7Iq6vMaPZav1IOXT4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5PlYrTAxuP4jdGGCfhHHIkEJ7U7EkPwrECQq1/CaMg=;
        b=iH2+labZ7pgMMqrv+nnw3/zZ3qxgMmvIug4Cedi5B0BizZHWA4EgrnpvCtlOkfFdze
         FUFda72k8zsLhMcce6sIYnMuf12BfWp3e8Jpfx9+myGyrMEju/FyeWJWnPkpbyVeUHkx
         ZS1UnY9OD0kzGsIpxkUGmIciL1TeZp6Zz1QyDl2SlutNl/bFNDJdTEbk948y2oARcfJN
         1pddQ+mQ5RpTa9QBoDHXgXJmEQVa93nDN3rK/EWUnC+BaOsQT6CSTea4GUx8nxZTB4cq
         iUBhKVnUEGPsdOWh0V+g4vHbOQUrXqVkgcoktjshcUOmv6cTNDq9haltZ6FTFosqTeqj
         HYhg==
X-Gm-Message-State: AGi0PuY8F1HOZO0K7ZWZz2Yw0FtK7OUSBDpHhK7RwBAhvB27yEPCmMR5
        pqTjPEDdOjyQHod/IfJXmcUxWw==
X-Google-Smtp-Source: APiQypK5wO/pT3SH10jr2z9q6Ql2ONlPngJbVETLFqKnjrW9asaC9My0tclDZaDOgw6H69igIIl2Zg==
X-Received: by 2002:a63:5663:: with SMTP id g35mr7350444pgm.356.1587743509867;
        Fri, 24 Apr 2020 08:51:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 185sm6546149pfv.9.2020.04.24.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:51:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Add "no-map" to cmd_db reserved area
Date:   Fri, 24 Apr 2020 08:51:29 -0700
Message-Id: <20200424085121.1.I9d1e84d30f488cdb5a957f582abaecd2c0b24d70@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example in the bindings and all the current users (except sc7180)
have "no-map".  I'm pretty sure we need it on sc7180 too.  Add it.

Fixes: e0abc5eb526e ("arm64: dts: qcom: sc7180: Add cmd_db reserved area")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4216b574c080..94d2ee126d25 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -73,6 +73,7 @@ reserved_memory: reserved-memory {
 		aop_cmd_db_mem: memory@80820000 {
 			reg = <0x0 0x80820000 0x0 0x20000>;
 			compatible = "qcom,cmd-db";
+			no-map;
 		};
 
 		smem_mem: memory@80900000 {
-- 
2.26.2.303.gf8c07b1a785-goog

