Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB96C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45AE2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgDQH0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:26:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbgDQH0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:26:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0AA69904CA792C4204D4;
        Fri, 17 Apr 2020 15:26:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 17 Apr
 2020 15:26:08 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent meta updates while checkpoint is
 in progress
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sahitya Tummala <stummala@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200331035419.GB79749@google.com> <20200331090608.GZ20234@codeaurora.org>
 <20200331184307.GA198665@google.com> <20200401050801.GA20234@codeaurora.org>
 <20200403171727.GB68460@google.com> <20200403172750.GD68460@google.com>
 <20200413174237.GC39092@google.com> <20200414134403.GA69282@google.com>
 <20200416214045.GB196168@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e1b763bf-7f72-01eb-a368-9b70e0f46f55@huawei.com>
Date:   Fri, 17 Apr 2020 15:26:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200416214045.GB196168@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/17 5:40, Jaegeuk Kim wrote:
> On 04/14, Jaegeuk Kim wrote:
>> On 04/13, Jaegeuk Kim wrote:
>>> On 04/03, Jaegeuk Kim wrote:
>>>> On 04/03, Jaegeuk Kim wrote:
>>>>> On 04/01, Sahitya Tummala wrote:
>>>>>> Hi Jaegeuk,
>>>>>>
>>>>>> Got it.
>>>>>> The diff below looks good to me.
>>>>>> Would you like me to test it and put a patch for this?
>>>>>
>>>>> Sahitya, Chao,
>>>>>
>>>>> Could you please take a look at this patch and test intensively?
>>>>>
>>>>> Thanks,
> 
> v5:
>  - add signal handler
> 
> Sahitya raised an issue:
> - prevent meta updates while checkpoint is in progress
> 
> allocate_segment_for_resize() can cause metapage updates if
> it requires to change the current node/data segments for resizing.
> Stop these meta updates when there is a checkpoint already
> in progress to prevent inconsistent CP data.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
