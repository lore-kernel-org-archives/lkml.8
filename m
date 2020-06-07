Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F9D2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD4r7KAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgFGQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgFGQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:30:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86AC08C5C6
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:30:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so17531927ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ythenNMgCasy/26fjGx9+1WbKj8OM9GaH/NHc6AXhOM=;
        b=aD4r7KAYyBWRL+r3cCNFwandPIp1eaBY0+mJVtAAbLtlNeZCVeWmO4LdP98zGXkx2f
         mWWk3CuksVHnax1r1AAVz5876ez1ow5sbWhBGtJY0DmabUBtHAGnvlt1bxUVFJwk9OLz
         7X0SneyAfRhAjPkbAtwQ5OMzdMWIBSmbJvkSdy+lvAsyfSJErqbJmvJThSZjFU1KJrCe
         cpuYcZOGcVK3QquNEw3olj2fEPbf6FCVU/qXa6LhWsako84djR1C25QZQWcwdUQSgW8x
         SvqFhDiRFY/zVHG2Bw1dgI24DdE66sH6Hwl+PPj1Wzd/7mBFNJSFnOWgN0q14Jl7jDgy
         ft4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ythenNMgCasy/26fjGx9+1WbKj8OM9GaH/NHc6AXhOM=;
        b=nc/Yvr1HzmPaSabU+7THBcVpxqSECaRH+Hi/AEQZOZ3pQ3/Dn38Pbmclg4RN11JN6/
         XACnlKCJ0oyx7qNJtYJcaLwyvfZz9Zu7ZUoJhXW6zqru3iSuD5l9KtBrmoja1dNyLGUu
         ICLTPmljoTGIF94z6gLhda9wOpcJEnUVI09kBPaR3G6EpB1SsBMTbPNxP8sOrnTQNiZt
         kkqimSiUCibtn+nJsMQrfmHLkE5wajkRSraGWyGO3toDaffUlOSiDdzJ5Iy/47CI6xwi
         vIoDByDejAalJXnzZX0REi53L5FivUF1j1mLpmVwzYS2RHvfoAyqL5kv6zn7uSlQ/Bwq
         3fcg==
X-Gm-Message-State: AOAM532yJEoVDkpg3vjjY0Z2SM4MQvkaMl0xerKFcOC+MLsyivo4wLnx
        gt6Yv2hVrZN40vrG3gJ2eSecVA==
X-Google-Smtp-Source: ABdhPJztgQw/a4CxBiVGeklrqq34QTqDSxO6rZE1olhTeauKdcDOH+dSCnusoO2D30v2fZFAEdjbEQ==
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr9651976ljo.110.1591547448299;
        Sun, 07 Jun 2020 09:30:48 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id l7sm1726511ljj.55.2020.06.07.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:30:47 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v4 02/10] media: i2c: imx290: fix the order of the args in SET_RUNTIME_PM_OPS()
Date:   Sun,  7 Jun 2020 19:30:17 +0300
Message-Id: <20200607163025.8409-3-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607163025.8409-1-andrey.konovalov@linaro.org>
References: <20200607163025.8409-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is defined as SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn),
so imx290_power_off must be the 1st arg, and imx290_power_on the 2nd.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/imx290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 2d8c38ffe2f0..d0322f9a8856 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -648,7 +648,7 @@ static int imx290_power_off(struct device *dev)
 }
 
 static const struct dev_pm_ops imx290_pm_ops = {
-	SET_RUNTIME_PM_OPS(imx290_power_on, imx290_power_off, NULL)
+	SET_RUNTIME_PM_OPS(imx290_power_off, imx290_power_on, NULL)
 };
 
 static const struct v4l2_subdev_video_ops imx290_video_ops = {
-- 
2.17.1

