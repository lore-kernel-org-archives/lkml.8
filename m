Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D1206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="neABOikZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCXNpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:45:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35954 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgCXNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:45:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200324134519euoutp029061962dc8e50da6af8ba755aa8ed897~-QWpxL0XI3077330773euoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:45:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200324134519euoutp029061962dc8e50da6af8ba755aa8ed897~-QWpxL0XI3077330773euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585057519;
        bh=yXh2RcsZrYf2EbSKBQkmhmg+sHAmDch+gTjfbijzcbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neABOikZ4nqsjyc3v6hvgQtqmQ2T7Pn78RypvHTWVVwjUAvxGDZLNXV8t58n49P8H
         Wg9nZwftKX1VBfeCnc+qk1rBPCy73yrKhD+7j302fhWOJIkmuz5CBt8shrZjcsXF2j
         qIJXH8PVM/uuPdQliVV4SC0hGJmYuZmb4y2cePTw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200324134518eucas1p186a71391f432238701705559ec0af916~-QWpdBeby1322113221eucas1p1X;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C3.05.61286.EEE0A7E5; Tue, 24
        Mar 2020 13:45:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af~-QWpKax371592915929eucas1p1R;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324134518eusmtrp1d4ce6f0970fcaf01bbce7bfa205456c3~-QWpJuYsM2608326083eusmtrp1k;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-48-5e7a0eeedb29
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.56.07950.EEE0A7E5; Tue, 24
        Mar 2020 13:45:18 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324134518eusmtip2036fcadcccc7c972512ce3d33fbd27af~-QWo2jwJP2918929189eusmtip2h;
        Tue, 24 Mar 2020 13:45:18 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com
Subject: [PATCH v2 1/6] video: fbdev: controlfb: fix sparse warning about
 using incorrect type
Date:   Tue, 24 Mar 2020 14:45:03 +0100
Message-Id: <20200324134508.25120-2-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87rv+KriDP4cMra4te4cq8XGGetZ
        La58fc9mcaLvA6vF5V1z2CxW/NzK6MDmcb/7OJPHkmlX2Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoEr48/E2ILdXBW3LvSzNzC+5uhi5OSQEDCR6JrXyt7FyMUhJLCCUaL/ViMLhPOFUWL+
        20+sEM5nRom/n6YzwrQ0/JrODJFYziixeco7hJaXC9YxgVSxCVhJTGxfBdYhIpAgsWL6DDCb
        WSBF4sOW/2A1wkDxXTNvs4LYLAKqEl2T3wMdwsHBK2ArsWBVOMQyeYmt3z6BlXAK2En0TjvE
        DGLzCghKnJz5hAVipLxE89bZYAdJCPxnk7h5ZCkzRLOLxJs3V5kgbGGJV8e3sEPYMhKnJ/ew
        QDSsA3qt4wVU93ZGieWT/7FBVFlL3Dn3iw3kImYBTYn1u/Qhwo4SxybNYQUJSwjwSdx4Kwhx
        BJ/EpG2gUAEJ80p0tAlBVKtJbFi2gQ1mbdfOlVCneUj8vjCBfQKj4iwk78xC8s4shL0LGJlX
        MYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKaV0/+Of9rB+PVS0iFGAQ5GJR5ejYeVcUKs
        iWXFlbmHGCU4mJVEeDenVsQJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1
        ILUIJsvEwSnVwFiQk7ntVrlbz/ddR35I/7r7fcFM4XW738jsFEx0ufTJjL8+QmmfnMLRNr+Z
        zMHp5VHrZaJdlq4KZJUT8l2Vesx6gk2ezzIGlr0rt3zexF90uvdrg8dDdbv2RZ1KOqurTpyT
        dudck9sy3/igpr+Xd+DSKyerVtqbbeSZFTOpYWP+HZVt4tr765RYijMSDbWYi4oTAZkCy+An
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xe7rv+KriDN4cULG4te4cq8XGGetZ
        La58fc9mcaLvA6vF5V1z2CxW/NzK6MDmcb/7OJPHkmlX2Tz6tqxi9Pi8SS6AJUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48/E2ILdXBW3LvSz
        NzC+5uhi5OSQEDCRaPg1nRnEFhJYyiix76xDFyMHUFxG4vj6MogSYYk/17rYuhi5gEo+MUpM
        P/sIrJ5NwEpiYvsqRhBbRCBJorPhJFicWSBNYtLZu0wgtrBAnMTaTYfZQWwWAVWJrsnv2UHm
        8wrYSixYFQ4xX15i67dPrCA2p4CdRO+0Q1Dn2Eq8W38cbDyvgKDEyZlPWCDGy0s0b53NPIFR
        YBaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECA3/bsZ9bdjB2vQs+xCjAwajE
        w6vxsDJOiDWxrLgy9xCjBAezkgjv5tSKOCHelMTKqtSi/Pii0pzU4kOMpkA/TGSWEk3OB0Zl
        Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRq2KNUWX/bKZL4uf
        KWwPL1q3hUUlP7dz3qPMWVPKXn4p9XGOddJb/yeotYc763uVFXOLqcXPQ+3FixcdUi871W15
        YlnqcoOYNMPdS7q/1Kuxi1pff3o8YSVbQ1Z89pmTettkfO5oaSTdytcqCI4uPS0hfynRxaBE
        cd6B6jXr98m9eRSSMXGJEktxRqKhFnNRcSIAlQpAI5ICAAA=
X-CMS-MailID: 20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
        <CGME20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use in_le32() instead of le32_to_cpup() to fix sparse warning about
improper type of the argument.

Also add missing inline keyword to control_par_to_var() definition
(to match function prototype).

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 38b61cdb5ca4..9625792f4413 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -313,7 +313,7 @@ static int controlfb_blank(int blank_mode, struct fb_info *info)
 		container_of(info, struct fb_info_control, info);
 	unsigned ctrl;
 
-	ctrl = le32_to_cpup(CNTRL_REG(p,ctrl));
+	ctrl = in_le32(CNTRL_REG(p, ctrl));
 	if (blank_mode > 0)
 		switch (blank_mode) {
 		case FB_BLANK_VSYNC_SUSPEND:
@@ -952,7 +952,8 @@ static int control_var_to_par(struct fb_var_screeninfo *var,
  * Convert hardware data in par to an fb_var_screeninfo
  */
 
-static void control_par_to_var(struct fb_par_control *par, struct fb_var_screeninfo *var)
+static inline void control_par_to_var(struct fb_par_control *par,
+	struct fb_var_screeninfo *var)
 {
 	struct control_regints *rv;
 	
-- 
2.24.1

