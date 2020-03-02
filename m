Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B21C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26362173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCBTNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:13:45 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50560 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbgCBTNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:13:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6F42AFB03;
        Mon,  2 Mar 2020 20:13:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2fTSlKgT4MT7; Mon,  2 Mar 2020 20:13:39 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A6F7E40490; Mon,  2 Mar 2020 20:13:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/etnaviv: Consider all kwnown idle bits in debugfs
Date:   Mon,  2 Mar 2020 20:13:34 +0100
Message-Id: <4af1a3f1df51feac79b25cc86c5554d74cfb657c.1583176306.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1583176306.git.agx@sigxcpu.org>
References: <cover.1583176306.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were missing out on some bits the vendor kernel driver knows about.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 873d9103164d..187de610b325 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -930,6 +930,20 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 		seq_puts(m, "\t FP is not idle\n");
 	if ((idle & VIVS_HI_IDLE_STATE_TS) == 0)
 		seq_puts(m, "\t TS is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_BL) == 0)
+		seq_puts(m, "\t BL is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_ASYNCFE) == 0)
+		seq_puts(m, "\t ASYNCFE is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_MC) == 0)
+		seq_puts(m, "\t MC is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_PPA) == 0)
+		seq_puts(m, "\t PPA is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_WD) == 0)
+		seq_puts(m, "\t WD is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_NN) == 0)
+		seq_puts(m, "\t NN is not idle\n");
+	if ((idle & VIVS_HI_IDLE_STATE_TP) == 0)
+		seq_puts(m, "\t TP is not idle\n");
 	if (idle & VIVS_HI_IDLE_STATE_AXI_LP)
 		seq_puts(m, "\t AXI low power mode\n");
 
-- 
2.23.0

