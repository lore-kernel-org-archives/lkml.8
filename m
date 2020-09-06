Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A444C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FE52075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgIFQWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:22:46 -0400
Received: from gw.c-home.cz ([89.24.150.100]:41975 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgIFQW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:22:29 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 086GLocv011279;
        Sun, 6 Sep 2020 18:21:59 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/sun4i: mixer: Extend regmap max_register
Date:   Sun,  6 Sep 2020 18:21:40 +0200
Message-Id: <20200906162140.5584-3-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200906162140.5584-1-m.cerveny@computer.org>
References: <20200906162140.5584-1-m.cerveny@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better guess. Secondary CSC registers are from 0xF0000.

Signed-off-by: Martin Cerveny <m.cerveny@computer.org>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index cc4fb916318f..c3304028e3dc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -307,7 +307,7 @@ static struct regmap_config sun8i_mixer_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= 0xbfffc, /* guessed */
+	.max_register	= 0xffffc, /* guessed */
 };
 
 static int sun8i_mixer_of_get_id(struct device_node *node)
-- 
2.17.1

