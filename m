Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83909C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2332253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAWLCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:02:17 -0500
Received: from foss.arm.com ([217.140.110.172]:37772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgAWLCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:02:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96BE631B;
        Thu, 23 Jan 2020 03:02:16 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E150A3F6C4;
        Thu, 23 Jan 2020 03:02:15 -0800 (PST)
Subject: Re: [RFC PATCH 00/11] SCMI Notifications Support
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com
References: <20200120122333.46217-1-cristian.marussi@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <04de7f47-76c8-6250-3360-5a928cd3842c@arm.com>
Date:   Thu, 23 Jan 2020 11:02:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120122333.46217-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 20/01/2020 12:23, Cristian Marussi wrote:
> Hi all,
> 
> this series wants to introduce SCMI Notification Support, built on top of
> the standard Kernel notification chain subsystem.
> 
[snip]

> 
> Based on scmi-next [1], on top of:
> 
> commit 257d0e20ec4f ("include: trace: Add SCMI header with trace events")

Sorry but I've got this is wrong, the series is based in fact on top of the
very following commit on scmi-next [1]:

729d3530a504 drivers: firmware: scmi: Extend SCMI transport layer by trace events

Thanks Jim for reporting this.

Regards

Cristian

> 
> This series has been tested on JUNO with an experimental firmware only
> supporting Perf Notifications.
> 
> Any thoughts ?
> 
> Thanks
> 
> Cristian
> ----
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> 
> Cristian Marussi (8):
>   firmware: arm_scmi: Add core notifications support
>   firmware: arm_scmi: Add notifications anti-tampering
>   firmware: arm_scmi: Enable core notifications
>   firmware: arm_scmi: Add Power notifications support
>   firmware: arm_scmi: Add Perf notifications support
>   firmware: arm_scmi: Add Sensor notifications support
>   firmware: arm_scmi: Add Reset notifications support
>   firmware: arm_scmi: Add Base notifications support
> 
> Sudeep Holla (3):
>   firmware: arm_scmi: Add receive buffer support for notifications
>   firmware: arm_scmi: Update protocol commands and notification list
>   firmware: arm_scmi: Add support for notifications message processing
> 
>  drivers/firmware/arm_scmi/Makefile  |    2 +-
>  drivers/firmware/arm_scmi/base.c    |  132 ++++
>  drivers/firmware/arm_scmi/bus.c     |    3 +
>  drivers/firmware/arm_scmi/common.h  |    4 +
>  drivers/firmware/arm_scmi/driver.c  |  121 +++-
>  drivers/firmware/arm_scmi/notify.c  | 1047 +++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/notify.h  |   79 ++
>  drivers/firmware/arm_scmi/perf.c    |  167 ++++-
>  drivers/firmware/arm_scmi/power.c   |  161 +++-
>  drivers/firmware/arm_scmi/reset.c   |  126 +++-
>  drivers/firmware/arm_scmi/sensors.c |  105 ++-
>  include/linux/scmi_protocol.h       |   82 +++
>  12 files changed, 1991 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/firmware/arm_scmi/notify.c
>  create mode 100644 drivers/firmware/arm_scmi/notify.h
> 

