Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5782CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7A2206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHJKAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:00:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54204 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:59:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k54au-0005nX-RN; Mon, 10 Aug 2020 09:59:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/vlv_dsi_pll: fix spelling mistake "Cant" -> "Can't"
Date:   Mon, 10 Aug 2020 10:59:52 +0100
Message-Id: <20200810095952.60968-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a drm_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
index d0a514301575..4070b00c3690 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
@@ -483,7 +483,7 @@ int bxt_dsi_pll_compute(struct intel_encoder *encoder,
 
 	if (dsi_ratio < dsi_ratio_min || dsi_ratio > dsi_ratio_max) {
 		drm_err(&dev_priv->drm,
-			"Cant get a suitable ratio from DSI PLL ratios\n");
+			"Can't get a suitable ratio from DSI PLL ratios\n");
 		return -ECHRNG;
 	} else
 		drm_dbg_kms(&dev_priv->drm, "DSI PLL calculation is Done!!\n");
-- 
2.27.0

