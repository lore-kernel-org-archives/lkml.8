Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2559C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8372078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438942AbgDNLHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:07:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:55315 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438931AbgDNLHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:07:12 -0400
IronPort-SDR: UYGi80TwhA9fSDubrh1GgtNxXZngVhPTsuXqUhEyRd36L5SqDL3BZxVFHIQfPXFIyKt+tMBIK/
 LIGJYXm7inYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:07:09 -0700
IronPort-SDR: pA7/gJMubPfJMQ+e+plvninRb7LQT9IuPX6aKRV0HMneYUaN57/nWrJxnfeeFNVC9hvq+8bQLQ
 FC3QtUzAYLdQ==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="427025524"
Received: from mdoerbec-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:07:04 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     James Hilliard <james.hilliard1@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] component: Silence bind error on -EPROBE_DEFER
In-Reply-To: <20200411054106.25366-1-james.hilliard1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200411054106.25366-1-james.hilliard1@gmail.com>
Date:   Tue, 14 Apr 2020 14:07:01 +0300
Message-ID: <87lfmymilm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020, James Hilliard <james.hilliard1@gmail.com> wrote:
> If a component fails to bind due to -EPROBE_DEFER we should not log an
> error as this is not a real failure.
>
> Fixes:
> vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
> vc4-drm soc:gpu: master bind failed: -517

I'd think the probe defer is useful information anyway. Maybe just tone
down the severity and/or the message?

BR,
Jani.

>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/base/component.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index e97704104784..157c6c790578 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -256,7 +256,8 @@ static int try_to_bring_up_master(struct master *master,
>  	ret = master->ops->bind(master->dev);
>  	if (ret < 0) {
>  		devres_release_group(master->dev, NULL);
> -		dev_info(master->dev, "master bind failed: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_info(master->dev, "master bind failed: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -611,8 +612,10 @@ static int component_bind(struct component *component, struct master *master,
>  		devres_release_group(component->dev, NULL);
>  		devres_release_group(master->dev, NULL);
>  
> -		dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
> -			dev_name(component->dev), component->ops, ret);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
> +				dev_name(component->dev), component->ops, ret);
> +		}
>  	}
>  
>  	return ret;

-- 
Jani Nikula, Intel Open Source Graphics Center
