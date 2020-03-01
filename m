Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07811C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90BA214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgCATPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:15:44 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33535 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCATPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:15:44 -0500
X-Originating-IP: 71.238.64.75
Received: from localhost (c-71-238-64-75.hsd1.or.comcast.net [71.238.64.75])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8F863E000A;
        Sun,  1 Mar 2020 19:15:02 +0000 (UTC)
Date:   Sun, 1 Mar 2020 11:15:01 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200301191501.GA235404@localhost>
References: <20200229025228.GA203607@localhost>
 <20200301183231.GA544682@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301183231.GA544682@dhcp-10-100-145-180.wdl.wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 10:32:31AM -0800, Keith Busch wrote:
> On Fri, Feb 28, 2020 at 06:52:28PM -0800, Josh Triplett wrote:
> > @@ -2074,7 +2074,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
> >  		if ((csts & NVME_CSTS_RDY) == bit)
> >  			break;
> >  
> > -		msleep(100);
> > +		usleep_range(1000, 2000);
> >  		if (fatal_signal_pending(current))
> >  			return -EINTR;
> >  		if (time_after(jiffies, timeout)) {
> 
> The key being this sleep schedules the task unlike udelay.

Right; I don't think it's reasonable to busyloop here, just sleep for
less time.

> It's neat you can boot where 100ms is considered a long time.

It's been fun. This was one of the longest single delays in a ~1s boot.

> This clearly helps when you've one nvme that becomes ready quickly, but
> what happens with many nvme's that are slow to ready? This change will
> end up polling the status of those 1000's of times, I wonder if there's
> a point where this frequent sleep/wake cycle initializing a whole lot
> of nvme devices in parallel may interfere with other init tasks.

usleep_range allows the kernel to consolidate those wakeups, so if you
have multiple NVMe devices, the kernel should in theory just wake up
once, check them all for readiness, and go back to sleep.

> I doubt there's really an issue there, but thought it's worth considering
> what happens at the other end of the specturm.
> 
> Anyway, the patch looks fine to me.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thank you!

Does this seem reasonable to enqueue for 5.7?

- Josh Triplett
