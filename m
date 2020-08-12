Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD07C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC42205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHLHMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:12:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbgHLHMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:12:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EC1DE398E5F144B6222;
        Wed, 12 Aug 2020 15:12:48 +0800 (CST)
Received: from [127.0.0.1] (10.57.60.129) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 15:12:38 +0800
Subject: Re: [PATCH drm/hisilicon v2 0/3] hibmc clean up and code refactoring
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
References: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
 <312b8060-f015-35ba-f4f6-ad992aa09aa9@suse.de>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <8f558a5c-61b6-303a-0c2f-e0f63e9faa10@huawei.com>
Date:   Wed, 12 Aug 2020 15:12:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <312b8060-f015-35ba-f4f6-ad992aa09aa9@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.57.60.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/12 15:04, Thomas Zimmermann 写道:
> Hi
> 
> Am 03.08.20 um 02:38 schrieb Tian Tao:
>> patch #1 and #3 is clean up, patch #2 is for code refactoring
> 
> Sorry for all my reviews taking so long. Please merge patch #3 into
> patch #2 and then the series is
> 
thanks,I will send v3 to fix this.
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> I noticed that hibmc use DRM_ERROR in several places. A good follow-up
> patchset would be the conversion to drm_info/drm_warn/drm_error/etc.
> 
I will send another patchset to fix this.
> Best regards
> Thomas
> 
>>
>> Changes since v1:
>> - Rewrite the commits messages and patch name in #1
>> - Rewrite the commits message in #2.
>> - Add the new patch #3
>>
>> Tian Tao (3):
>>    drm/hisilicon: Remove the unused include statements
>>    drm/hisilicon: Code refactoring for hibmc_drv_de
>>    drm/hisilicon: Rename variables to represent the correct meaning
>>
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 58 ++++++------------------
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  5 --
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 -
>>   4 files changed, 15 insertions(+), 52 deletions(-)
>>
> 

