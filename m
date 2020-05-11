Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C997C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0110207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZOCtuOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgEKMhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727994AbgEKMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:37:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0622C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:37:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so4846896wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WudCDKNIwltqXyIC4sQmrbpS3pV2CUnNxCEdHAnQUy4=;
        b=mZOCtuOYeQFrMdo7vUDcjGR/z4NHAHfhoEAuZycbrWaagbg6QpIKT+ZGRgL3JZ4Fqr
         bfqG4S7lQF2W66AvtBncKd/JQyRgGsLp5Hhplwxj2Iy8k2dPKBHIT/6mu2uuhYkClfPr
         p4ynpQoowfRu3zO5ntd1Xc0sy575WYhifa6NJH6yXtP+J17d39ikTYGZVzlPIeCm9pCy
         H6bxp1igS3Hc2m6ype4rDWzCZIkvg11FT5ZGWCUI2AtAy2D9/pXivMyulsltV0y+06OZ
         fbpDKU/Tyh6KZAwtoAskeHG4Z8TjuDNhUbDfqZMDsS6sv1ayU91WJGn8rpol6V/DCr2M
         vRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WudCDKNIwltqXyIC4sQmrbpS3pV2CUnNxCEdHAnQUy4=;
        b=eFyOr4vyJPaJCpluLKjt3krxTjLX/Tv5xQ3w0yAssF8f7ZrGhG4ToMOQvZ2Echii9V
         iJXMs73BROudC01JEH+E8ber3oivgdwwpKOkXIrPHiAMkeUyf5XCJ9NYpwdeb133KmgO
         q2QBQJvoaRsNgECqo0uYncSYcYGrYY0mYfjXaqOg1vEHy7TI2iNdSA0tAUVMN/3BUw1b
         Jc9E3ww224IBNfPUOh7v4U+z6NehR1gQwMkSiQXMIE//O4b6Jv5Miue4r5DGBgvR4aWs
         vQilhbybLF/2tl38+juCMeItNBNFHxZWoFPmqgqPgGfkJf01twthcWNvhTvi5Q28RqNw
         niHg==
X-Gm-Message-State: AGi0PuaruZP8lDxAgobO7LK+9PYt9yZM01Cor5c8dQGkUq/0xdR+dbiu
        VaNWUT07bhIU22qp7x0o0iTfPh48XMQTAQ==
X-Google-Smtp-Source: APiQypJ1RLhv+eW1TsuHlL9e31WY/kp/20I/CtCBpc1+BVpOMZUIWxDjCKGW3YThyDvPEw8Yrsfg7w==
X-Received: by 2002:adf:8563:: with SMTP id 90mr18295265wrh.74.1589200671321;
        Mon, 11 May 2020 05:37:51 -0700 (PDT)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id y70sm27981473wmc.36.2020.05.11.05.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:37:50 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.or,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/etnaviv: fix perfmon domain interation
Date:   Mon, 11 May 2020 14:37:33 +0200
Message-Id: <20200511123744.96246-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GC860 has one GPU device which has a 2d and 3d core. In this case
we want to expose perfmon information for both cores.

The driver has one array which contains all possible perfmon domains
with some meta data - doms_meta. Here we can see that for the GC860
two elements of that array are relevant:

  doms_3d: is at index 0 in the doms_meta array with 8 perfmon domains
  doms_2d: is at index 1 in the doms_meta array with 1 perfmon domain

The userspace driver wants to get a list of all perfmon domains and
their perfmon signals. This is done by iterating over all domains and
their signals. If the userspace driver wants to access the domain with
id 8 the kernel driver fails and returns invalid data from doms_3d with
and invalid offset.

This results in:
  Unable to handle kernel paging request at virtual address 00000000

On such a device it is not possible to use the userspace driver at all.

The fix for this off-by-one error is quite simple.

Reported-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Fixes: ed1dd899baa3 ("drm/etnaviv: rework perfmon query infrastructure")
Cc: stable@vger.kernel.or
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index e6795bafcbb9..35f7171e779a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -453,7 +453,7 @@ static const struct etnaviv_pm_domain *pm_domain(const struct etnaviv_gpu *gpu,
 		if (!(gpu->identity.features & meta->feature))
 			continue;
 
-		if (meta->nr_domains < (index - offset)) {
+		if ((meta->nr_domains - 1) < (index - offset)) {
 			offset += meta->nr_domains;
 			continue;
 		}
-- 
2.26.2

