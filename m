Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AD7207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824444;
	bh=FGetf+iVgy0vcrFX5izmqoZB7XMZZxHn5IEkcjsJXMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DbEkwYlVzWfIE166vDpNH3sdy+J0z1zya7BLmHVVCS/lLttBbHwXa1Sq2Uo82BdnG
	 Ij7z7wVJyAWAeDXxvQTFixbwXzJocfqZE8t/llzONFdn21qfASWp0pcnWW4twccWsC
	 He1jMx5akKYAVSfUg6/TZq7GyV4v61SXCf5uecns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgERRyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730747AbgERRyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:54:01 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB45220826;
        Mon, 18 May 2020 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824441;
        bh=FGetf+iVgy0vcrFX5izmqoZB7XMZZxHn5IEkcjsJXMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyph8D8EtgCp2cujLjccSTM+tAFK5nAoCfNCnEw1Hu786e9LMfic2dssZoVavfoEx
         LhGiKRQxbUfg1E+TjlgUbRoRTdasRXmGPceJ9d2dxt5nn4hsvEWAGsuSt3JLOTVpuO
         aVjJOs7d0f3qaMejLDDZFFUKGak54OZHObqMUKBw=
Date:   Mon, 18 May 2020 10:54:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush dirty meta pages when flushing
 them
Message-ID: <20200518175400.GA218254@google.com>
References: <20200515021554.226835-1-jaegeuk@kernel.org>
 <9ba6e5ef-068d-a925-1eb9-107b0523666c@huawei.com>
 <20200515144509.GA46028@google.com>
 <cd964a56-b2a7-48de-97a6-5d89d9a590a3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd964a56-b2a7-48de-97a6-5d89d9a590a3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Chao Yu wrote:
> On 2020/5/15 22:45, Jaegeuk Kim wrote:
> > On 05/15, Chao Yu wrote:
> >> On 2020/5/15 10:15, Jaegeuk Kim wrote:
> >>> Let's guarantee flusing dirty meta pages to avoid infinite loop.
> >>
> >> What's the root cause? Race case or meta page flush failure?
> > 
> > Investigating, but at least, this can avoid the inifinite loop there.
> 
> Hmm... this fix may cover the root cause..

We're getting reached out to one related to this issue where single SSA
page is dirtied at the moment. Anyway, I think it'd be fine to get this
as we can detect any fs consistency issue by fsck. So far, I haven't seen
any problem in all my local stress tests.

> 
> Thanks,
> 
> > 
> > V2:
> > 
> >>From c60ce8e7178004fd6cba96e592247e43b5fd98d8 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Wed, 13 May 2020 21:12:53 -0700
> > Subject: [PATCH] f2fs: flush dirty meta pages when flushing them
> > 
> > Let's guarantee flusing dirty meta pages to avoid infinite loop.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 620a386d82c1a..3dc3ac6fe1432 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1266,6 +1266,9 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
> >  		if (unlikely(f2fs_cp_error(sbi)))
> >  			break;
> >  
> > +		if (type == F2FS_DIRTY_META)
> > +			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
> > +							FS_CP_META_IO);
> >  		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
> >  	}
> >  	finish_wait(&sbi->cp_wait, &wait);
> > 
