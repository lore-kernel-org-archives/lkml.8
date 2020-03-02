Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8384C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFBF20842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCBTNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:13:43 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50546 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgCBTNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:13:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5D92BFB02;
        Mon,  2 Mar 2020 20:13:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3cX07bvLwRke; Mon,  2 Mar 2020 20:13:38 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8D62340237; Mon,  2 Mar 2020 20:13:36 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/etnaviv: Update idle bits
Date:   Mon,  2 Mar 2020 20:13:33 +0100
Message-Id: <29414e54218e74b92342cfebcfbee69ac31546ef.1583176306.git.agx@sigxcpu.org>
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

Update the state HI and common header from rnndb commit
commit 19280a95a (rnndb: Update idle bits)

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/etnaviv/state_hi.xml.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/state_hi.xml.h b/drivers/gpu/drm/etnaviv/state_hi.xml.h
index 41d8da2b6f4f..8fe4598395f1 100644
--- a/drivers/gpu/drm/etnaviv/state_hi.xml.h
+++ b/drivers/gpu/drm/etnaviv/state_hi.xml.h
@@ -81,6 +81,13 @@ DEALINGS IN THE SOFTWARE.
 #define VIVS_HI_IDLE_STATE_IM					0x00000200
 #define VIVS_HI_IDLE_STATE_FP					0x00000400
 #define VIVS_HI_IDLE_STATE_TS					0x00000800
+#define VIVS_HI_IDLE_STATE_BL					0x00001000
+#define VIVS_HI_IDLE_STATE_ASYNCFE				0x00002000
+#define VIVS_HI_IDLE_STATE_MC					0x00004000
+#define VIVS_HI_IDLE_STATE_PPA					0x00008000
+#define VIVS_HI_IDLE_STATE_WD					0x00010000
+#define VIVS_HI_IDLE_STATE_NN					0x00020000
+#define VIVS_HI_IDLE_STATE_TP					0x00040000
 #define VIVS_HI_IDLE_STATE_AXI_LP				0x80000000
 
 #define VIVS_HI_AXI_CONFIG					0x00000008
-- 
2.23.0

