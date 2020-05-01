Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FCDC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A0E20836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgEAQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:39:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:62857 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgEAQjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:39:04 -0400
IronPort-SDR: Y7J3bu9ocWgXIqCSfEeBwOW15jgzYc+o8/HSqFKMenQOUiILZI599PYUkeJrRBewuoUPHUPmbt
 N9ahBaQ8LR8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 09:39:04 -0700
IronPort-SDR: zrMjFlI5GKlH4TXYRDlrYH+y4RvFi9JUquNOINeYDvbyd/TY7ET9xA71XSATxJF2sHZhBcsczD
 AIYY9EdWJ68A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; 
   d="scan'208";a="433362656"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2020 09:39:03 -0700
Subject: Re: [PATCH 4/4 v2] firmware: stratix10-svc: Slightly simplify code
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
 <8c505c686438c54da61ad4fe15e1eae722011153.1588142343.git.christophe.jaillet@wanadoo.fr>
 <1f8ae50d-6830-7fbb-e999-3e8110fe7cd6@linux.intel.com>
 <c7ac6b7c-a1d5-e001-964b-0881707c41b1@wanadoo.fr>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <2a1de0d5-444a-2680-10b5-8578c2670d54@linux.intel.com>
Date:   Fri, 1 May 2020 11:55:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c7ac6b7c-a1d5-e001-964b-0881707c41b1@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/1/20 10:48 AM, Christophe JAILLET wrote:
> Le 01/05/2020 à 17:40, Richard Gong a écrit :
>> Hi,
>>
>> On 4/29/20 1:52 AM, Christophe JAILLET wrote:
>>> Replace 'devm_kmalloc_array(... | __GFP_ZERO)' with the equivalent and
>>> shorter 'devm_kcalloc(...)'.
>>>
>> It doesn't make much sense.
>> Actually devm_kcalloc returns devm_kmalloc_array(.., flag | __GFP_ZERO).
>>
> The only goal is to have a sightly less verbose code.
> This saves one line of code and there is no need to wonder why we 
> explicitly pass __GFP_ZERO to kmalloc_array.
> 
> Mostly a matter of taste.
I prefer this part remain unchanged.

Regards,
Richard

> 
> 'devm_kcalloc' is inlined, so the binary should be exactly the same. >
> CJ
> 
>>> 'ctrl->genpool' can not be NULL, so axe a useless test in the remove
>>> function.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>   drivers/firmware/stratix10-svc.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/firmware/stratix10-svc.c 
>>> b/drivers/firmware/stratix10-svc.c
>>> index 739004398877..c228337cb0a1 100644
>>> --- a/drivers/firmware/stratix10-svc.c
>>> +++ b/drivers/firmware/stratix10-svc.c
>>> @@ -1002,8 +1002,7 @@ static int stratix10_svc_drv_probe(struct 
>>> platform_device *pdev)
>>>       if (!controller)
>>>           return -ENOMEM;
>>>   -    chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
>>> -                   sizeof(*chans), GFP_KERNEL | __GFP_ZERO);
>>> +    chans = devm_kcalloc(dev, SVC_NUM_CHANNEL, sizeof(*chans), 
>>> GFP_KERNEL);
>>>       if (!chans)
>>>           return -ENOMEM;
>>>   @@ -1086,8 +1085,7 @@ static int stratix10_svc_drv_remove(struct 
>>> platform_device *pdev)
>>>           kthread_stop(ctrl->task);
>>>           ctrl->task = NULL;
>>>       }
>>> -    if (ctrl->genpool)
>>> -        gen_pool_destroy(ctrl->genpool);
>>> +    gen_pool_destroy(ctrl->genpool);
>>>       list_del(&ctrl->node);
>>>         return 0;
>>>
>>
>> Regards,
>> Richard
>>
> 
