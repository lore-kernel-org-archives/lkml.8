Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84490C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5484120888
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590419170;
	bh=4SC2F/J4NM6UzddDGe9P2eGlKLN/Z3dzLHep/jr+Cg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zmlUGc++yX0O3K1YpD2F7fqvICz+vJqKXcgpkX19LUANWhdeR3cRb8udkMfvafCb7
	 HVwQajbEawMnz/iSIs1iauFSUdG009Xcnl9ty9zu3/9cI2fqEWVzxr+Y3Xjnp1t8tT
	 BvjGrTtMycX6A9pSSAQ9yrkL/MJirSbV6Au1rB7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbgEYPGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403996AbgEYPGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:06:09 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B334C2073B;
        Mon, 25 May 2020 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590419168;
        bh=4SC2F/J4NM6UzddDGe9P2eGlKLN/Z3dzLHep/jr+Cg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlK20N5IGG1yq/mL5w9FNBnsglQEBvK/wPUtLGakC+fhSReBtCHjU0u23i3kQRBxB
         yhm0qwTkD0TvHHE7w6RgTvc/dbHJZ8EIzx5PftivOe9DWBbQr2O1GdeCzh3gyWtCiW
         3ClhhR8uygFFtIFwoRCm4hOyj4RSgmuvkokxr/rw=
Date:   Mon, 25 May 2020 08:06:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
Message-ID: <20200525150608.GA55033@google.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com>
 <20200525035655.GA135148@google.com>
 <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25, Chao Yu wrote:
> On 2020/5/25 11:56, Jaegeuk Kim wrote:
> > Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
> 
> IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
> pages like we change for node pages to avoid potential dead loop...

I believe we're doing for them. :P

> 
> Thanks,
> 
> > in an inifinite loop. Let's drop dirty pages at umount in that case.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v3:
> >  - fix wrong unlock
> > 
> > v2:
> >  - fix typos
> > 
> >  fs/f2fs/node.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index e632de10aedab..e0bb0f7e0506e 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> >  
> >  	trace_f2fs_writepage(page, NODE);
> >  
> > -	if (unlikely(f2fs_cp_error(sbi)))
> > +	if (unlikely(f2fs_cp_error(sbi))) {
> > +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> > +			ClearPageUptodate(page);
> > +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> > +			unlock_page(page);
> > +			return 0;
> > +		}
> >  		goto redirty_out;
> > +	}
> >  
> >  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >  		goto redirty_out;
> > 
