Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA620C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779892145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xpy/MF7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIGIS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgIGISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:18:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0789C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:18:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so14840268wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bX1s4xMuL5vY2ccVWkeVsR98TkYqApy3vJM/yyJ0UUI=;
        b=xpy/MF7WlNAaepdnXSosFHddhAhU/jmZO82o8zHY6wCRvPW51p6Du1L3QdA5hyh+ik
         hFGY+o5OV8lzi1QtZ4416DJ5yxkukQtNxwePe5bCqdSgWTcYi4FxrxzelPJktF6SpTiM
         f4ZIHH72qSZyKypnocTiV0dUTgiuNzUcW5t71r64Laq0WZzwW00OJyZyW0HEV9tIaa7Y
         GTC7joGdyUaJWKSaMj7BqNXlSqVhhIPfZGbR0B8J8PiSw/ZWrJSK6WKzom3T+7XwWNPk
         V7KKJh8S0Nq0h0/loU+TzSIruF6bhgiYmKYdMS9us3aNOWCcqLn/QZz67/sXQOGWCqbM
         QmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bX1s4xMuL5vY2ccVWkeVsR98TkYqApy3vJM/yyJ0UUI=;
        b=EMNfqQU2lff+SYXkfGb1Gvb/jRQoEDHbKhPk8HmsPLT8BMal40nRnP4WAla8vKUPlE
         4puYHQYOvYDoXau6K3i8Q7Bu/XOO5DaIdBXSnpFZKkt9A9omMHPKbhdHsDum8zkYsvg+
         9PiJUQ+kNe70tSz3szNgGcElNYjyY6k03yNqvsx8Z4xlmMFcTSu71/E1jnSwNco+XIe/
         iDzDkt/knQEUAgphV0y8tCmbBVh/JXlwb6URBqbrTW9gH8zt36e7LVBbuJOvY+nt3I5y
         GWP/+FrhqtgxnfnIXzEve/2xGb6plOc7vxjm8o+CxpUaXcByA0JZhRj+gx1bRmaiy+XN
         FNYg==
X-Gm-Message-State: AOAM533JTvcHn1eC1rNYelEJ2EnvPhMYnlr6qDUh96mYh9MRlqKZVwqJ
        uk5l/roFrwZgwdc29x2VWIT3/Q==
X-Google-Smtp-Source: ABdhPJx37EVAY06BMAZdNUlhN9PbcXqw4hXGyZnhzv+klLTi6jqFy02Q485CkAsqiiMLG71JIu+hlg==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr13292808wrv.141.1599466717335;
        Mon, 07 Sep 2020 01:18:37 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id q186sm28032205wma.45.2020.09.07.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:18:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/6] drm/meson: remove useless recursive components matching
Date:   Mon,  7 Sep 2020 10:18:24 +0200
Message-Id: <20200907081825.1654-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907081825.1654-1-narmstrong@baylibre.com>
References: <20200907081825.1654-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial design was recursive to cover all port/endpoints, but only the first layer
of endpoints should be covered by the components list.
This also breaks the MIPI-DSI init/bridge attach sequence, thus only parse the
first endpoints instead of recursing.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 48 +++++--------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 92346653223f..1a4cf910c6a0 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -449,46 +449,6 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
-/* Possible connectors nodes to ignore */
-static const struct of_device_id connectors_match[] = {
-	{ .compatible = "composite-video-connector" },
-	{ .compatible = "svideo-connector" },
-	{ .compatible = "hdmi-connector" },
-	{ .compatible = "dvi-connector" },
-	{}
-};
-
-static int meson_probe_remote(struct platform_device *pdev,
-			      struct component_match **match,
-			      struct device_node *parent,
-			      struct device_node *remote)
-{
-	struct device_node *ep, *remote_node;
-	int count = 1;
-
-	/* If node is a connector, return and do not add to match table */
-	if (of_match_node(connectors_match, remote))
-		return 1;
-
-	component_match_add(&pdev->dev, match, compare_of, remote);
-
-	for_each_endpoint_of_node(remote, ep) {
-		remote_node = of_graph_get_remote_port_parent(ep);
-		if (!remote_node ||
-		    remote_node == parent || /* Ignore parent endpoint */
-		    !of_device_is_available(remote_node)) {
-			of_node_put(remote_node);
-			continue;
-		}
-
-		count += meson_probe_remote(pdev, match, remote, remote_node);
-
-		of_node_put(remote_node);
-	}
-
-	return count;
-}
-
 static int meson_drv_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
@@ -503,8 +463,14 @@ static int meson_drv_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		count += meson_probe_remote(pdev, &match, np, remote);
+		DRM_DEBUG_DRIVER("parent %pOF remote %pOF\n", np, remote);
+
+		DRM_DEBUG_DRIVER("match add %pOF parent %s\n", remote, dev_name(&pdev->dev));
+		component_match_add(&pdev->dev, &match, compare_of, remote);
+
 		of_node_put(remote);
+
+		++count;
 	}
 
 	if (count && !match)
-- 
2.22.0

