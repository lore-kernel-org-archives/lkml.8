Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9834C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9827E206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJGYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:24:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:5451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgDJGYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:24:39 -0400
IronPort-SDR: Gv7qfjxm+gQcA08UsOIHA+p0OF0Py1d9ibN5o6HmpdUif0FqfSvnoFU3Gv/1IAREHqcNe+lFzf
 9RrtjSH9oG8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 23:24:39 -0700
IronPort-SDR: Nz8s7/Lni2JGlHWWeGn+1eHvhQeRASmLxgkhIL3lj49IBv8FkTYJJhyz9RbnY3RbEpofEkVMgZ
 eSEJXJWvWchQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; 
   d="scan'208";a="240862325"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.255.30.81]) ([10.255.30.81])
  by orsmga007.jf.intel.com with ESMTP; 09 Apr 2020 23:24:38 -0700
Subject: Re: [PATCH] vdpa: allow a 32 bit vq alignment
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org
References: <20200409202825.10115-1-mst@redhat.com>
 <bed03b3a-ebc0-2a93-7e6b-8f884eab747b@redhat.com>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
Message-ID: <1c164046-cc4c-f5fb-bed1-a650b5078b6f@intel.com>
Date:   Fri, 10 Apr 2020 14:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bed03b3a-ebc0-2a93-7e6b-8f884eab747b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/2020 2:21 PM, Jason Wang wrote:
> Cc Ling Shan.
>
> On 2020/4/10 上午4:28, Michael S. Tsirkin wrote:
>> get_vq_align returns u16 now, but that's not enough for
>> systems/devices with 64K pages. All callers assign it to
>> a u32 variable anyway, so let's just change the return
>> value type to u32.
>>
>> Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c  | 2 +-
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>>   include/linux/vdpa.h             | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c 
>> b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 28d9e5de5675..abf6a061cab6 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -226,7 +226,7 @@ static u32 ifcvf_vdpa_get_vendor_id(struct 
>> vdpa_device *vdpa_dev)
>>       return IFCVF_SUBSYS_VENDOR_ID;
>>   }
>>   -static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>> +static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>>   {
>>       return IFCVF_QUEUE_ALIGNMENT;
>>   }
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c 
>> b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 72863d01a12a..7957d2d41fc4 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -435,7 +435,7 @@ static u64 vdpasim_get_vq_state(struct 
>> vdpa_device *vdpa, u16 idx)
>>       return vrh->last_avail_idx;
>>   }
>>   -static u16 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>> +static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>>   {
>>       return VDPASIM_QUEUE_ALIGN;
>>   }
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 733acfb7ef84..5453af87a33e 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -164,7 +164,7 @@ struct vdpa_config_ops {
>>       u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
>>         /* Device ops */
>> -    u16 (*get_vq_align)(struct vdpa_device *vdev);
>> +    u32 (*get_vq_align)(struct vdpa_device *vdev);
>>       u64 (*get_features)(struct vdpa_device *vdev);
>>       int (*set_features)(struct vdpa_device *vdev, u64 features);
>>       void (*set_config_cb)(struct vdpa_device *vdev,
>
looks good to me

Thanks,
BR
Zhu Lingshan

