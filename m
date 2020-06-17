Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70D3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04832088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFQXbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:31:13 -0400
Received: from foss.arm.com ([217.140.110.172]:37446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQXbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:31:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E77631042;
        Wed, 17 Jun 2020 16:31:12 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6ACF3F71F;
        Wed, 17 Jun 2020 16:31:11 -0700 (PDT)
Date:   Thu, 18 Jun 2020 00:31:05 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, dave.martin@arm.com,
        cristian.marussi@arm.com
Subject: Re: [PATCH v8 3/9] firmware: arm_scmi: Add notification dispatch and
 delivery
Message-ID: <20200617233105.GB9236@e119603-lin.cambridge.arm.com>
References: <20200520081118.54897-1-cristian.marussi@arm.com>
 <20200520081118.54897-4-cristian.marussi@arm.com>
 <20200608170346.GD13622@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608170346.GD13622@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:03:46PM +0100, Sudeep Holla wrote:
> On Wed, May 20, 2020 at 09:11:12AM +0100, Cristian Marussi wrote:
> > Add core SCMI Notifications dispatch and delivery support logic which is
> > able, at first, to dispatch well-known received events from the RX ISR to
> > the dedicated deferred worker, and then, from there, to final deliver the
> > events to the registered users' callbacks.
> > 
> > Dispatch and delivery is just added here, still not enabled.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/notify.c | 354 ++++++++++++++++++++++++++++-
> >  drivers/firmware/arm_scmi/notify.h |  10 +
> >  2 files changed, 362 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> > index 7cf61dbe2a8e..d582f71fde5b 100644
> > --- a/drivers/firmware/arm_scmi/notify.c
> > +++ b/drivers/firmware/arm_scmi/notify.c
> 
> [...]
> 
> > @@ -1085,6 +1422,12 @@ int scmi_notification_init(struct scmi_handle *handle)
> >  	ni->gid = gid;
> >  	ni->handle = handle;
> >  
> > +	ni->notify_wq = alloc_workqueue("scmi_notify",
> > +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> > +					0);
> 
> What's the use of WQ_SYSFS for SCMI notifications ? Do we need it ?
> 

Lukasz asked for it, when we were talking about workqueues' priorities configurability.
(not implemented in this series)

Thanks

Cristian
> -- 
> Regards,
> Sudeep
