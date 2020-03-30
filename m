Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACABC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00A32073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Bw4JdP70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgC3Gxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:53:55 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26570 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbgC3Gxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:53:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585551234; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=NxnZdIQiHu9SdYni9w/ASzbt88VeS0n25G+4IoCyDSY=; b=Bw4JdP70zSP5vbJHRNWECMjBZSFvYYByG66W/7JWaRw8XenhoFxi4NtpfLnEAggOz7/i/jey
 Ss1fTMEN9wdPiqHzItk6SgrzZkUhe+lUYa1sO2G41++28SNv7k4vBckcLfSVkZSf/tvd7K5P
 88+hShqqyF5cegkFk87izqn7Des=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e819775.7f3accc6ca08-smtp-out-n03;
 Mon, 30 Mar 2020 06:53:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E012DC433D2; Mon, 30 Mar 2020 06:53:41 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F10BC433F2;
        Mon, 30 Mar 2020 06:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F10BC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 30 Mar 2020 12:23:35 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
Message-ID: <20200330065335.GT20234@codeaurora.org>
References: <1584506689-5041-1-git-send-email-stummala@codeaurora.org>
 <29d4adc4-482d-3d92-1470-3405989ea231@huawei.com>
 <20200326133700.GR20234@codeaurora.org>
 <2b0d8d4c-a981-4edc-d8ca-fe199a63ea79@huawei.com>
 <20200327030542.GS20234@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327030542.GS20234@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Fri, Mar 27, 2020 at 08:35:42AM +0530, Sahitya Tummala wrote:
> On Fri, Mar 27, 2020 at 09:51:43AM +0800, Chao Yu wrote:
> > 
> > With this patch, most of xfstest cases cost 5 * n second longer than before.
> > 
> > E.g. generic/003, during umount(), we looped into retrying one bio
> > submission.
> > 
> > [61279.829724] F2FS-fs (zram1): Found nat_bits in checkpoint
> > [61279.885337] F2FS-fs (zram1): Mounted with checkpoint version = 5cf3cb8e
> > [61281.912832] submit discard bio start [23555,1]
> > [61281.912835] f2fs_submit_discard_endio [23555,1] err:-11
> > [61281.912836] submit discard bio end [23555,1]
> > [61281.912836] move dc to retry list [23555,1]
> > 
> > ...
> > 
> > [61286.881212] submit discard bio start [23555,1]
> > [61286.881217] f2fs_submit_discard_endio [23555,1] err:-11
> > [61286.881223] submit discard bio end [23555,1]
> > [61286.881224] move dc to retry list [23555,1]
> > [61286.905198] submit discard bio start [23555,1]
> > [61286.905203] f2fs_submit_discard_endio [23555,1] err:-11
> > [61286.905205] submit discard bio end [23555,1]
> > [61286.905206] move dc to retry list [23555,1]
> > [61286.929157] F2FS-fs (zram1): Issue discard(23555, 23555, 1) failed, ret: -11
> > 
> > Could you take a look at this issue?
> 
> Let me check and get back on this.

I found the issue. The dc with multiple bios is getting requeued again and
again in case if one of its bio gets -EAGAIN error. Even the successfully
completed bios are getting requeued again resulting into long latency.
I have fixed it by splitting the dc in such case so that we can requeue only
the leftover bios into a new dc and retry that later within the 5 sec timeout.

Please help to review v3 posted and if it looks good, I would like to request
you to test the earlier regression scenario with it to check the result again?

thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > > 
> > > Thanks,
> > > 
> > >> Thanks,
> > >>
> > >>> +				break;
> > >>> +			}
> > >>> +		}
> > >>>  
> > >>>  		atomic_inc(&dcc->issued_discard);
> > >>>  
> > >>> @@ -1463,6 +1477,40 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> > >>>  	return issued;
> > >>>  }
> > >>>  
> > >>> +static bool __should_discard_retry(struct f2fs_sb_info *sbi,
> > > s> > +		struct discard_policy *dpolicy)
> > >>> +{
> > >>> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> > >>> +	struct discard_cmd *dc, *tmp;
> > >>> +	bool retry = false;
> > >>> +	unsigned long flags;
> > >>> +
> > >>> +	if (dpolicy->type != DPOLICY_UMOUNT)
> > >>> +		f2fs_bug_on(sbi, 1);
> > >>> +
> > >>> +	mutex_lock(&dcc->cmd_lock);
> > >>> +	list_for_each_entry_safe(dc, tmp, &(dcc->retry_list), list) {
> > >>> +		if (dpolicy->timeout != 0 &&
> > >>> +			f2fs_time_over(sbi, dpolicy->timeout)) {
> > >>> +			retry = false;
> > >>> +			break;
> > >>> +		}
> > >>> +
> > >>> +		spin_lock_irqsave(&dc->lock, flags);
> > >>> +		if (!dc->bio_ref) {
> > >>> +			dc->state = D_PREP;
> > >>> +			dc->error = 0;
> > >>> +			reinit_completion(&dc->wait);
> > >>> +			__relocate_discard_cmd(dcc, dc);
> > >>> +			retry = true;
> > >>> +		}
> > >>> +		spin_unlock_irqrestore(&dc->lock, flags);
> > >>> +	}
> > >>> +	mutex_unlock(&dcc->cmd_lock);
> > >>> +
> > >>> +	return retry;
> > >>> +}
> > >>> +
> > >>>  static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > >>>  					struct discard_policy *dpolicy)
> > >>>  {
> > >>> @@ -1470,12 +1518,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > >>>  	struct list_head *pend_list;
> > >>>  	struct discard_cmd *dc, *tmp;
> > >>>  	struct blk_plug plug;
> > >>> -	int i, issued = 0;
> > >>> +	int i, err, issued = 0;
> > >>>  	bool io_interrupted = false;
> > >>>  
> > >>>  	if (dpolicy->timeout != 0)
> > >>>  		f2fs_update_time(sbi, dpolicy->timeout);
> > >>>  
> > >>> +retry:
> > >>>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> > >>>  		if (dpolicy->timeout != 0 &&
> > >>>  				f2fs_time_over(sbi, dpolicy->timeout))
> > >>> @@ -1509,7 +1558,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > >>>  				break;
> > >>>  			}
> > >>>  
> > >>> -			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > >>> +			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > >>> +			if (err == -EAGAIN)
> > >>> +				congestion_wait(BLK_RW_ASYNC,
> > >>> +						DEFAULT_IO_TIMEOUT);
> > >>>  
> > >>>  			if (issued >= dpolicy->max_requests)
> > >>>  				break;
> > >>> @@ -1522,6 +1574,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > >>>  			break;
> > >>>  	}
> > >>>  
> > >>> +	if (!list_empty(&dcc->retry_list) &&
> > >>> +		__should_discard_retry(sbi, dpolicy))
> > >>> +		goto retry;
> > >>> +
> > >>>  	if (!issued && io_interrupted)
> > >>>  		issued = -1;
> > >>>  
> > >>> @@ -1613,6 +1669,12 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
> > >>>  		goto next;
> > >>>  	}
> > >>>  
> > >>> +	if (dpolicy->type == DPOLICY_UMOUNT &&
> > >>> +		!list_empty(&dcc->retry_list)) {
> > >>> +		wait_list = &dcc->retry_list;
> > >>> +		goto next;
> > >>> +	}
> > >>> +
> > >>>  	return trimmed;
> > >>>  }
> > >>>  
> > >>> @@ -2051,6 +2113,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> > >>>  	for (i = 0; i < MAX_PLIST_NUM; i++)
> > >>>  		INIT_LIST_HEAD(&dcc->pend_list[i]);
> > >>>  	INIT_LIST_HEAD(&dcc->wait_list);
> > >>> +	INIT_LIST_HEAD(&dcc->retry_list);
> > >>>  	INIT_LIST_HEAD(&dcc->fstrim_list);
> > >>>  	mutex_init(&dcc->cmd_lock);
> > >>>  	atomic_set(&dcc->issued_discard, 0);
> > >>>
> > > 
> 
> -- 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
