Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733C521775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGTIaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:30:04 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:47470 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgGTIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:30:03 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 04:30:02 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id ADD4715E5;
        Mon, 20 Jul 2020 16:22:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.230] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17843T139820244399872S1595233344948995_;
        Mon, 20 Jul 2020 16:22:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ee61f11e52c0f1bdab7b994fbb736568>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/5=5d_drm=3a_rockchip=3a_add_missing_regi?=
 =?UTF-8?B?c3RlcnMgZm9yIFJLMzE4OOOAkOivt+azqOaEj++8jOmCruS7tueUsWxpbnV4LXJv?=
 =?UTF-8?Q?ckchip-bounces+andy=2eyan=3drock-chips=2ecom=40lists=2einfradead?=
 =?UTF-8?B?Lm9yZ+S7o+WPkeOAkQ==?=
To:     Alex Bee <knaerzche@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
References: <20200718200323.3559-1-knaerzche@gmail.com>
 <20200718200323.3559-3-knaerzche@gmail.com>
From:   Andy Yan <andy.yan@rock-chips.com>
Message-ID: <871ce1ac-2d5b-c0a2-60a6-6aba0f296c18@rock-chips.com>
Date:   Mon, 20 Jul 2020 16:22:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718200323.3559-3-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex:

On 7/19/20 4:03 AM, Alex Bee wrote:
> This patch adds dither_up, dsp_lut_en, data_blank and dsp_data_swap
> registers to enable their respective functionality for RK3188's VOP.
>
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index b046910129fb..971a6bda7458 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -512,6 +512,10 @@ static const struct vop_common rk3188_common = {
>   	.dither_down_en = VOP_REG(RK3188_DSP_CTRL0, 0x1, 11),
>   	.dither_down_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 10),
>   	.dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x3, 24),
> +	.dither_up = VOP_REG(RK3188_DSP_CTRL0, 0x1, 9),
> +	.dsp_lut_en = VOP_REG(RK3188_SYS_CTRL, 0x1, 28),
> +	.data_blank = VOP_REG(RK3188_DSP_CTRL1, 0x1, 25),
> +	.dsp_data_swap = VOP_REG(RK3188_DSP_CTRL1, 0x1f, 26),



I can't find the definition of dsp_data_swap, or I missed something?



>   };
>   
>   static const struct vop_win_data rk3188_vop_win_data[] = {


