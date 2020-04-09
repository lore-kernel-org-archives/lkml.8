Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97752C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8322085B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586399284;
	bh=uxk0S1npFOAmVD7CQaJ0Plq215CQzVmPjf8As32lTHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0NGp4GjmJfLOtsCVCnqtM0cekZSuWIa698wNjKTo3bB+qfceDVbYjtePiw0AXTAy
	 nDzJKPqzCrazM5DCLx4UrW+++evwCQum1HAQNcGi3aNHtAeWSnLgETqtvLeJTtVbdK
	 4A4aJrnudJnrh6PHG6DI82n/9pOsh3fsmLaIt7Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDIC2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgDIC2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 22:28:02 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883E820787;
        Thu,  9 Apr 2020 02:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586399282;
        bh=uxk0S1npFOAmVD7CQaJ0Plq215CQzVmPjf8As32lTHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yt4FJC/etaDubiv39P2czMkzYLhEZRlqGYanFHoScCIsR1PqW/592al1uIFDlJnL0
         VPsSxUQbMw7Iu60w/pT+rWpEX8WwhGOd8MxkflT53LYFeRpnzShiWHQpk8lSqXOceE
         nAkGkBjKsPh0hPbNZhuzqs1cY4j1kE0TzYJIjg5c=
Date:   Wed, 8 Apr 2020 19:28:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sysfs/data_io_flag to attach
 REQ_META/FUA
Message-ID: <20200409022802.GC110440@google.com>
References: <20200403161249.68385-1-jaegeuk@kernel.org>
 <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
 <20200407025913.GB137081@google.com>
 <2ca452cd-073a-29fa-1884-99ad1199bb97@huawei.com>
 <20200409022005.GA110440@google.com>
 <69df999a-1df2-595e-579d-a8c3fc700d7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69df999a-1df2-595e-579d-a8c3fc700d7b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Chao Yu wrote:
> On 2020/4/9 10:20, Jaegeuk Kim wrote:
> > On 04/07, Chao Yu wrote:
> >> On 2020/4/7 10:59, Jaegeuk Kim wrote:
> >>> On 04/07, Chao Yu wrote:
> >>>> On 2020/4/4 0:12, Jaegeuk Kim wrote:
> >>>>> This patch introduces a way to attach REQ_META/FUA explicitly
> >>>>> to all the data writes given temperature.
> >>>>>
> >>>>> -> attach REQ_FUA to Hot Data writes
> >>>>>
> >>>>> -> attach REQ_FUA to Hot|Warm Data writes
> >>>>>
> >>>>> -> attach REQ_FUA to Hot|Warm|Cold Data writes
> >>>>>
> >>>>> -> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
> >>>>>           REQ_META to Hot Data writes
> >>>>
> >>>> Out of curiosity, what scenario it is used for?
> >>>
> >>> It's testing purpose to compare the bandwidths per different IO flags.
> >>
> >> Thanks for the hint. :)
> >>
> >> As nobarrier was set in Android, so REQ_PREFLUSH will not be considered in
> >> this sysfs interface?
> > 
> > I don't see any diff on performance, so not interesting. :)
> 
> I doubt it may has diff on non-ufs/emmc device? just guess.

I don't have any data on emmc, so maybe. Which case do we send REQ_PREFLUSH?

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>> .
> >>>
> > .
> > 
