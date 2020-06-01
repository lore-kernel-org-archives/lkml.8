Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42A72068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035475;
	bh=GZhhrHGz8Ys3XjEkj3lsFSGFyE1jA+X30Q4yoTtdXjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=juu+yWQULup14aeB1bZFDEo1o2AoP4d5zhKqqFVb8yGhdEgU2LRS/6Rj27h4gO8ih
	 /xQQCgMjNcUB2qrorQUWpec6QtYgsyU7CAUCfaSEvpJcI/TZJeHKAhsoT+Tw6Yqkrj
	 At5UB1sUHYoJFNbyBpbIrE1APg9IERwp+NmUYrzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgFASRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbgFASRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:17:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5852068D;
        Mon,  1 Jun 2020 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035464;
        bh=GZhhrHGz8Ys3XjEkj3lsFSGFyE1jA+X30Q4yoTtdXjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=04Fm+2rpQxX/RRws0amOsjQDBkMOcCArIT4rNBu8L6nbgexFZmtfa63YBc/d2Nqc+
         fAHacQtMdNvdSkaZVSWONipf8BH2F7vy17nD8jxPC+MVaiBgmftEqofpUKCeHsmJxd
         vxYiHlD7tdmir0+QfeszvuZn+SXRucV7SUDInI0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 132/177] mm,thp: stop leaking unreleased file pages
Date:   Mon,  1 Jun 2020 19:54:30 +0200
Message-Id: <20200601174059.501360844@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

[ Upstream commit 2f33a706027c94cd4f70fcd3e3f4a17c1ce4ea4b ]

When collapse_file() calls try_to_release_page(), it has already isolated
the page: so if releasing buffers happens to fail (as it sometimes does),
remember to putback_lru_page(): otherwise that page is left unreclaimable
and unfreeable, and the file extent uncollapsible.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: <stable@vger.kernel.org>	[5.4+]
Link: http://lkml.kernel.org/r/alpine.LSU.2.11.2005231837500.1766@eggly.anvils
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..ba059e68cf50 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1673,6 +1673,7 @@ static void collapse_file(struct mm_struct *mm,
 		if (page_has_private(page) &&
 		    !try_to_release_page(page, GFP_KERNEL)) {
 			result = SCAN_PAGE_HAS_PRIVATE;
+			putback_lru_page(page);
 			goto out_unlock;
 		}
 
-- 
2.25.1



