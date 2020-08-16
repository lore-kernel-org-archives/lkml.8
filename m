Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF5DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515F22078D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 05:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqDQw0LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgHPFu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 01:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgHPFu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 01:50:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B84C061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 22:50:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so6549997pfw.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y8IbMlSvYeV7TuMHFK5bjwWRDCnF/ixMBMv2DD2BAzY=;
        b=LqDQw0LGtg9nA50EIOSJkM9B61pEAaPXaGH5qyL7I9qrqz1Nx8wkt+MLpmcLyvNaX/
         xnOObUry8iqHpBity5FlQc56RHZUl5crwoygjMZLQJ+Pta5nP+IXJaiQ76qWuVdULIiY
         0JgB8aPdi34Ea0xNg3fCR7YS+Wkta7TSnKxr73qYz0m8aTO9cM7uP6yDQYzrCMSL+lna
         1xVophSU5jJHQS8Jo43ysexFTF6lwuOvZXuv7F0dOLwX/MUHLskt68N2nnEnwdgwiKOe
         BlFC9IGWFAXpk8adM16j43T7E2VOtGNs8/nrthEZvIo922lo2mmJb4sZYc7GuJQpX/pb
         W/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y8IbMlSvYeV7TuMHFK5bjwWRDCnF/ixMBMv2DD2BAzY=;
        b=oON0i7geSGTqkmk3LrLPFd0GCHKEkvGlOCULC2U4NhzdPY/lz0CRKpRC0t1k1Yzm5g
         +qB2mazqecNAV6mv5+7kJ5ZWpLmdj52YbIreDRgal/Gb0f4YjZgk0xSRGILSEvStgLlU
         oYAOAB1pFl3FJ8SSKgh6VkSVh6keTbNnOXtSbPxhPnIsSW7PZDh0gYdT60X4FFPqf+oc
         BoPyxDx4WnGyu24s4A0BkLL5F+nbaO7APU/YRxp+TaZNp5fNsRDClEmFsJQEd7u3Ru/5
         5/RttFlzdrUFzBBFbR3zNlGlf9JB8W20ZtxHhrmlib9fYiWJqS1o6otwBQpmbK+ebUD9
         80VQ==
X-Gm-Message-State: AOAM530j7LM62Kx0iIKHhuk6BXLDkoQrX9oV+8VjKMqA193/USKmXLPn
        LBAYv5EG9SM3/Tf0VL3Qd3g=
X-Google-Smtp-Source: ABdhPJw9jizrjHsIQvcg5ILlLHHR92ovY96FJUYVDQwtTLE0Gtl06KnhM4Bdb8wPIROjVDZiktAWhw==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr6942242pfk.219.1597557056656;
        Sat, 15 Aug 2020 22:50:56 -0700 (PDT)
Received: from inforce-server-Z9PE-D8-WS.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id x22sm14009310pfn.41.2020.08.15.22.50.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 22:50:56 -0700 (PDT)
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
Subject: [PATCH] drm/bridge/tc358775: Fix for PTR_ERR
Date:   Sun, 16 Aug 2020 11:20:41 +0530
Message-Id: <1597557042-5154-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

passing zero to 'PTR_ERR'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 7da15cd..d951cdc 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -684,7 +684,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	tc->vdd = devm_regulator_get(dev, "vdd-supply");
 	if (IS_ERR(tc->vdd)) {
-		ret = PTR_ERR(tc->vddio);
+		ret = PTR_ERR(tc->vdd);
 		dev_err(dev, "vdd-supply not found\n");
 		return ret;
 	}
-- 
2.7.4

