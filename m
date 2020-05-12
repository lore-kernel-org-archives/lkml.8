Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F9C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E4020714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589265463;
	bh=dtOykIWdlo6UzWclrcAiB6mjg5q5DPJDz1k6M/Lo4y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vR1pGbFAeVToAYahbmc6MmafnXUKpUn5flhTqq7835IF+SEdCaBPEyXbrULvkR8MO
	 cj/a/iQZg0r07/jFy4/gDDcGNHEKXbopSXkjVDZwXDYlAB2hnJfly2BYafRC1trQ5g
	 PIDn9buV6zsvQ5vx+GOlpV3kvXIM3sh1g3yXNVrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgELGhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:37:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D46E20733;
        Tue, 12 May 2020 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589265462;
        bh=dtOykIWdlo6UzWclrcAiB6mjg5q5DPJDz1k6M/Lo4y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6mn2kkbxT6O4BTldBDkMmCC6VUbI9c/qM3UDDIQ6MVHhxampn+SD9Hw0UrnOFtf4
         vlm60XWZismBxKxRsXGzBmn+91HP5sVfdhsf9lokKiUNgNuuK9FGC9dAWfqICsPFL/
         EyHGAL0tHlhZvy0roKLBQj/Ont3kpt9rdHjcgr3k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ingo Molnar <mingo@kernel.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/2] kasan: add missing prototypes to fix compilation warnings
Date:   Tue, 12 May 2020 09:37:28 +0300
Message-Id: <20200512063728.17785-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512063728.17785-1-leon@kernel.org>
References: <20200512063728.17785-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Use internal kasan header to declare missing prototypes to fix the
following compilation warnings.

mm/kasan/report.c:457:6: warning: no previous prototype for 'report_enabled' [-Wmissing-prototypes]
  457 | bool report_enabled(void)
      |      ^~~~~~~~~~~~~~
mm/kasan/report.c:482:6: warning: no previous prototype for '__kasan_report' [-Wmissing-prototypes]
  482 | void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
      |      ^~~~~~~~~~~~~~

Fixes: 57b78a62e7f2 ("x86/uaccess, kasan: Fix KASAN vs SMAP")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 mm/kasan/common.c | 3 ---
 mm/kasan/kasan.h  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2906358e42f0..cbb119224330 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -613,9 +613,6 @@ void kasan_free_shadow(const struct vm_struct *vm)
 }
 #endif

-extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
-extern bool report_enabled(void);
-
 bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
 {
 	unsigned long flags = user_access_save();
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d428e588c700..02d54a1d0b2d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,6 +153,9 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);

+bool report_enabled(void);
+void __kasan_report(unsigned long addr, size_t size, bool is_write,
+		    unsigned long ip);
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
--
2.26.2

