Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A67FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3592C2065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jXqpT17h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391242AbgEZUaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389367AbgEZUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:30:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1070C061A0F;
        Tue, 26 May 2020 13:30:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so25267862ejq.5;
        Tue, 26 May 2020 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HLyQeHEwRkmBN7Mz1fWdkXpoemib6Ct8xH1uqDFVgM=;
        b=jXqpT17hC9igpJGL8HqGKNSS1UpVOL7bro0lhrsTvwHSTf3+2sZmgHAZq3AmMUN1u4
         qmFWaqtO5r5SV/aJJGR7/gy/iFe3UC1WIkMs/RVrQtoHON7mQ81GTCHXFax3O1QnW8e4
         SsLD/tkyohqFtjaLi7YLYiqi3eq0y7ZCtPWuY0S0xMWuH4oF/EMAWtIJdgYvFx4x9g4P
         AMQGTDivXwDTtuctM3ElwNCTec3EHAb9u2PA8KUWGMC8i5HmPwR5VxsktsrLlZSRtD6H
         mO+B/1E5RbIv/5q2xI4e5ROZOCsZY/1nyzUZtts/2X4titAry4ZX5yFDy2AWNPlSxaie
         vfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HLyQeHEwRkmBN7Mz1fWdkXpoemib6Ct8xH1uqDFVgM=;
        b=HzahqeuM/5oOeNICFhbJ3D5GpauYfCS+y3SzhcoChM39CC2o6cs8esNg3Ovt5Pjg8U
         T6jqAoGS5tCHhw/IV7En5Ldw0sOwdwQ1DVWH+A89vToFWIxROMBp53rmIkfB0M7zi0RC
         JbEOQouuH0PlmaSJO62J0YmOy6PFk1YRgrjDih9PJJoFBVRrW+y2J+DOIMQq9VD0roMA
         dLiFkiITq1Sk6fYu5Jb0RxqVMQFtjNVd58tYLgyp+bMhnffztP5JFjg6Jyo1D/9nj9cw
         WjXc8iYHRErsIgscMZmgN9wSschQaDuF10OaeUBT6YnmPqelCQzz3YSI+Xf0EPqfhqEq
         dKLg==
X-Gm-Message-State: AOAM532SRkwexiRDULhg3mNlxxdR5TCjo/O9XPNc9NPKhr/gEwNkH0VU
        wndP5dFVAVOLHafNgJMsR1k=
X-Google-Smtp-Source: ABdhPJxqtvm6ZozNr3OfWjYHXrv9+mhZTQjYNNza+YL7N1NIhEwIs64tPCmgerGMOLsrKUYhFRDdAw==
X-Received: by 2002:a17:906:4815:: with SMTP id w21mr2784486ejq.533.1590525009201;
        Tue, 26 May 2020 13:30:09 -0700 (PDT)
Received: from localhost.localdomain (p200300f137189200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3718:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id ce16sm735517ejb.76.2020.05.26.13.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:30:08 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com
Cc:     hanjie.lin@amlogic.com, yue.wang@amlogic.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH for-5.8 2/2] usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs
Date:   Tue, 26 May 2020 22:29:43 +0200
Message-Id: <20200526202943.715220-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526202943.715220-1-martin.blumenstingl@googlemail.com>
References: <20200526202943.715220-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3_meson_g12a_usb2_init_phy() crashes with NULL pointer on an SM1
board (which uses the same USB setup as G12A) dereference as reported
by the Kernel CI bot. This is because of the following call flow:
  dwc3_meson_g12a_probe
    priv->drvdata->setup_regmaps
      dwc3_meson_g12a_setup_regmaps
        priv->usb2_ports is still 0 so priv->u2p_regmap[i] will be NULL
    dwc3_meson_g12a_get_phys
      initializes priv->usb2_ports
    priv->drvdata->usb_init
      dwc3_meson_g12a_usb_init
        dwc3_meson_g12a_usb_init_glue
          dwc3_meson_g12a_usb2_init
            priv->drvdata->usb2_init_phy
              dwc3_meson_g12a_usb2_init_phy
                dereferences priv->u2p_regmap[i]

Call priv->drvdata->setup_regmaps only after dwc3_meson_g12a_get_phys so
priv->usb2_ports is initialized and the regmaps will be set up
correctly. This fixes the NULL dereference later on.

Fixes: 013af227f58a97 ("usb: dwc3: meson-g12a: handle the phy and glue registers separately")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index ce5388338389..1f7f4d88ed9d 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -708,11 +708,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	priv->drvdata = of_device_get_match_data(&pdev->dev);
-
 	priv->dev = dev;
-	ret = priv->drvdata->setup_regmaps(priv, base);
-	if (ret)
-		return ret;
 
 	priv->vbus = devm_regulator_get_optional(dev, "vbus");
 	if (IS_ERR(priv->vbus)) {
@@ -749,6 +745,10 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clks;
 
+	ret = priv->drvdata->setup_regmaps(priv, base);
+	if (ret)
+		return ret;
+
 	if (priv->vbus) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-- 
2.26.2

