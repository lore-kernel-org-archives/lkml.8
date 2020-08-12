Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA06D2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csaCe0hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgHLEEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgHLEEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:04:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3DEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:04:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so1385142ybh.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v1Nsq9N+YQMLR2jVkYck8gxTVP3hZK8QOU/HVFJRBuQ=;
        b=csaCe0hu/9JP+zZ//ozPOmHL0XLWrT5paJCyufD/RjSWZqGoymXuR8bYKZwSQ1xuZU
         vIRZSMK8FDns62Qcd5FuuBDWnbNstU2ZV3QKwHO4SKL9M153Ij5kZ4jAm0EicHVAYUdH
         k/4Zp5xdQLxCmW1c14Jo+q3jtnrXto5cI0aIfUTZ0m/iJrfRU2zIe56v7fK2poN4b/h8
         u5JFRJTCIIHeXq6HQhlgkpYbk4E43h4brKG+y5t+/+qraGWTrPcKitVVNIXAtw5uDYzS
         +zsRCwUeR8tA9RcYzpoeNggIOfI4bIGICR619BYk6opbVjwcQhA5S2W8uqHf8wRDQ1xY
         cG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v1Nsq9N+YQMLR2jVkYck8gxTVP3hZK8QOU/HVFJRBuQ=;
        b=i9xkbD7/qDKMq3tDEvX9rFXTWjZNzN225OlTDYaB6PGVI7cyLzcK4SCLNhUh1tUwW0
         wwdE+N6NRL6uImk77pVZALicauhsEmVc2B/nPkOjTMZqqrsW7IkqTxqEenW6lbFAs+nH
         hqXs9hAa5qNVTF4CQ4KlqbPCx0NmMUaCMBpOnTCz6flst2ackzlg86HMmiI6SCyVKWNu
         SWwl7Dc8v/JVgxmI/xT8VyUWGKHzljnMVBrYsJXwx0fW/O0gZlsiP09JeY6XNfeq+Sj5
         7fhmZDopntsDEra9SWBL4r+X/ll7PGzfUleGfnr0tO8TZ9gnnmo9FPqM3FBvBnb2nR4M
         4aXg==
X-Gm-Message-State: AOAM531faPx9iIrIQEJZTHLOmV1hX5eYAZEhiXAwA733yMDylMprWAx1
        MM/1JODCPBBHNa6IZGKA+/bab8ksnUo=
X-Google-Smtp-Source: ABdhPJzgKSVVawICdS1/tR2l0UkUBVuqBVVkP81T13b/A37jSsQT9YvQyxxxCErkAdkeK4g0XQL0xeV+dhs=
X-Received: by 2002:a05:6902:4c6:: with SMTP id v6mr25855740ybs.499.1597205071788;
 Tue, 11 Aug 2020 21:04:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 22:04:23 -0600
Message-Id: <20200812040423.2707213-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH 1/3] mm: don't call activate_page() on new ksm pages
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lru_cache_add_active_or_unevictable() already adds new ksm pages to
active lru. Calling activate_page() isn't really necessary in this
case.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swapfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6c26916e95fd..cf115ea26a20 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1913,16 +1913,16 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, false);
+		/*
+		 * Move the page to the active list so it is not
+		 * immediately swapped out again after swapon.
+		 */
+		activate_page(page);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	}
 	swap_free(entry);
-	/*
-	 * Move the page to the active list so it is not
-	 * immediately swapped out again after swapon.
-	 */
-	activate_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
 	if (page != swapcache) {
-- 
2.28.0.236.gb10cc79966-goog

