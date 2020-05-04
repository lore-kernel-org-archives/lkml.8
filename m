Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A065BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894E221841
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgEDROn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:14:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbgEDROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:14:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 506D2101E;
        Mon,  4 May 2020 10:14:39 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B128A3F68F;
        Mon,  4 May 2020 10:14:38 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_sdei: remove unused interfaces
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangxiongfeng2@huawei.com
References: <20200504164224.2842960-1-hch@lst.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <7c127e49-b1c6-c7ac-69bf-9fc0a6dba4c4@arm.com>
Date:   Mon, 4 May 2020 18:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200504164224.2842960-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

(CC: +Xiongfeng)

Thanks for the reminder - I was just searching for who was using this.

On 04/05/2020 17:42, Christoph Hellwig wrote:
> The export symbols to register/unregister and enable/disable events
> aren't ever used outside of arm_sdei.c, so mark them static.

Xiongfeng, you have drivers using this, could they be posted upstream. Or can we stop
exporting these?


(they were originally added for the GHES RAS thing, but by the time it was all merged
upstream, it wasn't possible to build it as a module)

Thanks,

James


> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 334c8be0c11fb..bdd6461647d74 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -400,7 +400,7 @@ static void _local_event_enable(void *data)
>  	sdei_cross_call_return(arg, err);
>  }
>  
> -int sdei_event_enable(u32 event_num)
> +static int sdei_event_enable(u32 event_num)
>  {
>  	int err = -EINVAL;
>  	struct sdei_event *event;
> @@ -429,7 +429,6 @@ int sdei_event_enable(u32 event_num)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL(sdei_event_enable);
>  
>  static int sdei_api_event_disable(u32 event_num)
>  {
> @@ -447,7 +446,7 @@ static void _ipi_event_disable(void *data)
>  	sdei_cross_call_return(arg, err);
>  }
>  
> -int sdei_event_disable(u32 event_num)
> +static int sdei_event_disable(u32 event_num)
>  {
>  	int err = -EINVAL;
>  	struct sdei_event *event;
> @@ -471,7 +470,6 @@ int sdei_event_disable(u32 event_num)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL(sdei_event_disable);
>  
>  static int sdei_api_event_unregister(u32 event_num)
>  {
> @@ -502,7 +500,7 @@ static int _sdei_event_unregister(struct sdei_event *event)
>  	return sdei_do_cross_call(_local_event_unregister, event);
>  }
>  
> -int sdei_event_unregister(u32 event_num)
> +static int sdei_event_unregister(u32 event_num)
>  {
>  	int err;
>  	struct sdei_event *event;
> @@ -533,7 +531,6 @@ int sdei_event_unregister(u32 event_num)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL(sdei_event_unregister);
>  
>  /*
>   * unregister events, but don't destroy them as they are re-registered by
> @@ -603,7 +600,8 @@ static int _sdei_event_register(struct sdei_event *event)
>  	return err;
>  }
>  
> -int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
> +static int sdei_event_register(u32 event_num, sdei_event_callback *cb,
> +		void *arg)
>  {
>  	int err;
>  	struct sdei_event *event;
> @@ -643,7 +641,6 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL(sdei_event_register);
>  
>  static int sdei_reregister_event_llocked(struct sdei_event *event)
>  {
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index 0a241c5c911d8..5f9fb1d95d515 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -22,21 +22,6 @@
>   */
>  typedef int (sdei_event_callback)(u32 event, struct pt_regs *regs, void *arg);
>  
> -/*
> - * Register your callback to claim an event. The event must be described
> - * by firmware.
> - */
> -int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg);
> -
> -/*
> - * Calls to sdei_event_unregister() may return EINPROGRESS. Keep calling
> - * it until it succeeds.
> - */
> -int sdei_event_unregister(u32 event_num);
> -
> -int sdei_event_enable(u32 event_num);
> -int sdei_event_disable(u32 event_num);
> -
>  /* GHES register/unregister helpers */
>  int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
>  		       sdei_event_callback *critical_cb);
> 

