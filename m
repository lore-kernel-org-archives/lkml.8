Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746CFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC782073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dbmNbOqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgCCOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:06:33 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:24795 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgCCOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:06:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583244392; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=F8RBcxUmZe2rqyQIpBMVD6tFlkNTS1F7x44l6S2dx0k=; b=dbmNbOqboe74L7U9XnOcTIgxTo51W2eunAkSpFzkGhoKuKZpwph5FU9XIcid1+746OkfsaPU
 fmP8XjGDRFLbt2Mi7vPs3/d5UY2yEkeffmwah1mWZSKn/zqVWqngMviLPHWK9cjm05RNZaVl
 J6VLB/ZKCvlgws3AUgt1byPQ5AQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5e645e.7f1eea896ab0-smtp-out-n03;
 Tue, 03 Mar 2020 14:06:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 888E8C4479C; Tue,  3 Mar 2020 14:06:22 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35924C43383;
        Tue,  3 Mar 2020 14:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35924C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 3 Mar 2020 19:36:16 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: Fix mount failure due to SPO after a
 successful online resize FS
Message-ID: <20200303140616.GF20234@codeaurora.org>
References: <1582799978-22277-1-git-send-email-stummala@codeaurora.org>
 <c39e0cf1-dbb1-5f60-50b5-e0eb246782bc@huawei.com>
 <20200302043948.GE20234@codeaurora.org>
 <4d228adb-7038-1c03-e877-93221b920104@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d228adb-7038-1c03-e877-93221b920104@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Tue, Mar 03, 2020 at 08:06:21PM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2020/3/2 12:39, Sahitya Tummala wrote:
> > Hi Chao,
> > 
> > On Fri, Feb 28, 2020 at 04:35:37PM +0800, Chao Yu wrote:
> >> Hi Sahitya,
> >>
> >> Good catch.
> >>
> >> On 2020/2/27 18:39, Sahitya Tummala wrote:
> >>> Even though online resize is successfully done, a SPO immediately
> >>> after resize, still causes below error in the next mount.
> >>>
> >>> [   11.294650] F2FS-fs (sda8): Wrong user_block_count: 2233856
> >>> [   11.300272] F2FS-fs (sda8): Failed to get valid F2FS checkpoint
> >>>
> >>> This is because after FS metadata is updated in update_fs_metadata()
> >>> if the SBI_IS_DIRTY is not dirty, then CP will not be done to reflect
> >>> the new user_block_count.
> >>>
> >>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>> ---
> >>>  fs/f2fs/gc.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>> index a92fa49..a14a75f 100644
> >>> --- a/fs/f2fs/gc.c
> >>> +++ b/fs/f2fs/gc.c
> >>> @@ -1577,6 +1577,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >>>  
> >>>  	update_fs_metadata(sbi, -secs);
> >>>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
> >>
> >> Need a barrier here to keep order in between above code and set_sbi_flag(DIRTY)?
> > 
> > I don't think a barrier will help here. Let us say there is a another context
> > doing CP already, then it races with update_fs_metadata(), so it may or may not
> > see the resize updates and it will also clear the SBI_IS_DIRTY flag set by resize
> > (even with a barrier).
> 
> I agreed, actually, we didn't consider race condition in between CP and
> update_fs_metadata(), it should be fixed.
> 
> > 
> > I think we need to synchronize this with CP context, so that these resize changes
> > will be reflected properly. Please see the new diff below and help with the review.
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index a14a75f..5554af8 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1467,6 +1467,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
> >         long long user_block_count =
> >                                 le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
> > 
> > +       clear_sbi_flag(sbi, SBI_IS_DIRTY);
> 
> Why clear dirty flag here?

Yes, it is not required. I will remove it.

> 
> And why not use cp_mutex to protect update_fs_metadata() in error path of
> f2fs_sync_fs() below?

Yes, will add a lock there too.

Thanks,

> 
> >         SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
> >         MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
> >         FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
> > @@ -1575,9 +1576,12 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >                 goto out;
> >         }
> > 
> > +       mutex_lock(&sbi->cp_mutex);
> >         update_fs_metadata(sbi, -secs);
> >         clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
> >         set_sbi_flag(sbi, SBI_IS_DIRTY);
> > +       mutex_unlock(&sbi->cp_mutex);
> > +
> >         err = f2fs_sync_fs(sbi->sb, 1);
> >         if (err) {
> >                 update_fs_metadata(sbi, secs);
> 
> 		  ^^^^^^^^^^^^^^
> 
> In addition, I found that we missed to use sb_lock to protect f2fs_super_block
> fields update, will submit a patch for that.
> 
> Thanks,
> 
> > 
> > thanks,
> > 
> >>
> >>> +	set_sbi_flag(sbi, SBI_IS_DIRTY);
> >>>  	err = f2fs_sync_fs(sbi->sb, 1);
> >>>  	if (err) {
> >>>  		update_fs_metadata(sbi, secs);
> >>
> >> Do we need to add clear_sbi_flag(, SBI_IS_DIRTY) into update_fs_metadata(), so above
> >> path can be covered as well?
> >>
> >> Thanks,
> >>
> >>>
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
