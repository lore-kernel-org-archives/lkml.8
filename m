Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC7EC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD2F2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCHPWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:22:51 -0400
Received: from mail.manjaro.org ([176.9.38.148]:48390 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCHPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:22:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 98ED437A1C4E;
        Sun,  8 Mar 2020 16:22:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5tXGCKXIUL-q; Sun,  8 Mar 2020 16:22:47 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/1] Regression in analogix_anx78xx
Date:   Sun,  8 Mar 2020 16:22:37 +0100
Message-Id: <20200308152238.1294229-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ff1e8fb68ea0 ("drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers")
stores the max link rate in a u8, overflowing it.
This will probably prevent the link training from working.

I've not tested this patch beyond a simple compile test since I do not own
any devices containing an anx78xx. So please test!


Best regards,

Tobias

Changelog:
 v2: Skip forward and back conversion to/from link rate

Tobias Schramm (1):
  drm/bridge: anx78xx: fix calculation of dp link rate

 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.24.1

