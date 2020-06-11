Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D752078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+z/AWXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFKJTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgFKJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:19:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85963C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:19:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so2411184pfw.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LpZ1I24LzIYbhauF0cdv9OkeHWQm8vU4vzlbgzihJI=;
        b=C+z/AWXqqqyoNGp2beIObz9flW/5cQ7P6N13gSPIgc64s2Jop6sfsm7A9Fyv5oLwXV
         4ZGcCbEzds+M8NSiYmV1e/tQCX4hd6FePNTXJtm7XgH02eGGtUnFa0XlzBQUXwTlmiX1
         odZLSscTFven04VLWscFmeudCJ2U4LgGusJMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LpZ1I24LzIYbhauF0cdv9OkeHWQm8vU4vzlbgzihJI=;
        b=GFJ5WEiDMmBtjkzujl8rgkx2dGQ7XFZZzEblD6nm4Pm3ArXoN4BhYh0WAuBiEPypO+
         4jIjEToKc49Fwi99LluUEsAp4mr37EwVNv/ylkLznlmlG08x2jN/R+UmXkV9bPl+9hlj
         0iUhHdAK8k2S5wU1ofj+LGWA0EL6beFJMXriUEgHFv7C55dd+3p+1psvQAAFyO+DXQMC
         8IfKfAx0ResZpiN+qdhdk8UdBs0R8ykMYuhk0MuoDLRz5ztLW9BMtqu/2n5YbqlCHqmT
         5+6bF8zKCwm6+pbOhivY8MqcoRtnM/CVZzaS2GlW2O1TSRoSR2hzixFcEJe+oZQm0sOW
         MxmA==
X-Gm-Message-State: AOAM530L9tlDZGpuPY91T+kFW9d+2Ox1ekvwgkaLH/jrYTNinipY1O2k
        vriPdqGi4Aj//OmTD2115zGiYA==
X-Google-Smtp-Source: ABdhPJwzJPE7MfrQqvauxYPmpM5cOPWyY7NDCroTlQmtVZKhjPPDhPWOd2QQiztqms+Ay51GEAd7KA==
X-Received: by 2002:a62:7993:: with SMTP id u141mr6712669pfc.110.1591867165095;
        Thu, 11 Jun 2020 02:19:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 1sm2367852pfx.210.2020.06.11.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:19:24 -0700 (PDT)
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
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH/RFC 4/8] phy: qcom-qmp: Get dp_com I/O resource by index
Date:   Thu, 11 Jun 2020 02:19:15 -0700
Message-Id: <20200611091919.108018-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200611091919.108018-1-swboyd@chromium.org>
References: <20200611091919.108018-1-swboyd@chromium.org>
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index dace2f497c85..9dbc8c422263 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -2608,8 +2608,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
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

