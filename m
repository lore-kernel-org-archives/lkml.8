Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F7EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EA1206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rqDBhjOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAJQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:16:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62461 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgFAJQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:16:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591002984; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Z1DEgGAFeyjkj2r68HTxRbGMmwFPf9VSMnCHwAuxjok=; b=rqDBhjOawrL722Wt3kEa59ZQNNMMeA/13SPsCN8GQo9n2hUl6b7jNFeeeDwcsy418s0Y3wv4
 PwRwMP+r+uH2eSHmnR4tQVGefW5A/KN8eHVpDcQdoE5lkUiPczrduhjPP3P4aPq23ykLwVNP
 EJt/O+nCg0e/jUXPv+CEiTehyZc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ed4c7645086732481222e38 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Jun 2020 09:16:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCA3BC43387; Mon,  1 Jun 2020 09:16:19 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57644C433CA;
        Mon,  1 Jun 2020 09:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57644C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 1 Jun 2020 14:45:50 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix retry logic in
 f2fs_write_cache_pages()
Message-ID: <20200601091549.GG20234@codeaurora.org>
References: <1590546056-17871-1-git-send-email-stummala@codeaurora.org>
 <1d54379e-35c7-76e0-0c8a-d89bfcecb935@huawei.com>
 <78d2f29b-3ec0-39bc-46cf-88e82f1970c9@huawei.com>
 <20200528191839.GA180586@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528191839.GA180586@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Can you please help review below diff given by Jaegeuk?
If it looks good, I can send a v2.

Thanks,

On Thu, May 28, 2020 at 12:18:39PM -0700, Jaegeuk Kim wrote:
> On 05/28, Chao Yu wrote:
> > On 2020/5/28 10:45, Chao Yu wrote:
> > > On 2020/5/27 10:20, Sahitya Tummala wrote:
> > >> In case a compressed file is getting overwritten, the current retry
> > >> logic doesn't include the current page to be retried now as it sets
> > >> the new start index as 0 and new end index as writeback_index - 1.
> > >> This causes the corresponding cluster to be uncompressed and written
> > >> as normal pages without compression. Fix this by allowing writeback to
> > >> be retried for the current page as well (in case of compressed page
> > >> getting retried due to index mismatch with cluster index). So that
> > >> this cluster can be written compressed in case of overwrite.
> > >>
> > >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > >> ---
> > >>  fs/f2fs/data.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > >> index 4af5fcd..bfd1df4 100644
> > >> --- a/fs/f2fs/data.c
> > >> +++ b/fs/f2fs/data.c
> > >> @@ -3024,7 +3024,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> > >>  	if ((!cycled && !done) || retry) {
> > > 
> > > IMO, we add retry logic in wrong place, you can see that cycled value is
> > > zero only if wbc->range_cyclic is true, in that case writeback_index is valid.
> > > 
> > > However if retry is true and wbc->range_cyclic is false, then writeback_index
> > > would be uninitialized variable.
> > > 
> > > Thoughts?
> > > 
> > > Thanks,
> > > 
> > >>  		cycled = 1;
> > >>  		index = 0;
> > >> -		end = writeback_index - 1;
> > 
> > BTW, I notice that range_cyclic writeback flow was refactored in below commit,
> > and skeleton of f2fs.writepages was copied from mm/page-writeback.c::write_cache_pages(),
> > I guess we need follow that change.
> > 
> > 64081362e8ff ("mm/page-writeback.c: fix range_cyclic writeback vs writepages deadlock")
> 
> Is that something like this?
> 
> ---
>  fs/f2fs/data.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 48a622b95b76e..28fcdf0d4dcb9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2861,7 +2861,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
>  	pgoff_t done_index;
> -	int cycled;
>  	int range_whole = 0;
>  	xa_mark_t tag;
>  	int nwritten = 0;
> @@ -2879,17 +2878,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	if (wbc->range_cyclic) {
>  		writeback_index = mapping->writeback_index; /* prev offset */
>  		index = writeback_index;
> -		if (index == 0)
> -			cycled = 1;
> -		else
> -			cycled = 0;
>  		end = -1;
>  	} else {
>  		index = wbc->range_start >> PAGE_SHIFT;
>  		end = wbc->range_end >> PAGE_SHIFT;
>  		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>  			range_whole = 1;
> -		cycled = 1; /* ignore range_cyclic tests */
>  	}
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
>  		tag = PAGECACHE_TAG_TOWRITE;
> @@ -3054,10 +3048,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  		}
>  	}
>  #endif
> -	if ((!cycled && !done) || retry) {
> -		cycled = 1;
> +	if (retry) {
>  		index = 0;
> -		end = writeback_index - 1;
> +		end = -1;
>  		goto retry;
>  	}
>  	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
