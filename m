Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A77FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15920719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8hwkqNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCYWDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:03:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46319 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:03:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so5350631wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R49ssuqQGRjTcbw9XYqjygG4biZpQtMbehigwtsfjOM=;
        b=b8hwkqNqX/+hIC58/+o/jd+0hEIUCn6eGgDrCSTUGUo6c4fzZOYMEj37Roe2WBsIq2
         zPqtqniduYl+UvmFPdYuneOUTIEcUghd16bL9IJqmhH7XZTTrtZuQfFuLW/rgoeJOIZi
         KioKbDKUOjj1HE5tnVJk5cA1RODuS8ThgUlXbJzegQlwTT2tHHyq166tWty1RcqiWiOA
         4iVYzWAU/BjXIhlpyTreOQLqfAVOdvZkQrU15XbQbZof9bm3wZaUN34MCo6SojmQ5pSx
         U5iDZ6m7UARO56gdtaY4WIPX4f/p/P58rJaGF8PR5pXxxx/DuKqPmOlSyUprBt78MJkD
         zVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R49ssuqQGRjTcbw9XYqjygG4biZpQtMbehigwtsfjOM=;
        b=FjfmCHuHZm6CAl1dQOaENAaiDgx7h+FiuL5GIICsguo2nMuMvxfluol2XsIiwzng7x
         bHFxiDp6EsJhMIa7g9bnsqyOsznec8Zvt8Sqbl7sSu6Gr5U+4/ThCLqdjl5PiGNWJohA
         RQmfH2n8t80Td2eiaIAt8xH/1ClSjbYdD8b6KP+amZL9dgRAwFIeiAlPqgGBFQDo9CA5
         5RBRDin9w8omK1cUujWvhmtS4knWTGQddkEWQxL4Q716ZZWPF7lt2OtX0y50ppnwqG2r
         pNOYPGDPeXujPXhqpGA53ceC6yOThXLD0VTNZtPW//A9PJj880M2OYIvxc2+XVa6htVC
         wviw==
X-Gm-Message-State: ANhLgQ2Vfj4LRJNNrCbuThEdVRI266LG/s/RT4g7MVlS4jyNHI/B4iNV
        EeZ8HkfzqKuW4X6lFqswZwhebXPt
X-Google-Smtp-Source: ADFU+vts1LWIKOZxKckKm7jY1vK/lIgif1ns7ncn3MUnWWG+0Lwvm1lfxOUZoRF5sAbRYiKZPWNlrg==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr5907386wrx.360.1585173810581;
        Wed, 25 Mar 2020 15:03:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u8sm408952wrn.69.2020.03.25.15.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 15:03:29 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] mm/swapfile.c: remove the extra check in scan_swap_map_slots()
Date:   Wed, 25 Mar 2020 22:03:09 +0000
Message-Id: <20200325220309.9803-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200325220309.9803-1-richard.weiyang@gmail.com>
References: <20200325220309.9803-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scan_swap_map_slots() is only called by scan_swap_map() and
get_swap_pages(). Both ensure nr would not exceed SWAP_BATCH.

Just remove it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 85b151d73128..6b6e41967bf3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -740,9 +740,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	int latency_ration = LATENCY_LIMIT;
 	int n_ret = 0;
 
-	if (nr > SWAP_BATCH)
-		nr = SWAP_BATCH;
-
 	/*
 	 * We try to cluster swap pages by allocating them sequentially
 	 * in swap.  Once we've allocated SWAPFILE_CLUSTER pages this
-- 
2.23.0

