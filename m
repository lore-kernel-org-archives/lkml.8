Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DDF2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgFJIXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:23:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJIXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:23:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA28E1F1;
        Wed, 10 Jun 2020 01:23:23 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 014D63F6CF;
        Wed, 10 Jun 2020 01:23:18 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:23:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        arnd@arndb.de, Jassi Brar <jaswinder.singh@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix timeout value for send_message
Message-ID: <20200610082315.GB2689@bogus>
References: <20200607193023.52344-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607193023.52344-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 02:30:23PM -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> Currently scmi_do_xfer() submits a message to mailbox api and waits
> for an apparently very short time. This works if there are not many
> messages in the queue already. However, if many clients share a
> channel and/or each client submits many messages in a row, the

The recommendation in such scenarios is to use multiple channel.

> timeout value becomes too short and returns error even if the mailbox
> is working fine according to the load. The timeout occurs when the
> message is still in the api/queue awaiting its turn to ride the bus.
>
>  Fix this by increasing the timeout value enough (500ms?) so that it
> fails only if there is an actual problem in the transmission (like a
> lockup or crash).
>
> [If we want to capture a situation when the remote didn't
> respond within expected latency, then the timeout should not
> start here, but from tx_prepare callback ... just before the
> message physically gets on the channel]
>

The bottle neck may not be in the remote. It may be mailbox serialising
the requests even when it can parallelise.

> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/firmware/arm_scmi/driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index dbec767222e9..46ddafe7ffc0 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -303,7 +303,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  	}
>
>  	if (xfer->hdr.poll_completion) {
> -		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> +		ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
>

This is unacceptable delay for schedutil fast_switch. So no for this one.

>  		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
>
> @@ -313,7 +313,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  			ret = -ETIMEDOUT;
>  	} else {
>  		/* And we wait for the response. */
> -		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> +		timeout = msecs_to_jiffies(500);

In general, this hides issues in the remote. We are trying to move towards
tops 1ms for a request and with MBOX_QUEUE at 20, I see 20ms is more that
big enough. We have it set to 30ms now. 500ms is way too large and not
required IMO.

--
Regards,
Sudeep
