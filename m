Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28924C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCAB2071C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590458213;
	bh=hzScoNd2/3SO1/KnojehnqOZFasSdnAL7Ekyg64eR4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BLcm6OwlR2JPJ0BaIZQW1J1Rp6yDFmIeVHTCDdejBPs72c9XiEECcfYkWdeLWLuAq
	 MYs13HCCpQQ8jpYmIK7k1Z5WQgI4XN3TH/L8ZnOe0LuxYUgI1btDpMVJBnsMfJx6ge
	 LKsQBOFJgWWCChrruvCrkbJIaS2Z3Yjmo1BKGy1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbgEZB4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388351AbgEZB4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:56:51 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5982068D;
        Tue, 26 May 2020 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590458211;
        bh=hzScoNd2/3SO1/KnojehnqOZFasSdnAL7Ekyg64eR4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/ggbCG7ghxJZftLEKw0f8J/bL9mpd6zjQaJPGP6nnfvu6ZurUREu8LdAz4yVwdHG
         lm4OdfZufA70y1+3MdaDEiMfo9l3A3l/KT+7alB+iNxLXEX7UOwAXG5NJgInPqQSdY
         LFxKRcXOjtY4cFslb/U45TYcm/u602P8GXxEABL4=
Date:   Mon, 25 May 2020 18:56:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
Message-ID: <20200526015650.GA207949@google.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com>
 <20200525035655.GA135148@google.com>
 <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
 <20200525150608.GA55033@google.com>
 <92afae8b-2dd3-171a-562c-404a67f9aab2@huawei.com>
 <a44f9c2e-3859-6c5d-6f06-7c4c6b4c01c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44f9c2e-3859-6c5d-6f06-7c4c6b4c01c5@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26, Chao Yu wrote:
> On 2020/5/26 9:11, Chao Yu wrote:
> > On 2020/5/25 23:06, Jaegeuk Kim wrote:
> >> On 05/25, Chao Yu wrote:
> >>> On 2020/5/25 11:56, Jaegeuk Kim wrote:
> >>>> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
> >>>
> >>> IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
> >>> pages like we change for node pages to avoid potential dead loop...
> >>
> >> I believe we're doing for them. :P
> > 
> > Actually, I mean do we need to drop dirty meta/data pages explicitly as below:
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 3dc3ac6fe143..4c08fd0a680a 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -299,8 +299,15 @@ static int __f2fs_write_meta_page(struct page *page,
> > 
> >  	trace_f2fs_writepage(page, META);
> > 
> > -	if (unlikely(f2fs_cp_error(sbi)))
> > +	if (unlikely(f2fs_cp_error(sbi))) {
> > +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> > +			ClearPageUptodate(page);
> > +			dec_page_count(sbi, F2FS_DIRTY_META);
> > +			unlock_page(page);
> > +			return 0;
> > +		}
> >  		goto redirty_out;
> > +	}
> >  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >  		goto redirty_out;
> >  	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 48a622b95b76..94b342802513 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2682,6 +2682,12 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> > 
> >  	/* we should bypass data pages to proceed the kworkder jobs */
> >  	if (unlikely(f2fs_cp_error(sbi))) {
> > +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> > +			ClearPageUptodate(page);
> > +			inode_dec_dirty_pages(inode);
> > +			unlock_page(page);
> > +			return 0;
> > +		}
> 
> Oh, I notice previously, we will drop non-directory inode's dirty pages directly,
> however, during umount, we'd better drop directory inode's dirty pages as well, right?

Hmm, I remember I dropped them before. Need to double check.

> 
> >  		mapping_set_error(page->mapping, -EIO);
> >  		/*
> >  		 * don't drop any dirty dentry pages for keeping lastest
> > 
> >>
> >>>
> >>> Thanks,
> >>>
> >>>> in an inifinite loop. Let's drop dirty pages at umount in that case.
> >>>>
> >>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>> ---
> >>>> v3:
> >>>>  - fix wrong unlock
> >>>>
> >>>> v2:
> >>>>  - fix typos
> >>>>
> >>>>  fs/f2fs/node.c | 9 ++++++++-
> >>>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >>>> index e632de10aedab..e0bb0f7e0506e 100644
> >>>> --- a/fs/f2fs/node.c
> >>>> +++ b/fs/f2fs/node.c
> >>>> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> >>>>  
> >>>>  	trace_f2fs_writepage(page, NODE);
> >>>>  
> >>>> -	if (unlikely(f2fs_cp_error(sbi)))
> >>>> +	if (unlikely(f2fs_cp_error(sbi))) {
> >>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> >>>> +			ClearPageUptodate(page);
> >>>> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> >>>> +			unlock_page(page);
> >>>> +			return 0;
> >>>> +		}
> >>>>  		goto redirty_out;
> >>>> +	}
> >>>>  
> >>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>>  		goto redirty_out;
> >>>>
> >> .
> >>
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> > 
