Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31809C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149362076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGRS0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:26:41 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:46630 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgGRS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 14:26:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5C641FB04;
        Sat, 18 Jul 2020 20:26:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ntX7PWNyZs1; Sat, 18 Jul 2020 20:26:38 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 833FE42576; Sat, 18 Jul 2020 20:26:37 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 0/1] drm/bridge: nwl-dsi: Drop DRM_BRIDGE_ATTACH_NO_CONNECTOR check.
Date:   Sat, 18 Jul 2020 20:26:36 +0200
Message-Id: <cover.1595096667.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We don't create a connector but let panel_bridge handle that so there's
no point in rejecting DRM_BRIDGE_ATTACH_NO_CONNECTOR.

This was prompted by Sam in
https://lore.kernel.org/dri-devel/20200718115734.GA2989793@ravnborg.org/

Signed-off-by: Guido Günther <agx@sigxcpu.org>

Guido Günther (1):
  drm/bridge: nwl-dsi: Drop DRM_BRIDGE_ATTACH_NO_CONNECTOR check.

 drivers/gpu/drm/bridge/nwl-dsi.c | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.26.2

