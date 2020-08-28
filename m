Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2B208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598601632;
	bh=oUZCAVbtcMydjvoZYyf2WwWg8pwGlx2bq516aI+fa7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XSMMgdYdkQNqNgBGlA8pECj9ejUdO7CS1sxhLi2YL94k4cz5apOylFnv9ci6Zc1M+
	 mGs+kt+WLv89MrRQc7A5OyyyUd+wGHUzV5U3oH0ip5jcJgP+m9Kh89RMfd/utNjCvJ
	 TUlkbIIkstsqihibgFyup6fo20V7x3vMtEc6PdDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgH1IAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH1IAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:00:30 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AD2205CB;
        Fri, 28 Aug 2020 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598601629;
        bh=oUZCAVbtcMydjvoZYyf2WwWg8pwGlx2bq516aI+fa7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P76Uz+CcmzajUs1I4wD15bQoWu7IxT1hgqj+U4LnwzO7wHBUkwQppOAQmIR9Jm8J+
         rGcjLhdsqJHe66Nh9+IuRMrkw0PGKGb+iPgFBZZwQQ/IpgE95QwlO9IgNWRIj8mFcQ
         f3ky0upcSAi3+o5ZVimpIhk6M3V7tWgpIyvo3IJI=
Date:   Fri, 28 Aug 2020 13:30:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
Message-ID: <20200828080024.GP2639@vkoul-mobl>
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
 <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
 <20200821050758.GI2639@vkoul-mobl>
 <29ea5a44-b971-770a-519c-ae879557b63f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ea5a44-b971-770a-519c-ae879557b63f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 10:17, Pierre-Louis Bossart wrote:
> 
> 
> > > cancel_work_sync() will either
> > > a) wait until the current work completes, or
> > > b) prevent a new one from starting.
> > > 
> > > there's no way to really 'abort' a workqueue, 'cancel' means either complete
> > > or don't start.
> > 
> > Quite right, as that is how everyone deals with it. Stop the irq from
> > firing first and then wait until work is cancelled or completed, hence
> > cancel_work_sync()
> 
> No, this cannot work... The work queue in progress will initiate
> transactions which would never complete because the interrupts are disabled.

Okay that makes sense then

> > > if you disable the interrupts then cancel the work, you have a risk of not
> > > letting the work complete if it already started (case a).
> > > 
> > > The race is
> > > a) the interrupt thread (this function) starts
> > > b) the work is scheduled and starts
> > > c) the suspend handler starts and disables interrupts in [1] below.
> > > d) the work initiates transactions which will never complete since Cadence
> > > interrupts have been disabled.
> > 
> > Would it not be better to let work handle the case of interrupts
> > disabled and not initiates transactions which wont complete here? That
> > sounds more reasonable to do rather than complete the work which anyone
> > doesn't matter as you are suspending
> 
> A in-progress workqueue has no notion that interrupts are disabled, nor that
> the device is in the process of suspending. It writes into a fifo and blocks
> with wait_for_completion(). the complete() is done in an interrupt thread,
> triggered when the RX Fifo reaches a watermark.
> 
> So if you disable interrupts, the complete() never happens.
> 
> The safe way to do things with the current code is to let the workqueue
> complete, then disable interrupts.
> 
> We only disable interrupts on suspend, we don't need to test if interrupts
> are enabled for every single byte that's transmitted on the bus. Not to
> mention that this additional test would be racy as hell and require yet
> another synchronization primitive making the code more complicated.
> 
> So yes, the current transactions will complete and will be ignored, but it's
> a lot better than trying to prevent these transactions from happening with
> extra layers of complexity that will impact *every* transaction.
> 
> BTW I looked at another alternative based on the msg lock, so that
> interrupts cannot be disabled while a message is being sent. However because
> a workqueue may send multiple messages, e.g. to read registers are
> non-contiguous locations, there is no way to guarantee what happens how
> messages and interrupt disabling are scheduled, so there'd still be a case
> of a workqueue not completing and being stuck on a mutex_lock(), not so good
> either.
> 
> In short, this is the simplest way to fix the timeout on resume.

Is this timeout for suspend or resume? Somehow I was under the
assumption that it is former? Or is the result seen on resume?

Rereading the race describe above in steps, I think this should be
handled in step c above. Btw is that suspend or runtime suspend which
causes this? Former would be bigger issue as we should not have work
running when we return from suspend call. Latter should be dealt with
anyway as device might be off after suspend.

-- 
~Vinod
