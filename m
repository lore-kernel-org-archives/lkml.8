Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1992074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFwKVZmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgFIN3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgFIN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:29:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A689C08C5C2;
        Tue,  9 Jun 2020 06:29:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so25073041ljn.4;
        Tue, 09 Jun 2020 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=ZFwKVZmJ8MZiS+yKqDOG1+DhkcEJJCq/2FLEmxlbnI8iOoQ0pvvcX+9WbJnEL4Y07y
         q0s3iTqppiEmQg/QWgIF1Hh38LG0s+86Y4cCi1NJY325/Lopu1av7FBHu0RuyEhrOCHo
         v3dI0Ke2MXFFbZRg3xm1m9Rz59DXhcn+5oYzXaLGP99IwsJVaWzk1LYRtIMx3JAKlxrm
         kfLLc/RO7ZUEDNvYOIatxGVHjr7vO25gfP4ECoZUXDMZ+lR8HkBjTvd6o8LoHd/+Hrs1
         tU/p5ClJJIl5wYjdTVXUvPcv6l2IYek75ImnUD/eilhDdAzF1monsFjDZvQzVtl5tt4f
         HBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=tRFqiJmpOYuaNaKWpMPGyq6f+CEWpJPDPxkatCskBLfltpNYMj8FBa/LiGVdfTXiL0
         Y7E0iHMCPXUX+piIuXSwk82i0Egi0FSNtpsSWKm+AOOiBJlfe1S4KiJ7nZAV3vXN2ED+
         ECHSEF9f751KD04//WyTf3b9ivtP762LgKo4/QpUan/3QR8USCbqH98rBABNkqbVZfZW
         jxj/ZCx4hb8DKhXVm1jns4ix8y0C9n7HYziidTvF/VMNRJVv3LEhnwb8XrWcEqr2gIqK
         ohg2//BAo2qeCgPGY1OEOZSU7LsK4cX4BIEwLVDm2XHGHvgONzlnEcrHN1ajtM8Ev2Df
         9jdg==
X-Gm-Message-State: AOAM533Hc0KZk7Q2Xd0HGFoB4fxg/slViseorToy7x3D+s6itdpb/3vN
        dlAtzpcYEP8fSeR5BAV8Zrs=
X-Google-Smtp-Source: ABdhPJxoPCX31yr+6U+GKJT2eytYYVErrWCMsq+nf1jvEBCuB8LYKRf2OQ7DnGBobtfcAb7fJw8L1A==
X-Received: by 2002:a2e:8796:: with SMTP id n22mr12640360lji.15.1591709353929;
        Tue, 09 Jun 2020 06:29:13 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id s8sm5069821lfc.83.2020.06.09.06.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:29:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] drm/tegra: output: Don't leak OF node on error
Date:   Tue,  9 Jun 2020 16:28:52 +0300
Message-Id: <20200609132855.20975-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609132855.20975-1-digetx@gmail.com>
References: <20200609132855.20975-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node should be put before returning error in tegra_output_probe(),
otherwise node's refcount will be leaked.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/output.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index e36e5e7c2f69..a6a711d54e88 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -102,10 +102,10 @@ int tegra_output_probe(struct tegra_output *output)
 	panel = of_parse_phandle(output->of_node, "nvidia,panel", 0);
 	if (panel) {
 		output->panel = of_drm_find_panel(panel);
+		of_node_put(panel);
+
 		if (IS_ERR(output->panel))
 			return PTR_ERR(output->panel);
-
-		of_node_put(panel);
 	}
 
 	output->edid = of_get_property(output->of_node, "nvidia,edid", &size);
@@ -113,13 +113,12 @@ int tegra_output_probe(struct tegra_output *output)
 	ddc = of_parse_phandle(output->of_node, "nvidia,ddc-i2c-bus", 0);
 	if (ddc) {
 		output->ddc = of_find_i2c_adapter_by_node(ddc);
+		of_node_put(ddc);
+
 		if (!output->ddc) {
 			err = -EPROBE_DEFER;
-			of_node_put(ddc);
 			return err;
 		}
-
-		of_node_put(ddc);
 	}
 
 	output->hpd_gpio = devm_gpiod_get_from_of_node(output->dev,
-- 
2.26.0

