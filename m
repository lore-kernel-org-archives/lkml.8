Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EA3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802762073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcFylXjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGACYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGACX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:23:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC9BC061755;
        Tue, 30 Jun 2020 19:23:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so25093772ljo.0;
        Tue, 30 Jun 2020 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=ZcFylXjOLKEs1YEHNYW5SEnwvyP1m2KYyDK40/iSh+wd1xzgRYRzAkZ02SDRdHlvKS
         FgrWvv/f3DqvqBTjLmLMu4Vgb37oufCQuhSiLv7Q8iMnxlMii3z2EN99y3ogpR5LzBEt
         0fn0iX2x4kpfMChJJ1RtTXPIBNkK0+CXoEQIIOnJgB9wcneA3QNTxl5UBz6qmXB4MpD1
         qLT+F+1ONyFbEv9w+pZzH42FrR1hpE8wt08Gr9xjhZWw4kJmx47RfgK8qOhTzI3Usqvf
         EUJDevskWnGxAUq5YBorUMVQzkr7/o32+e8vp7FaZrropV+fV4n2v7q6GABdOBvgbR1r
         CbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=AmZve8DvSTjSPmOxmPGPcOevznLoFzJA/pmVZWjHK+oPjGzyqTtIO8WoPDvmylaUpL
         SK+5+dxLBBQPxcOEyzGuBS5HXJmx/SNDtKTkIQ3PTZveul99tIh7YGI9JlCNmUKZowyT
         ohD7w4tu8/0tJRMCY/UIl6QhonZF0zGkaIckKaF8QpEqZyYj5fvVbGU5eTceUfSFVP3u
         wv0s5dh1QeRcHCj7AASAWWigxEb8f77jxad3+di6P0lNTbW71g8tF89mfQzUGMJhmiMT
         uT3QFKrwUHCf3Mbm1ZV45FITFMIVDfmx3UkDSqYOD55DzR0gl6+CK6Vd/h1psjM3Tb/X
         IEfA==
X-Gm-Message-State: AOAM531adIjyQN0mNxptzElLSk59h3dJKBH61WDdxq3Rv1AL5Qll/u46
        ujDPYL7Suym3z3cJ+K+eyldPU9O8TtM=
X-Google-Smtp-Source: ABdhPJzLVu+pc8eNoqlmFJWxGvBMY4WUCgYsygKPGHe9uic2XNC86UNcEKaXm3lAtRK2Rl63z8Fk0Q==
X-Received: by 2002:a05:651c:3cf:: with SMTP id f15mr9939751ljp.365.1593570236235;
        Tue, 30 Jun 2020 19:23:56 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id f21sm1303557ljj.121.2020.06.30.19.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 19:23:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/4] drm/tegra: output: Don't leak OF node on error
Date:   Wed,  1 Jul 2020 05:21:25 +0300
Message-Id: <20200701022128.12968-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701022128.12968-1-digetx@gmail.com>
References: <20200701022128.12968-1-digetx@gmail.com>
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

