Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5295C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD7F21927
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St0hXYA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgDVVlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgDVVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:41:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA0C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:41:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so4376940wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ThhukyQINKI9whzNRVjFk4vyyNMAskuRdMfXhDNMzHw=;
        b=St0hXYA70gpzdeNRTuM1ZDupzmvZsnJzUQA8kIcp5aafnhKa+vEsAj/3nxKZQEOnnm
         BHXMvwLE+vNxlAADZO5QgdCRij+dAh5MvvzX/gPMC2Vjr9UvUx6gldOefKGLpccaSavG
         gNGFH+1ZXsvoizKnp4UNk/hg3jTr1hrKvxq1TFHITicRhe6sz4vgCNPm20QCdZ2qFFvI
         E3aygkvT7qRdYOCol7WIO9i1ZoUX7qdCWDQJKf6Wll8t7F+hUQPfJmuuhNAm2wKbVceH
         WA3UK980MibzA7++XQvnLHTwxpjaAnL8hdoLCbDGuuNOdww4Mz/lJR3US6LBEGI+ucAR
         t5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ThhukyQINKI9whzNRVjFk4vyyNMAskuRdMfXhDNMzHw=;
        b=NqW//YnLtm1dk9L/y9XMZx7RyFMjDb6WvtHp+ELKt9z2rlz3SAaxP5w3ygqfkdjmP3
         OWNv8R4RPPyiz4kNH4b275IckW4T079DNiswl/Eirk6RhOOeFHwnISKPDo9XpszSXXmX
         KF/me/j2R/Q3Fk2ouRu57zmH3n73Mw+kJI5M7p0vyqbGDV+CGaKjRimkM0HbmNahnAxa
         R2fYKUZJAlA2fwgJ5m0T8glJIZ1UOHzNaCEu961zZrgHYrBEwHKw8lC+6V0cywATCyK2
         a7S7jY8jaL4bkVSH75qcEEItwVmv3qXhT88d7UGmoD7EGNhpWKf4WSB3AhlkYjgJ7I0Q
         c8iA==
X-Gm-Message-State: AGi0PuZumGl/BSnH0Zfyct+1SrMHTIxmvWJWN2Q+/AmRwTYy/NgSE7/q
        vDR8cowjO9IxiFGt5GLx1mc=
X-Google-Smtp-Source: APiQypJFdVUUcvCoLGEcck1TA1kOWxee40GrKRRTfNUBhRVTWDz51oR2Z4lREoX1Ws5xzVPoifqFSg==
X-Received: by 2002:a5d:4748:: with SMTP id o8mr1148817wrs.422.1587591679490;
        Wed, 22 Apr 2020 14:41:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h17sm746578wmm.6.2020.04.22.14.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 14:41:18 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, Wei Yang <richard.weiyang@gmail.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v2] mm/swapfile.c: simplify the scan loop in scan_swap_map_slots()
Date:   Wed, 22 Apr 2020 21:41:11 +0000
Message-Id: <20200422214111.19370-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit c60aa176c6de8 ("swapfile: swap allocation cycle if
nonrot"), swap allocation is cyclic. Current approach is done with two
separate loop on the upper and lower half. This looks a little
redundant.

From another point of view, the loop iterates [lowest_bit, highest_bit]
range starting with (offset + 1) but except scan_base. So we can
simplify the loop with condition (next_offset() != scan_base) by
introducing next_offset() which makes sure offset fit in that range
with correct order.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Hugh Dickins <hughd@google.com>
CC: "Huang, Ying" <ying.huang@intel.com>

---
v2:
  * return scan_base if the lower part is eaten
  * only start over when iterating on the upper part
---
 mm/swapfile.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f903e5a165d5..0005a4a1c1b4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -729,6 +729,19 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	}
 }
 
+static unsigned long next_offset(struct swap_info_struct *si,
+				unsigned long *offset, unsigned long scan_base)
+{
+	/* only start over when iterating on the upper part */
+	if (++(*offset) > si->highest_bit && *offset > scan_base) {
+		*offset = si->lowest_bit;
+		/* someone has eaten the lower part */
+		if (si->lowest_bit >= scan_base)
+			return scan_base;
+	}
+	return *offset;
+}
+
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
 			       swp_entry_t slots[])
@@ -876,22 +889,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 scan:
 	spin_unlock(&si->lock);
-	while (++offset <= si->highest_bit) {
-		if (!si->swap_map[offset]) {
-			spin_lock(&si->lock);
-			goto checks;
-		}
-		if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
-			spin_lock(&si->lock);
-			goto checks;
-		}
-		if (unlikely(--latency_ration < 0)) {
-			cond_resched();
-			latency_ration = LATENCY_LIMIT;
-		}
-	}
-	offset = si->lowest_bit;
-	while (offset < scan_base) {
+	while (next_offset(si, &offset, scan_base) != scan_base) {
 		if (!si->swap_map[offset]) {
 			spin_lock(&si->lock);
 			goto checks;
@@ -904,7 +902,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
 		}
-		offset++;
 	}
 	spin_lock(&si->lock);
 
-- 
2.23.0

