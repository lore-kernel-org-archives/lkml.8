Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1878C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19972074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgDHHWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:22:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:10805 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHHWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:22:44 -0400
IronPort-SDR: QZME3hUoJXd7zhOqpVhH5KJJ0cs42SI0cjJJvQi7rihEtw8LcDnt06ezSgrO+vZnCcbi+NDx1a
 1tQuyVYYlvUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 00:22:43 -0700
IronPort-SDR: tOuocFG0D/Wi2hHfRqzdl1/BIu5OGbDkB/6Qc4hqb2H0Zzk86rOtoEiwfsNVIN57DqkhkNvVEb
 WjPeWJNWfWqA==
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="425043160"
Received: from slinke-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.237])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 00:22:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher\, Alexander" <alexander.deucher@amd.com>
Cc:     "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP Spectre x360 Convertible 13t-aw100
In-Reply-To: <1F57CA05-3E23-4CA8-A138-6785906ED465@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200323053528.3147-1-kai.heng.feng@canonical.com> <41FD4AD2-81F9-45E8-B5D6-9CC255D0581B@canonical.com> <1F57CA05-3E23-4CA8-A138-6785906ED465@canonical.com>
Date:   Wed, 08 Apr 2020 10:22:37 +0300
Message-ID: <87mu7migqq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Apr 2020, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> On Mar 27, 2020, at 19:03, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> Hi,
>> 
>>> On Mar 23, 2020, at 13:35, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>> 
>>> There's another OLED panel needs to use DPCD aux interface to control
>>> backlight.
>>> 
>>> BugLink: https://bugs.launchpad.net/bugs/1860303
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> 
>> Would it be possible to review this?
>> I'd like to send a similar quirk for a new panel, and I want to avoid causing any merge conflict.
>
> Another gentle ping...

Can't really review, but if you say that's needed...

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
>> 
>> Kai-Heng
>> 
>>> ---
>>> drivers/gpu/drm/drm_dp_helper.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
>>> index 8ba4531e808d..a0d4314663de 100644
>>> --- a/drivers/gpu/drm/drm_dp_helper.c
>>> +++ b/drivers/gpu/drm/drm_dp_helper.c
>>> @@ -1301,6 +1301,8 @@ static const struct edid_quirk edid_quirk_list[] = {
>>> 	 * only supports DPCD backlight controls
>>> 	 */
>>> 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>>> +	/* HP Spectre x360 Convertible 13t-aw100 */
>>> +	{ MFG(0x4c, 0x83), PROD_ID(0x42, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>>> 	/*
>>> 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
>>> 	 * backlight control, and some only support AUX backlight control. All
>>> -- 
>>> 2.17.1
>>> 
>> 
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
