Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C995C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9727207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594321547;
	bh=bxaXBOmDH6ga++Cg4fHewftn6tf7p8Mbj208rLVhETE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vymX5QlSEmvOti92Oaz3zC3WZGRFu2bA0mhYCb1VFV0pCHgPnjf4QCvcVn79gOhTv
	 sjbAoSqwxpbdRAYWy8f6IWRzIF8gdYAdGDLAALsGVojRKzq1IQ0aP/HbET/20SFeRy
	 V4kKWqvV1TmVREKBJC4ZjrxMMwmhR7R/ejzbTzM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGITFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGITFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:05:46 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF65E2078B;
        Thu,  9 Jul 2020 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594321546;
        bh=bxaXBOmDH6ga++Cg4fHewftn6tf7p8Mbj208rLVhETE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vACCLOd6Ey1c+lPIOv9tvzjCp2nWY9H/mINVAWRatkjnWj0nmiCo5WqtDGMeEpFvY
         DVyyN0wL9QOhFY4UTcLVyJugUw/wo9880M2any/esVzJZN4I0YWr8YX3PNEZciuE97
         boYR+uUwOqvp/j43ODA41NfO2GbQ4I+ke4keXuK8=
Date:   Thu, 9 Jul 2020 12:05:45 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip writeback of quota data
Message-ID: <20200709190545.GA3001066@google.com>
References: <20200709053027.351974-1-jaegeuk@kernel.org>
 <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09, Chao Yu wrote:
> On 2020/7/9 13:30, Jaegeuk Kim wrote:
> > It doesn't need to bypass flushing quota data in background.
> 
> The condition is used to flush quota data in batch to avoid random
> small-sized udpate, did you hit any problem here?

I suspect this causes fault injection test being stuck by waiting for inode
writeback completion. With this patch, it has been running w/o any issue so far.
I keep an eye on this.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 44645f4f914b6..72e8b50e588c1 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> >  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >  		goto skip_write;
> >  
> > -	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
> > +	if (S_ISDIR(inode->i_mode) &&
> >  			wbc->sync_mode == WB_SYNC_NONE &&
> >  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
> >  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
> > 
