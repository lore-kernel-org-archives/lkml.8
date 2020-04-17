Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACC0C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868FE21D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbqKbSdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgDQJjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgDQJjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:39:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED723C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:39:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so2268864wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNSs/WMMs8v8LjUrmuY7lbgWrm5/KMfPWOpJUMEIGMY=;
        b=JbqKbSdcMZexzofzc9Tq5ioiUHPtcqHNoP80MWNiHMvtWkRfplPiXtpRt7drnCbcN9
         rKjiG756xPwfC6l1JaF/NFRdW+2kWQDPFrX1OwBZQauIi4x+sy2x4Dqc1HoNBgJSLgYX
         eIijShSPioui6pcAky8KsSWFNu51TS5FZaBjH/4MNOVs4Tc6tuDvMflchE+v/bev1YAT
         6NMfglbEG9f47JiuYUo2Dgz/WCeNpjdIhdUme0OZgQ3WbR0tdI5gmZ+9Zy4845YvNPmG
         FW48wgsMsMaXEbZu8WmM3LcdW8DjOmE8GNwx+HMk/5H2b6lH7qF969czt/QGWjVvFXGy
         XFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNSs/WMMs8v8LjUrmuY7lbgWrm5/KMfPWOpJUMEIGMY=;
        b=LigX/MuYg64A8UsAIT0sS2H0MoSgGFNZ/lXN6JY6vG8C3Mtcms8wkp6DmhQ3dKSmgx
         XaoLmbGW/mQupQOHBmIScAkjfFNhGcnln0wWl9C+0/nY5RGeoY5MKQz9NhguFeqt4q00
         /Ed1YT69N6DDqpRCNh43y/RMOEvhjZNLv/NO41Y2HoGQ0oid0W3kaAWEizj7LA4uFlMe
         8Q4nd2480H5ChV5rzOOS14IiNSqbz/JHGhYusRbVaVtzZ4MW3iFva0vpYD6mRVJftP2K
         aMSaSgvVyruNeYcVYg2F0pXQxMpKKSiNFGMhkwbDI/0wptVrcU/4GiIGNqlwLZh5iPW6
         H/+A==
X-Gm-Message-State: AGi0PuYY2b1dMqHbz/GeaDufNH+Rg/Sd5PizuKLU6AA4yAPI45feziQM
        AkHS6h8mp6oK+uvimaRhtlccsw==
X-Google-Smtp-Source: APiQypLjCDr+lHOQd9iORXNvwi4wAxPgeC5qmc2MlHGFNNmFnbrdDVk1ilQZTEUF+aK84deHja4gzg==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr2417599wmb.75.1587116357734;
        Fri, 17 Apr 2020 02:39:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y18sm7719884wmc.45.2020.04.17.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:39:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: ngd: remove redundant assignment
Date:   Fri, 17 Apr 2020 10:39:14 +0100
Message-Id: <20200417093914.22052-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove redundant assignment, as this is already done fewlines lines before.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7426b5884218..743ee7b4e63f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1365,7 +1365,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		platform_device_add(ngd->pdev);
 		ngd->base = ctrl->base + ngd->id * data->offset +
 					(ngd->id - 1) * data->size;
-		ctrl->ngd = ngd;
 
 		return 0;
 	}
-- 
2.21.0

