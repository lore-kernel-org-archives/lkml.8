Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C463C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC10C2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JGWMcr6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgFOJse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:48:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31185 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgFOJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:48:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592214512; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=DAfTLEEf3LnWmAUk6MRmvkiG3ETej98GVuLEc2MGvis=; b=JGWMcr6iG4cbNfU87M4gNEdDTxSPUNyJsiHVNbc5x16Kk52KJSpUoFD3YBlSDS0AQzfRxo0i
 E/TFt5h3497lWeo1XV4Dd2mOqNfQabQm59pVKEqIJEt5HU/ZUOlDqK7B86bhnA9od5dCV9by
 X6frFV6+1QbTf6+01A+kDeRT098=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ee743ea86de6ccd443539a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 09:48:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66B8AC43395; Mon, 15 Jun 2020 09:48:25 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C71EC433CA;
        Mon, 15 Jun 2020 09:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C71EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 15 Jun 2020 15:18:17 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Satya Tangirala <satyat@google.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: fix use-after-free when accessing
 bio->bi_crypt_context
Message-ID: <20200615094817.GA2916@codeaurora.org>
References: <1592193588-21701-1-git-send-email-stummala@codeaurora.org>
 <20200615050019.GA3100@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615050019.GA3100@sol.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sun, Jun 14, 2020 at 10:00:19PM -0700, Eric Biggers wrote:
> On Mon, Jun 15, 2020 at 09:29:48AM +0530, Sahitya Tummala wrote:
> > There could be a potential race between these two paths below,
> > leading to use-after-free when accessing bio->bi_crypt_context.
> > 
> > f2fs_write_cache_pages
> > ->f2fs_do_write_data_page on page#1
> >   ->f2fs_inplace_write_data
> >     ->f2fs_merge_page_bio
> >       ->add_bio_entry
> > ->f2fs_do_write_data_page on page#2
> >   ->f2fs_inplace_write_data
> >     ->f2fs_merge_page_bio
> >       ->f2fs_crypt_mergeable_bio
> >         ->fscrypt_mergeable_bio
> >   				       f2fs_write_begin on page#1
> > 				       ->f2fs_wait_on_page_writeback
> > 				         ->f2fs_submit_merged_ipu_write
> > 					   ->__submit_bio
> > 					The bio gets completed, calling
> > 					bio_endio
> > 					->bio_uninit
> > 					  ->bio_crypt_free_ctx
> > 	  ->use-after-free issue
> > 
> > Fix this by moving f2fs_crypt_mergeable_bio() check within
> > add_ipu_page() so that it's done under bio_list_lock to prevent
> > the above race.
> > 
> > Fixes: 15e76ad23e72 ("f2fs: add inline encryption support")
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> > This fix is rebased to the tip of fscrypt git -
> > https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
> > branch - inline-encryption
> > 
> >  fs/f2fs/data.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 0dfa8d3..3b53554 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -762,9 +762,10 @@ static void del_bio_entry(struct bio_entry *be)
> >  	kmem_cache_free(bio_entry_slab, be);
> >  }
> >  
> > -static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
> > -							struct page *page)
> > +static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
> > +				struct page *page, int *bio_needs_submit)
> >  {
> > +	struct f2fs_sb_info *sbi = fio->sbi;
> >  	enum temp_type temp;
> >  	bool found = false;
> >  	int ret = -EAGAIN;
> > @@ -780,6 +781,15 @@ static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
> >  				continue;
> >  
> >  			found = true;
> > +			if (*bio && (!page_is_mergeable(sbi, *bio,
> > +					*fio->last_block, fio->new_blkaddr) ||
> > +				    !f2fs_crypt_mergeable_bio(*bio,
> > +					  fio->page->mapping->host,
> > +					  fio->page->index, fio))) {
> > +				ret = 0;
> > +				*bio_needs_submit = 1;
> > +				break;
> > +			}
> >  
> >  			if (bio_add_page(*bio, page, PAGE_SIZE, 0) ==
> >  							PAGE_SIZE) {
> > @@ -864,6 +874,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >  	struct bio *bio = *fio->bio;
> >  	struct page *page = fio->encrypted_page ?
> >  			fio->encrypted_page : fio->page;
> > +	int bio_needs_submit = 0;
> >  
> >  	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> >  			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
> > @@ -872,11 +883,6 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >  	trace_f2fs_submit_page_bio(page, fio);
> >  	f2fs_trace_ios(fio, 0);
> >  
> > -	if (bio && (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> > -				       fio->new_blkaddr) ||
> > -		    !f2fs_crypt_mergeable_bio(bio, fio->page->mapping->host,
> > -					      fio->page->index, fio)))
> > -		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
> >  alloc_new:
> >  	if (!bio) {
> >  		bio = __bio_alloc(fio, BIO_MAX_PAGES);
> > @@ -886,8 +892,12 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >  
> >  		add_bio_entry(fio->sbi, bio, page, fio->temp);
> >  	} else {
> > -		if (add_ipu_page(fio->sbi, &bio, page))
> > +		if (add_ipu_page(fio, &bio, page, &bio_needs_submit))
> > +			goto alloc_new;
> > +		if (bio_needs_submit) {
> > +			f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
> >  			goto alloc_new;
> > +		}
> >  	}
> >  
> >  	if (fio->io_wbc)
> 
> Thanks, I'm still trying to understand this part of the code, but it's looking
> like this is a real bug.  Do you also have a reproducer that produces a KASAN
> report, or did you find this another way?
> 

This was once reported as a stability issue internally on our downstream kernel
having the new FBE patches. I have then reviewed the code and found the issue path.
There is no consistent way to reproduce this problem.

> One comment: add_ipu_page() already submits the bio if it's full.  Wouldn't it
> be better to use that instead of f2fs_submit_merged_ipu_write()?  I.e.:
> 

Your suggestion looks good to me. I will post a v2.

Thanks,

> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e9dcda80e599..d7a51dbe208b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -762,9 +762,10 @@ static void del_bio_entry(struct bio_entry *be)
>  	kmem_cache_free(bio_entry_slab, be);
>  }
>  
> -static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
> +static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
>  							struct page *page)
>  {
> +	struct f2fs_sb_info *sbi = fio->sbi;
>  	enum temp_type temp;
>  	bool found = false;
>  	int ret = -EAGAIN;
> @@ -780,14 +781,18 @@ static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
>  				continue;
>  
>  			found = true;
> -
> -			if (bio_add_page(*bio, page, PAGE_SIZE, 0) ==
> -							PAGE_SIZE) {
> +			if (page_is_mergeable(sbi, *bio, *fio->last_block,
> +					      fio->new_blkaddr) &&
> +			    f2fs_crypt_mergeable_bio(*bio,
> +						      fio->page->mapping->host,
> +						      fio->page->index, fio) &&
> +			    bio_add_page(*bio, page,
> +					 PAGE_SIZE, 0) == PAGE_SIZE) {
>  				ret = 0;
>  				break;
>  			}
>  
> -			/* bio is full */
> +			/* page can't be merged into bio; submit the bio */
>  			del_bio_entry(be);
>  			__submit_bio(sbi, *bio, DATA);
>  			break;
> @@ -872,11 +877,6 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  	trace_f2fs_submit_page_bio(page, fio);
>  	f2fs_trace_ios(fio, 0);
>  
> -	if (bio && (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -				       fio->new_blkaddr) ||
> -		    !f2fs_crypt_mergeable_bio(bio, fio->page->mapping->host,
> -					      fio->page->index, fio)))
> -		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
>  alloc_new:
>  	if (!bio) {
>  		bio = __bio_alloc(fio, BIO_MAX_PAGES);
> @@ -886,7 +886,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  
>  		add_bio_entry(fio->sbi, bio, page, fio->temp);
>  	} else {
> -		if (add_ipu_page(fio->sbi, &bio, page))
> +		if (add_ipu_page(fio, &bio, page))
>  			goto alloc_new;
>  	}
>  

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
