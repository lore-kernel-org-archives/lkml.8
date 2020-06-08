Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C54CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E206D2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgFHRD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:03:56 -0400
Received: from foss.arm.com ([217.140.110.172]:55328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbgFHRDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:03:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24051FB;
        Mon,  8 Jun 2020 10:03:52 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1C43F73D;
        Mon,  8 Jun 2020 10:03:49 -0700 (PDT)
Date:   Mon, 8 Jun 2020 18:03:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, dave.martin@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 3/9] firmware: arm_scmi: Add notification dispatch and
 delivery
Message-ID: <20200608170346.GD13622@bogus>
References: <20200520081118.54897-1-cristian.marussi@arm.com>
 <20200520081118.54897-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520081118.54897-4-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:11:12AM +0100, Cristian Marussi wrote:
> Add core SCMI Notifications dispatch and delivery support logic which is
> able, at first, to dispatch well-known received events from the RX ISR to
> the dedicated deferred worker, and then, from there, to final deliver the
> events to the registered users' callbacks.
> 
> Dispatch and delivery is just added here, still not enabled.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/notify.c | 354 ++++++++++++++++++++++++++++-
>  drivers/firmware/arm_scmi/notify.h |  10 +
>  2 files changed, 362 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 7cf61dbe2a8e..d582f71fde5b 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c

[...]

> @@ -1085,6 +1422,12 @@ int scmi_notification_init(struct scmi_handle *handle)
>  	ni->gid = gid;
>  	ni->handle = handle;
>  
> +	ni->notify_wq = alloc_workqueue("scmi_notify",
> +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> +					0);

What's the use of WQ_SYSFS for SCMI notifications ? Do we need it ?

-- 
Regards,
Sudeep
