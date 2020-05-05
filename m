Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA06206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgEECIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:08:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgEECIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:08:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5F59D0614359400BC61;
        Tue,  5 May 2020 10:08:20 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 10:08:19 +0800
Subject: Re: [PATCH] firmware: arm_sdei: remove unused interfaces
To:     James Morse <james.morse@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200504164224.2842960-1-hch@lst.de>
 <7c127e49-b1c6-c7ac-69bf-9fc0a6dba4c4@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <6d0adc02-bcd8-2217-c145-d609528fbe77@huawei.com>
Date:   Tue, 5 May 2020 10:08:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7c127e49-b1c6-c7ac-69bf-9fc0a6dba4c4@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2020/5/5 1:14, James Morse wrote:
> Hi Christoph,
> 
> (CC: +Xiongfeng)
> 
> Thanks for the reminder - I was just searching for who was using this.

Thanks for CC me. We do have a driver that are using it.

> 
> On 04/05/2020 17:42, Christoph Hellwig wrote:
>> The export symbols to register/unregister and enable/disable events
>> aren't ever used outside of arm_sdei.c, so mark them static.
> 
> Xiongfeng, you have drivers using this, could they be posted upstream. Or can we stop
> exporting these?

It's the SDEI Wathchdog which is used for hardlockup detection. But I wasn't
able to push it upstream because we have Pseudo-NMI in mainline.

> 
> 
> (they were originally added for the GHES RAS thing, but by the time it was all merged
> upstream, it wasn't possible to build it as a module)

The SDEI Watchdog driver also can't be built as a module. We still need to
modify the origin kernel. So I think this patch doesn't affect me. Thanks for CC me.

Thanks,
Xiongfeng

> 
> Thanks,
> 
> James
> 
> 
>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>> index 334c8be0c11fb..bdd6461647d74 100644
>> --- a/drivers/firmware/arm_sdei.c
>> +++ b/drivers/firmware/arm_sdei.c
>> @@ -400,7 +400,7 @@ static void _local_event_enable(void *data)
>>  	sdei_cross_call_return(arg, err);
>>  }
>>  
>> -int sdei_event_enable(u32 event_num)
>> +static int sdei_event_enable(u32 event_num)
>>  {
>>  	int err = -EINVAL;
>>  	struct sdei_event *event;
>> @@ -429,7 +429,6 @@ int sdei_event_enable(u32 event_num)
>>  
>>  	return err;
>>  }
>> -EXPORT_SYMBOL(sdei_event_enable);
>>  
>>  static int sdei_api_event_disable(u32 event_num)
>>  {
>> @@ -447,7 +446,7 @@ static void _ipi_event_disable(void *data)
>>  	sdei_cross_call_return(arg, err);
>>  }
>>  
>> -int sdei_event_disable(u32 event_num)
>> +static int sdei_event_disable(u32 event_num)
>>  {
>>  	int err = -EINVAL;
>>  	struct sdei_event *event;
>> @@ -471,7 +470,6 @@ int sdei_event_disable(u32 event_num)
>>  
>>  	return err;
>>  }
>> -EXPORT_SYMBOL(sdei_event_disable);
>>  
>>  static int sdei_api_event_unregister(u32 event_num)
>>  {
>> @@ -502,7 +500,7 @@ static int _sdei_event_unregister(struct sdei_event *event)
>>  	return sdei_do_cross_call(_local_event_unregister, event);
>>  }
>>  
>> -int sdei_event_unregister(u32 event_num)
>> +static int sdei_event_unregister(u32 event_num)
>>  {
>>  	int err;
>>  	struct sdei_event *event;
>> @@ -533,7 +531,6 @@ int sdei_event_unregister(u32 event_num)
>>  
>>  	return err;
>>  }
>> -EXPORT_SYMBOL(sdei_event_unregister);
>>  
>>  /*
>>   * unregister events, but don't destroy them as they are re-registered by
>> @@ -603,7 +600,8 @@ static int _sdei_event_register(struct sdei_event *event)
>>  	return err;
>>  }
>>  
>> -int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
>> +static int sdei_event_register(u32 event_num, sdei_event_callback *cb,
>> +		void *arg)
>>  {
>>  	int err;
>>  	struct sdei_event *event;
>> @@ -643,7 +641,6 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
>>  
>>  	return err;
>>  }
>> -EXPORT_SYMBOL(sdei_event_register);
>>  
>>  static int sdei_reregister_event_llocked(struct sdei_event *event)
>>  {
>> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
>> index 0a241c5c911d8..5f9fb1d95d515 100644
>> --- a/include/linux/arm_sdei.h
>> +++ b/include/linux/arm_sdei.h
>> @@ -22,21 +22,6 @@
>>   */
>>  typedef int (sdei_event_callback)(u32 event, struct pt_regs *regs, void *arg);
>>  
>> -/*
>> - * Register your callback to claim an event. The event must be described
>> - * by firmware.
>> - */
>> -int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg);
>> -
>> -/*
>> - * Calls to sdei_event_unregister() may return EINPROGRESS. Keep calling
>> - * it until it succeeds.
>> - */
>> -int sdei_event_unregister(u32 event_num);
>> -
>> -int sdei_event_enable(u32 event_num);
>> -int sdei_event_disable(u32 event_num);
>> -
>>  /* GHES register/unregister helpers */
>>  int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
>>  		       sdei_event_callback *critical_cb);
>>
> 
> 
> .
> 

