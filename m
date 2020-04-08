Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA39C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711032072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgDHS3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:29:38 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:38024 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgDHS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:29:36 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1FA44804D5;
        Wed,  8 Apr 2020 20:29:32 +0200 (CEST)
Date:   Wed, 8 Apr 2020 20:29:26 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Enrico Weigelt <info@metux.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] fbdev: mx3fb: const pointer to ipu_di_signal_cfg
Message-ID: <20200408182926.GA21997@ravnborg.org>
References: <20200408162551.3928330-1-arnd@arndb.de>
 <87pnchhp2s.fsf@intel.com>
 <20200408180216.GC24828@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408180216.GC24828@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8
        a=QyXUC8HyAAAA:8 a=7gkXJVJtAAAA:8 a=ZTmiYS-oAAAA:8 a=hD80L64hAAAA:8
        a=VwQbUJbxAAAA:8 a=6NHAqQbvyHSTyVc_V14A:9 a=CjuIK1q_8ugA:10
        a=D0XLA9XvdZm18NrgonBM:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Bgfdu2smNuKfk3vLOmSO:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Pinchart <laurent.pinchart@ideasonboard.com> and
Jani Nikula <jani.nikula@intel.com> both
suggested to make the pointer to struct ipu_di_signal_cfg const.

Fix this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 3f6c93ec9254 ("fbdev: mx3fb: avoid warning about psABI change")
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Enrico Weigelt <info@metux.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
---

Again, sorry. I should have waited a day before applying.

	Sam

 drivers/video/fbdev/mx3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index e13fea3a292f..603731a5a72e 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 			  uint16_t h_start_width, uint16_t h_sync_width,
 			  uint16_t h_end_width, uint16_t v_start_width,
 			  uint16_t v_sync_width, uint16_t v_end_width,
-			  struct ipu_di_signal_cfg *sig)
+			  const struct ipu_di_signal_cfg *sig)
 {
 	unsigned long lock_flags;
 	uint32_t reg;
-- 
2.20.1

