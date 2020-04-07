Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F4C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5789E20644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDGJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:36:35 -0400
Received: from foss.arm.com ([217.140.110.172]:54096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGJgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:36:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59DC830E;
        Tue,  7 Apr 2020 02:36:34 -0700 (PDT)
Received: from bogus (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F98A3F73D;
        Tue,  7 Apr 2020 02:36:32 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:36:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 01/13] firmware: arm_scmi: Add receive buffer support
 for notifications
Message-ID: <20200407093629.GB28444@bogus>
References: <20200327143438.5382-1-cristian.marussi@arm.com>
 <20200327143438.5382-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327143438.5382-2-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 02:34:26PM +0000, Cristian Marussi wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
>
> With all the plumbing in place, let's just add the separate dedicated
> receive buffers to handle notifications that can arrive asynchronously
> from the platform firmware to OS.
>
> Also add one check to see if the platform supports any receive channels
> before allocating the receive buffers: since those buffers are optionally
> supported though, the whole xfer initialization is also postponed to be
> able to check for their existence in advance.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> [Changed parameters in __scmi_xfer_info_init()]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

[...]

> @@ -566,6 +568,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>  	return 0;
>  }
>
> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +{
> +	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
> +
> +	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))

Theoretically, this could be bit tricky if we need to support platforms
without Rx channel for base protocol but may have Rx for some specific
protocols. But we have other problems too, so we can address that if
required in future.

Anyways, the first 4 patches are simple and quite independent from the
notification part. I will queue them as is and you can drop if you respin
the series.

I may need some time to go through the series completely and I am trying
to comment as I go through individual patches as I may get answers to
my own questions as I review.

--
Regards,
Sudeep
