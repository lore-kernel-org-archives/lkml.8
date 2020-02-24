Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24ACC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AF82176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582581634;
	bh=EZ+Ei0mMz9aXg3foEaWmEi27b7awpExGYB0AFFAuoqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VzpttNIygRYRQp0EVjAK1wSzEIIeQp/UF9/VB1wkKm2mk/liXOnY4kC7lZjXOvA14
	 H3PqtsZOC5uph60wWxg+cPd6SUjGkGqoReRv8olQaTQNqvjk4g9XiI5MoWCg3ciNaw
	 XNHr1JiKxwP1Txj3l/MB9FwhgKkupWnugIf3ZznY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBXWAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBXWAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:00:32 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD0120CC7;
        Mon, 24 Feb 2020 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582581632;
        bh=EZ+Ei0mMz9aXg3foEaWmEi27b7awpExGYB0AFFAuoqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0MIX48mZqh7MT751Vhna3OD982qJJ5UTkzxOZbW23WmZhEVMyMaAgEy6GR85ShQY
         MHxPab2CLyyQ6oJO+pLL5YlNbtDt7e3pw1yr8mRUi30r1jQqo/NRNHPI+4NTbb5z5x
         n82nVdimza2L8+HJKyGBjmGN4g2OgB6DaVVPCJkM=
Date:   Mon, 24 Feb 2020 14:00:31 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: avoid unneeded barrier in do_checkpoint()
Message-ID: <20200224220031.GC77839@google.com>
References: <20200218102136.32150-1-yuchao0@huawei.com>
 <20200218102136.32150-3-yuchao0@huawei.com>
 <20200219025154.GB96609@google.com>
 <576f8389-ba27-b461-5466-cc62e84b5c92@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576f8389-ba27-b461-5466-cc62e84b5c92@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19, Chao Yu wrote:
> On 2020/2/19 10:51, Jaegeuk Kim wrote:
> > On 02/18, Chao Yu wrote:
> >> We don't need to wait all dirty page submitting IO twice,
> >> remove unneeded wait step.
> > 
> > What happens if checkpoint and other meta writs are reordered?
> 
> checkpoint can be done as following:
> 
> 1. All meta except last cp-park of checkpoint area.
> 2. last cp-park of checkpoint area
> 
> So we only need to keep barrier in between step 1 and 2, we don't need
> to care about the write order of meta in step 1, right?

Ah, let me integrate this patch into Sahitya's patch.

f2fs: fix the panic in do_checkpoint()

> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/checkpoint.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index 751815cb4c2b..9c88fb3d255a 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -1384,8 +1384,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>  
> >>  	/* Flush all the NAT/SIT pages */
> >>  	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> >> -	/* Wait for all dirty meta pages to be submitted for IO */
> >> -	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
> >>  
> >>  	/*
> >>  	 * modify checkpoint
> >> -- 
> >> 2.18.0.rc1
> > .
> > 
