Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E18E20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr0A25+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgGVSOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:14:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39FBC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so2381299edz.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NUkQtv3OJHBzboi9ru1HyxK6os+k6GP868ADn16gFFU=;
        b=Yr0A25+8HZhtQNRtUXpWrihE5hC09s6PB8Ecc61nnw5jJrjAHYEaAZFsC4OeW1QdKk
         uoZp5lL7mWGagAVynN3amwJeNlbHpj4Z/FETX9Iu/837eiy7dcyuCEz4CFZL/rRzqpOe
         uinUfsZ9dlvU0P37gCridlrLSYBV16dzMZ8nX1JVYBxyMrQ2jcqv4ooxYjV7mRzUtBgV
         6dB87LJQjMUwdF88P/oixIA1jQ0NcQa48DuNh86HCl1+4VkhSRYPJTCkrGiCnsNsE6Pb
         ijZ2Jx3aaiRyjI2Ner8PI6Rc8klmEmfDcVeHQDjClW6B6HkBoO/EJmV+MPEyEVUL8ssr
         Lc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NUkQtv3OJHBzboi9ru1HyxK6os+k6GP868ADn16gFFU=;
        b=eiPDYqtSQQqBxpz9fJC7jsms1VSLQ+ZLgsqkS0t6dL/3EjFABc5UtyHw6oBRMPOAQR
         smASFHxdjAFZQfLOMBzxmcltsAQgBsGGaldBf9STaLucC7AnDb0WmrNuxIjVXutveVlo
         /iMdy1VgKb72bSG7AJcUPmkVgbma2CLY4KOy4WndNy3W//bBC2rasmK+a01Qli/iZjxJ
         k42ktQa/1TcVjyQ+lw5cew0tMXRdM9asOlpRH3td/jfi/qgdXFijxdJXDCQPx3l1fwZx
         OWf64MPlqpKettzpHqOZbTOwybavhgPTbNt8cY0jQqezEf4DAXXO+IM7g64LLuvzUp8t
         LWtw==
X-Gm-Message-State: AOAM533N4WojDe7TSW16+5hrk3y9TLpegSuc9OOlE5RfduKd20F8Iebi
        7zYj2Wyh0Mji1Dx8fgroSQ==
X-Google-Smtp-Source: ABdhPJxHHQnxfYsacvYxK8fphmFU5Y2/bDjz1g0ykQdB6aaEDAKTVi+GC+doGqCwIerSb2ZyUtCjkQ==
X-Received: by 2002:aa7:d802:: with SMTP id v2mr689281edq.77.1595441675574;
        Wed, 22 Jul 2020 11:14:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id x64sm372954edc.95.2020.07.22.11.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:14:35 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] drm: rockchip: use overlay windows as such
Date:   Wed, 22 Jul 2020 20:13:32 +0200
Message-Id: <20200722181332.26995-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722181332.26995-1-knaerzche@gmail.com>
References: <20200722181332.26995-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the comment for rk3288_vop_win_data windows that are
supposed to be an overlay window are missused as HWC windows due to the
missing implementation of that window type in the VOP driver.

This also applies to VOPs RK3036, RK3126, RK3188 and RK3228, which all
have at least one (1) dedicated HWC window (which are not currently
defined in the driver).
Since all the VOPs mentioned have only one (1) overlay window and all
now support alpha blending , it should also be used as such, as this
offers a much broader usage perspective for them.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

Changes in v2:
- rephrase commit message

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 5a13b4ab77e1..b4a00f13b559 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -131,7 +131,7 @@ static const struct vop_win_data rk3036_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3036_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3036_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const int rk3036_vop_intrs[] = {
@@ -200,7 +200,7 @@ static const struct vop_win_data rk3126_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3036_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3126_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const struct vop_data rk3126_vop = {
@@ -542,7 +542,7 @@ static const struct vop_win_data rk3188_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3188_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3188_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const int rk3188_vop_intrs[] = {
@@ -979,7 +979,7 @@ static const struct vop_win_data rk3228_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x40, .phy = &rk3288_win01_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const struct vop_data rk3228_vop = {
-- 
2.17.1

