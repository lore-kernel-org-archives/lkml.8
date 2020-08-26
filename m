Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29B220737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nswCwHh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHZCsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHZCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:47:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1952C061797
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so202101pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4Q7Cl+cu3/CF8brIVfk0tQHaoP3ezD7cmpJk6HAZvg=;
        b=nswCwHh/hcgBu/MulB5sS0uMz6USXeVvdwgxOzK214astSv+BIxFvxF0Bumh9s5zI/
         V4lLj/d22cTMZRzNSlHY3wnWRfhiymjo7tF91iSHAOnB3iCumyJ5K+ghTpw8SVTfxKTB
         oxYORQ51cGpnE0quM17uAvWQpprY879n1EX8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4Q7Cl+cu3/CF8brIVfk0tQHaoP3ezD7cmpJk6HAZvg=;
        b=lWUwGz3Np80/l/SIBesiUaiDf7V2Z/Uh9m9SK2NDcFiK8KDb172ogJryJYjw/CpIz+
         kKrK4m79Ts6LWzSF6NNk+ShMeto2EVWbXaDvM8+tD0W/pWu2qQO/IB5/ZmrMTC1w4G2D
         2904byVqV/rPncdsogKr6DovunMPDaG1ua99QaiyPDHPCd9sjXWE+lkSaFvSQo5MPKJu
         SDSMJvnjuk3cFzVCXD+ezAXQrW1TZWwE/iFIy3V4X7OOHNnCudPFeIx4oLI0iGP0Y1Bh
         FOUONmCh2+FkTgZAzneiFrLH8/Rb0WKmoPOLuKMwku0dfxBl37TyBv/cm5Qnr8HZMByj
         /UNQ==
X-Gm-Message-State: AOAM532PXovx3//B7PxUIGc9DOQKSW7/F533pJ+F9xAbqTuFTH9bSBLG
        awMgYgpjEkgMpQJ0NbB2QGs/+w==
X-Google-Smtp-Source: ABdhPJxdvC3WhhKuuJL53euVmbgWCmg6a8NKLad+aZ2/98+Owvt+TjSpAFXR19pZSpaukOquEEPA1A==
X-Received: by 2002:a17:902:9b8d:: with SMTP id y13mr8182606plp.90.1598410039209;
        Tue, 25 Aug 2020 19:47:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u65sm684381pfb.102.2020.08.25.19.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 19:47:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v1 5/9] phy: qcom-qmp: Get dp_com I/O resource by index
Date:   Tue, 25 Aug 2020 19:47:07 -0700
Message-Id: <20200826024711.220080-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200826024711.220080-1-swboyd@chromium.org>
References: <20200826024711.220080-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dp_com resource is always at index 1 according to the dts files in
the kernel. Get this resource by index so that we don't need to make
future additions to the DT binding use 'reg-names'.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 40c051813c34..76d7a9e80f04 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3266,8 +3266,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
 	/* per PHY dp_com; if PHY has dp_com control block */
 	if (cfg->has_phy_dp_com_ctrl) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "dp_com");
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
-- 
Sent by a computer, using git, on the internet

