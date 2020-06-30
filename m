Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4557C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4F206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgF3QMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:12:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:5124 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgF3QMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:12:31 -0400
IronPort-SDR: UIqPCxq6wHPVjEuj910TMS8g4RQfdZVHzPHATPoR1MsIoWZ1v8emFJWUMv7Auevkwy3iCwKW9h
 TPCEuFrB0VOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133743023"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="133743023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 09:12:28 -0700
IronPort-SDR: b1ZIG90Ns5VTtFNFOdONDPYhuUUbk5FZg445d1fNc83SD7O7Kzd24S0rxeRyNkcIODClJ4eJmU
 bJAfO3zTYDtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="265155430"
Received: from unknown (HELO rzhang1-mobile) ([10.249.168.95])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 09:12:26 -0700
Message-ID: <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 00:12:25 +0800
In-Reply-To: <20200625144509.17918-4-daniel.lezcano@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <20200625144509.17918-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 16:45 +0200, Daniel Lezcano wrote:
> Initially the thermal framework had a very simple notification
> mechanism to send generic netlink messages to the userspace.
> 
> The notification function was never called from anywhere and the
> corresponding dead code was removed. It was probably a first attempt
> to introduce the netlink notification.
> 
> At LPC2018, the presentation "Linux thermal: User kernel interface",
> proposed to create the notifications to the userspace via a kfifo.
> 
> The advantage of the kfifo is the performance. It is usually used
> from
> a 1:1 communication channel where a driver captures data and send
> them
> as fast as possible to an userspace process.
> 
> The inconvenient is the process uses the notification channel
> exclusively, thus no other process is allowed to use the channel to
> get temperature or notifications.
> 
> The purpose of this series is to provide a fully netlink featured
> thermal management.
> 
> This patch is defining a generic netlink API to discover the current
> thermal setup, get events and temperature sampling. As any genetlink
> protocol, it can evolve and the versionning allows to keep the
> backward
> compatibility.
> 
> In order to not flood the user with a single channel data, there are
> two multicast channels, one for the temperature sampling when the
> thermal zone is updated and another one for the events, so the user
> can get the events only without the thermal zone temperature
> sampling. All these events are from the ones presented at the
> LPC2018.
> 
> Also, a list of commands to discover the thermal setup is given and
> can be extended on purpose.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Makefile          |   2 +-
>  drivers/thermal/thermal_core.h    |  19 +
>  drivers/thermal/thermal_netlink.c | 645
> ++++++++++++++++++++++++++++++
>  include/linux/thermal.h           |  12 -
>  include/uapi/linux/thermal.h      |  80 +++-
>  5 files changed, 738 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/thermal/thermal_netlink.c
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 0c8b84a09b9a..1bbf0805fb04 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_THERMAL)		+= thermal_sys.o
>  thermal_sys-y			+= thermal_core.o
> thermal_sysfs.o \
> -					thermal_helpers.o
> +					thermal_helpers.o
> thermal_netlink.o
>  
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index 7e8f45db6bbf..08eb03fe4f69 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -52,6 +52,25 @@ int for_each_thermal_governor(int (*cb)(struct
> thermal_governor *, void *),
>  
>  struct thermal_zone_device *thermal_zone_get_by_id(int id);
>  
> +/* Netlink notification function */
> +int thermal_notify_tz_create(int tz_id, const char *name);
> +int thermal_notify_tz_delete(int tz_id);

> +int thermal_notify_tz_enable(int tz_id);
> +int thermal_notify_tz_disable(int tz_id);

these two will be used after merging the mode enhancement patches from
Andrzej Pietrasiewicz, right?


> +int thermal_notify_tz_trip_down(int tz_id, int id);
> +int thermal_notify_tz_trip_up(int tz_id, int id);

> +int thermal_notify_tz_trip_delete(int tz_id, int id);
> +int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> +			       int temp, int hyst);

is there any case we need to use these two?

> +int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> +				  int temp, int hyst);
> +int thermal_notify_cdev_update(int cdev_id, int state);

This is used when the cdev cur_state is changed.
what about cases that cdev->max_state changes? I think we need an extra
event for it, right?
> 
> +int thermal_notify_cdev_add(int cdev_id, const char *name,
> +			    int min_state, int max_state);
> +int thermal_notify_cdev_delete(int cdev_id);

These two should be used in patch 5/5.

> +int thermal_notify_tz_gov_change(int tz_id, const char *name);
> +int thermal_genl_sampling_temp(int id, int temp);
> +

 struct thermal_attr {
>  	struct device_attribute attr;
>  	char name[THERMAL_NAME_LENGTH];
> diff --git a/drivers/thermal/thermal_netlink.c
> b/drivers/thermal/thermal_netlink.c
> new file mode 100644
> index 000000000000..a8d6a815a21d
> --- /dev/null
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -0,0 +1,645 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * Generic netlink for thermal management framework
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <net/genetlink.h>
> +#include <uapi/linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +static const struct genl_multicast_group thermal_genl_mcgrps[] = {
> +	{ .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
> +	{ .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
> +};
> +
> +static const struct nla_policy
> thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
> +	/* Thermal zone */
> +	[THERMAL_GENL_ATTR_TZ]			= { .type =
> NLA_NESTED },
> +	[THERMAL_GENL_ATTR_TZ_ID]		= { .type = NLA_U32 },
> +	[THERMAL_GENL_ATTR_TZ_TEMP]		= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_TZ_TRIP]		= { .type =
> NLA_NESTED },
> +	[THERMAL_GENL_ATTR_TZ_TRIP_ID]		= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]	= { .type = NLA_U32 },
> +	[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]	= { .type = NLA_U32 },
> +	[THERMAL_GENL_ATTR_TZ_TRIP_HYST]	= { .type = NLA_U32 },
> +	[THERMAL_GENL_ATTR_TZ_MODE]		= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT]	= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_TZ_NAME]		= { .type =
> NLA_STRING,
> +						    .len =
> THERMAL_NAME_LENGTH },
> +	/* Governor(s) */
> +	[THERMAL_GENL_ATTR_TZ_GOV]		= { .type =
> NLA_NESTED },
> +	[THERMAL_GENL_ATTR_TZ_GOV_NAME]		= { .type =
> NLA_STRING,
> +						    .len =
> THERMAL_NAME_LENGTH },
> +	/* Cooling devices */
> +	[THERMAL_GENL_ATTR_CDEV]		= { .type = NLA_NESTED },
> +	[THERMAL_GENL_ATTR_CDEV_ID]		= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]	= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]	= { .type = NLA_U32
> },
> +	[THERMAL_GENL_ATTR_CDEV_MIN_STATE]	= { .type = NLA_U32
> },

is there any case that min_state does not equal 0?

> +	[THERMAL_GENL_ATTR_CDEV_NAME]		= { .type =
> NLA_STRING,
> +						    .len =
> THERMAL_NAME_LENGTH },
> +};
> +

[...]
> +
> +static cb_t cmd_cb[] = {
> +	[THERMAL_GENL_CMD_TZ_GET]	= thermal_genl_cmd_tz_get,

> +	[THERMAL_GENL_CMD_TZ_GET_TRIP]	=
> thermal_genl_cmd_tz_get_trip,
> +	[THERMAL_GENL_CMD_TZ_GET_TEMP]	=
> thermal_genl_cmd_tz_get_temp,
> +	[THERMAL_GENL_CMD_TZ_GET_GOV]	=
> thermal_genl_cmd_tz_get_gov,

A dumb question, can we share the same command for the above three?
Say,
THERMAL_GENL_CMD_GET_ALL_TZ or THERMAL_GENL_CMD_GET_TZS returns the id
&& name of all the thermal zones.
THERMAL_GENL_CMD_GET_TZ returns general information of a specified
thermal zone, include trip points, governor and temperature. My
understanding is that all these information will be queried once, in
the very beginning, and then userpsace relies on the netlink events to
give updated information, right?

This could simplify the kernel code and also userspace a bit.

thanks,
rui


