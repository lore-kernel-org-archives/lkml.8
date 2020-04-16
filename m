Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628522072D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rh6nALOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391123AbgDPDf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:35:56 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20296 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbgDPDft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:35:49 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200416033545epoutp02bc1631fce06f4543889995d1bee90b62~GL4ATpYsM0782107821epoutp02-
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:35:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200416033545epoutp02bc1631fce06f4543889995d1bee90b62~GL4ATpYsM0782107821epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587008145;
        bh=yWL2MFhV8L3OokKgPk9AaY1d1laWT5u9vlv+KNP6WrQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Rh6nALOY37FqhyG+kGvlee7yuTbmHcxa4qoD5gwm1XbyvAf+KIwy0+2I/aimRaC+m
         1Z62vOltadRramR+reMI4/vODNhuvtNOxT75NZRw+aU9ySMLuJzI/3xe2UxSBYeAI5
         C+hTqmfaqiBLFbwmlYnRP+5g3/woX9M6DF+S0nug=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200416033545epcas1p332be81e5610fcc56866971beec7c4049~GL3-sc_xq1083310833epcas1p3P;
        Thu, 16 Apr 2020 03:35:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 492lHN0QgzzMqYlm; Thu, 16 Apr
        2020 03:35:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.77.04402.F82D79E5; Thu, 16 Apr 2020 12:35:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a~GL3_HNYXG0184601846epcas1p2T;
        Thu, 16 Apr 2020 03:35:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200416033543epsmtrp17852f07d8d0bdc6afb12cb19348bea55~GL3_GS-NO2924629246epsmtrp1x;
        Thu, 16 Apr 2020 03:35:43 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-54-5e97d28f4d77
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.4D.04024.F82D79E5; Thu, 16 Apr 2020 12:35:43 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200416033543epsmtip23022a73905f0710cb316026c6ce786fd~GL398wvwF0615006150epsmtip2A;
        Thu, 16 Apr 2020 03:35:43 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, mgorman@suse.de, m.szyprowski@samsung.com,
        mina86@mina86.com, riel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
Date:   Thu, 16 Apr 2020 12:35:14 +0900
Message-Id: <20200416033514.6366-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQLf/0vQ4g333rCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8XaI3fZLSa/e8ZoseB4C6vFsq/v2S3+XlnPYvF4PbcDt8fOWXfZ
        PTat6mTz2PRpErvHiRm/WTzW/XnF5PF+31U2j74tqxg9Np+u9vi8SS6AMyrHJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7G6u//WAp6xCt6
        PwQ0MG4U7mLk5JAQMJGYf34FSxcjF4eQwA5GibvfF7OBJIQEPjFK/N0bApH4BpRYt4gJpuPI
        51dQHXsZJV6fW8sI4XxnlNj3+StYO5uAtsT7BZNYQRIiAk2MEj83zwdrYRboYZS49mkC2Cxh
        gUCJC/P+gXWwCKhKHNz0hxXE5hWwkThxYy5zFyMH0D55iYX/mUF6JQQOsEncfTiNHSLuInHs
        YCDEScISr45vYYewpSRe9rexQ9Q3M0q8nbmZEcJpAXpiUy8jRJWxRG/PBbAFzAKaEut36UOE
        FSV2/p4LVsIswCfx7msPK8QuXomONiGIEjWJlmdfWSFsGYm//55B2R4SjacusUPCLlZif/d0
        xgmMsrMQFixgZFzFKJZaUJybnlpsWGCIHEubGMEpUMt0B+OUcz6HGAU4GJV4eA1eTosTYk0s
        K67MPcQowcGsJMK7w396nBBvSmJlVWpRfnxRaU5q8SFGU2DgTWSWEk3OB6bnvJJ4Q1MjY2Nj
        CxMzczNTYyVx3qnXc+KEBNITS1KzU1MLUotg+pg4OKUaGBPzLa5v2Fl3+Y/Wmz2O4ouviVu+
        /tS6wO6c4JSQ+UvqPom1x3qeMlbufuVie+D80h+Lf9nkcR459r6yeJfJ+fiSoxxfvmutl+7c
        e+v21HcuGdFrClUm1SvuWc6ePY3/oGVwjZva87/B2UueXLV+cf3wz926uyatVfux4NvunT01
        TQu+J9hcOn9ciaU4I9FQi7moOBEAw3QLNZcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvG7/pelxBqemSFjMWb+GzaJ780xG
        i973r5gsLu+aw2Zxb81/Vou1R+6yW0x+94zRYsHxFlaLZV/fs1v8vbKexeLxem4Hbo+ds+6y
        e2xa1cnmsenTJHaPEzN+s3is+/OKyeP9vqtsHn1bVjF6bD5d7fF5k1wAZxSXTUpqTmZZapG+
        XQJXxurv/1gKesQrej8ENDBuFO5i5OSQEDCROPL5FUsXIxeHkMBuRomWi8eYIRIyEm/OPwVK
        cADZwhKHDxdD1HxllJjxeCcTSA2bgLbE+wWTWEESIgJdjBIbrs8Hc5gFJjBKHJ84nRWkW1jA
        X2L/fxuQBhYBVYmDm/6wgti8AjYSJ27MZYZYIC+x8D/zBEaeBYwMqxglUwuKc9Nziw0LDPNS
        y/WKE3OLS/PS9ZLzczcxgsNRS3MH4+Ul8YcYBTgYlXh4DV5OixNiTSwrrsw9xCjBwawkwrvD
        f3qcEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYz9My/4
        iysuv7lybtYFG8fCdQx8a1c5dq8Ut+w7U/T57mGu/6ZPfgbw+974obrP7Y54+qlb84PMDxc2
        qRx/WqLaa8sY8X5+2LOAxEdTUtQ/FT9bbv/talXM0/8Ke5r2hlfPVa/ePOfeRfvZQTGPlvU/
        UWhZdiH29IvvfFN8ru7oeFiqH6pyIWurEktxRqKhFnNRcSIAfs62qEMCAAA=
X-CMS-MailID: 20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a
References: <CGME20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix nr_isolate_* mismatch problem between cma and dirty
lazyfree page.

If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
page, then the lazyfree page is changed to a normal anon page having
SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
with the change, reclaim context correctly counts isolated files because
it uses is_file_lru to distinguish file. And the change to anon is not
happened if try_to_unmap_one is used for migration. So migration context
like compaction also correctly counts isolated files even though it uses
page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
MADV_FREE").

But the nr_isolate_* mismatch problem happens on cma alloc. There is
reclaim_clean_pages_from_list which is being used only by cma. It was
introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
contiguous allocation instead of migration") to reclaim clean file pages
without migration. The cma alloc uses both reclaim_clean_pages_from_list
and migrate_pages, and it uses page_is_file_lru to count isolated
files. If there are dirty lazyfree pages allocated from cma memory
region, the pages are counted as isolated file at the beginging but are
counted as isolated anon after finished.

Mem-Info:
Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no

Like log above, there was too much isolated file, 37664kB, which
triggers too_many_isolated in reclaim when there is no isolated file in
system wide. It could be reproducible by running two programs, doing
MADV_FREE, writing and doing cma alloc, respectively. Although isolated
anon is 0, I found that the internal value of isolated anon was the
negative value of isolated file.

Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
lazyfree page can be checked by both PageAnon(page) and
page_is_file_lru. But in this case, PageAnon is enough to skip all
anon pages.

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868fc4926..9380a18eef5e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 	LIST_HEAD(clean_pages);
 
 	list_for_each_entry_safe(page, next, page_list, lru) {
+		/* to avoid race with MADV_FREE anon page */
+		if (PageAnon(page))
+			continue;
 		if (page_is_file_lru(page) && !PageDirty(page) &&
 		    !__PageMovable(page) && !PageUnevictable(page)) {
 			ClearPageActive(page);
-- 
2.13.7

