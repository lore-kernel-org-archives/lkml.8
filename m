Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29524C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060C3206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA3GVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:21:00 -0500
Received: from olimex.com ([184.105.72.32]:54138 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgA3GVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:21:00 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 22:20:58 -0800
Subject: Re: [PATCH v3 1/1] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
To:     Maxime Ripard <maxime@cerno.tech>,
        Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com
References: <20200128140642.8404-1-stefan@olimex.com>
 <20200128140642.8404-2-stefan@olimex.com>
 <20200129164321.34mornbi3xvx5dys@gilmour.lan>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <64676a4b-e149-146c-81b4-7fd5e792efc5@olimex.com>
Date:   Thu, 30 Jan 2020 08:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129164321.34mornbi3xvx5dys@gilmour.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/29/20 6:43 PM, Maxime Ripard wrote:
> Hi,
>
> On Tue, Jan 28, 2020 at 04:06:42PM +0200, Stefan Mavrodiev wrote:
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> index 68d4644ac2dc..4cd35c97c503 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> @@ -23,6 +23,8 @@
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_probe_helper.h>
>>
>> +#include <sound/soc.h>
>> +
>>   #include "sun4i_backend.h"
>>   #include "sun4i_crtc.h"
>>   #include "sun4i_drv.h"
>> @@ -87,6 +89,10 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
>>
>>   	DRM_DEBUG_DRIVER("Disabling the HDMI Output\n");
>>
>> +#ifdef CONFIG_DRM_SUN4I_HDMI_AUDIO
>> +	sun4i_hdmi_audio_destroy(hdmi);
>> +#endif
>> +
>>   	val = readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>>   	val &= ~SUN4I_HDMI_VID_CTRL_ENABLE;
>>   	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>> @@ -114,6 +120,11 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
>>   		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
>>
>>   	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>> +
>> +#ifdef CONFIG_DRM_SUN4I_HDMI_AUDIO
>> +	if (hdmi->hdmi_audio && sun4i_hdmi_audio_create(hdmi))
>> +		DRM_ERROR("Couldn't create the HDMI audio adapter\n");
>> +#endif
> I really don't think we should be creating / removing the audio card
> at enable / disable time.

For me it's unnatural to have sound card all the time, even when the HDMI
is not plugged-in.

I'll follow your suggestion. Besides it's easier for me just to drop this
register/unregister mechanism.

Best regards,
Stefan Mavrodiev

>
> To fix the drvdata pointer, you just need to use the card pointer in
> the unbind, and that's it.
>
> Maxime
