Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B7DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE11120720
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbgFSIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:39:35 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:60738 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgFSIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:39:23 -0400
Received: from localhost (unknown [192.168.167.70])
        by regular1.263xmail.com (Postfix) with ESMTP id 5FCE413DD;
        Fri, 19 Jun 2020 16:39:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.76] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P7896T140607601231616S1592555948689939_;
        Fri, 19 Jun 2020 16:39:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a251438a6d703a40437df80de2a62cbd>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] drm/rockchip: vop: fix vop full rgb24 r/b color error
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        andy.yan@rock-chips.com, huangtao@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200619021251.22991-1-hjc@rock-chips.com>
 <2786595.VspqIdsi2r@phil>
From:   Huang Jiachai <hjc@rock-chips.com>
Message-ID: <0fe318e7-2f35-d311-ff3a-b67cc527cc87@rock-chips.com>
Date:   Fri, 19 Jun 2020 16:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2786595.VspqIdsi2r@phil>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi heiko,

在 2020/6/19 15:02, Heiko Stuebner 写道:
> Hi Sandy,
>
> Am Freitag, 19. Juni 2020, 04:12:51 CEST schrieb Sandy Huang:
>> RGB888 format msb is red component and the lsb is blue component,
>> at vop full platform this is swapped, and this is different from vop
>> lite and vop next, so add this patch to fix it.
> just me struggling with color formats ... and wondering why this never
> came up so far - with Version 3 being all major SoCs of the last years.
>
> So I guess the reason that nobody noticed so far is, that most things
> will use ARGB888 instead of RGB888?
yes, most gpu output format is ARGB888, so we didn't noticed it before.
> One implementation nit below as well.
>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index c80f7d9fd13f..1c17048ad737 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -132,6 +132,7 @@ struct vop_win {
>>   
>>   struct rockchip_rgb;
>>   struct vop {
>> +	uint32_t version;
>>   	struct drm_crtc crtc;
>>   	struct device *dev;
>>   	struct drm_device *drm_dev;
>> @@ -989,6 +990,12 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>>   	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
>>   
>>   	rb_swap = has_rb_swapped(fb->format->format);
>> +	/*
>> +	 * VOP full need to do rb swap to show rgb888/bgr888 format color correctly
>> +	 */
> one-line-comment?
> 	/* VOP-full needs rb_swap for correctly showing rgb888/bgr888 */
>
>> +	if ((fb->format->format == DRM_FORMAT_RGB888 || fb->format->format == DRM_FORMAT_BGR888) &&
>> +	    VOP_MAJOR(vop->version) == 3)
>> +		rb_swap = !rb_swap;
> can we move this into the existing has_rb_swapped() function?
> Like doing
> 	rb_swap = has_rb_swapped(vop, fb->format->format)
> and adding your conditional to the end there?
>
OK, update at v2.
> Thanks
> Heiko
>
>
>>   	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
>>   
>>   	/*
>> @@ -2091,6 +2098,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>>   	vop->dev = dev;
>>   	vop->data = vop_data;
>>   	vop->drm_dev = drm_dev;
>> +	vop->version = vop_data->version;
>>   	dev_set_drvdata(dev, vop);
>>   
>>   	vop_win_init(vop);
>>
>
>
>
>
>
-- 
Best Regard

黄家钗
Sandy Huang
Addr: 福州市鼓楼区铜盘路软件大道89号福州软件园A区21号楼(350003)
       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
Tel：+86 0591-87884919  8690
E-mail：hjc@rock-chips.com



