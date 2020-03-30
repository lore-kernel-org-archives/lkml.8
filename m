Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E6CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B36220714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585593288;
	bh=D6kjymPrenC+cUpVAxVDQtqw5/rOWTUihU++6B1ZeFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uOwtZcmxHrl4ziY3T9GqeMlmDI/m+idkze9rC4Nq7k3AbrZvfIsW/71ZSFnQsiI0F
	 bQ98n0iC2SicxHpTrki5komBez55OWgtxWR/oz3GKsAwhIuoaenFaj3lRN7fAnrRS/
	 +aL+ye2tjkXuJqH3EemvV7DcU+GxVOSA2mRXrxGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgC3Sec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3Sec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:34:32 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DF420714;
        Mon, 30 Mar 2020 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585593271;
        bh=D6kjymPrenC+cUpVAxVDQtqw5/rOWTUihU++6B1ZeFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIBk3nfFe2y8VbA1NQzUnWZT11JhlPqtqfg8BaGqW6IT9KIdkO8f9/r0up3hi+fjq
         fJMZ0Nb+EJm3mH9EVcyt++iiG0gx1nDhZlRDJ0VeRiN/k/HmqilWbJA1OzL1O3Z2nN
         uyYdB86aqeyMwZVfFmymtIxZS0ZAKEBRD9sP/rAI=
Date:   Mon, 30 Mar 2020 11:34:31 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
Message-ID: <20200330183431.GA34947@google.com>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200327192412.GA186975@google.com>
 <397da8a6-fdb4-9637-c6ea-803492c408a2@huawei.com>
 <20200330084033.GU20234@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330084033.GU20234@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30, Sahitya Tummala wrote:
> On Sat, Mar 28, 2020 at 04:38:00PM +0800, Chao Yu wrote:
> > Hi all,
> > 
> > On 2020/3/28 3:24, Jaegeuk Kim wrote:
> > > Hi Sahitya,
> > > 
> > > On 03/26, Sahitya Tummala wrote:
> > >> allocate_segment_for_resize() can cause metapage updates if
> > >> it requires to change the current node/data segments for resizing.
> > >> Stop these meta updates when there is a checkpoint already
> > >> in progress to prevent inconsistent CP data.
> > > 
> > > Doesn't freeze|thaw_bdev(sbi->sb->s_bdev); work for you?
> > 
> > That can avoid foreground ops racing? rather than background ops like
> > balance_fs() from kworker?
> > 
> 
> Yes, that can only prevent foreground ops but not the background ops
> invoked in the context of kworker thread.
> 
> > BTW, I found that {freeze,thaw}_bdev is not enough to freeze all
> > foreground fs ops, it needs to use {freeze,thaw}_super instead.
> > 
> 
> Yes, I agree.

sgtm. :)

> 
> Thanks,
> 
> > ---
> >  fs/f2fs/gc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 26248c8936db..acdc8b99b543 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1538,7 +1538,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >  		return -EINVAL;
> >  	}
> > 
> > -	freeze_bdev(sbi->sb->s_bdev);
> > +	freeze_super(sbi->sb);
> > 
> >  	shrunk_blocks = old_block_count - block_count;
> >  	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
> > @@ -1551,7 +1551,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >  		sbi->user_block_count -= shrunk_blocks;
> >  	spin_unlock(&sbi->stat_lock);
> >  	if (err) {
> > -		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> > +		thaw_super(sbi->sb);
> >  		return err;
> >  	}
> > 
> > @@ -1613,6 +1613,6 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >  	}
> >  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
> >  	mutex_unlock(&sbi->resize_mutex);
> > -	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> > +	thaw_super(sbi->sb);
> >  	return err;
> >  }
> > -- 
> > 2.18.0.rc1
> > 
> > > 
> > >>
> > >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > >> ---
> > >>  fs/f2fs/gc.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > >> index 5bca560..6122bad 100644
> > >> --- a/fs/f2fs/gc.c
> > >> +++ b/fs/f2fs/gc.c
> > >> @@ -1399,8 +1399,10 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
> > >>  	int err = 0;
> > >>  
> > >>  	/* Move out cursegs from the target range */
> > >> +	f2fs_lock_op(sbi);
> > >>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
> > >>  		allocate_segment_for_resize(sbi, type, start, end);
> > >> +	f2fs_unlock_op(sbi);
> > >>  
> > >>  	/* do GC to move out valid blocks in the range */
> > >>  	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
> > >> -- 
> > >> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > >> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> > > .
> > > 
> 
> -- 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
