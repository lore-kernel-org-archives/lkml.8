Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C09C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D564206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584063938;
	bh=eOeeLsiw73oz23MELGRqbWNabA9/QJa23yrnUToudVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ej8YR+m9sJAfEkY+VVIrvZDRgb+Z+X2qlH0d8YX0D7QoLKJWUrtPMlSUXhgB0yJ6j
	 D9V8uAM0mnm7OEa3PNMVoII8+K4DMfPLkB6egL3k1FT+PgI88mk3Kx6ZByWNF+P4h5
	 AyVg4XV3F8nEHNdwqJwNJeJwrH+TD+cEtr47yVzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMBph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCMBpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:45:36 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00EFA206EB;
        Fri, 13 Mar 2020 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584063936;
        bh=eOeeLsiw73oz23MELGRqbWNabA9/QJa23yrnUToudVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpuV21MXLiAl8IdbIWtXwY3FgUU8dBbJ9WEo93Kwg+/GbAoFuNFGEfl/f/SaBxTIY
         be3GCDYZZlblAInUV8NiFetDEY4YfF/f0t23vKmPCD8pVdooMxCVlRIfLPmlZHLemP
         cvpyyBOHJc1NiUw1RwXDYvTCQbstB8PkklyaTh20=
Date:   Thu, 12 Mar 2020 18:45:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
Message-ID: <20200313014535.GA72547@google.com>
References: <1584011671-20939-1-git-send-email-stummala@codeaurora.org>
 <20200312170242.GA185506@google.com>
 <20200313012604.GI20234@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313012604.GI20234@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13, Sahitya Tummala wrote:
> On Thu, Mar 12, 2020 at 10:02:42AM -0700, Jaegeuk Kim wrote:
> > On 03/12, Sahitya Tummala wrote:
> > > F2FS already has a default timeout of 5 secs for discards that
> > > can be issued during umount, but it can take more than the 5 sec
> > > timeout if the underlying UFS device queue is already full and there
> > > are no more available free tags to be used. In that case, submit_bio()
> > > will wait for the already queued discard requests to complete to get
> > > a free tag, which can potentially take way more than 5 sec.
> > > 
> > > Fix this by submitting the discard requests with REQ_NOWAIT
> > > flags during umount. This will return -EAGAIN for UFS queue/tag full
> > > scenario without waiting in the context of submit_bio(). The FS can
> > > then handle these requests by retrying again within the stipulated
> > > discard timeout period to avoid long latencies.
> > > 
> > > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > > ---
> > >  fs/f2fs/segment.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index fb3e531..a06bbac 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -1124,10 +1124,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > >  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> > >  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> > >  					&(dcc->fstrim_list) : &(dcc->wait_list);
> > > -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> > > +	int flag;
> > >  	block_t lstart, start, len, total_len;
> > >  	int err = 0;
> > >  
> > > +	flag = dpolicy->sync ? REQ_SYNC : 0;
> > > +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
> > > +
> > >  	if (dc->state != D_PREP)
> > >  		return 0;
> > >  
> > > @@ -1203,6 +1206,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > >  		bio->bi_end_io = f2fs_submit_discard_endio;
> > >  		bio->bi_opf |= flag;
> > >  		submit_bio(bio);
> > > +		if ((flag & REQ_NOWAIT) && (dc->error == -EAGAIN)) {
> > > +			dc->state = D_PREP;
> > > +			err = dc->error;
> > > +			break;
> > > +		}
> > >  
> > >  		atomic_inc(&dcc->issued_discard);
> > >  
> > > @@ -1510,6 +1518,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > >  			}
> > >  
> > >  			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > > +			if (dc->error == -EAGAIN) {
> > > +				congestion_wait(BLK_RW_ASYNC, HZ/50);
> > 
> > 						--> need to be DEFAULT_IO_TIMEOUT
> 
> Yes, i will update it.
> 
> > 
> > > +				__relocate_discard_cmd(dcc, dc);
> > 
> > It seems we need to submit bio first, and then move dc to wait_list, if there's
> > no error, in __submit_discard_cmd().
> 
> Yes, that is not changed and it still happens for the failed request
> that is re-queued here too when it gets submitted again later.
> 
> I am requeuing the discard request failed with -EAGAIN error back to 
> dcc->pend_list[] from wait_list. It will call submit_bio() for this request
> and also move to wait_list when it calls __submit_discard_cmd() again next
> time. Please let me know if I am missing anything?

This patch has no problem, but I'm thinking that __submit_discard_cmd() needs
to return with any values by assumption where the waiting list should have
submitted commands.

> 
> Thanks,
> 
> > 
> > > +			}
> > >  
> > >  			if (issued >= dpolicy->max_requests)
> > >  				break;
> > > -- 
> > > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> -- 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
