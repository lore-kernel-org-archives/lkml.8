Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D854C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ED022CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3y29rNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHGIhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgHGIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:37:13 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D83C061574;
        Fri,  7 Aug 2020 01:37:12 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so406503qvw.1;
        Fri, 07 Aug 2020 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzKR9fHjZx1AaQExoBve0sSYuiasNViTLdv1o+mD+6Q=;
        b=H3y29rNHBwvSlWePlB/j3lgL0GjywETBOcirj8u4yKtxpdyL3bfjuzj1jNQ5EEbIun
         yhuCUnuG1aS3fZd5k7Ll4pnVuJ/Lut2dxUG3V4WAYa9n3k+AFbapYGVfbvzJTPyGwf3x
         hVZgn2zlMhyv2vEvd/QwgvwRLDpfeGQGJyFilALVa8YkBuhRaHznJew8B+qNMNfuDHyc
         aGyswHBFi65Nzq8yIpvnrdufwDnYODviRJBL8w3qT/JqAtQ35Dq8KZ+hTvowLeHDG9s1
         MgfZDBqal0gzosrEpu724SkueW2C+0n47rBuuwq8FBmACGHdaD8m2raBsXY1fMgoyFYW
         Qjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzKR9fHjZx1AaQExoBve0sSYuiasNViTLdv1o+mD+6Q=;
        b=WIdCUUsMwNK0iaeZ3IhPXaI7m9ooZ7Yooft5koBC/3r8bOwKsujJplbAZeifE+J/m9
         bo11fxGkRHnr0ETPJ5qvVbPfN159lR+yfa+hyqjHTMXIs9pO3oSyrMK6Wz+KffMIn+J5
         tYeu8HSkwLZbEDa/I9fEKAwFzXCNMSpgqdYFryMdhK8n2XK1oLKdMFwjHdUIXbOvhyv1
         XzfMLfqGSAQ/R+ycfdfYsz0HeS0bSC6AUrrK/1T1u3uuHugPFNT4BTqY2QU3kRn/ssvE
         FvxWqbvQ/+XSyJpSiLqk+6lNBFIIEZ4vAMpP3WeTb/u7DTu9y5PUEj1eiab10FdHHmZd
         5+pQ==
X-Gm-Message-State: AOAM533ZHYk8jQZtKx/KANveEpWmf9tw0lXVT3CYH/SoYysR6mQgXX54
        i3wmthtlatg/kXLcr4oV7+s=
X-Google-Smtp-Source: ABdhPJyPXSw1O5XN5M+Y93vNG6SmqTGTE+fS2tcUjgOTE1aFXJcHY99JP5iwSURFXJyCOfKPclrqbw==
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr13485713qvx.6.1596789432215;
        Fri, 07 Aug 2020 01:37:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id c42sm7846728qte.5.2020.08.07.01.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 01:37:11 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     Benoit Parrot <bparrot@ti.com>
Cc:     skhan@linuxfoundation.org,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] media: platform: vpdma.c: fix comparison to bool
Date:   Fri,  7 Aug 2020 05:35:46 -0300
Message-Id: <20200807083548.204360-19-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following coccinelle report:

drivers/media/platform/ti-vpe/vpdma.c:946:5-26: WARNING:
Comparison to bool

Found using - Coccinelle (http://coccinelle.lip6.fr)

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/media/platform/ti-vpe/vpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti-vpe/vpdma.c
index 2e5148ae7a0f..de600ffffbbc 100644
--- a/drivers/media/platform/ti-vpe/vpdma.c
+++ b/drivers/media/platform/ti-vpe/vpdma.c
@@ -943,7 +943,7 @@ int vpdma_hwlist_alloc(struct vpdma_data *vpdma, void *priv)
 
 	spin_lock_irqsave(&vpdma->lock, flags);
 	for (i = 0; i < VPDMA_MAX_NUM_LIST &&
-	    vpdma->hwlist_used[i] == true; i++)
+	    vpdma->hwlist_used[i]; i++)
 		;
 
 	if (i < VPDMA_MAX_NUM_LIST) {
-- 
2.28.0

