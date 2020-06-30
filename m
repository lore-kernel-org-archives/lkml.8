Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BC12073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbgF3MO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:14:29 -0400
Received: from mail.loongson.cn ([114.242.206.163]:32906 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732036AbgF3MO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:14:28 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT2ifLPte1wpNAA--.794S3;
        Tue, 30 Jun 2020 20:14:23 +0800 (CST)
Subject: Re: [PATCH] gpu/drm: Replace "%p" with "%pK"
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <1593502561-15190-1-git-send-email-yangtiezhu@loongson.cn>
 <26fcd5ec-4e90-8b98-8fbb-605f5906ad75@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <286d0a26-c0bd-f151-12c7-dafb34016230@loongson.cn>
Date:   Tue, 30 Jun 2020 20:14:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <26fcd5ec-4e90-8b98-8fbb-605f5906ad75@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxT2ifLPte1wpNAA--.794S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fGF47Aw1fWrWrGFyrCrg_yoW5Wr1kpF
        4xGFyYkr95Zw1j9347AFyUAFyFyw47Xay8GF1UC34S9w15ZF4jkF13Jr47XrW8XFs2yr42
        qr1Uuay5WF1jkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07j7F4iUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2020 04:05 PM, Christian König wrote:
> Am 30.06.20 um 09:36 schrieb Tiezhu Yang:
>> When I update the latest kernel, I see the following "____ptrval____" 
>> boot
>> messages. Use "%pK" instead of "%p" so that the cpu address can be 
>> printed
>> when the kptr_restrict sysctl is set to 1.
>>
>> Both radeon_fence_driver_start_ring() and 
>> amdgpu_fence_driver_start_ring()
>> have this similar issue, fix them.
>>
>> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu 
>> addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
>> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu 
>> addr 0x0000000040056038 and cpu addr 0x(____ptrval____)
>
> We can probably just completely drop the CPU address here.

OK, maybe the CPU address is not much useful. If nobody has any objections,
I will send v2 to remove the debug info about CPU address.

Thanks,
Tiezhu

>
> Christian.
>
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
>>   drivers/gpu/drm/radeon/radeon_fence.c     | 2 +-
>>   2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index d878fe7..d4d1e8c 100644
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
>> 0x%016llx, cpu addr 0x%pK\n",
>> +              ring->name, ring->fence_drv.gpu_addr, 
>> ring->fence_drv.cpu_addr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/radeon/radeon_fence.c 
>> b/drivers/gpu/drm/radeon/radeon_fence.c
>> index 43f2f93..c51b094 100644
>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
>> @@ -865,7 +865,7 @@ int radeon_fence_driver_start_ring(struct 
>> radeon_device *rdev, int ring)
>>       }
>>       radeon_fence_write(rdev, 
>> atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
>>       rdev->fence_drv[ring].initialized = true;
>> -    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>> 0x%016llx and cpu addr 0x%p\n",
>> +    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>> 0x%016llx and cpu addr 0x%pK\n",
>>            ring, rdev->fence_drv[ring].gpu_addr, 
>> rdev->fence_drv[ring].cpu_addr);
>>       return 0;
>>   }

