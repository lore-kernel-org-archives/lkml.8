Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77893C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438F3206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iab+lc8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgGLPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:25:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40159 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728826AbgGLPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594567503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=n8o3ePgic4naJPCVQ1wtcacm70aGxOgRT3KJzb6/xpk=;
        b=Iab+lc8V9v/bShsjVz4YFJQe5vW39u/j5mXzhNHSukH8xyYH6L7YxqoymnhGd0ZRhU5Bsy
        M2+v+vdyovCmXee2DLVxxmwqM/IFkTTPBGAPJyRZVD7c0z4LPyfUTnvdU37EDNqjaUS1Gr
        hdy4K7BnEk5wJUmfbz+vaZcKAikFcj8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-_zKjP8_gP6KvN3In-YEUkg-1; Sun, 12 Jul 2020 11:25:02 -0400
X-MC-Unique: _zKjP8_gP6KvN3In-YEUkg-1
Received: by mail-qk1-f200.google.com with SMTP id 13so8825963qkk.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n8o3ePgic4naJPCVQ1wtcacm70aGxOgRT3KJzb6/xpk=;
        b=Y7UsdrMWZyEmz7p0YEOzvMmQtMmQJ1SFGS9g36yaru9n8hYJ2cTPIKwA+kO5gFm31N
         q2BlgONzzphbBlh5+gYbjY5UbPfHUHUkYHIkYWLHktzAKLzhtgKW3lbl64m7sLXR8PEH
         fRfyDvT3GvUPuze1QuhkaSR51OCE4p60+X/0TmoM7Ir+lHaDkRDCm1+HKHRt0Z15Cect
         YeM+/6VjRab3xuZ4Rl/J0gtFLIpsAXLes8J+4mY2sPhFc2ZnEqcFZYkP5PdaW4in3RQp
         esRLyRNSLqk82WSS8JP2Lp0pMlEK7xFRe5E/FnD5IujtCDUxKaO/AXzmt6uC3xrcmEcz
         oP9A==
X-Gm-Message-State: AOAM531RnilKeEBkpRlaqwJfp9pk1iY79jDrRqk5soQMb6+ZlIJK/YoJ
        KCFgMbRMvgV+tXtL9zsjICvZ61FIkeDxh3TrBElW5EhxvTCG4XtfSKOk4/PpJGyGsc7+/BAuqGi
        gcK2gRnMAT566rT+t0ke9VGNL
X-Received: by 2002:ac8:19ad:: with SMTP id u42mr81124461qtj.168.1594567501933;
        Sun, 12 Jul 2020 08:25:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl77Yeo2vRgSclJ0lpU+vhDmXAKPXH0ay/FXIRBXDB1L7WTw8VZGr76FSRgh/J2hBHT9EZkA==
X-Received: by 2002:ac8:19ad:: with SMTP id u42mr81124448qtj.168.1594567501723;
        Sun, 12 Jul 2020 08:25:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o20sm16321336qtk.56.2020.07.12.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 08:25:00 -0700 (PDT)
From:   trix@redhat.com
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        architt@codeaurora.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/bridge: sil_sii8620: initialize return of sii8620_readb
Date:   Sun, 12 Jul 2020 08:24:53 -0700
Message-Id: <20200712152453.27510-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

sil-sii8620.c:184:2: warning: Undefined or garbage value
  returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~

sii8620_readb calls sii8620_read_buf.
sii8620_read_buf can return without setting its output
pararmeter 'ret'.

So initialize ret.

Fixes: ce6e153f414a ("drm/bridge: add Silicon Image SiI8620 driver")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 3540e4931383..da933d477e5f 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -178,7 +178,7 @@ static void sii8620_read_buf(struct sii8620 *ctx, u16 addr, u8 *buf, int len)
 
 static u8 sii8620_readb(struct sii8620 *ctx, u16 addr)
 {
-	u8 ret;
+	u8 ret = 0;
 
 	sii8620_read_buf(ctx, addr, &ret, 1);
 	return ret;
-- 
2.18.1

