Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E735C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6165E206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgDKORW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 10:17:22 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10574 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgDKORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 10:17:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e91d1238a0-15a2e; Sat, 11 Apr 2020 22:16:04 +0800 (CST)
X-RM-TRANSID: 2eec5e91d1238a0-15a2e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.145.126])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e91d12012a-e4cb7;
        Sat, 11 Apr 2020 22:16:03 +0800 (CST)
X-RM-TRANSID: 2ee95e91d12012a-e4cb7
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] drm/dp_mst: Fix drm_dp_mst_topology.c selftest compilation warning
Date:   Sat, 11 Apr 2020 22:17:40 +0800
Message-Id: <20200411141740.14584-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct drm_dp_desc contains struct drm_dp_dpcd_ident, and the struct
drm_dp_dpcd_ident contains the array, so zero-initialization requires a 
more couple of braces. In the ARM compiler environment, the compile 
warning pointing it out:
    drivers/gpu/drm/drm_dp_mst_topology.c: In function 'drm_dp_mst_dsc_aux_for_port':
    drivers/gpu/drm/drm_dp_mst_topology.c:5494:9: warning: missing braces around initializer [-Wmissing-braces]
      struct drm_dp_desc desc = { 0 };

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 70c4b7a..4d8d1fd 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5494,7 +5494,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *immediate_upstream_port;
 	struct drm_dp_mst_port *fec_port;
-	struct drm_dp_desc desc = { 0 };
+	struct drm_dp_desc desc = { { { 0 } } };
 	u8 endpoint_fec;
 	u8 endpoint_dsc;
 
-- 
2.7.4



