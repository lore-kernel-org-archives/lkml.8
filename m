Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1BC20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="SQauLQ9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGGP6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:58:51 -0400
Received: from mail-ed1-x561.google.com (mail-ed1-x561.google.com [IPv6:2a00:1450:4864:20::561])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B63C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:58:50 -0700 (PDT)
Received: by mail-ed1-x561.google.com with SMTP id e22so38867463edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hGGzB42iFy6ghF2u4QUqQFvdM4Y3ZVYyPzuZ+b6j5U8=;
        b=SQauLQ9kLevGI1sjapbckHVSOl/rItba2jDiiEVbyk6vgD+ekaU79GMgdlUfeg7csN
         k3FdKEQUQbUTZHGuSDJ6Hc1TCopRcYom+7PnjG012s215/7xWz96ysJjtfamTV2vBUIk
         GTH3Tt9sXgLdclGWvy/420eUO0eSeRH3Lj7hEo1jcNtzrhX3DFCuZgX20Lw6tJLifJ/y
         5lFyyEB9m8vy15HwlJmM9Fmxyw8y1jMDeQMUWteqGLSYd3fPNmPoVdfmM28eLKdieewY
         Un2WtQzZYAELNz1E0JK3TaPSXrIkbgrzYXuv2CcIW/dhpW5JgfdO4BL74R7Q2uxoCwXE
         XZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hGGzB42iFy6ghF2u4QUqQFvdM4Y3ZVYyPzuZ+b6j5U8=;
        b=o3zWK3fA4C9K/rF0tsX94pdWPl9GkejDuklcwqHQWmueXxgN2wHJB/om2OPjxOKiLg
         H2GVIKI6QcXO1kSVr8cX4mwItmWHwSxfaC7EwYoy7AEuf8l7v4IC056hZ7Q/L/xBMk7K
         F0bpGz1pwlwevU9xBnnL+uJMvG1V596t6QLOzrDSti76oj6955wuJhmGbiQ/aVVoZfra
         RJe1qHr+zmr9DCNb0AOq7vovMiw40cea1AnzMpv0rg/S74b+wi6/KFS7f8lIGKujgiqO
         ZTTHTdEdNcr42SjusrsHXaPlhSScz0vtASPmJkF0PDnKc9GUr2Jt8nd0oJXzTJIx4Bv+
         /rBg==
X-Gm-Message-State: AOAM532QTkTWcitoi+ZTOnwgNuiSLYt4K2Gxc0XIYYxqQ/hsGHYd75Oq
        rD7bzV45CeiXEYS62VDIi+esZY1cyooMcpybdmrrku/AfROB
X-Google-Smtp-Source: ABdhPJw3Tm43QgiqUvFQKRBYj1WOXo2yPNyh9gnBzpc4EcPlPdfH4671tIhDdJpTzLcWR0pDV42EoW7gLio1
X-Received: by 2002:a50:acc5:: with SMTP id x63mr39384755edc.99.1594137528113;
        Tue, 07 Jul 2020 08:58:48 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id dn20sm5596ejc.142.2020.07.07.08.58.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Jul 2020 08:58:48 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.14.70] (port=54136 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jspzb-00069x-Mi; Tue, 07 Jul 2020 17:58:47 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: imx: Fix occasional screen corruption on modeset.
Date:   Tue,  7 Jul 2020 17:56:59 +0200
Message-Id: <1594137527-15201-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing a modeset the atomic core calls
ipu_crtc_atomic_disable() which switches off the DC and DI.

When we immediately restart as in the modeset case this sometimes
leads to corruption at the bottom of the screen looking like a mirror
image of the top.

The exact reason isn't understood but it seems timing related.

This was observed on i.MX6DL on a system that does 2 mode
transitions on boot (fbcon->android boot animation->android homescreen)
then no more during normal operation resulting in corruption
about once every 10 boots that lasted for variable durations
from a few seconds to several hours.

Dumping the buffers confirmed that they were correct in memory,
just the display was wrong.

For tests the problem was reproduced systematically by forcing
a full modeset every 10 frames even if when not required.

Leaving the DC and DI on if the CRTC is staying on fixes this.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index 63c0284..9137b64 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -84,8 +84,15 @@ static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
 	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
 
-	ipu_dc_disable_channel(ipu_crtc->dc);
-	ipu_di_disable(ipu_crtc->di);
+	/*
+	 * If we are just doing a modeset don't disable dc/di as that
+	 * sometimes leads to corruption at the bottom of the screen
+	 */
+	if (!crtc->state->active) {
+		ipu_dc_disable_channel(ipu_crtc->dc);
+		ipu_di_disable(ipu_crtc->di);
+	}
+
 	/*
 	 * Planes must be disabled before DC clock is removed, as otherwise the
 	 * attached IDMACs will be left in undefined state, possibly hanging
-- 
1.9.1

