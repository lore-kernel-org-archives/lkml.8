Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD799206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgFHRF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:05:58 -0400
Received: from foss.arm.com ([217.140.110.172]:55374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgFHRF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:05:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EDC01FB;
        Mon,  8 Jun 2020 10:05:57 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6DB3F73D;
        Mon,  8 Jun 2020 10:05:53 -0700 (PDT)
Date:   Mon, 8 Jun 2020 18:05:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, dave.martin@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 0/9] SCMI Notifications Core Support
Message-ID: <20200608170550.GE13622@bogus>
References: <20200520081118.54897-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520081118.54897-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Wed, May 20, 2020 at 09:11:09AM +0100, Cristian Marussi wrote:
> Hi all,
>
> this series wants to introduce SCMI Notification Support, built on top of
> the standard Kernel notification chain subsystem.
>
> At initialization time each SCMI Protocol takes care to register with the
> new SCMI notification core the set of its own events which it intends to
> support.
>
> Using the API exposed via scmi_handle.notify_ops a Kernel user can register
> its own notifier_t callback (via a notifier_block as usual) against any
> registered event as identified by the tuple:
>
> 		(proto_id, event_id, src_id)
>
> where src_id represents a generic source identifier which is protocol
> dependent like domain_id, performance_id, sensor_id and so forth.
> (users can anyway do NOT provide any src_id, and subscribe instead to ALL
>  the existing (if any) src_id sources for that proto_id/evt_id combination)
>
> Each of the above tuple-specified eventis will be served on its own
> dedicated blocking notification chain, dynamically allocated on-demand when
> at least one user has shown interest on that event.
>
> Upon a notification delivery all the users' registered notifier_t callbacks
> will be in turn invoked and fed with the event_id as @action param and a
> generated custom per-event struct _report as @data param.
> (as in include/linux/scmi_protocol.h)
>
> The final step of notification delivery via users' callback invocation is
> instead delegated to a pool of deferred workers (Kernel cmwq): each
> SCMI protocol has its own dedicated worker and dedicated queue to push
> events from the rx ISR to the worker.
>
> Based on scmi-next/for-next/scmi 5.7 [1], on top of:
>
> commit f7199cf48902 ("firmware: arm_scmi: Fix return error code in
> 		     smc_send_message")
>
> This series has been tested on JUNO with an experimental firmware only
> supporting Perf Notifications.
>

Thanks for working on this. Looks mostly OK. I have few minor comments
or queries.

--
Regards,
Sudeep
