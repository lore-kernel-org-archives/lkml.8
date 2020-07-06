Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C119FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25372074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGFIAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:00:39 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:60586 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgGFIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:00:39 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3E97FB05EE;
        Mon,  6 Jul 2020 16:00:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14850T139810951177984S1594022430112946_;
        Mon, 06 Jul 2020 16:00:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b5073015f233c5bae0bb8de4d53a18fa>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     huangtao@rock-chips.com, andy.yan@rock-chips.com,
        kever.yang@rock-chips.com, Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/of: Consider the state in which the ep is disabled
Date:   Mon,  6 Jul 2020 15:59:44 +0800
Message-Id: <20200706075944.11558-1-hjc@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

don't mask possible_crtcs if remote-point is disabled.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/drm_of.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index fdb05fbf72a0..f5f250435add 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -66,6 +66,11 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 	uint32_t possible_crtcs = 0;
 
 	for_each_endpoint_of_node(port, ep) {
+		if (!of_device_is_available(ep)) {
+			of_node_put(ep);
+			continue;
+		}
+
 		remote_port = of_graph_get_remote_port(ep);
 		if (!remote_port) {
 			of_node_put(ep);
-- 
2.17.1



