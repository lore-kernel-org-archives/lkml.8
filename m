Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DAC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0676520663
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgARIQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:16:02 -0500
Received: from [175.24.100.79] ([175.24.100.79]:54148 "EHLO mail.kaowomen.cn"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgARIQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:16:01 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jan 2020 03:16:00 EST
Received: by mail.kaowomen.cn (Postfix, from userid 5002)
        id 2ECB1E0F18; Sat, 18 Jan 2020 16:06:28 +0800 (CST)
Date:   Sat, 18 Jan 2020 16:06:28 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        irlied@linux.ie, daniel@ffwll.ch, airlied@redhat.com,
        tprevite@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] drm/drm_dp_mst:remove set but not used variable
 'origlen'
Message-ID: <20200118080628.mxcx7bfwdas5m7un@kaowomen.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/drm_dp_mst_topology.c:3693:16: warning: variable
‘origlen’ set but not used [-Wunused-but-set-variable]
  int replylen, origlen, curreply;

It looks like never use variable origlen after assign value to it.

Fixes: ad7f8a1f9ced7 (drm/helper: add Displayport multi-stream helper (v0.6))
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 4b74193b89ce..4c76e673206b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3690,7 +3690,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
 {
 	int len;
 	u8 replyblock[32];
-	int replylen, origlen, curreply;
+	int replylen, curreply;
 	int ret;
 	struct drm_dp_sideband_msg_rx *msg;
 	int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MSG_DOWN_REP_BASE;
@@ -3710,7 +3710,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
 	}
 	replylen = msg->curchunk_len + msg->curchunk_hdrlen;
 
-	origlen = replylen;
 	replylen -= len;
 	curreply = len;
 	while (replylen > 0) {
-- 
2.11.0

