Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AEEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F71620722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGAHlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:41:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:8453 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgGAHlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:41:45 -0400
IronPort-SDR: +UcjXXmJDNP5MiNiFXDrA2H7sR1YRnqna3+2Q5oScNzTltRzeZ/gcnsqk1k3Q7OBeO6lC66Dw5
 v+wExmZjLndQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="164500568"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="164500568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 00:41:41 -0700
IronPort-SDR: rVcSInZhrUsHCDl2NJ5vd8cM+dsiOSVeH/3hm3lHBzxspj/ivNrFEaRQY2/xjpLqcjqHlPAAvC
 t45prp1INMOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="277687655"
Received: from yumao-mobl1.ccr.corp.intel.com ([10.255.29.220])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2020 00:41:39 -0700
Message-ID: <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 15:41:38 +0800
In-Reply-To: <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <20200625144509.17918-4-daniel.lezcano@linaro.org>
         <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
         <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

On Tue, 2020-06-30 at 20:32 +0200, Daniel Lezcano wrote:
> Hi Zhang,
> 
> thanks for taking the time to review
> 
> 
> On 30/06/2020 18:12, Zhang Rui wrote:
> 
> [ ... ]
> 
> > > +int thermal_notify_tz_enable(int tz_id);
> > > +int thermal_notify_tz_disable(int tz_id);
> > 
> > these two will be used after merging the mode enhancement patches
> > from
> > Andrzej Pietrasiewicz, right?
> 
> Yes, that is correct.
> 
> > > +int thermal_notify_tz_trip_down(int tz_id, int id);
> > > +int thermal_notify_tz_trip_up(int tz_id, int id);
> > > +int thermal_notify_tz_trip_delete(int tz_id, int id);
> > > +int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> > > +			       int temp, int hyst);
> > 
> > is there any case we need to use these two?
> 
> There is the initial proposal to add/del trip points via sysfs which
> is
> not merged because of no comments and the presentation from Srinivas
> giving the 'add' and 'del' notification description, so I assumed the
> feature would be added soon.
> 
> These functions are here ready to be connected to the core code. If
> anyone is planning to implement add/del trip point, he won't have to
> implement these two notifications as they will be ready to be called.
> 
Then I'd prefer we only introduce the events that are used or will be
used soon, like the tz disable/enable, to avoid some potential dead
code.
We can easily add more events when they are needed.

Srinivas, do you have plan to use the trip add/delete events?

> > > +int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> > > +				  int temp, int hyst);
> > > +int thermal_notify_cdev_update(int cdev_id, int state);
> > 
> > This is used when the cdev cur_state is changed.
> > what about cases that cdev->max_state changes? I think we need an
> > extra
> > event for it, right?
> 
> Sure, I can add:
> 
> int thermal_notify_cdev_change(...)

thermal_notify_cdev_change() and thermal_notify_cdev_update() looks
confusing to me.
Can we use thermal_notify_cdev_update_cur() and
thermal_notify_cdev_update_max()?
Or can we use one event, with updated cur_state and max_state?

> > > +int thermal_notify_cdev_add(int cdev_id, const char *name,
> > > +			    int min_state, int max_state);
> > > +int thermal_notify_cdev_delete(int cdev_id);
> > 
> > These two should be used in patch 5/5.
> 
> Sure.
> 
> > > +int thermal_notify_tz_gov_change(int tz_id, const char *name);
> > > +int thermal_genl_sampling_temp(int id, int temp);
> > > +
> > 
> >  struct thermal_attr {
> > >  	struct device_attribute attr;
> > >  	char name[THERMAL_NAME_LENGTH];
> > > diff --git a/drivers/thermal/thermal_netlink.c
> > > b/drivers/thermal/thermal_netlink.c
> > > new file mode 100644
> > > index 000000000000..a8d6a815a21d
> > > --- /dev/null
> > > +++ b/drivers/thermal/thermal_netlink.c
> > > @@ -0,0 +1,645 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright 2020 Linaro Limited
> > > + *
> > > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > + *
> > > + * Generic netlink for thermal management framework
> > > + */
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <net/genetlink.h>
> > > +#include <uapi/linux/thermal.h>
> > > +
> > > +#include "thermal_core.h"
> > > +
> > > +static const struct genl_multicast_group thermal_genl_mcgrps[] =
> > > {
> > > +	{ .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
> > > +	{ .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
> > > +};
> > > +
> > > +static const struct nla_policy
> > > thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
> > > +	/* Thermal zone */
> > > +	[THERMAL_GENL_ATTR_TZ]			= { .type =
> > > NLA_NESTED },
> > > +	[THERMAL_GENL_ATTR_TZ_ID]		= { .type = NLA_U32 },
> > > +	[THERMAL_GENL_ATTR_TZ_TEMP]		= { .type = NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_TZ_TRIP]		= { .type =
> > > NLA_NESTED },
> > > +	[THERMAL_GENL_ATTR_TZ_TRIP_ID]		= { .type =
> > > NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]	= { .type = NLA_U32 },
> > > +	[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]	= { .type = NLA_U32 },
> > > +	[THERMAL_GENL_ATTR_TZ_TRIP_HYST]	= { .type = NLA_U32 },
> > > +	[THERMAL_GENL_ATTR_TZ_MODE]		= { .type = NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT]	= { .type = NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_TZ_NAME]		= { .type =
> > > NLA_STRING,
> > > +						    .len =
> > > THERMAL_NAME_LENGTH },
> > > +	/* Governor(s) */
> > > +	[THERMAL_GENL_ATTR_TZ_GOV]		= { .type =
> > > NLA_NESTED },
> > > +	[THERMAL_GENL_ATTR_TZ_GOV_NAME]		= { .type =
> > > NLA_STRING,
> > > +						    .len =
> > > THERMAL_NAME_LENGTH },
> > > +	/* Cooling devices */
> > > +	[THERMAL_GENL_ATTR_CDEV]		= { .type = NLA_NESTED },
> > > +	[THERMAL_GENL_ATTR_CDEV_ID]		= { .type = NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]	= { .type = NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]	= { .type = NLA_U32
> > > },
> > > +	[THERMAL_GENL_ATTR_CDEV_MIN_STATE]	= { .type = NLA_U32
> > > },
> > 
> > is there any case that min_state does not equal 0?
> 
> You are right, there is no min state for a cooling device, only for
> the
> instances in the thermal zones. I will fix that.
> 
> > > +	[THERMAL_GENL_ATTR_CDEV_NAME]		= { .type =
> > > NLA_STRING,
> > > +						    .len =
> > > THERMAL_NAME_LENGTH },
> > > +};
> > > +
> > 
> > [...]
> > > +
> > > +static cb_t cmd_cb[] = {
> > > +	[THERMAL_GENL_CMD_TZ_GET]	= thermal_genl_cmd_tz_get,
> > > +	[THERMAL_GENL_CMD_TZ_GET_TRIP]	=
> > > thermal_genl_cmd_tz_get_trip,
> > > +	[THERMAL_GENL_CMD_TZ_GET_TEMP]	=
> > > thermal_genl_cmd_tz_get_temp,
> > > +	[THERMAL_GENL_CMD_TZ_GET_GOV]	=
> > > thermal_genl_cmd_tz_get_gov,
> > 
> > A dumb question, can we share the same command for the above three?
> > Say,
> > THERMAL_GENL_CMD_GET_ALL_TZ or THERMAL_GENL_CMD_GET_TZS returns the
> > id
> > && name of all the thermal zones.
> > THERMAL_GENL_CMD_GET_TZ returns general information of a specified
> > thermal zone, include trip points, governor and temperature. My
> > understanding is that all these information will be queried once,
> > in
> > the very beginning, and then userpsace relies on the netlink events
> > to
> > give updated information, right?
> > 
> > This could simplify the kernel code and also userspace a bit.
> 
> Actually the userspace still need a 'get temp' or 'get trip'
> commands.
> 
> get temp : Get the temperature at any time, like reading the sysfs
> temperature
> 
> get trip : Get the trip point information when a trip event happens,
> no
> need to get a full discovery of the thermal zones before.
> 
> If I send a bulk message containing all the thermal zones, their
> trips
> point, the governors and the cooling devices, that will force the
> userspace to deal with multiple level of nested arrays. With netlinks
> that makes the code really more complicated and prone to errors.
> 
> With this approach, if the userspace is interested only on "gpu", it
> can
> get the thermal zone id when getting all the thermal zones <id, name>
> and then ask for the information it is interested in.
> 
> Well I thought that is be more flexible.

Then I'm totally okay with this implementation. Thanks for the
explanation.

thanks,
rui
> 
> 
> 
> 
> 

