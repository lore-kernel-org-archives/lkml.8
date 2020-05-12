Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A544CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EA5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgELRAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:00:24 -0400
Received: from foss.arm.com ([217.140.110.172]:58704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgELRAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:00:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88794D6E;
        Tue, 12 May 2020 10:00:23 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [10.57.61.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FE453F305;
        Tue, 12 May 2020 10:00:22 -0700 (PDT)
Date:   Tue, 12 May 2020 18:00:20 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan.Cameron@Huawei.com, james.quinlan@broadcom.com,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v7 1/9] firmware: arm_scmi: Add notification
 protocol-registration
Message-ID: <20200512170020.GC17648@e119603-lin.cambridge.arm.com>
References: <20200504163855.54548-1-cristian.marussi@arm.com>
 <20200504163855.54548-2-cristian.marussi@arm.com>
 <20200506152550.GA21779@arm.com>
 <20200511220403.GB17648@e119603-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511220403.GB17648@e119603-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:04:03PM +0100, Cristian Marussi wrote:
> Hi Dave
> 
> thanks for the review first of all.
> 
[snip]

> > I'm not sure about scmi_notification_exit() (see below).
[snip]
> > > +/**
> > > + * scmi_notification_exit()  - Shutdown and clean Notification core
> > > + * @handle: The handle identifying the platform instance to shutdown
> > > + */
> > > +void scmi_notification_exit(struct scmi_handle *handle)
> > > +{
> > > +	struct scmi_notify_instance *ni = handle->notify_priv;
> > > +
> > > +	if (unlikely(!ni || !atomic_read(&ni->initialized)))
> > > +		return;
> > > +
> > > +	atomic_set(&ni->enabled, 0);
> > > +	/* Ensure atomic values are updated */
> > > +	smp_mb__after_atomic();
> > 
> > If users can race with this, we're dead: the atomic by itself doesn't
> > ensure that handle is not in use once we arrive here.  Should this
> > be a refcount instead?
> > 
> > If users can't race with this, we probably don't protection here.
> > 
> > 
> > I may be misunderstanding what this code is doing...
> > 
> 
> First of all the enabled flag does not probably belong to this commit properly;
> here is initialized but it is really fully used only in subsequent patches
> (...so makes apparently little sense here... my bad...)
> 
> Anyway, in general SCMI protocols (beside notifications stuff) are initialized
> as depicted above, BUT they are never deinitialized explicitly (there's no
> equivalent scmi_protocol_deinit()) and also proto devices are never destroyed:
> so there's no scmi_protocol_deregister_events() neither in this series, because
> it would have been tricky to properly invoke it and would have not been consistent
> with the original SCMI design.
> 
> On the other side since in protocol driver _remove() some general protos resources
> are in fact freed anyway, for consistency I decided to free the devm notification
> resources allocated with the above init() in scmi_notification_exit(): this should
> happen only at system shutdown in fact when notification are no more of a concern.
> 
> So given there's no explicit deregister I had to ensure somehow that the wanna-be-freed
> notif devm resources were safe to be released.
> 
> In this context the 'enabled' atomic flag is set to 0 @_exit to stop the dispatch of the
> events (possibly still coming from the fw) from the ISR into the kfifo queues: once such
> pkts flow is stopped I destroy_sync() (in a subsequent patch @_exit too) all the workqueues
> fetching the events from the kfifos: this way I can be sure that all the notif resources
> are no more used at all when I free all of them with devm_release() at the end.
> 
> All of this is an additional precaution against buggy fw not stopping sending events
> even when asked to do so (by drivers when deregistering notif callbacks in their shutdown)
> 
> Give the above scenario on shutdown (which I never observed to tell the truth), and the fact
> I'm freeing all devm res (including ni) at shutdown, it's now apparent ALSO that I cannot use
> 'enabled' to keep stopped the flow in a safe way after its enclosing struct ni has been freed !
> 
> So I'll remove the 'enable' atomic_t too and rely equally on the bare !ni check to determine
> if the notification are enabled and should be dispatched. So that in 
> 

...replying to my early self here (o_O)....I'd add that I've tested the above changes (removing
initialized and enabled) triggering this _exit path by brutally unbinding the platform protocol
driver and I can see the notifications flow stop and the queues emptied as expected without
tragedy...the SCMI stack in general is not so happy though at that point, since it is not even
supposed to be unloaded ever in fact...I wonder if this limit condition(unbind of a core SCMI
driver which is not even modularizable in Kconfig) makes sense to be tested at all...
(if not for testing this specific code path...)

Cheers

Cristian

