Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B92C55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4518220735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny1jxqte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDUVix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgDUViw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:38:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3AC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:38:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id u13so11530wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSR5r/wajhT1lzrVFFeM0Q886ybMNfo5cBVQSVOnGIM=;
        b=Ny1jxqtehmWMDptZW60CSQE8CJkfg1lEhguzt9FOAlo742lBQ+gpgvLZRcG141kIgz
         KAlnPIUkhknP0kf48niP1Al398vZoJx1gVz0ep+zcZtaH9hIbgLjijUcQ6tj6yTudBtc
         Qqrvx92zv4Hp+o8V1lNo0GEDDa9aQ+iCWzcdbkgDcHL2fXsADwwLFWzQv6UFcwqBbWSh
         z1h1c5YaFkV0jA75VPqYkiIy/i9wlONCA1Y/HR0x214ZrgKJfxRXBQT6dK7n0iBV3rRl
         eeRbYllFkQQ+1cbS7rpxHfAgq3oYrW5uGrkmLoJ6iO00f6Wbk6yHgJztIufyb2jCJMC5
         Un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sSR5r/wajhT1lzrVFFeM0Q886ybMNfo5cBVQSVOnGIM=;
        b=HT2hyiPrMoeXV4qtZbY9mlTy4M/1nnYnn3B6ia/hdgn3YDf1VoianWQA/KRk9dCswu
         Bo2hquEgAr4/xJa4PC4deufg0dhk7naOafUnbtNpoYCBZ8uFwj37pgFrClPBoErP3FOR
         D5z4MkmQZqFWAW3g0nDazW9opcE//en6ApA8nsYN07btSWIdtt6al3iyw4EYEHGjO3ZG
         NrIVweou8LWYo9vZaaLMDy8rVtgrwVAytyc01ZMrMIKOZtksbxksjTO8kcDLEZsW9PHU
         RoErPvBuHZceWtodbyYSPOleaRkzFLaPGVpvaeVm4fSnzMPLFfYOak7QuXRGprwfuZK5
         GaMg==
X-Gm-Message-State: AGi0PuZIX/l76g+j51/RD9RV2CugJq66uHjdX/yQsAjTFZZNl5q8JvFM
        4lUUh9vQrjJPfZkKbAfHUApF31Pn
X-Google-Smtp-Source: APiQypJ6Wah3T29xpCEPhuLy6v6b3AoGB+41adC9U4sLqRp+MhkBYpyo6Snc9Cw4/xQsOOUaKOcukQ==
X-Received: by 2002:a5d:48cc:: with SMTP id p12mr27664497wrs.170.1587505130600;
        Tue, 21 Apr 2020 14:38:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i5sm5242518wrw.77.2020.04.21.14.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 14:38:50 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 3/3] mm/swapfile.c: omit a duplicate code by compare tmp and max first
Date:   Tue, 21 Apr 2020 21:38:24 +0000
Message-Id: <20200421213824.8099-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200421213824.8099-1-richard.weiyang@gmail.com>
References: <20200421213824.8099-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two duplicate code to handle the case when there is no
available swap entry. To avoid this, we can compare tmp and max first
and let the second guard do its job.

No functional change is expected.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: Huang Ying suggest to do this check to avoid lock contention
---
 mm/swapfile.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bc435c2eb916..f3eee6d8cddf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -629,17 +629,15 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	tmp = cluster->next;
 	max = min_t(unsigned long, si->max,
 		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
-	if (tmp >= max) {
-		cluster_set_null(&cluster->index);
-		goto new_cluster;
-	}
-	ci = lock_cluster(si, tmp);
-	while (tmp < max) {
-		if (!si->swap_map[tmp])
-			break;
-		tmp++;
+	if (tmp < max) {
+		ci = lock_cluster(si, tmp);
+		while (tmp < max) {
+			if (!si->swap_map[tmp])
+				break;
+			tmp++;
+		}
+		unlock_cluster(ci);
 	}
-	unlock_cluster(ci);
 	if (tmp >= max) {
 		cluster_set_null(&cluster->index);
 		goto new_cluster;
-- 
2.23.0

