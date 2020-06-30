Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C2EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51F520724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389331AbgF3PQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:34594 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389258AbgF3PQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:08 -0400
IronPort-SDR: WNEGCpR/agnoag6/Y+FoTMKavP6WaxTzAtvBpPlQsFROK8/i1HQELcFsPcvG4AyW9njAIESuYZ
 gJ8R0JZqh2ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="231134361"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="231134361"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 08:16:08 -0700
IronPort-SDR: Eyv4c6Y7NX6ZQpF7UE+I1/3NImbeBkTyo3NxSskj3zSdNm7FmyTW+E2DrPYwibxICFo69BAXs6
 1BpDWbisxE9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="281268035"
Received: from unknown (HELO rzhang1-mobile) ([10.249.168.95])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2020 08:16:07 -0700
Message-ID: <134103f124f45f100786c47b3f6fff52cedc5ed4.camel@intel.com>
Subject: Re: [PATCH v2 2/5] thermal: core: Get thermal zone by id
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Jun 2020 23:16:06 +0800
In-Reply-To: <20200625144509.17918-2-daniel.lezcano@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <20200625144509.17918-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 16:45 +0200, Daniel Lezcano wrote:
> The next patch will introduce the generic netlink protocol to handle
> events, sampling and command from the thermal framework. In order to
> deal with the thermal zone, it uses its unique identifier to
> characterize it in the message. Passing an integer is more efficient
> than passing an entire string.
> 
> This change provides a function returning back a thermal zone pointer
> corresponding to the identifier passed as parameter.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 14 ++++++++++++++
>  drivers/thermal/thermal_core.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index e2f8d2550ecd..58c95aeafb7f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -662,6 +662,20 @@ int for_each_thermal_zone(int (*cb)(struct
> thermal_zone_device *, void *),
>  	return ret;
>  }
>  
> +struct thermal_zone_device *thermal_zone_get_by_id(int id)
> +{
> +	struct thermal_zone_device *tz = NULL;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(tz, &thermal_tz_list, node) {
> +		if (tz->id == id)
> +			break;
> +	}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	return tz;
> +}
> +

IMO, this one, as well as thermal_zone_get_zone_by_name(), should all
be in thermal_helper.c

thanks,
rui
>  void thermal_zone_device_unbind_exception(struct thermal_zone_device
> *tz,
>  					  const char *cdev_type, size_t
> size)
>  {
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index bb8f8aee79eb..7e8f45db6bbf 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int
> (*cb)(struct thermal_cooling_device *,
>  int for_each_thermal_governor(int (*cb)(struct thermal_governor *,
> void *),
>  			      void *thermal_governor);
>  
> +struct thermal_zone_device *thermal_zone_get_by_id(int id);
> +
>  struct thermal_attr {
>  	struct device_attribute attr;
>  	char name[THERMAL_NAME_LENGTH];

