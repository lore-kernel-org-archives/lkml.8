Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EFC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3F1206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635231AbgDOHlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:41:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:61786 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635175AbgDOHls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:41:48 -0400
IronPort-SDR: /Zmg2UTnCEURGa06SdjaN2PCpDrMpgW2VrU9pZQJN8Wo8z4oSzK9unBC9W0wjSf110oulSgAdw
 AO67ZWrFkfAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:41:46 -0700
IronPort-SDR: xgNl2Gj6HE2Gw18Pl4vLDPZpmTopzDm+0O6eyyi3TvCEhbIFddpB7JlWvW9q/uchtjVyUU+/tu
 yoYiN1esP0YQ==
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="427348570"
Received: from ssolodk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.48.37])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:41:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Bernard Zhao <bernard@vivo.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@vivo.com,
        Huang Rui <ray.huang@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: Re: [PATCH] Optimized division operation to shift operation
In-Reply-To: <CADnq5_Phca3L-HGOQz0DPBoARHgwcJRK_a7-WmeFMPkrPWeOeg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1586864113-30682-1-git-send-email-bernard@vivo.com> <CADnq5_Phca3L-HGOQz0DPBoARHgwcJRK_a7-WmeFMPkrPWeOeg@mail.gmail.com>
Date:   Wed, 15 Apr 2020 10:41:37 +0300
Message-ID: <87lfmx5h72.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Tue, Apr 14, 2020 at 9:05 AM Bernard Zhao <bernard@vivo.com> wrote:
>>
>> On some processors, the / operate will call the compiler`s div lib,
>> which is low efficient, We can replace the / operation with shift,
>> so that we can replace the call of the division library with one
>> shift assembly instruction.

This was applied already, and it's not in a driver I look after... but
to me this feels like something that really should be
justified. Using >> instead of / for multiples of 2 division mattered 20
years ago, I'd be surprised if it still did on modern compilers.

BR,
Jani.


>>
>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Applied.  thanks.
>
> Alex
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
>>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
>>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index b205039..66cd078 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -175,10 +175,10 @@ static int gmc_v6_0_mc_load_microcode(struct amdgpu_device *adev)
>>         amdgpu_ucode_print_mc_hdr(&hdr->header);
>>
>>         adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
>> -       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
>> +       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
>>         new_io_mc_regs = (const __le32 *)
>>                 (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
>> -       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
>> +       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
>>         new_fw_data = (const __le32 *)
>>                 (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 9da9596..ca26d63 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -193,10 +193,10 @@ static int gmc_v7_0_mc_load_microcode(struct amdgpu_device *adev)
>>         amdgpu_ucode_print_mc_hdr(&hdr->header);
>>
>>         adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
>> -       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
>> +       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
>>         io_mc_regs = (const __le32 *)
>>                 (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
>> -       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
>> +       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
>>         fw_data = (const __le32 *)
>>                 (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 27d83204..295039c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -318,10 +318,10 @@ static int gmc_v8_0_tonga_mc_load_microcode(struct amdgpu_device *adev)
>>         amdgpu_ucode_print_mc_hdr(&hdr->header);
>>
>>         adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
>> -       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
>> +       regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
>>         io_mc_regs = (const __le32 *)
>>                 (adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
>> -       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
>> +       ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
>>         fw_data = (const __le32 *)
>>                 (adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>>
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
