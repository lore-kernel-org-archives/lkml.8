Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A978C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F63207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Mv9P92EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgEWEUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 00:20:17 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:54788 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgEWEUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 00:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Fynj679f2jrOclrqH6
        Nydv7tjRQ5vbBgRn0vdlSqZ50=; b=Mv9P92EPwGOwCVWPGo7+ksRlTkUbl8zfbp
        Ve3LExdLn1ScA1fzmqumZ7veaP1o8jxo/zpDZt88MZTEu9oyQayNVzTGsbxmGSaT
        yJK3+dzLrlMoCDL1DLETWQlxgeTo/UcfTxGJ9bgcUJzk9egktS92u0Y2FPSAESAH
        42g31mAZ0=
Received: from localhost.localdomain (unknown [122.194.9.243])
        by smtp9 (Coremail) with SMTP id NeRpCgAHxS01nchePzBaPA--.303S3;
        Sat, 23 May 2020 11:49:13 +0800 (CST)
From:   chenxb_99091@126.com
To:     David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xuebing Chen <chenxb_99091@126.com>
Subject: [PATCH] drm: fix setting of plane_mask in pan_display_atomic()  function for linux-4.4
Date:   Sat, 23 May 2020 11:49:07 +0800
Message-Id: <1590205747-19599-1-git-send-email-chenxb_99091@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NeRpCgAHxS01nchePzBaPA--.303S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrury3XFy7tr1kAryUtw47urg_yoWfGFg_CF
        48Zws2krsFyryIv3Wayw43ZFyFka1rAF4rJrs5K3sIyrnFvrn3Gw12va4xur1UXF18tFyq
        va42v3WfXryxtjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUntDG3UUUUU==
X-Originating-IP: [122.194.9.243]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbi7hktxVtC3bsREAAAsh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuebing Chen <chenxb_99091@126.com>

The <include/drm/drm_crtc.h> provides drm_for_each_plane_mask macro and
plane_mask is defined as bitmask of plane indices, such as
1<<drm_plane_index(plane). This patch fixes error setting of plane_mask
in pan_display_atomic() function.

Signed-off-by: Xuebing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index e449f22..6a9f7ee 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1256,7 +1256,7 @@ retry:
 			goto fail;
 
 		plane = mode_set->crtc->primary;
-		plane_mask |= drm_plane_index(plane);
+		plane_mask |= 1 << drm_plane_index(plane);
 		plane->old_fb = plane->fb;
 	}
 
-- 
2.7.4

