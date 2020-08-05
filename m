Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584D320792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHEKDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 06:03:51 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:58882 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHEKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 06:03:30 -0400
Received: from localhost (unknown [192.168.167.209])
        by regular1.263xmail.com (Postfix) with ESMTP id 46CF7485;
        Wed,  5 Aug 2020 18:03:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.76] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12032T139957011113728S1596621795960706_;
        Wed, 05 Aug 2020 18:03:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <58f15e56412951c2acfe8d69cef47c2a>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] drm: sysfs: Add to get current mode
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Tao Huang <huangtao@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200805083646.4123-1-hjc@rock-chips.com>
 <CAKMK7uGmKJqZJ0ONQjjquZn6mksKbkScmcUSEA43eg1jFskmTg@mail.gmail.com>
From:   Huang Jiachai <hjc@rock-chips.com>
Message-ID: <693f6555-d9d2-f255-1198-e3798c8f4fe8@rock-chips.com>
Date:   Wed, 5 Aug 2020 18:03:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGmKJqZJ0ONQjjquZn6mksKbkScmcUSEA43eg1jFskmTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

在 2020/8/5 17:36, Daniel Vetter 写道:
> On Wed, Aug 5, 2020 at 10:37 AM Sandy Huang <hjc@rock-chips.com> wrote:
>> add this node to get the current true mode.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Uh what's this for? Since it's sysfs, I guess there's something
> parsing this, which means we'd kinda need to have that piece too.
>
> If it's just for debugging purposes, then we already have this
> information in debugfs, together with everything else that's in the
> atomic modeset state.
> -Daniel

yes, this is just for debug;

and i get the information what i need from cat 
/sys/kernel/debug/dri/0/state, thanks.

>> ---
>>   drivers/gpu/drm/drm_sysfs.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>> index 939f0032aab1..f39bcd34853b 100644
>> --- a/drivers/gpu/drm/drm_sysfs.c
>> +++ b/drivers/gpu/drm/drm_sysfs.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/slab.h>
>>
>>   #include <drm/drm_connector.h>
>> +#include <drm/drm_crtc.h>
>>   #include <drm/drm_device.h>
>>   #include <drm/drm_file.h>
>>   #include <drm/drm_modes.h>
>> @@ -236,16 +237,45 @@ static ssize_t modes_show(struct device *device,
>>          return written;
>>   }
>>
>> +static ssize_t current_mode_show(struct device *device,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +       struct drm_connector *connector = to_drm_connector(device);
>> +       struct drm_display_mode *mode;
>> +       struct drm_crtc_state *crtc_state;
>> +       bool interlaced;
>> +       int written = 0;
>> +
>> +       if (!connector->state || !connector->state->crtc)
>> +               return written;
>> +
>> +       crtc_state = connector->state->crtc->state;
>> +       if (!crtc_state)
>> +               return written;
>> +
>> +       mode = &crtc_state->mode;
>> +
>> +       interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
>> +       written += snprintf(buf + written, PAGE_SIZE - written, "%dx%d%s%d\n",
>> +                           mode->hdisplay, mode->vdisplay,
>> +                           interlaced ? "i" : "p", drm_mode_vrefresh(mode));
>> +
>> +       return written;
>> +}
>> +
>>   static DEVICE_ATTR_RW(status);
>>   static DEVICE_ATTR_RO(enabled);
>>   static DEVICE_ATTR_RO(dpms);
>>   static DEVICE_ATTR_RO(modes);
>> +static DEVICE_ATTR_RO(current_mode);
>>
>>   static struct attribute *connector_dev_attrs[] = {
>>          &dev_attr_status.attr,
>>          &dev_attr_enabled.attr,
>>          &dev_attr_dpms.attr,
>>          &dev_attr_modes.attr,
>> +       &dev_attr_current_mode.attr,
>>          NULL
>>   };
>>
>> --
>> 2.17.1
>>
>>
>>
>
-- 
Best Regard

黄家钗
Sandy Huang
Addr: 福州市鼓楼区铜盘路软件大道89号福州软件园A区21号楼(350003)
       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
Tel：+86 0591-87884919  8690
E-mail：hjc@rock-chips.com



