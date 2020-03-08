Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED45C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C5B2072C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 04:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583643175;
	bh=07rLvQ0WqPhuHx8qZF5jp9yGE4CzHoiFnGAEnIVs0gk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WD0SIwG1BNF42ertlhinRKNEhY0kvQhn2pl4xwupv0mNs5VvzaFHk3l2H5Qj1h2lN
	 pPOHbthPdRtAc7JklTFlAtVt9Pd0ubcxqq4klxryNvOR9xf4kUPEFtWhJi6METU3e0
	 AudjNnBWVbKUOc6qbLHfmCJwDIEXRMnMw39EcoaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgCHEwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 23:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgCHEwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 23:52:46 -0500
Received: from DESKTOP-GFFITBK.localdomain (220-133-90-194.HINET-IP.hinet.net [220.133.90.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34712072C;
        Sun,  8 Mar 2020 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583643166;
        bh=07rLvQ0WqPhuHx8qZF5jp9yGE4CzHoiFnGAEnIVs0gk=;
        h=From:To:Cc:Subject:Date:From;
        b=m4Zj2xDSjTGoaTSoUSQs6A03ymGE8HVvObv62K525CY3HmsFNgl4Z5A1Z3iGevjsT
         3cvQw3NuBTLUhe8anoVra/G9i1NlTCFUwY9+9+xVVh5i7vPTNKqVNP1fNodUqNOee3
         YH8pFI7s90dQVQ01uqGxnnsCIIQp1kE86Fvz59fk=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] MAINTAINERS: Update Chun-Kuang Hu's email address
Date:   Sun,  8 Mar 2020 12:52:01 +0800
Message-Id: <20200308045201.3163-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address to @kernel.org

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..dceaeebce52a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5607,7 +5607,7 @@ F:	include/uapi/drm/lima_drm.h
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR MEDIATEK
-M:	CK Hu <ck.hu@mediatek.com>
+M:	Chun-Kuang Hu <chunkuang.hu@kernel.org>
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.17.1

