Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED30206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bzR+7EQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDTLhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:37:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16748 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbgDTLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:37:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587382637; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=FwkQvFRxwbLjQxAc2Z3zkT0Pkf1NFBtbxmMPO/jSwbI=; b=bzR+7EQksa4cuhMbPlAL7VgodaMSs1qlQ0jODmW8XReLlPKCUs39QeAIfyzwbrd18zy/as1N
 UYMSn0Wvh4NjAPAUOyA+2pGg50GwSE/IpyAP9Xck2sPvNhHDZbwWHGgG5TzV3pjR7MNCHbvH
 9OL/ca2eVDL94s0gxNxO8PLrFcE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9d8968.7f4598a6e768-smtp-out-n02;
 Mon, 20 Apr 2020 11:37:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1B69C43636; Mon, 20 Apr 2020 11:37:11 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0A63C433BA;
        Mon, 20 Apr 2020 11:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0A63C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 20 Apr 2020 17:07:05 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stummala@codeaurora.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent meta updates while checkpoint
 is in progress
Message-ID: <20200420113705.GF20234@codeaurora.org>
References: <20200331090608.GZ20234@codeaurora.org>
 <20200331184307.GA198665@google.com>
 <20200401050801.GA20234@codeaurora.org>
 <20200403171727.GB68460@google.com>
 <20200403172750.GD68460@google.com>
 <20200413174237.GC39092@google.com>
 <20200414134403.GA69282@google.com>
 <20200416214045.GB196168@google.com>
 <e1b763bf-7f72-01eb-a368-9b70e0f46f55@huawei.com>
 <20200417161516.GA17901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417161516.GA17901@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On Fri, Apr 17, 2020 at 09:15:16AM -0700, Jaegeuk Kim wrote:
> Hi Sahitya,
> 
> Could you please test this patch fully? I didn't test at all.

I have tested v5 and so far found only one problem where MAIN_SECS(sbi)
isn't updated properly. Fixed it as below.

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 603f195..a5166b1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1450,7 +1450,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
                f2fs_bug_on(sbi, 1);
        }
 out:
-       MAIN_SECS(sbi) -= secs;
+       MAIN_SECS(sbi) += secs;
        return err;
 }

I will let you know in case anything else shows up later.

Thanks,

> 
> Thanks,
> 
> On 04/17, Chao Yu wrote:
> > On 2020/4/17 5:40, Jaegeuk Kim wrote:
> > > On 04/14, Jaegeuk Kim wrote:
> > >> On 04/13, Jaegeuk Kim wrote:
> > >>> On 04/03, Jaegeuk Kim wrote:
> > >>>> On 04/03, Jaegeuk Kim wrote:
> > >>>>> On 04/01, Sahitya Tummala wrote:
> > >>>>>> Hi Jaegeuk,
> > >>>>>>
> > >>>>>> Got it.
> > >>>>>> The diff below looks good to me.
> > >>>>>> Would you like me to test it and put a patch for this?
> > >>>>>
> > >>>>> Sahitya, Chao,
> > >>>>>
> > >>>>> Could you please take a look at this patch and test intensively?
> > >>>>>
> > >>>>> Thanks,
> > > 
> > > v5:
> > >  - add signal handler
> > > 
> > > Sahitya raised an issue:
> > > - prevent meta updates while checkpoint is in progress
> > > 
> > > allocate_segment_for_resize() can cause metapage updates if
> > > it requires to change the current node/data segments for resizing.
> > > Stop these meta updates when there is a checkpoint already
> > > in progress to prevent inconsistent CP data.
> > > 
> > > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > 
> > Thanks,

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
