Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A74320809
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620085;
	bh=vvX5vaeR82uMFf05stT8fYK8rwwdtEyVA9ggdjIUTSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iLSBm9b/QQC+ewoqnMj+QGU4OQAEKFw/yJt4c8RuEVtOGWd9FW6fIj1hjpNdMsU+u
	 e9pWtHgDDH/eBYg1mz8QDCoPwlV0eI2WRM7FIAO/g9u8fMxJFhZ9QIzjYXXsVcsTfJ
	 5nMhpe5S4QbgxkIE3amAzPbQ3KLH4hboAopXN/Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgGAQOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731948AbgGAQOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:14:43 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D077B207FB;
        Wed,  1 Jul 2020 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620082;
        bh=vvX5vaeR82uMFf05stT8fYK8rwwdtEyVA9ggdjIUTSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RannkZZxUNr/2BO7IaAn8Qr+8Phk2tvtIMdK4syCoQuo0bI6dP7tnUrGkL3XamGdi
         3CLO4HRmAPF8jjYENRZ4Vz8v3lrJ0JXUml2WVg2Ra6cfhn1K25YMWtT/4UPO1kbs+w
         P02+rvCCDKBa5pPZIMuBH8qcvS/oQzQ4escNjoac=
Date:   Wed, 1 Jul 2020 09:14:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid readahead race condition
Message-ID: <20200701161442.GB1724572@google.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
 <20200629202720.GA230664@google.com>
 <20200630204348.GA2504307@ubuntu-s3-xlarge-x86>
 <20200630205635.GB1396584@google.com>
 <285a4e16-2cbc-d1e9-8464-8a06bacbaaa0@huawei.com>
 <d496f4b9-e4fa-1366-61a9-38ee59c20e15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d496f4b9-e4fa-1366-61a9-38ee59c20e15@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01, Chao Yu wrote:
> On 2020/7/1 9:59, Chao Yu wrote:
> > On 2020/7/1 4:56, Jaegeuk Kim wrote:
> >> On 06/30, Nathan Chancellor wrote:
> >>> On Mon, Jun 29, 2020 at 01:27:20PM -0700, Jaegeuk Kim wrote:
> >>>> If two readahead threads having same offset enter in readpages, every read
> >>>> IOs are split and issued to the disk which giving lower bandwidth.
> >>>>
> >>>> This patch tries to avoid redundant readahead calls.
> >>>>
> >>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>> ---
> >>>> v3:
> >>>>  - use READ|WRITE_ONCE
> >>>> v2:
> >>>>   - add missing code to bypass read
> >>>>  
> >>>>  fs/f2fs/data.c  | 18 ++++++++++++++++++
> >>>>  fs/f2fs/f2fs.h  |  1 +
> >>>>  fs/f2fs/super.c |  2 ++
> >>>>  3 files changed, 21 insertions(+)
> >>>>
> >>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>> index 995cf78b23c5e..360b4c9080d97 100644
> >>>> --- a/fs/f2fs/data.c
> >>>> +++ b/fs/f2fs/data.c
> >>>> @@ -2296,6 +2296,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
> >>>>  	unsigned nr_pages = rac ? readahead_count(rac) : 1;
> >>>>  	unsigned max_nr_pages = nr_pages;
> >>>>  	int ret = 0;
> >>>> +	bool drop_ra = false;
> >>>>  
> >>>>  	map.m_pblk = 0;
> >>>>  	map.m_lblk = 0;
> >>>> @@ -2306,10 +2307,24 @@ static int f2fs_mpage_readpages(struct inode *inode,
> >>>>  	map.m_seg_type = NO_CHECK_TYPE;
> >>>>  	map.m_may_create = false;
> >>>>  
> >>>> +	/*
> >>>> +	 * Two readahead threads for same address range can cause race condition
> >>>> +	 * which fragments sequential read IOs. So let's avoid each other.
> >>>> +	 */
> >>>> +	if (rac && readahead_count(rac)) {
> >>>> +		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
> >>>> +			drop_ra = true;
> >>>> +		else
> >>>> +			WRITE_ONCE(F2FS_I(inode)->ra_offset,
> >>>> +						readahead_index(rac));
> >>>> +	}
> >>>> +
> >>>>  	for (; nr_pages; nr_pages--) {
> >>>>  		if (rac) {
> >>>>  			page = readahead_page(rac);
> >>>>  			prefetchw(&page->flags);
> >>>> +			if (drop_ra)
> >>>> +				goto next_page;
> >>>
> >>> When CONFIG_F2FS_FS_COMPRESSION is not set (i.e. x86_64 defconfig +
> >>> CONFIG_F2FS_FS=y):
> >>>
> >>> $ make -skj"$(nproc)" O=out distclean defconfig fs/f2fs/data.o
> >>> ../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
> >>> ../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
> >>>  2327 |     goto next_page;
> >>>       |     ^~~~
> >>> ...
> >>
> >> Thanks. I pushed the fix for -next.
> >> https://lore.kernel.org/linux-f2fs-devel/1be18397-7fc6-703e-121b-e210e101357f@infradead.org/T/#t
> 
> It will hang the kernel because we missed to unlock those cached pages,
> I changed to 'goto set_error_page', the issue was gone.

How about v4?

> 
> Thanks,
> 
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Cheers,
> >>> Nathan
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
