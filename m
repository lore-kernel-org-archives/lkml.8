Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC73C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB5620786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQMQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:16:04 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:33232 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQMQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:16:04 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 08:16:02 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 727BF684;
        Wed, 17 Jun 2020 20:07:42 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.76] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P25389T140143172253440S1592395661407272_;
        Wed, 17 Jun 2020 20:07:42 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2f2aa222071add7fb750d61c24ed6731>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/2=5d_drm=3a_drm=5ffourcc=3a_add_NV20_YUV?=
 =?UTF-8?B?IGZvcm1hdOOAkOivt+azqOaEj++8jOmCruS7tueUsWxpbnV4LXJvY2tjaGlwLWJv?=
 =?UTF-8?Q?unces+sandy=2ehuang=3drock-chips=2ecom=40lists=2einfradead=2eorg?=
 =?UTF-8?B?5Luj5Y+R44CR?=
To:     Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Brian Starkey <brian.starkey@arm.com>,
        Ben Davis <ben.davis@arm.com>,
        =?UTF-8?B?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>
References: <20200607202521.18438-1-jonas@kwiboo.se>
 <20200607202521.18438-2-jonas@kwiboo.se>
From:   Huang Jiachai <hjc@rock-chips.com>
Message-ID: <d503eed1-571f-3e37-858b-b5de04cb79f7@rock-chips.com>
Date:   Wed, 17 Jun 2020 20:07:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200607202521.18438-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas Karlman,

     Is there an another yuv 10bit format with 4:4:4 sub-simpling but 
has no padding?

  Maybe we can call it DRM_FORMAT_NV30:

{ .format = DRM_FORMAT_NV30,		.depth = 0,
   .num_planes = 2, .char_per_block = { 5, 5, 0 },
   .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 1,
   .vsub = 1, .is_yuv = true },

this format can supported by rockchip rk3288/rk3399... platform, can you 
add this format at this series patches?

在 2020/6/8 4:25, Jonas Karlman 写道:
> DRM_FORMAT_NV20 is a 2 plane format suitable for linear memory layout.
> The format is similar to P210 with 4:2:2 sub-sampling but has no padding
> between components. Instead, luminance and chrominance samples are grouped
> into 4s so that each group is packed into an integer number of bytes:
>
> YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes
>
> The '20' suffix refers to the optimum effective bits per pixel which is
> achieved when the total number of luminance samples is a multiple of 4.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/drm_fourcc.c  | 4 ++++
>   include/uapi/drm/drm_fourcc.h | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 722c7ebe4e88..2a9c8ae719ed 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -278,6 +278,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
>   		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
>   		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
>   		  .vsub = 2, .is_yuv = true },
> +		{ .format = DRM_FORMAT_NV20,		.depth = 0,
> +		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
> +		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
> +		  .vsub = 1, .is_yuv = true },
>   		{ .format = DRM_FORMAT_Q410,		.depth = 0,
>   		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
>   		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index b5bf1c0e630e..244d32433a67 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -242,6 +242,7 @@ extern "C" {
>    * index 1 = Cr:Cb plane, [39:0] Cr1:Cb1:Cr0:Cb0 little endian
>    */
>   #define DRM_FORMAT_NV15		fourcc_code('N', 'V', '1', '5') /* 2x2 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV20		fourcc_code('N', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane */
>   
>   /*
>    * 2 plane YCbCr MSB aligned

-- 
Best Regard

黄家钗
Sandy Huang
Addr: 福州市鼓楼区铜盘路软件大道89号福州软件园A区21号楼(350003)
       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
Tel：+86 0591-87884919  8690
E-mail：hjc@rock-chips.com



