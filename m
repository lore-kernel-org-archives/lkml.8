Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206F4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98AE20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGPB7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:59:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbgGPB7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:59:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 094F3E12A9A918CC266D;
        Thu, 16 Jul 2020 09:59:41 +0800 (CST)
Received: from [10.174.179.105] (10.174.179.105) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 16 Jul
 2020 09:59:39 +0800
Subject: Re: [PATCH] drm: remove redundant assignment to variable 'ret'
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <ajax@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200715070559.180986-1-jingxiangfeng@huawei.com>
 <20200715120503.GJ3278063@phenom.ffwll.local>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F0FB48A.6080407@huawei.com>
Date:   Thu, 16 Jul 2020 09:59:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20200715120503.GJ3278063@phenom.ffwll.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.105]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/15 20:05, Daniel Vetter wrote:
> On Wed, Jul 15, 2020 at 03:05:59PM +0800, Jing Xiangfeng wrote:
>> The variable ret has been assigned the value '-EINVAL'. The assignment
>> in the if() is redundant. We can remove it.
>
> Nope, that's not correct. Before this assignement ret is guaranteed to be
> 0.

Before this assignment ret is '-EINVAL'(see commit 45bc3d26c95a: "drm: 
rework SET_MASTER and DROP_MASTER perm handling"). It is set to 0 above
around the drm_drop_master() calls.

Thanks
> -Daniel
>
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> ---
>>   drivers/gpu/drm/drm_auth.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
>> index 800ac39f3213..6e1b502f2797 100644
>> --- a/drivers/gpu/drm/drm_auth.c
>> +++ b/drivers/gpu/drm/drm_auth.c
>> @@ -299,7 +299,6 @@ int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
>>
>>   	if (file_priv->master->lessor != NULL) {
>>   		DRM_DEBUG_LEASE("Attempt to drop lessee %d as master\n", file_priv->master->lessee_id);
>> -		ret = -EINVAL;
>>   		goto out_unlock;
>>   	}
>>
>> --
>> 2.17.1
>>
>
