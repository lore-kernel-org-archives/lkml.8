Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CCFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6920738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAgktEuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgH0I2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0I17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:27:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:27:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so2933133pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fa/FRN51AnrOkZk0OKVdqIlVG6v9Zi3yinifrNAr+80=;
        b=lAgktEuIy34dp/IL4VO/nhPacZQjx7ZS/GCyeGhWta/d87/ZuyFrJyuXa5+XCeh8aY
         giY1uJQmPaVIllgUBTD6aq/USKvSqcZGHnGxGcxvokWkSD4TuR8D1y49FwOxq+wWyi2q
         T1wjNwRavC055dQg7/3fgRc+4sA7pltoprZBfNLqLcGHCSTg90myRn3shmZ3x39tVkMA
         LJybGFW6Yh6VSUMXP/ZRUZ7zxNA789r3+Yz4/lrOl+caDEmQRa6XhkI8vzPjfVTqvePr
         +m1ZYaHcAviJ8AvaOPaPbGNVYSgdggBMw0EbqPSk8FDdkMDQysmARMCWFiGfQWuHkoiL
         DUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fa/FRN51AnrOkZk0OKVdqIlVG6v9Zi3yinifrNAr+80=;
        b=onX8FcLYglDGbraa8HQbcIiNGBALRbX/3WUyeZspUSr1haXy7uoGjRKfy2OjIABwHG
         xiIxdkAl6sjAYiRehEQzHGJ6ldFdkHryjBnlbvCWZ4uVj9HQ1uKr8I9dcj3WKuacp/xy
         YSiCZiURMWsOJmbdFny/2n/CK7I/WT6oQBtUG/f//KZ5DyA8GtitCM24zCkYOobwputu
         Jk6LE3cJk8GIQt4HM+Rtnk57A++/vDr5XCWDvwPOAzJM7/lYBA5QIOuyuE1+AHf/z8fE
         BFcEM1+dB23fgoT2N09uVcd9PO4Uhd75xvNj9Z+r1Ai9b6CFMieWkqQVUxSTdY2Z37FD
         xqWA==
X-Gm-Message-State: AOAM531f8HfpDn8JZNrWEQU0QgUWaJnpGsGg7FBKDEhiPel+0mCZMPUB
        5KE9BuQ3phyn+s1OkN0scjA=
X-Google-Smtp-Source: ABdhPJw0wpighmqc7EmYHrVUF+WfEIiNTI/2BA3wK7bI2s3bMt5o33dbBjrJNfbucH+HlrS3SadA7A==
X-Received: by 2002:a63:4e56:: with SMTP id o22mr13163940pgl.381.1598516878036;
        Thu, 27 Aug 2020 01:27:58 -0700 (PDT)
Received: from localhost.localdomain ([117.192.156.236])
        by smtp.gmail.com with ESMTPSA id ft11sm1443967pjb.13.2020.08.27.01.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:27:57 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/bridge/tc358775: Fix semicolon
Date:   Thu, 27 Aug 2020 13:56:57 +0530
Message-Id: <1598516817-8240-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.1.2
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneded semicolon

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index d951cdc..2272adc 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -485,7 +485,7 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 		val |= TC358775_LVCFG_PCLKDIV(DIVIDE_BY_6);
 	} else {
 		val |= TC358775_LVCFG_PCLKDIV(DIVIDE_BY_3);
-	};
+	}
 	d2l_write(tc->i2c, LVCFG, val);
 }
 
-- 
2.1.2

