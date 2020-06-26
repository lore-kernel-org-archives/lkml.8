Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639B6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35994208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jvWP7omt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgFZOT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:19:56 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:1079 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFZOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=FEGBRfIR1s0iOSC2ksl+oI8rZYqeM0zR23Uk0jXoKPc=;
        b=jvWP7omtX/XrEkbtoiUz8aVRP7W6fn2S5YZgNCGD1+yYGeGNnWtDNA3Z/c8OtxpI9Sq2
        IkSwSqRj6OMw8PeYGYci25iHhPU0N0BmjB1f96fw1MgFsmFJtwckyFNJBYvQ1JCJsgSubt
        DeZkN7J3QfX6dZ7ZJ8N49vxrQJKC4/FYI=
Received: by filterdrecv-p3las1-7754f7d4cc-h4ckv with SMTP id filterdrecv-p3las1-7754f7d4cc-h4ckv-20-5EF60409-55
        2020-06-26 14:19:53.796366727 +0000 UTC m=+72377.440658206
Received: from [10.13.72.114] (unknown)
        by ismtpd0007p1lon1.sendgrid.net (SG) with ESMTP
        id zPf15BMQRF-Lidn4m7Cubg
        Fri, 26 Jun 2020 14:19:53.332 +0000 (UTC)
Subject: Re: [PATCH 1/2] drm: drm_fourcc: add NV20 YUV
 =?UTF-8?B?Zm9ybWF044CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtcm9ja2NoaXAtYm91bmNlcytzYQ==?=
 =?us-ascii?Q?ndy=2Ehuang=3Drock-chips=2Ecom=40lists=2Einfradea?=
 =?UTF-8?B?ZC5vcmfku6Plj5HjgJE=?=
References: <20200607202521.18438-1-jonas@kwiboo.se>
 <20200607202521.18438-2-jonas@kwiboo.se>
 <d503eed1-571f-3e37-858b-b5de04cb79f7@rock-chips.com>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <f5c46547-3278-2226-e194-929fbfa95864@kwiboo.se>
Date:   Fri, 26 Jun 2020 14:19:53 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d503eed1-571f-3e37-858b-b5de04cb79f7@rock-chips.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hy6P=2FSOgwow3R0Z8y?=
 =?us-ascii?Q?W1KoHyhm09b7AooB6A2o7db6A8+5y6zT2UI+303?=
 =?us-ascii?Q?MS9NESYX+3Km3PkmWA=2FsT9auOwL7KKEVMpd=2Fdez?=
 =?us-ascii?Q?aC3EZOaq2lSpjg41F=2FbXYR7VxcxjWEnrdlePDgi?=
 =?us-ascii?Q?HdT6YrlXCS7eSHQ5wOQOqkkDqeLi7TxvYuGawMv?=
 =?us-ascii?Q?+e5TVzZ0uVapU857oi+Tw=3D=3D?=
To:     Huang Jiachai <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?b?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Ben Davis <ben.davis@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-17 14:07, Huang Jiachai wrote:
> Hi Jonas Karlman,
> 
>      Is there an another yuv 10bit format with 4:4:4 sub-simpling but 
> has no padding?
> 
>   Maybe we can call it DRM_FORMAT_NV30:
> 
> { .format = DRM_FORMAT_NV30,		.depth = 0,
>    .num_planes = 2, .char_per_block = { 5, 5, 0 },
>    .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 1,
>    .vsub = 1, .is_yuv = true },
> 
> this format can supported by rockchip rk3288/rk3399... platform, can you 
> add this format at this series patches?

I will send a v2 including this 4:4:4 format later this weekend.

Is there any hw block on rk3288/rk3399 that can produce a buffer in such format?
If I am not mistaken rkvdec only support 10-bit h264 in 4:2:0/4:2:2 and
hevc 4:2:0 10-bit, those are the formats I have been able to test so far.

Regards,
Jonas

> 
> 在 2020/6/8 4:25, Jonas Karlman 写道:
>> DRM_FORMAT_NV20 is a 2 plane format suitable for linear memory layout.
>> The format is similar to P210 with 4:2:2 sub-sampling but has no padding
>> between components. Instead, luminance and chrominance samples are grouped
>> into 4s so that each group is packed into an integer number of bytes:
>>
>> YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes
>>
>> The '20' suffix refers to the optimum effective bits per pixel which is
>> achieved when the total number of luminance samples is a multiple of 4.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/gpu/drm/drm_fourcc.c  | 4 ++++
>>   include/uapi/drm/drm_fourcc.h | 1 +
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>> index 722c7ebe4e88..2a9c8ae719ed 100644
>> --- a/drivers/gpu/drm/drm_fourcc.c
>> +++ b/drivers/gpu/drm/drm_fourcc.c
>> @@ -278,6 +278,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>   		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
>>   		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
>>   		  .vsub = 2, .is_yuv = true },
>> +		{ .format = DRM_FORMAT_NV20,		.depth = 0,
>> +		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
>> +		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
>> +		  .vsub = 1, .is_yuv = true },
>>   		{ .format = DRM_FORMAT_Q410,		.depth = 0,
>>   		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
>>   		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>> index b5bf1c0e630e..244d32433a67 100644
>> --- a/include/uapi/drm/drm_fourcc.h
>> +++ b/include/uapi/drm/drm_fourcc.h
>> @@ -242,6 +242,7 @@ extern "C" {
>>    * index 1 = Cr:Cb plane, [39:0] Cr1:Cb1:Cr0:Cb0 little endian
>>    */
>>   #define DRM_FORMAT_NV15		fourcc_code('N', 'V', '1', '5') /* 2x2 subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV20		fourcc_code('N', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane */
>>   
>>   /*
>>    * 2 plane YCbCr MSB aligned
> 
