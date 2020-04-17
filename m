Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7DC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D8E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587140119;
	bh=ECCfbaSoEBEJ6WvTW36xUahNJiM0dMQr/S7euQZ88dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gp8djto5tj7DWgivkaMxi/eG5BVu27mw4wuLFiLbQbp3G+lOjRMazU0+ixKi1AGK/
	 gzyAwssP8/Br6o7AxtkRVKPEhGBGwP/9llMt2pxNiP4UhHhW00aydrsh3dayc3mjbt
	 1jtb0+P56r0BVWyfnirFTmnFrzV0NOA2xOY2OdNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgDQQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgDQQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:15:17 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF672072D;
        Fri, 17 Apr 2020 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587140117;
        bh=ECCfbaSoEBEJ6WvTW36xUahNJiM0dMQr/S7euQZ88dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKJgxUHT9WLUQmTCNTg45NPovpnw3Zz+WXdmnua4zbrQuym9O5pYzYViZrtEaOwIJ
         lgaLTU2oB/a8gRFrCD2mLR4aor/SqW1qEQg+EN3aMGtDILQhgawWD7PWB/DW6O1cjO
         t4DLlGphDdhHzG+O9w0awnT2jYVYQo9OEwThD2Ws=
Date:   Fri, 17 Apr 2020 09:15:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent meta updates while checkpoint
 is in progress
Message-ID: <20200417161516.GA17901@google.com>
References: <20200331035419.GB79749@google.com>
 <20200331090608.GZ20234@codeaurora.org>
 <20200331184307.GA198665@google.com>
 <20200401050801.GA20234@codeaurora.org>
 <20200403171727.GB68460@google.com>
 <20200403172750.GD68460@google.com>
 <20200413174237.GC39092@google.com>
 <20200414134403.GA69282@google.com>
 <20200416214045.GB196168@google.com>
 <e1b763bf-7f72-01eb-a368-9b70e0f46f55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b763bf-7f72-01eb-a368-9b70e0f46f55@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

Could you please test this patch fully? I didn't test at all.

Thanks,

On 04/17, Chao Yu wrote:
> On 2020/4/17 5:40, Jaegeuk Kim wrote:
> > On 04/14, Jaegeuk Kim wrote:
> >> On 04/13, Jaegeuk Kim wrote:
> >>> On 04/03, Jaegeuk Kim wrote:
> >>>> On 04/03, Jaegeuk Kim wrote:
> >>>>> On 04/01, Sahitya Tummala wrote:
> >>>>>> Hi Jaegeuk,
> >>>>>>
> >>>>>> Got it.
> >>>>>> The diff below looks good to me.
> >>>>>> Would you like me to test it and put a patch for this?
> >>>>>
> >>>>> Sahitya, Chao,
> >>>>>
> >>>>> Could you please take a look at this patch and test intensively?
> >>>>>
> >>>>> Thanks,
> > 
> > v5:
> >  - add signal handler
> > 
> > Sahitya raised an issue:
> > - prevent meta updates while checkpoint is in progress
> > 
> > allocate_segment_for_resize() can cause metapage updates if
> > it requires to change the current node/data segments for resizing.
> > Stop these meta updates when there is a checkpoint already
> > in progress to prevent inconsistent CP data.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
