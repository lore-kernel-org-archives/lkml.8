Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE129C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFD6206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgBUNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:25:17 -0500
Received: from foss.arm.com ([217.140.110.172]:39280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgBUNZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:25:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD74730E;
        Fri, 21 Feb 2020 05:25:16 -0800 (PST)
Received: from [10.37.12.243] (unknown [10.37.12.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315133F703;
        Fri, 21 Feb 2020 05:25:14 -0800 (PST)
Subject: Re: [RFC PATCH v2 07/13] firmware: arm_scmi: Add notification
 dispatch and delivery
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com
References: <20200214153535.32046-1-cristian.marussi@arm.com>
 <20200214153535.32046-8-cristian.marussi@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e45e87e2-aaaf-c35b-b864-c080fd6e0ba6@arm.com>
Date:   Fri, 21 Feb 2020 13:25:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200214153535.32046-8-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

I didn't want to jump into your discussion with Jim in other broader
thread with this small thought, so I added a comment below.

On 2/14/20 3:35 PM, Cristian Marussi wrote:
> Add core SCMI Notifications dispatch and delivery support logic which is
> able, at first, to dispatch well-known received events from the RX ISR to
> the dedicated deferred worker, and then, from there, to final deliver the
> events to the registered users' callbacks.
> 
> Dispatch and delivery is just added here, still not enabled.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> V1 --> V2
> - splitted out of V1 patch 04
> - moved from IDR maps to real HashTables to store event_handlers
> - simplified delivery logic
> ---
>   drivers/firmware/arm_scmi/notify.c | 242 ++++++++++++++++++++++++++++-
>   drivers/firmware/arm_scmi/notify.h |  22 +++
>   2 files changed, 262 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 1339b6de0a4c..c2341c5304cf 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -48,13 +48,44 @@
>    * particular event coming only from a well defined source (like CPU vs GPU).
>    * When the source is not specified the user callback will be registered for
>    * all existing sources for that event (if any).

[snip]

>   
> @@ -840,6 +1071,11 @@ static struct scmi_notify_ops notify_ops = {
>    */
>   int scmi_notification_init(struct scmi_handle *handle)
>   {
> +	scmi_notify_wq = alloc_workqueue("scmi_notify",
> +					 WQ_UNBOUND | WQ_FREEZABLE, 0);

I think it might limit some platforms. It depends on their workload.
If they have some high priority workloads which rely on this mechanisms,
they might need a RT task here. The workqueues would be scheduled in
CFS, so it depends on workload in there (we might even see 10s ms delays
in scheduling-up them). If we use RT we would grab the CPU from CFS.

It would be good if it is a customization option: which mechanism
to use based on some a parameter. Then we could create:
a) workqueue with the flags above
b) workqueue with WQ_HIGHPRI (limited by minimum nice)
c) kthread_create_worker() with RT/DL/FIFO sched policy
   (with also a parameterized priority)

In default clients might use a) but when they want to tune their
platform, they might change only a parameter in their scmi code,
not maintaining a patch for the RT function out of tree.

Regards,
Lukasz

