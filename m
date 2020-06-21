Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DECCC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD6C252DD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHUShlUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgFUW2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbgFUW2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:28:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEFC061795;
        Sun, 21 Jun 2020 15:28:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m26so8489753lfo.13;
        Sun, 21 Jun 2020 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGMVc7fYIskRhRxhgb+o8TAVuUeppcTSMbztCWrU0FY=;
        b=XHUShlUyPVq6qda8TU0xvOi8y2O9qsu0OR5kZtu2ADHQW4UmcHOkVG7+0R3wzTFYpH
         k/VCTFtLYqfo0TlPctn7IS/Q9Tg5CIyrN4GAGoI5d5Oh+mUDgWkCrLjnXJyC1SRuNhTY
         XZTXHhQJER/TUvPJtwP92g56QbRHuViCmbjQBIXRfUDzY3FQC5hPCluIP28Dlz7/Oa0/
         os3SaBzqwKWUXf/L3uEryuRIWyxGc2rr8t1c7O4rjoRZPbS87aowsbd/NzOb43eKI7Qn
         N8GQVlhLbAOCwIrKR2rkL0czj4VRCGV5+PhvZ1fEtev635KVbOR+QqvSX2y1tAdW1AAp
         PqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGMVc7fYIskRhRxhgb+o8TAVuUeppcTSMbztCWrU0FY=;
        b=jBQTChhZ8YfVlzrbCqyptscp5NbMzQL82yklhiAj+Yf8KXJhL1rUlP5/jSMAeCv2dH
         /vWi5M/66N51AROFyelYdRabxtEHPPBjvEFNIG6WCaEi4iSnWwv4kV+JMqF5JraLJ1Sc
         4J80PGPBBRiTOaOmEqDvZ+sBEk04woY1bHZhHy8VElQm++/ssvjwWo1KnQHtbRuj7qev
         Hi9bjUFhvlZJiC+dypsERYdVizjesDgbv4yDhbGHQrtt3xAAj49KOsKNBdUDlkV68P5M
         uJOglN+QXHTYzvXYHw+IT91cy2NRrRmnFMgOZCOaTEFwvsjrgHMtdEsulQ8LerRFzVRd
         MHIw==
X-Gm-Message-State: AOAM530cmc5oLCR+YsaIaTM3IZjmeJ6geduhShLn+9IHOo4XyYloapnz
        4zgwGdau0i5XwaPOntVuUzYsrp6j
X-Google-Smtp-Source: ABdhPJzDyKEijm/9WLODmqHtoi1wGcYSZF1ETm3VkOk7VWhQgi4MgfCFWtWz/0PrAWYB4ocjZrQynQ==
X-Received: by 2002:a19:e93:: with SMTP id 141mr8072563lfo.107.1592778484128;
        Sun, 21 Jun 2020 15:28:04 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 11sm2361295lju.118.2020.06.21.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:28:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] drm/panel-simple: Correct EDT ET057090DHU connector type
Date:   Mon, 22 Jun 2020 01:27:41 +0300
Message-Id: <20200621222742.25695-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200621222742.25695-1-digetx@gmail.com>
References: <20200621222742.25695-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EDT ET057090DHU panel has a DPI connector and not LVDS. This patch
corrects the panel's description.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Fixes: 94f07917ebe8 ("drm/panel-simple: Add missing connector type for some panels")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ea6973d5cf54..87edd2bdf09a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1588,7 +1588,7 @@ static const struct panel_desc edt_et057090dhu = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
-	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 static const struct drm_display_mode edt_etm0700g0dh6_mode = {
-- 
2.26.0

