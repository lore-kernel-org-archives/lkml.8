Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE58C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FEF20714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auvVzsF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgC2WXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:23:01 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53370 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2WXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:23:01 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so6707155pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMRg/0yP9Xjy60a6h6rFBJo8CZLHExlOMPlSPckVbZw=;
        b=auvVzsF2PAUhBsqMwmVPVipZ8ae2alRiOjyFYIBalIWGSP7xNNwp/tQgbo3QBACovY
         UN67goolyTBoRVy2sxQuNXs4OH8DMquMR+kv5P3CrOcZSUZXa03f50OGeoYLk9lYw6K0
         OXz9hpmZf8XJVHOs71psXRA/x9KeJzViDbV/EhiFKd80dhJeRW+uLcGGdFH0DOgaO00H
         Rnf14q5dJxLDAXtWyQ6oUlOmx27UVhsPq2WDdKxGN8kMe4GAHC8WbtCE5/W2vbwIhQms
         mApl3AeYX3B5kGEqpK2+IdkhoucELKj0FBB9H73GE3FJwRjvca+RJvOtUyln8bO2pmKn
         pfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMRg/0yP9Xjy60a6h6rFBJo8CZLHExlOMPlSPckVbZw=;
        b=BRe1TxwAlgCp9pf2Ul74V0epuJyMYQ1xtC6IxS/4TBZCPksicewhoUHEuvBp1eQHP/
         jC2Iv4v2inW53462LfCvj2BTWgtuLe9A+ScQpd+U1AniZcWhkWCFAgpEjotzNjo4csQJ
         rwzwckK+SrlZVNJSc4oVXISigvdOeHlG5GkTDnyCEZtZjn2Q95ziLROPpNRD+xd7JMla
         o1xTmrKSWfvtXKRbuWk0vi92WO6bNJL67qTjeLmKcniJI1gtO4QE1nFGb1ivBMlBqnw9
         o/UFm8H6T15w9QNCW+KDTytm0V3plH6hjrsfP6GLdulO2GIOPVhiFV+H7PXq3F0UUpYy
         gyGQ==
X-Gm-Message-State: ANhLgQ3gMsBEGnh/SZ1Y9J6vJENcFom0NNYhA2I4PVxk3fUb9ycQqkSU
        r29ggP8i0XlyDqTz7e4q1Pw=
X-Google-Smtp-Source: ADFU+vuRsESBPbbYj7/sBEGFFADXyyCP9QY+TCgzQXqevkGRa/Gzp3bp6Oi25VgJSvC0PE1XYx/bfg==
X-Received: by 2002:a17:90a:368f:: with SMTP id t15mr12898021pjb.23.1585520579653;
        Sun, 29 Mar 2020 15:22:59 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id mq6sm8993269pjb.38.2020.03.29.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:22:59 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] drm/bridge: anx6345: set correct BPC for display_info of connector
Date:   Sun, 29 Mar 2020 15:22:53 -0700
Message-Id: <20200329222253.2941405-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (e.g. sun4i-drm) need this info to decide whether they
need to enable dithering. Currently driver reports what panel supports
and if panel supports 8 we don't get dithering enabled.

Hardcode BPC to 6 for now since that's the only BPC
that driver supports.

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index d7cb10c599a3..ea5de9395662 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -494,6 +494,9 @@ static int anx6345_get_modes(struct drm_connector *connector)
 
 	num_modes += drm_add_edid_modes(connector, anx6345->edid);
 
+	/* Driver currently supports only 6bpc */
+	connector->display_info.bpc = 6;
+
 unlock:
 	if (power_off)
 		anx6345_poweroff(anx6345);
-- 
2.25.0

