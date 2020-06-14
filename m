Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76279C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5626420739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7gvBJJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgFNRX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgFNRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:23:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BDC05BD43;
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so16430858ljc.8;
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyQqkmAqCRmhebVrr7VbOeFm0zvD99iAEoTluAvbJX0=;
        b=E7gvBJJiMDzQ/hN1Q+zOkceklOE1WVsx+l7Iy9oVFXo5YdbJGaqXM1qt5YZ3j3zBoY
         2JmV6Ixn9GR6yhMc8rvT1dcmt//FSyhkSfcqF1GebqLgCpUiZLapr6jsTRYRJTRq5d/C
         Z/HR33BZUAVEKxTTJs0RdooZEqN7qmnRgfJngaqFt6eEzh0F4qaKRJPSp61zuzhwCF0J
         1OwGlGBGStNgq2Qh39E0tSs83Jmil03qwcc6RJpD1uus/SQSm4UVPvfisEahbNDFaOp+
         HbW5eowMmTX36XcBG7Wdqhz0kOdKepyD3Rznmh9qZzafTkX2MVWIr6GcWMoclqep168B
         +EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyQqkmAqCRmhebVrr7VbOeFm0zvD99iAEoTluAvbJX0=;
        b=br/NTW38eWkl1VWv2klvesoEcil83fhlridLnbsxMcA8eiBn1Ty/N+jrNC6XRCjqyO
         b0glrncJmSs4MgfIUJgE92SWKPdXNkvY4d1eKomtmR+QSgni6RKF7/yUvqZBFlh7lKjl
         m6tnVR+3grwWOFNUsBdVuehjvWOJt1CLrdaw9JfeN9o2KbtiHWxsP93YXNuHyJ7oC/Hh
         /iGNw4ewBX02siqRmnI100Gz7MzWiYnsLRP5HlvU0K1bEdf54+4Siua9xSiFpcZIy2c4
         YpACCDVlDOu0XwICGL121wW1iJa6QlsScjIz2vndfp646XTzV8KxSFcjAFKytYZlHzzV
         8nEg==
X-Gm-Message-State: AOAM531ppYec3Ak2+gtLZTuehWF5MaULgDo8IIf2vr2lTWM0f3CkWjUE
        OLM7teEXsJE+p5VHO2f8YUI=
X-Google-Smtp-Source: ABdhPJxjKu9bib2Y/FR5d++QXjDAXCBR7MA6OqR8H3NBmnRWIAqCA7uBRZPeT0pH9/ki30A+N3Wr1A==
X-Received: by 2002:a2e:954c:: with SMTP id t12mr6303730ljh.287.1592155400529;
        Sun, 14 Jun 2020 10:23:20 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id m14sm55144lfp.18.2020.06.14.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:23:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/6] drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
Date:   Sun, 14 Jun 2020 20:22:30 +0300
Message-Id: <20200614172234.8856-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614172234.8856-1-digetx@gmail.com>
References: <20200614172234.8856-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When graph isn't defined in a device-tree, the of_graph_get_remote_node()
prints a noisy error message, telling that port node is not found. This is
undesirable behaviour in our case because absence of a panel/bridge graph
is a valid case. Let's check presence of the local port in a device-tree
before proceeding with parsing the graph.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/drm_of.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index b50b44e76279..e0652c38f357 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -239,13 +239,24 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_bridge **bridge)
 {
 	int ret = -EPROBE_DEFER;
-	struct device_node *remote;
+	struct device_node *local, *remote;
 
 	if (!panel && !bridge)
 		return -EINVAL;
 	if (panel)
 		*panel = NULL;
 
+	/*
+	 * of_graph_get_remote_node() produces a noisy error message if port
+	 * node isn't found and the absence of the port is a legit case here,
+	 * so at first we silently check presence of the local port.
+	 */
+	local = of_graph_get_local_port(np);
+	if (!local)
+		return -ENODEV;
+
+	of_node_put(local);
+
 	remote = of_graph_get_remote_node(np, port, endpoint);
 	if (!remote)
 		return -ENODEV;
-- 
2.26.0

