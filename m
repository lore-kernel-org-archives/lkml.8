Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9004C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6504207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693522;
	bh=ENwJXkJLKZRRsPK+WQo6kcGcxKkeYsu9FJkyfV7BrsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmQELStCF/8dVglkREWQooA4MY4yODdEZxIxpY90HDPuEbamS+2WTAbRlnIgD0z3v
	 Bmog5y7ipQ6yDUJv5efoUMMHYnYbDPQWuf60ogrerW/ODjrYSiptuDeCXLfW99jbtf
	 2bOjxw5tZpFHVTuzZu+rE3veCasLS/6ZSPC4S12s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406254AbgE1TSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405596AbgE1TSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:18:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E0D2075A;
        Thu, 28 May 2020 19:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590693519;
        bh=ENwJXkJLKZRRsPK+WQo6kcGcxKkeYsu9FJkyfV7BrsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxJ5emo9TW7QwGwPSsV9Dp1eJDxxvH4nmRepMbV4kjwQoATkDAQwKTqE05mMxWE2b
         U36vLeleBvo0SwmbPZfbuGe4GbUsq9AS8XxCMEXyo6gJx/WucGGSc5x/+Nhhvjozbk
         OXcjyo8rgkphmvKFpjCzbLVST1jQ5R9N5dsyWg68=
Date:   Thu, 28 May 2020 12:18:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix retry logic in
 f2fs_write_cache_pages()
Message-ID: <20200528191839.GA180586@google.com>
References: <1590546056-17871-1-git-send-email-stummala@codeaurora.org>
 <1d54379e-35c7-76e0-0c8a-d89bfcecb935@huawei.com>
 <78d2f29b-3ec0-39bc-46cf-88e82f1970c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d2f29b-3ec0-39bc-46cf-88e82f1970c9@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28, Chao Yu wrote:
> On 2020/5/28 10:45, Chao Yu wrote:
> > On 2020/5/27 10:20, Sahitya Tummala wrote:
> >> In case a compressed file is getting overwritten, the current retry
> >> logic doesn't include the current page to be retried now as it sets
> >> the new start index as 0 and new end index as writeback_index - 1.
> >> This causes the corresponding cluster to be uncompressed and written
> >> as normal pages without compression. Fix this by allowing writeback to
> >> be retried for the current page as well (in case of compressed page
> >> getting retried due to index mismatch with cluster index). So that
> >> this cluster can be written compressed in case of overwrite.
> >>
> >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >> ---
> >>  fs/f2fs/data.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index 4af5fcd..bfd1df4 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -3024,7 +3024,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> >>  	if ((!cycled && !done) || retry) {
> > 
> > IMO, we add retry logic in wrong place, you can see that cycled value is
> > zero only if wbc->range_cyclic is true, in that case writeback_index is valid.
> > 
> > However if retry is true and wbc->range_cyclic is false, then writeback_index
> > would be uninitialized variable.
> > 
> > Thoughts?
> > 
> > Thanks,
> > 
> >>  		cycled = 1;
> >>  		index = 0;
> >> -		end = writeback_index - 1;
> 
> BTW, I notice that range_cyclic writeback flow was refactored in below commit,
> and skeleton of f2fs.writepages was copied from mm/page-writeback.c::write_cache_pages(),
> I guess we need follow that change.
> 
> 64081362e8ff ("mm/page-writeback.c: fix range_cyclic writeback vs writepages deadlock")

Is that something like this?

---
 fs/f2fs/data.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 48a622b95b76e..28fcdf0d4dcb9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2861,7 +2861,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
-	int cycled;
 	int range_whole = 0;
 	xa_mark_t tag;
 	int nwritten = 0;
@@ -2879,17 +2878,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
 		index = writeback_index;
-		if (index == 0)
-			cycled = 1;
-		else
-			cycled = 0;
 		end = -1;
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			range_whole = 1;
-		cycled = 1; /* ignore range_cyclic tests */
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
@@ -3054,10 +3048,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		}
 	}
 #endif
-	if ((!cycled && !done) || retry) {
-		cycled = 1;
+	if (retry) {
 		index = 0;
-		end = writeback_index - 1;
+		end = -1;
 		goto retry;
 	}
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-- 
2.27.0.rc0.183.gde8f92d652-goog

