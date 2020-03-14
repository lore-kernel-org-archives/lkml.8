Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B9C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D6F2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYo6vcut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCOCGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:06:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34277 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCOCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:06:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id s13so14769057ljm.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1+NVMP/qb3L1ZqyDLHUbOyatkLKfRF6W9vCOiaIIQwM=;
        b=NYo6vcuta83TP1sd5MkyupCDh0FjQ1GTWdLfsWP4JSGGUp6ocRBmB4ubXeHHwnm+R4
         p5vx4/eMxsn5AVhG2Tu6Va4E8OPHc4EPAil+AdMcXNi3XwbIouJ7e8BI3PmptohQ6jw1
         7fl4nJ56InkNgjfwVnoYtClPOq48Ha4zcKTUWtOGkD+soWUD6Fo2TYq9fIq8TcrvCQ/1
         dw63AwAniX8HM86HpAgGYJSuczQlIvzUZzvy8Pj+0IfAFBHMPzO2/nWeRNgsdU3OF50u
         scs4Wp7N4L3uVTcuyJovQWoDle/BneZFA1/oYESJi3e14l7oonSYISRKxzQmVGIOGeFk
         QV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1+NVMP/qb3L1ZqyDLHUbOyatkLKfRF6W9vCOiaIIQwM=;
        b=eRa8TDe2PBsEA3lPinJMXguT25FdIfSq2eKX2sMEB4jE0ixbfF0or/KpPKub1SzUwe
         P+Qd5oRI1CPrG2+PssLth2uSE6thugZH3G8OomcTKX5FwRt1olPPwIMUW0dPw3b1x/Wx
         5CIvHNE1A8NRpAKRkKTQJ6amxIzWsMTffCxbMmb90/QtfSt5xVW0/2fa81eZ7RREDsZR
         9+UED9nguLNtNZDF+cKo2XIJIGU1OcxnHuQuqmIRNqgYv8iQnSuXFbUkczJkXwOZ2aMO
         jD55cxiWT/HVVeBbea4Wa6sARaQYqOTcbznPi9EP8qWVAM7blbbxvw+nKEOR7I+Lrw3+
         xbMw==
X-Gm-Message-State: ANhLgQ3l5xYVAQfqnHfd1SAjcjjkScXYgbss3ndJc0mTi72GRiq7TBLW
        B0G8VCDB1aDqanyXdeTXVto0xYSq
X-Google-Smtp-Source: ADFU+vsTmSRUXiCWKVnd5AR1DG546YG2GOxymlbg9xT5dw9kTnDwnEpKpJQ1d8dnCsTLFQhmgFfrPw==
X-Received: by 2002:a5d:4406:: with SMTP id z6mr26022346wrq.68.1584223186862;
        Sat, 14 Mar 2020 14:59:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u1sm67338960wrt.78.2020.03.14.14.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 14:59:46 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm/swap_state.c: use the same way to count page in [add_to|delete_from]_swap_cache
Date:   Sat, 14 Mar 2020 21:59:12 +0000
Message-Id: <20200314215912.1554-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function add_to_swap_cache() and delete_from_swap_cache() are counter
parts, while currently they use different way to count page.

It doesn't break any thing because we only have two size for PageAnon,
but this is confusing and not a good practice.

This patch corrects it by both using compound_nr().

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swap_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a9bc5e..51d8884a693a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -158,7 +158,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
-	int i, nr = hpage_nr_pages(page);
+	int i, nr = compound_nr(page);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);
 
@@ -251,7 +251,7 @@ void delete_from_swap_cache(struct page *page)
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
-	page_ref_sub(page, hpage_nr_pages(page));
+	page_ref_sub(page, compound_nr(page));
 }
 
 /* 
-- 
2.23.0

