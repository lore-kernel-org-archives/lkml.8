Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6D720C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUgY/1fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIITCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:02:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:02:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so3456231wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5BanKhi0v3vlOO/CZA+lZIZgxy5a1H/JGqfzet+ZBg=;
        b=tUgY/1fYk5Kq+fvcwA0lHtkxZI0KcXPOUUiv4CLIsFYUhCg36sr+Nu8GRq1dChywgY
         QBMR7qdX/I7qDOmqr8bCf4B9leYrX1WtA2xyeWik/zA4Us606HG9fnd6hfalnKmI5oci
         5nRh8wK64RyBxLekIAcJAgErFVGD5flo5WayxD/DttKWoOWg+fDFV8aR0eNnuL0cvsUz
         2g2wZv6SB7E+4or2hdOgLwXymUHPSaRNeTk5BYHNGpSAIQVJ5F/5YdUaXaFhZAXPmII3
         BPx4ZO1KfaR9PIfDIcoYu95JjFt9lcJj8cUjkvJ5cM8RH9E3quhwUpaHtNPjDmy93/m9
         5rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5BanKhi0v3vlOO/CZA+lZIZgxy5a1H/JGqfzet+ZBg=;
        b=qhfke4C1ty/HElynt0BF4lrnnt1/fkA9g6dUjswc0ZC7ZtWGV9HXvmuVFEiHiQqolO
         dvDoANjLVT7r2jATDCqqre+rhifOzG96wl8f63HSvvv1W8Hxp+4YHxj/ebbrYDnN7S7r
         XwbzDhgBDzcHHqV3mD3bi4mU6QsvaYrjKc574ji8Q1NaK5PS3VZF2s4jdr8Xm2uYBTsA
         WLZYm/eH+mStqa3eP1GYI7S7J9MptGDcyzsp6wE20PrK6tm2eZnBSUKXIk12N9NZ9e9r
         i/pkcEADzJ3lXvitLBv8ID1ikhRhbjKt+P6iNIqah50xKXkUkwyxWbITAwlvgtybX1EX
         DeDA==
X-Gm-Message-State: AOAM53158p2Qp7hd3vCi82bfdqG9KQLSbnNduVnpM+mBaqPyETizlvx7
        XTS5er/P0/UipQJciKelWJM=
X-Google-Smtp-Source: ABdhPJwPBWKRAcgWTlrUQmnl/uCGo1O0YqG+z6a3TYA8X/Jkm6kTxwS/lTyuEMN5Yq9AedMRaZYfzg==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr5238839wmb.13.1599678139157;
        Wed, 09 Sep 2020 12:02:19 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id f23sm593788wmc.3.2020.09.09.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:02:18 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philippe Cornu <philippe.cornu@st.com>,
        =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-mipi-dsi: Use kmemdup cf. kmalloc+memcpy
Date:   Wed,  9 Sep 2020 20:02:08 +0100
Message-Id: <20200909190213.156302-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup can be used instead of kmalloc+memcpy. Replace an occurrence of
this pattern.

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 52f5c5a2ed64..7e9a62ad56e8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1049,12 +1049,10 @@ static void debugfs_create_files(void *data)
 	};
 	int i;
 
-	dsi->debugfs_vpg = kmalloc(sizeof(debugfs), GFP_KERNEL);
+	dsi->debugfs_vpg = kmemdup(debugfs, sizeof(debugfs), GFP_KERNEL);
 	if (!dsi->debugfs_vpg)
 		return;
 
-	memcpy(dsi->debugfs_vpg, debugfs, sizeof(debugfs));
-
 	for (i = 0; i < ARRAY_SIZE(debugfs); i++)
 		debugfs_create_file(dsi->debugfs_vpg[i].name, 0644,
 				    dsi->debugfs, &dsi->debugfs_vpg[i],
-- 
2.28.0

