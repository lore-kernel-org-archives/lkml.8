Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666BCC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B97F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgAPByO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:54:14 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39969 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729949AbgAPByO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:54:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tnr.RhS_1579139650;
Received: from 30.5.115.118(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Tnr.RhS_1579139650)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 09:54:11 +0800
Subject: Re: [PATCH 1/3] firmware: arm_sdei: fix possible deadlock
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <a00c53ef-aed4-ac26-6cfe-8d4cc6daa7f8@linux.alibaba.com>
Date:   Thu, 16 Jan 2020 09:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Sorry for the late reply, this problem was found by code review.


Thanks,

luanshi

ÔÚ 2019/12/23 22:22, luanshi Ð´µÀ:
> From: Liguang Zhang <zhangliguang@linux.alibaba.com>
>
> We call sdei_reregister_event() with sdei_list_lock held but
> _sdei_event_register() and sdei_event_destroy() also acquires
> sdei_list_lock thus creating A-A deadlock.
>
> Fixes: da351827240e ("firmware: arm_sdei: Add support for CPU and system power states")
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>   drivers/firmware/arm_sdei.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a479023..b122927 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -651,20 +651,19 @@ static int sdei_reregister_event(struct sdei_event *event)
>   
>   	lockdep_assert_held(&sdei_events_lock);
>   
> -	err = _sdei_event_register(event);
> +	err = sdei_api_event_register(event->event_num,
> +				       sdei_entry_point,
> +				       event->registered,
> +				       SDEI_EVENT_REGISTER_RM_ANY, 0);
>   	if (err) {
>   		pr_err("Failed to re-register event %u\n", event->event_num);
> -		sdei_event_destroy(event);
> +		list_del(&event->list);
> +		kfree(event->registered);
>   		return err;
>   	}
>   
> -	if (event->reenable) {
> -		if (event->type == SDEI_EVENT_TYPE_SHARED)
> -			err = sdei_api_event_enable(event->event_num);
> -		else
> -			err = sdei_do_cross_call(_local_event_enable, event);
> -	}
> -
> +	if (event->reenable)
> +		err = sdei_api_event_enable(event->event_num);
>   	if (err)
>   		pr_err("Failed to re-enable event %u\n", event->event_num);
>   
