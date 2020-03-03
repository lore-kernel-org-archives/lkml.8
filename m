Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832A24686
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583195223;
	bh=LmgsaIdNSuh1GFcbg1TfNtt83OynHxc8RLKCyyPeZOc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YTkkWk7NbEkBznGd/Hj7cVX1ETyg4YAOH/qMGUy5MdtvWPcwwRX66q0YnE2nvH8/D
	 +FqF94YvH/JRYpA8i5C0eameWbui/N9lSlyS4oQSCkW4i171d761E7O5ewMvciWU/h
	 XEXPytqc2EcnBS3lodhS915owphF77EhwCb0L4UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCCA1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:27:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43421 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCA1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:27:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so522714pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5Htb+vUh56qOP6Vzd600P/JN9cTq1qV0kCCiKMtZAw=;
        b=X+hMW2YZrc5aBlegIh/3GJcg+WZv1aSukyhUlcHo8SY1JSMz/xzfd8J6UYvrD7ZqNL
         feG/jJH7mW9KZCz7yX+sN9ohUCyJYKoEkIh00jk0T6iFT0lU/8rMSnlzcOeR0njB4Q3B
         hElZJ56miJLCVyrwVHu+eOXJ6tJPAUvbtGuTsyUycsST6WjlJHT0ugInKSrOIcJsl5vK
         qgfy/BpFaJSCeJpj3OobAZOuY6mxuLeCM9JHlrY/t7mrm4Lc9W0q9yyJsdKYfUnnDefr
         G87efnqRRVa3yk8MWsDiac9yDB1yawk76wHyx7QlBPj1FZk8rvdaVQw3j8EDoWE4F+0b
         J4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=g5Htb+vUh56qOP6Vzd600P/JN9cTq1qV0kCCiKMtZAw=;
        b=ZJ/uI60vmtmg+hjsiqRgsPzqLGSEfm2PpNkRpwBDjGTM3ItJDE2TKqUETkC65eDhcF
         TxnbudMfaQd0RGDlNFlnUK+8dTGHvo1zjreu2pXwnJAmPGsW7Huta3mqQgMF5HRR/8We
         PaA2xQq16DPdBCovU4xDsHSPyJjaLNGumpFsaSD3yNuqoZJ+4bYtikGaWjK4R11+Xytr
         2XVTexJvncjk/dgIynjEjtuf7Om1io7gdD/ME1Ndu3uGkN2LD3HQtRuyHZpBB7guFbyz
         17VpPEuT72M0Bwo/lB7cdR/ePo6zDoprdhPxkfjpoI67H+EWrop8Vjz5hxrbRGixKVB/
         MfAg==
X-Gm-Message-State: ANhLgQ3xVWW3+hUxBBvd9V4QDCbzP3cLfxtBZCg5vgE+PWYhYftkbxix
        UfOnM4CYb7yVJ8S9hDiO4lI=
X-Google-Smtp-Source: ADFU+vvQVAs9yxW36AF8DBR2anF9ES7U7tLkO8900GlD5Lolz8tsul0heWb402DGS9r41xaVuz6NvA==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr1375010pgh.27.1583195220576;
        Mon, 02 Mar 2020 16:27:00 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id x11sm21990313pfn.53.2020.03.02.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 16:26:59 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: fix long time stall from mm_populate
Date:   Mon,  2 Mar 2020 16:26:38 -0800
Message-Id: <20200303002638.206421-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, fault handler releases mmap_sem before requesting readahead
and then it is supposed to retry lookup the page from page cache with
FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.

However, what happens if the fault handler find a page from page
cache and the page has readahead marker but are waiting under
writeback? Plus one more condition, it happens under mm_populate
which repeats faulting unless it encounters error. So let's assemble
conditions below.

       CPU 1                                                        CPU 2

- first loop
    mm_populate
     for ()
       ..
       ret = populate_vma_page_range
         __get_user_pages
           faultin_page
             handle_mm_fault
               filemap_fault
                 do_async_mmap_readahead
                   if (PageReadahead(pageA))
                     maybe_unlock_mmap_for_io
                       up_read(mmap_sem)
					                    shrink_page_list
                                                              pageout
                                                                SetPageReclaim(=SetPageReadahead)(pageA)
                                                                writepage
                                                                  SetPageWriteback(pageA)

                     page_cache_async_readahead()
		       ClearPageReadahead(pageA)
                 do_async_mmap_readahead
		 lock_page_maybe_drop_mmap
		   goto out_retry

					                    the pageA is reclaimed
							    and new pageB is populated to the file offset
							    and finally has become PG_readahead

- second loop

	  __get_user_pages
           faultin_page
             handle_mm_fault
               filemap_fault
                 do_async_mmap_readahead
                   if (PageReadahead(pageB))
                     maybe_unlock_mmap_for_io
                       up_read(mmap_sem)
					                    shrink_page_list
                                                              pageout
                                                                SetPageReclaim(=SetPageReadahead)(pageB)
                                                                writepage
                                                                  SetPageWriteback(pageB)

                     page_cache_async_readahead()
		       ClearPageReadahead(pageB)
                 do_async_mmap_readahead
		 lock_page_maybe_drop_mmap
		   goto out_retry

It could be repeated forever so it's livelock. Without involving reclaim,
it could happens if ra_pages become zero by fadvise/other threads who
have same fd one doing randome while the other one is sequential
because page_cache_async_readahead has following condition check like
PageWriteback and ra_pages are never synchrnized with fadvise and
shrink_readahead_size_eio from other threads.

page_cache_async_readahead(struct address_space *mapping,
                           unsigned long req_size)
{
        /* no read-ahead */
        if (!ra->ra_pages)
                return;

Thus, we need to limit fault retry from mm_populate like page
fault handler.

Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/gup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..6f6548c63ad5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1133,7 +1133,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
  *
  * This takes care of mlocking the pages too if VM_LOCKED is set.
  *
- * return 0 on success, negative error code on error.
+ * return number of pages pinned on success, negative error code on error.
  *
  * vma->vm_mm->mmap_sem must be held.
  *
@@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	long ret = 0;
+	bool tried = false;
 
 	end = start + len;
 
@@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
-		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		ret = populate_vma_page_range(vma, nstart, nend,
+						tried ? NULL : &locked);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
 				continue;	/* continue at next VMA */
 			}
 			break;
-		}
+		} else if (ret == 0)
+			tried = true;
+		else
+			tried = false;
 		nend = nstart + ret * PAGE_SIZE;
 		ret = 0;
 	}
-- 
2.25.0.265.gbab2e86ba0-goog

