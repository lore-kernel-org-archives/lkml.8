Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA2120757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VvwKoOo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDILsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:48:09 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38739 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgDILsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:48:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586432888; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=TS4I8jwvGMbIpjuXY03G0dGC33G+ug/cebdMISYHD8U=; b=VvwKoOo7+jAZORRm0AIVWTBGqgCUp0ixXI+kqHPG0vm56vIzy0wh4rsaK+07a1kUtJp6BZGr
 WwJkrVnNS+6OgUripK0IWed2wRoKy4rjnbq9O9YwRBKjzGDLDJ/jKKcXoXx7vZM2Lqm9j0cr
 biCvYk1qC1EZDmrxq8opCcvMi9Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f0b75.7fe88f4ce3e8-smtp-out-n03;
 Thu, 09 Apr 2020 11:48:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49F2DC432C2; Thu,  9 Apr 2020 11:48:04 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC8CFC433CB;
        Thu,  9 Apr 2020 11:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC8CFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 9 Apr 2020 17:17:57 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH v3] f2fs: fix long latency due to discard during umount
Message-ID: <20200409114756.GD20234@codeaurora.org>
References: <1585550730-1858-1-git-send-email-stummala@codeaurora.org>
 <20200331184655.GB198665@google.com>
 <20200401092201.GB20234@codeaurora.org>
 <20200403171943.GC68460@google.com>
 <20200408090024.GC20234@codeaurora.org>
 <20200409022928.GD110440@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409022928.GD110440@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 07:29:28PM -0700, Jaegeuk Kim wrote:
> On 04/08, Sahitya Tummala wrote:
> > Hi Jaegeuk,
> > 
> > On Fri, Apr 03, 2020 at 10:19:43AM -0700, Jaegeuk Kim wrote:
> > > On 04/01, Sahitya Tummala wrote:
> > > > Hi Jaegeuk,
> > > > 
> > > > On Tue, Mar 31, 2020 at 11:46:55AM -0700, Jaegeuk Kim wrote:
> > > > > On 03/30, Sahitya Tummala wrote:
> > > > > > F2FS already has a default timeout of 5 secs for discards that
> > > > > > can be issued during umount, but it can take more than the 5 sec
> > > > > > timeout if the underlying UFS device queue is already full and there
> > > > > > are no more available free tags to be used. In that case, submit_bio()
> > > > > > will wait for the already queued discard requests to complete to get
> > > > > > a free tag, which can potentially take way more than 5 sec.
> > > > > > 
> > > > > > Fix this by submitting the discard requests with REQ_NOWAIT
> > > > > > flags during umount. This will return -EAGAIN for UFS queue/tag full
> > > > > > scenario without waiting in the context of submit_bio(). The FS can
> > > > > > then handle these requests by retrying again within the stipulated
> > > > > > discard timeout period to avoid long latencies.
> > > > > 
> > > > > Sorry, Sahitya, but, do we really need to do like this? How about just
> > > > > controlling # of outstanding discarding bios in __issue_discard_cmd()?
> > > > 
> > > > Do you mean something like this?
> > > > 
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index 1a62b27..860dd43 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -1099,7 +1099,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> > > >         } else if (discard_type == DPOLICY_FSTRIM) {
> > > >                 dpolicy->io_aware = false;
> > > >         } else if (discard_type == DPOLICY_UMOUNT) {
> > > > -               dpolicy->max_requests = UINT_MAX;
> > > > +               dpolicy->max_requests = 30;
> > > 
> > > Can we use max queue depth of the block device?
> > 
> > I think it should be limited to 8 or 16 as Chao suggested, so that we can have
> > better control on the given timeout value? Thoughts?
> 
> Where is 8 or 16 coming from? What about SSD? Sorry, it's unclear to me.

With this patch we now wait for a batch of discard requests in __issue_discard_cmd()
with a upper timeout of 5 sec. So, I thought that having a smaller batch of
discard requests would help us to avoid queuing more requests and end up waiting
for more time in __wait_all_discard_cmd(). Today we have DEF_MAX_DISCARD_REQUEST
as 8 for default max discard requests. If it too less, may be for umount
we can use 16 instead. But the idea is to avoid more wait time.

If you would like to propose to use max queue depth, we can get it from bdev as 
sbi->sb->s_bdev->bd_queue->queue_depth. Is it okay to use it in our FS? or you
think it should be hardcoded to 32 (as most UFS/eMMC devices will have this as
its queue depth)? Please let me know.

Thanks,

> 
> > 
> > Thanks,
> > 
> > > 
> > > >                 dpolicy->io_aware = false;
> > > >                 /* we need to issue all to keep CP_TRIMMED_FLAG */
> > > >                 dpolicy->granularity = 1;
> > > > @@ -1470,12 +1470,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > >         struct list_head *pend_list;
> > > >         struct discard_cmd *dc, *tmp;
> > > >         struct blk_plug plug;
> > > > -       int i, issued = 0;
> > > > +       int i, issued;
> > > >         bool io_interrupted = false;
> > > > 
> > > >         if (dpolicy->timeout != 0)
> > > >                 f2fs_update_time(sbi, dpolicy->timeout);
> > > > 
> > > > +retry:
> > > > +       issued = 0;
> > > >         for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> > > >                 if (dpolicy->timeout != 0 &&
> > > >                                 f2fs_time_over(sbi, dpolicy->timeout))
> > > > @@ -1522,6 +1524,11 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > >                         break;
> > > >         }
> > > > 
> > > > +       if (dpolicy->type == DPOLICY_UMOUNT && issued) {
> > > > +               __wait_all_discard_cmd(sbi, dpolicy);
> > > > +               goto retry;
> > > > +       }
> > > > +
> > > >         if (!issued && io_interrupted)
> > > >                 issued = -1;
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > > > > > ---
> > > > > > v3:
> > > > > > -Handle the regression reported by Chao with v2.
> > > > > > -simplify the logic to split the dc with multiple bios incase any bio returns
> > > > > >  EAGAIN and retry those new dc within 5 sec timeout.
> > > > > > 
> > > > > >  fs/f2fs/segment.c | 65 +++++++++++++++++++++++++++++++++++++++++++------------
> > > > > >  1 file changed, 51 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > > > index fb3e531..55d18c7 100644
> > > > > > --- a/fs/f2fs/segment.c
> > > > > > +++ b/fs/f2fs/segment.c
> > > > > > @@ -1029,13 +1029,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
> > > > > >  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> > > > > >  	unsigned long flags;
> > > > > >  
> > > > > > -	dc->error = blk_status_to_errno(bio->bi_status);
> > > > > > -
> > > > > >  	spin_lock_irqsave(&dc->lock, flags);
> > > > > > +	if (!dc->error)
> > > > > > +		dc->error = blk_status_to_errno(bio->bi_status);
> > > > > > +
> > > > > >  	dc->bio_ref--;
> > > > > > -	if (!dc->bio_ref && dc->state == D_SUBMIT) {
> > > > > > -		dc->state = D_DONE;
> > > > > > -		complete_all(&dc->wait);
> > > > > > +	if (!dc->bio_ref) {
> > > > > > +		if (dc->error || dc->state == D_SUBMIT) {
> > > > > > +			dc->state = D_DONE;
> > > > > > +			complete_all(&dc->wait);
> > > > > > +		}
> > > > > >  	}
> > > > > >  	spin_unlock_irqrestore(&dc->lock, flags);
> > > > > >  	bio_put(bio);
> > > > > > @@ -1124,10 +1127,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> > > > > >  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> > > > > >  					&(dcc->fstrim_list) : &(dcc->wait_list);
> > > > > > -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> > > > > > +	int flag;
> > > > > >  	block_t lstart, start, len, total_len;
> > > > > >  	int err = 0;
> > > > > >  
> > > > > > +	flag = dpolicy->sync ? REQ_SYNC : 0;
> > > > > > +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
> > > > > > +
> > > > > >  	if (dc->state != D_PREP)
> > > > > >  		return 0;
> > > > > >  
> > > > > > @@ -1192,10 +1198,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  		dc->bio_ref++;
> > > > > >  		spin_unlock_irqrestore(&dc->lock, flags);
> > > > > >  
> > > > > > -		atomic_inc(&dcc->queued_discard);
> > > > > > -		dc->queued++;
> > > > > > -		list_move_tail(&dc->list, wait_list);
> > > > > > -
> > > > > >  		/* sanity check on discard range */
> > > > > >  		__check_sit_bitmap(sbi, lstart, lstart + len);
> > > > > >  
> > > > > > @@ -1203,6 +1205,29 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  		bio->bi_end_io = f2fs_submit_discard_endio;
> > > > > >  		bio->bi_opf |= flag;
> > > > > >  		submit_bio(bio);
> > > > > > +		if (flag & REQ_NOWAIT) {
> > > > > > +			if (dc->error == -EAGAIN) {
> > > > > > +				spin_lock_irqsave(&dc->lock, flags);
> > > > > > +				dc->len -= len;
> > > > > > +				if (!dc->len) {
> > > > > > +					dc->len = total_len;
> > > > > > +					dc->state = D_PREP;
> > > > > > +					reinit_completion(&dc->wait);
> > > > > > +				} else {
> > > > > > +					dcc->undiscard_blks -= total_len;
> > > > > > +					if (dc->state == D_PARTIAL)
> > > > > > +						dc->state = D_SUBMIT;
> > > > > > +				}
> > > > > > +				err = dc->error;
> > > > > > +				dc->error = 0;
> > > > > > +				spin_unlock_irqrestore(&dc->lock, flags);
> > > > > > +				break;
> > > > > > +			}
> > > > > > +		}
> > > > > > +
> > > > > > +		atomic_inc(&dcc->queued_discard);
> > > > > > +		dc->queued++;
> > > > > > +		list_move_tail(&dc->list, wait_list);
> > > > > >  
> > > > > >  		atomic_inc(&dcc->issued_discard);
> > > > > >  
> > > > > > @@ -1214,8 +1239,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  		len = total_len;
> > > > > >  	}
> > > > > >  
> > > > > > -	if (!err && len)
> > > > > > -		__update_discard_tree_range(sbi, bdev, lstart, start, len);
> > > > > > +	if ((!err || err == -EAGAIN) && total_len && dc->start != start)
> > > > > > +		__update_discard_tree_range(sbi, bdev, lstart, start,
> > > > > > +					total_len);
> > > > > >  	return err;
> > > > > >  }
> > > > > >  
> > > > > > @@ -1470,12 +1496,15 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  	struct list_head *pend_list;
> > > > > >  	struct discard_cmd *dc, *tmp;
> > > > > >  	struct blk_plug plug;
> > > > > > -	int i, issued = 0;
> > > > > > +	int i, err, issued = 0;
> > > > > >  	bool io_interrupted = false;
> > > > > > +	bool retry;
> > > > > >  
> > > > > >  	if (dpolicy->timeout != 0)
> > > > > >  		f2fs_update_time(sbi, dpolicy->timeout);
> > > > > >  
> > > > > > +retry:
> > > > > > +	retry = false;
> > > > > >  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> > > > > >  		if (dpolicy->timeout != 0 &&
> > > > > >  				f2fs_time_over(sbi, dpolicy->timeout))
> > > > > > @@ -1509,7 +1538,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  				break;
> > > > > >  			}
> > > > > >  
> > > > > > -			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > > > > > +			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > > > > > +			if (err == -EAGAIN) {
> > > > > > +				congestion_wait(BLK_RW_ASYNC,
> > > > > > +						DEFAULT_IO_TIMEOUT);
> > > > > > +				retry = true;
> > > > > > +			}
> > > > > >  
> > > > > >  			if (issued >= dpolicy->max_requests)
> > > > > >  				break;
> > > > > > @@ -1522,6 +1556,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > > > >  			break;
> > > > > >  	}
> > > > > >  
> > > > > > +	if (retry)
> > > > > > +		goto retry;
> > > > > > +
> > > > > >  	if (!issued && io_interrupted)
> > > > > >  		issued = -1;
> > > > > >  
> > > > > > -- 
> > > > > > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > > > > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> > > > 
> > > > -- 
> > > > --
> > > > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> > 
> > -- 
> > --
> > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
