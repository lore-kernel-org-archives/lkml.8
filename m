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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2260C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A041B21927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD75O/Fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDSBjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDSBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:39:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC514C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t12so1220007edw.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YQ0IcD0MJa87Cl5cTZ+wxBcgc8xap3RC76BVjfIWVzU=;
        b=tD75O/FhAiU4tZlZn9qCLTOtwiBMTsQyy00zKr8jfD0SDT/f3eOlUGzOufRnPAAoF9
         I1st4PwIcwVtGKwAMlZ4my/xrbNqmEQtJhw6/jhriv0h185vZFB7nPbIG5FJ+u16OqZn
         cGAtjUJqvcLR8hzRG97pFV4xaPf4qVTGK3WtUa43hyU1OwHZzQ54+ARTkj865FqFrcBg
         FthwoEEPalDoI6PZu9z1/93deBEl2du4YAFaAvz2NZx+odT7qSOwE5Imk6bhd9B0LKV0
         8UW4n/TEPNKHzxXVr2LwrB6rPCb9Y0gxpJoFh055ywb0OcJOjrKukGTAD4DcgJ2sSSGr
         aIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YQ0IcD0MJa87Cl5cTZ+wxBcgc8xap3RC76BVjfIWVzU=;
        b=AnH+bTW9bryKkoR2hcq1VBE+bUauq4K1U9dfcOTswTKDp9OdRVkqOMr6b16e1Fxucv
         19YnxyyRuWhX0r2BAh5wZMUq9M7ktsDkcGvHpnxjQsnjSi1Y0h9FvNUEOra6mxxMsLBj
         4Zp/JDgJxRln2jMIUEv+9sg0A2VLoEEi6TZTPkz0QRG7+xXFwXrxyD+iOmVPQyxD/FjE
         L+LD/VdlsL03fLLhpkO0iHJOLZDcrJJ39b43Ih9rrzkv0b37PUIA4E2zaFIZFmIIzyef
         XsmEnCJvoh1ptNxSFJwrejhUMvLPO1dPtC0r1zjv4GtmLgm66dnGBj2MhYCauJJEkoMe
         H3Bw==
X-Gm-Message-State: AGi0PuZPVyBm0oPTMIwA7/eG3rCC8UOkS4X7teo5+8IkYIaOewzeWBj9
        5FG8QCidqnPcML5MZsuECZw=
X-Google-Smtp-Source: APiQypKtrQeAtBQk489goKZCmTEe3TzZzMjbpTdAWBmVki5DbC5eT0gEuTu4vqJXhH84TKEqepnGNA==
X-Received: by 2002:a50:cd89:: with SMTP id p9mr8914024edi.188.1587260369506;
        Sat, 18 Apr 2020 18:39:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k33sm3345395edc.18.2020.04.18.18.39.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Apr 2020 18:39:28 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/4] mm/swapfile.c: found_free could be represented by (tmp < max)
Date:   Sun, 19 Apr 2020 01:39:18 +0000
Message-Id: <20200419013921.14390-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not necessary to use the variable found_free to record the
status. Just check tmp and max is enough.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c457f3be6944..654bad5173bc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -601,7 +601,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 {
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
-	bool found_free;
 	unsigned long tmp, max;
 
 new_cluster:
@@ -623,8 +622,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 			return false;
 	}
 
-	found_free = false;
-
 	/*
 	 * Other CPUs can use our cluster if they can't find a free cluster,
 	 * check if there is still free entry in the cluster
@@ -638,21 +635,19 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	}
 	ci = lock_cluster(si, tmp);
 	while (tmp < max) {
-		if (!si->swap_map[tmp]) {
-			found_free = true;
+		if (!si->swap_map[tmp])
 			break;
-		}
 		tmp++;
 	}
 	unlock_cluster(ci);
-	if (!found_free) {
+	if (tmp >= max) {
 		cluster_set_null(&cluster->index);
 		goto new_cluster;
 	}
 	cluster->next = tmp + 1;
 	*offset = tmp;
 	*scan_base = tmp;
-	return found_free;
+	return tmp < max;
 }
 
 static void __del_from_avail_list(struct swap_info_struct *p)
-- 
2.23.0

