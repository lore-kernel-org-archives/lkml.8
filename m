Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB7FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B41620737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYC6c5VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCYWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:03:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38020 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:03:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so5440092wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=agvIO6IAC74tbDrcVh+mwo/yT2bxjnoGYoZ36w/G8wI=;
        b=WYC6c5VQO1ju237T5Q+oZJnUvpwVU6UMDzPNqJoZ5i3WQHvpLkSUaHlVBlt0snttNR
         JaWW25ZiFwHJAFBSfD9+H/EP0RDZY4p/pjzjZVw1Jv7nyt+HdR7plTSucKqgBqGKNuTR
         dC5yA9JG3lYDvia6iSH8j5rLsayQrK9ot8A1pL7llwKk5A0uytgrKoDeA7+BxEtzzlPP
         +wHlweCpXRNSLtDGijcTK/lB6R6IN1avAmitao49Axw7j7uWK6zbL7zHJZxkqNMOy1EA
         g1bGCHHNF2xJKaaDKvuC9WO+MA7eRiMtZRDlZAp40w+KhwpXeS4Zv6YOGGdEu1BuRpSI
         T4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=agvIO6IAC74tbDrcVh+mwo/yT2bxjnoGYoZ36w/G8wI=;
        b=H1RqlM49sRivTwM95bzMLiqUeBdRm/IVa23IQJ5wpKptZadROgoERypnwJVU72EmEM
         f7DsrDZuk2yNDand/l94VFs+yn5cJam98Nt1Lx5BYL2+h0TvQwJ/hNPSZDhTBXrdhfOC
         w7lxnb5Mw2LarwsyGdn0f4q1oAuasHrqg8gXOn/nS6eSQuunrX+0VjjEHuecChTj/mys
         oRDJ89FucG176h3sZnOg4f0/eDLktIf1/T2YvoNGXfvIusv7vpA/qRN/yFimB32drA7J
         UOL7uf/WlfUPkJDbbzPxIFIcLxjhSvIju1kcLTf7GprJ+Z3vbe5XqOB4MgTsMOF1PShm
         lnEA==
X-Gm-Message-State: ANhLgQ2rkqlvhFxzsMs8Z6G98IcqOQwISLk0bFm9VxnveUMz50FAq27j
        kME5j9u92d9iWq69o03sOY9mCyKt
X-Google-Smtp-Source: ADFU+vuBltj8DZBlHNgYky+cwNcndJJYwg6qRPvBFLxAZRgw/+d63+IXqaflixa3ETgMJ0d8z1JPrg==
X-Received: by 2002:adf:83c4:: with SMTP id 62mr6015181wre.105.1585173804669;
        Wed, 25 Mar 2020 15:03:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y200sm567990wmc.20.2020.03.25.15.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 15:03:24 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] mm/swapfile.c: simplify the calculation of n_goal
Date:   Wed, 25 Mar 2020 22:03:08 +0000
Message-Id: <20200325220309.9803-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use min3() to simplify the comparison and make it more self-explaining.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2c33ff456ed5..85b151d73128 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1004,11 +1004,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	if (avail_pgs <= 0)
 		goto noswap;
 
-	if (n_goal > SWAP_BATCH)
-		n_goal = SWAP_BATCH;
-
-	if (n_goal > avail_pgs)
-		n_goal = avail_pgs;
+	n_goal = min3((long)n_goal, (long)SWAP_BATCH, avail_pgs);
 
 	atomic_long_sub(n_goal * size, &nr_swap_pages);
 
-- 
2.23.0

