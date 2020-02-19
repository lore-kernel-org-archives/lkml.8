Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05128C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5DB206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vSIEsdEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBSONl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:13:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39445 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgBSONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:13:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so716760wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=k+5x80NuD9V+Qnk21e0mDSFOMaIC5Iytof66uYIbXss=;
        b=vSIEsdExWZ2FbdPu0MU7VTcU7IF3oIQ32l2NuuFLX8Pl5KvjA2twy0JNbXU9P3gDHq
         pOIyRNd5icecIFJ6CN41j4lbT0HN7PdIOQQfHknbRaNqaij9+c0i4d0iJg+IQGvonXEU
         /9FRusWgtIxolCOpZiznjI7l95lFAo6SYHdMTkHOSWXGeE5QQ4xXAyjQIBJ7H28zG08w
         aF36mTgygaz9dlKMUJ1bBVY4y30cpm+aMCHoCls0t+A8d56qFO9jks3oTHVBldvNsVj2
         Eafka6pMIzGAL5iq4nWphoxSq1ILpTyXY8Snp3fTPCd08FppMLnwh55Ef5rUYg9R1hKi
         SLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k+5x80NuD9V+Qnk21e0mDSFOMaIC5Iytof66uYIbXss=;
        b=qI9+XJgce4HYCrcWZujLyn+sthkCJZUAFucUXo/W8QYXCasH7hAsGMz5O7QDi2dom+
         8iAMCpD9rKgbENxtbJ5yMnh/QWvgiQRSa/u9QPkhVR/goEhi2l9VHk1MOwbwe0+9CkO0
         KuExh7QZZs38mKVw0Lh0KGGXjufalXTJ5pkgLA42N0dgbP1ffy1Zgw9nQXNqZAwO75WA
         CxqzYp6Uihuf66SSns4TEJqiv7gg1scSkw4c8pwyuRUensy6KlhhLQ8Cf6oNkde6V5hH
         5UT0AgAWuFKC651Z8q9Dnmv1EUq1F00OelpUrdXbkkvYRrWkg3Wr2CiGnJtaRbOm9pw7
         ESkQ==
X-Gm-Message-State: APjAAAVI7jbTViWn4/dFmDM97TAc63jvxn+oa9vHB4Um7oAiQN9fJcu8
        Me4vW5ZwBEzT9TUkrice6RrI9A==
X-Google-Smtp-Source: APXvYqzMstRSs0CuhMEXF+cVCctS5nCVYxs4zXGgDEYIyjt2Wlt/zX0aqBTexiTEeZ2jMvRmxr7YRg==
X-Received: by 2002:adf:f406:: with SMTP id g6mr36762230wro.189.1582121618880;
        Wed, 19 Feb 2020 06:13:38 -0800 (PST)
Received: from robin.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g25sm7999695wmh.3.2020.02.19.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:13:38 -0800 (PST)
From:   Phong LE <ple@baylibre.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>
Subject: [PATCH] drm/mediatek: component type MTK_DISP_OVL_2L is not correctly handled
Date:   Wed, 19 Feb 2020 15:13:24 +0100
Message-Id: <20200219141324.29299-1-ple@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The larb device remains NULL if the type is MTK_DISP_OVL_2L.
A kernel panic is raised when a crtc uses mtk_smi_larb_get or
mtk_smi_larb_put.

Signed-off-by: Phong LE <ple@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 1f5a112bb034..57c88de9a329 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -471,6 +471,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	/* Only DMA capable components need the LARB property */
 	comp->larb_dev = NULL;
 	if (type != MTK_DISP_OVL &&
+	    type != MTK_DISP_OVL_2L &&
 	    type != MTK_DISP_RDMA &&
 	    type != MTK_DISP_WDMA)
 		return 0;
-- 
2.17.1

