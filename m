Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB00AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982252084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGBIgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:36:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:39214 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbgGBIf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:35:59 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxXetknP1eFWVOAA--.8S3;
        Thu, 02 Jul 2020 16:35:50 +0800 (CST)
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        alexander.deucher@amd.com
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
 <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
Date:   Thu, 2 Jul 2020 16:35:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxXetknP1eFWVOAA--.8S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43Wr1DAryfZw48Gw1kuFg_yoW5uF4xpF
        WrGa4Ykr95Zw1j9347AFyUZFyFyw4xWay8Kr1DC34a9w15ZF10kr13Aw47XFWkXrs3tr4I
        qr1ku3y8W3WjkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4NtxUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 04:27 PM, Christian König wrote:
> Am 02.07.20 um 04:27 schrieb Tiezhu Yang:
>> When I update the latest kernel, I see the following "____ptrval____" 
>> boot
>> messages.
>>
>> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu 
>> addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
>> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu 
>> addr 0x0000000040056038 and cpu addr 0x(____ptrval____)
>>
>> Both radeon_fence_driver_start_ring() and 
>> amdgpu_fence_driver_start_ring()
>> have the similar issue, there exists the following two methods to 
>> solve it:
>> (1) Use "%pK" instead of "%p" so that the CPU address can be printed 
>> when
>> the kptr_restrict sysctl is set to 1.
>> (2) Just completely drop the CPU address suggested by Christian, because
>> the CPU address was useful in the past, but isn't any more. We now 
>> have a
>> debugfs file to read the current fence values.
>>
>> Since the CPU address is not much useful, just remove the debug info 
>> about
>> CPU address.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Splitting it into one patch for radeon and one for amdgpu might be 
> nice to have.

Should I split this patch into two patches and then send v3?
If yes, I will do it soon.

>
> But either way Reviewed-by: Christian König <christian.koenig@amd.com> 
> for the patch.
>
> Thanks,
> Christian.
>
>> ---
>>
>> v2:
>>    - Just remove the debug info about CPU address suggested by Christian
>>    - Modify the patch subject and update the commit message
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
>>   drivers/gpu/drm/radeon/radeon_fence.c     | 4 ++--
>>   2 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index d878fe7..a29f2f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -422,9 +422,8 @@ int amdgpu_fence_driver_start_ring(struct 
>> amdgpu_ring *ring,
>>       ring->fence_drv.irq_type = irq_type;
>>       ring->fence_drv.initialized = true;
>>   -    DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr "
>> -              "0x%016llx, cpu addr 0x%p\n", ring->name,
>> -              ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
>> +    DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr 
>> 0x%016llx\n",
>> +              ring->name, ring->fence_drv.gpu_addr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/radeon/radeon_fence.c 
>> b/drivers/gpu/drm/radeon/radeon_fence.c
>> index 43f2f93..8735bf2 100644
>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
>> @@ -865,8 +865,8 @@ int radeon_fence_driver_start_ring(struct 
>> radeon_device *rdev, int ring)
>>       }
>>       radeon_fence_write(rdev, 
>> atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
>>       rdev->fence_drv[ring].initialized = true;
>> -    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>> 0x%016llx and cpu addr 0x%p\n",
>> -         ring, rdev->fence_drv[ring].gpu_addr, 
>> rdev->fence_drv[ring].cpu_addr);
>> +    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>> 0x%016llx\n",
>> +         ring, rdev->fence_drv[ring].gpu_addr);
>>       return 0;
>>   }

