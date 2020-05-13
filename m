Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9FD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbgEMS4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:56:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgEMS4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:56:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1820531B;
        Wed, 13 May 2020 11:56:22 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [10.57.41.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020403F305;
        Wed, 13 May 2020 11:56:20 -0700 (PDT)
Date:   Wed, 13 May 2020 19:56:18 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Jonathan.Cameron@Huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        sudeep.holla@arm.com, lukasz.luba@arm.com
Subject: Re: [PATCH v7 1/9] firmware: arm_scmi: Add notification
 protocol-registration
Message-ID: <20200513185618.GD17648@e119603-lin.cambridge.arm.com>
References: <20200504163855.54548-1-cristian.marussi@arm.com>
 <20200504163855.54548-2-cristian.marussi@arm.com>
 <20200506152550.GA21779@arm.com>
 <20200511220403.GB17648@e119603-lin.cambridge.arm.com>
 <20200513164612.GV21779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164612.GV21779@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:46:13PM +0100, Dave Martin wrote:
> On Mon, May 11, 2020 at 11:04:03PM +0100, Cristian Marussi wrote:
> > Hi Dave
> > 
> > thanks for the review first of all.
> > 
[snip]

> > 
> > First of all the enabled flag does not probably belong to this commit properly;
> > here is initialized but it is really fully used only in subsequent patches
> > (...so makes apparently little sense here... my bad...)
> > 
> > Anyway, in general SCMI protocols (beside notifications stuff) are initialized
> > as depicted above, BUT they are never deinitialized explicitly (there's no
> > equivalent scmi_protocol_deinit()) and also proto devices are never destroyed:
> > so there's no scmi_protocol_deregister_events() neither in this series, because
> > it would have been tricky to properly invoke it and would have not been consistent
> > with the original SCMI design.
> > 
> > On the other side since in protocol driver _remove() some general protos resources
> > are in fact freed anyway, for consistency I decided to free the devm notification
> > resources allocated with the above init() in scmi_notification_exit(): this should
> > happen only at system shutdown in fact when notification are no more of a concern.
> > 
> > So given there's no explicit deregister I had to ensure somehow that the wanna-be-freed
> > notif devm resources were safe to be released.
> > 
> > In this context the 'enabled' atomic flag is set to 0 @_exit to stop the dispatch of the
> > events (possibly still coming from the fw) from the ISR into the kfifo queues: once such
> > pkts flow is stopped I destroy_sync() (in a subsequent patch @_exit too) all the workqueues
> > fetching the events from the kfifos: this way I can be sure that all the notif resources
> > are no more used at all when I free all of them with devm_release() at the end.
> > 
> > All of this is an additional precaution against buggy fw not stopping sending events
> > even when asked to do so (by drivers when deregistering notif callbacks in their shutdown)
> > 
> > Give the above scenario on shutdown (which I never observed to tell the truth), and the fact
> > I'm freeing all devm res (including ni) at shutdown, it's now apparent ALSO that I cannot use
> > 'enabled' to keep stopped the flow in a safe way after its enclosing struct ni has been freed !
> > 
> > So I'll remove the 'enable' atomic_t too and rely equally on the bare !ni check to determine
> > if the notification are enabled and should be dispatched. So that in 
> > 
> > scmi_notify_init() {
> > 
> > 	if (unlikely(!ni))
> > 		return 0;     /// Stop notification dispatching from ISR
> > }
> > 
> > So ni and !ni will signify (initialized && enabled) or not.
> 
> Can this still race?

It should not race now with a few barriers...V8 is not posted still (and it's a
bit different from the above broken snippet of mine :D)

> 
> If teardown is impossible or useless, perhaps it would make sense not to
> have the code for it (?)
> 

Well yes in fact I was doubtful from the start if this rarely used code was
needed at all...I added just for consistency since some cleanup happens
elsewhere in SCMI...but...

> Do we expect SCMI related drivers to be buildable as modules?
> 

... talking with Sudeep these days around the content of this thread, it seems that
we should be able anyway to modularize cleanly most of the SCMI core due to the
Android GKI thing....so I'm going to review the whole SCMI core and notification
shutdown/cleanup process soon....still I'm not convinced if I'll do anything different
here for notif at that point...as of now I fixed as above the current series foro v8
following your feedback then we'll see if I'll change it more drastically....

> > Not really a short explanation...sorry
> 
> Sounds like it's not simple :)
> 
> What you've said sounds plausible -- I haven't found much time to think
> about it this week I'm afraid!
>

Thanks you for the feedback !

Cheers,

Cristian
 
> Cheers
> ---Dave
