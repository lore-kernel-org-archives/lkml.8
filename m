Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1771C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD95221927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4fK9jlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDSBjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDSBjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:39:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so4820181ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEpAYCD5bOLpZUQC8vcQ6f94jMBWQvvy2nCjFU0ls9c=;
        b=t4fK9jlK1wgUSy+Pp+/3CzqaLFZ/PyK13I1ufEUVNj/FijAUxfHLltfr5bpd84ZhCS
         3PUKQlbLSBRxWVL13fRsFXBu5QuoCjnlHC76ighBdO67VY96Se4SQvZutSJGHvP3JB8K
         duGuAycRktDcEnZ+jhMTw0wrLBn+wQ6JN5xLnzMPjUy+B6hFHS3cYC3ZgliyE7tWl6bz
         2qL++6iy73Rj6+ZbC601D9vsRxPWYunk6L6NbTykXXRZ2kyN0LJAOV+0FG6vy/b4O96V
         +0ibXSLhcis1geYfN3aija8bdcn35ZVhqCfnQM/qTp/m5AI+8RWMdXSPsXkr95fkXZta
         8zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEpAYCD5bOLpZUQC8vcQ6f94jMBWQvvy2nCjFU0ls9c=;
        b=gtpo3/bpxXV39dQSOtPadbUWbimKAkQTQphE+4qBHpjc8jo3QWPvTu8LA/zhl0hI4P
         F3r6cdo6zs5b4Wt11dU5v+vKE6ebaSUp1dXiZTOFaUSMEOi5uB516pqv86SzhwAQw+Fv
         QdSexp/LBdaZxc2RvFUHgdINAxhAOT1oIIt2pzvI8YZe+KjtnOKZUbeWWXw02/m/xUe2
         U5iA6nkIPh3LfWl6kafcUPpYHdcZv1zurQ1+Yvsk2XuS5EUmyBt7EILnXQFVu7GKI4gY
         bDSxQ8204P6ksgJ+n9nLJTBrUm6Q1egy6j76TNZAVuvObJD0Pz2Eld/efQZtZV4yPD35
         Mv/g==
X-Gm-Message-State: AGi0PuYCv2Oe0Z8iRh1kG5lAmr+k/1UNLvsGIh+/7ZKfVPeORI/2r8Lv
        ueqp7SpQCSTtevdbEFRyX+g=
X-Google-Smtp-Source: APiQypLwymbsIeu6DL+padVkq+SZ74RPG7CqKILycA3osCTvhH+R6l6a/35jhnjBHTa8yj3piGV0VQ==
X-Received: by 2002:a17:906:a441:: with SMTP id cb1mr10262872ejb.242.1587260371291;
        Sat, 18 Apr 2020 18:39:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l2sm3615505ejz.29.2020.04.18.18.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Apr 2020 18:39:30 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/4] mm/swapfile.c: compare tmp and max after trying to iterate on swap_map
Date:   Sun, 19 Apr 2020 01:39:20 +0000
Message-Id: <20200419013921.14390-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200419013921.14390-1-richard.weiyang@gmail.com>
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two duplicate code to handle the case when there is no
available swap entry. Just let the code go through and do the check at
second place.

No functional change is expected.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3aae700f9931..07b0bc095411 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -629,10 +629,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	tmp = cluster->next;
 	max = min_t(unsigned long, si->max,
 		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
-	if (tmp >= max) {
-		cluster_set_null(&cluster->index);
-		goto new_cluster;
-	}
 	ci = lock_cluster(si, tmp);
 	while (tmp < max) {
 		if (!si->swap_map[tmp])
-- 
2.23.0

