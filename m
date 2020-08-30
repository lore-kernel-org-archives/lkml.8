Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF76C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07C020DD4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT+D8vnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgH3VSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:18:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E67C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:18:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so4451866ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jiTIAaOvTcC09Rh4hOm98fvpcoLfNJ6VwISeHIermxU=;
        b=dT+D8vnV5/QzPKHiw6JhuWu5OSBIX4DLxnaw/T5DX05HnmcrgLb+jX8oQubdeVvTEp
         tI0HmpYQwddTfQRC6Ah+ud63bjLYFhVxXDYcRmzXE2zkmSe6WHKj4Q5GiAFBcfwfpKBm
         DJCU1st5oF4zZK0eWFR+b3mTMCobdeawD6T9qHLhagCfpGzr7tPanxbXkR17Tb0K0fuB
         1nXjn3xsEM1X5zFsa6KSKBWOuQP2wUJpZiJnM0h9GWbDhp5Kip1BGcEipS510pb9J7eM
         8Fi2XJC+5l3HiEDwVwpXFKAcENcrOVw1cq4F1PFwPP2FbD7tUSpIyqXiSYMDGN9jrKHu
         21hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jiTIAaOvTcC09Rh4hOm98fvpcoLfNJ6VwISeHIermxU=;
        b=XGRQ+cf6qX8omUbQqJmtkfGUcLaZMlUx2i9R3nl0NdwOZoHXr0PCW/kEuZE28jqckT
         unFECBvWWXk34YareC6pdBwTA1wZuIStOD+jveRyLtiZZOgFw7HyeCSc4BgfgZYt8REZ
         XLRStXUzo6k0kQzhwtFWvIvXDIQbp4iuraA/37wYIPe+wRNmz5mPz89bPMkdIWA/y47R
         B8R6Y8Z1TzgmR7gOoGZhp1/cOrOkSAarWJszJMLO/qxVZ0fTa9Lx3rqmCOSgF/torns9
         B509xKe6QLqaDfd2Ha6Un1M0YLCfK8Qkaix3rzNVi9Wi4H76DhCIQ13Yt16vb+qSfYuS
         T75w==
X-Gm-Message-State: AOAM5324Gu8N3Hq3dcX14CXjjojSJum+v1vUYumriLXzxFzWU9k4Knjn
        d/cnYG3wC7YICeAEDyxVhfk=
X-Google-Smtp-Source: ABdhPJw0+B2rnE9+5WaS9MRpDfvC8pRvDb6ixwRob4AV7JgunEpgK/MucpOqxcn96aSlnza5+VKABQ==
X-Received: by 2002:a2e:2f16:: with SMTP id v22mr3785894ljv.39.1598822284777;
        Sun, 30 Aug 2020 14:18:04 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r11sm1153464lji.104.2020.08.30.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 14:18:04 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] drm/gma500: Constify static structs
Date:   Sun, 30 Aug 2020 23:17:41 +0200
Message-Id: <20200830211741.17326-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to assign their address to the fbops field in
the fb_info struct, which is a const pointer. Make them const to allow
the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/gma500/framebuffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index da02d7e8a8f5..54d9876b5305 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -164,7 +164,7 @@ static int psbfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	return 0;
 }
 
-static struct fb_ops psbfb_ops = {
+static const struct fb_ops psbfb_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
 	.fb_setcolreg = psbfb_setcolreg,
@@ -175,7 +175,7 @@ static struct fb_ops psbfb_ops = {
 	.fb_sync = psbfb_sync,
 };
 
-static struct fb_ops psbfb_roll_ops = {
+static const struct fb_ops psbfb_roll_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
 	.fb_setcolreg = psbfb_setcolreg,
@@ -186,7 +186,7 @@ static struct fb_ops psbfb_roll_ops = {
 	.fb_mmap = psbfb_mmap,
 };
 
-static struct fb_ops psbfb_unaccel_ops = {
+static const struct fb_ops psbfb_unaccel_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
 	.fb_setcolreg = psbfb_setcolreg,
-- 
2.28.0

