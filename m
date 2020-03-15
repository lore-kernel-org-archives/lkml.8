Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D409C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555C72076A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggxtvo43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCOB3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:29:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37169 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCOB3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:29:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so14232612wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jV5tZ1v/p9xuQRyV8rZQ6DHYjtqoRajw8WCeLW9xLgk=;
        b=Ggxtvo43ajRmI5XCMihEXXh5QNfPP23IGgGAQofyo4EoerWACwkSgJUcxjU/ijSMWo
         60T9pSBznVoXwlbAs0KCk1QLA8RCHEhiukgDi9GW5j0nQnAse7PG58dm+HH1MyY9B/iU
         kzQj+KfJLboan5g4H2QR3ZbMdzCjtccJMnDMyIYlLTjmrETLv11gbCWyHqtvNG9wSdzn
         LkGxuFsXEPb8X2PWZ17NJCWvfVVwzQGIuiskbmyPUKJLCji+M+Y91B7l645s+2m+7I7Q
         LTiAWBKL/lnfhv9ZYkVrUX9KJyc53tinFNgyLw0nUD7Xy9tkkV0CRj60MELGerw2iw43
         SpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jV5tZ1v/p9xuQRyV8rZQ6DHYjtqoRajw8WCeLW9xLgk=;
        b=acOGRUFNrA8X7FDmerFT70sSv/z0ktDvf0a4jqmMTc2zpDSzyLw7pmO+m4MFmuuIsR
         VwgV4baiEw9TKyIVEX/F0Zv61NmFsCCyvWO9CDsggyAosCwdb6VsG3NoTpPH2l/n6VYl
         JXRRZ7ZKQRMb0Wv8HWAwqKXWt+NdSvHcGP9iDDf7dUA6El8RKpZGky+Y7JA+ItfWSoZi
         la/TTjYc93zz4Kx7hQVBHNrFk3NyaqGBn7Hv/0auvncbjcceTnk6ieRv5urP2q4hLKg4
         ffr0WST7vYfuOP3Nx8wbhXlz06yNuUwm4Ct7aDsTAkoXGhRhYBaz0ZXtPFscGUJReuy6
         XPTg==
X-Gm-Message-State: ANhLgQ3cat7XnkKgJY2U2ElgZhQ+dj566qqkFhZAGDepEqD+0j74wJVu
        HM3HeyGkb+aNPzw/kMYr5Tk=
X-Google-Smtp-Source: ADFU+vsZhRwK0DE+LLHqscVM9gM+lQ91sJTeWm5Zea/fhcv+Vly6TyyRCGkXzfhH1uz8putd0WBPAw==
X-Received: by 2002:a1c:1b4c:: with SMTP id b73mr18403017wmb.17.1584235769447;
        Sat, 14 Mar 2020 18:29:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i6sm22802683wru.40.2020.03.14.18.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 18:29:28 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [Patch v2] mm/swap_state.c: use the same way to count page in [add_to|delete_from]_swap_cache
Date:   Sun, 15 Mar 2020 01:29:20 +0000
Message-Id: <20200315012920.2687-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function add_to_swap_cache() and delete_from_swap_cache() are counter
parts, while currently they use different way to count page.

It doesn't break any thing because we only have two size for PageAnon,
but this is confusing and not a good practice.

This patch corrects it by both using hpage_nr_pages().

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>

---
v2: change to hpage_nr_pages() which is opt.
    suggested by Matthew Wilcox
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a9bc5e..ebed37bbf7a3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -116,7 +116,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE_ORDER(xas, &address_space->i_pages, idx, compound_order(page));
-	unsigned long i, nr = compound_nr(page);
+	unsigned long i, nr = hpage_nr_pages(page);
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
-- 
2.23.0

