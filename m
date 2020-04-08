Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80432C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B202072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDHHXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:23:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:59904 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgDHHXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:23:14 -0400
IronPort-SDR: zXcfL6zgi8L105m1vMKwiHnkcUQmTm8+wmKkWXogQ+qCZr2SrqDfKq2OW2oHVznLEUUlcAGtd1
 KLUE7eBICAGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 00:23:13 -0700
IronPort-SDR: wbNSLqrG9YH/WEuK3RhT2/b2jaChlUH8aGF188QgLpZkAWUXWTDZRQ1kJN6f2krch4WwzGgGWF
 ypbPpiqp0B4g==
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="398121561"
Received: from slinke-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.237])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 00:23:10 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP CML 2020 system
In-Reply-To: <20200407075353.12747-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200407075353.12747-1-kai.heng.feng@canonical.com>
Date:   Wed, 08 Apr 2020 10:23:07 +0300
Message-ID: <87k12qigpw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Apr 2020, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> There's another Samsung OLED panel needs to use DPCD aux interface to
> control backlight.

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index c6fbe6e6bc9d..d0cfee3b7a65 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -1299,6 +1299,8 @@ static const struct edid_quirk edid_quirk_list[] = {
>  	 * only supports DPCD backlight controls
>  	 */
>  	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> +	/* HP CML 2020 system */
> +	{ MFG(0x4c, 0x83), PROD_ID(0x45, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>  	/*
>  	 * Some Dell CML 2020 systems have panels support both AUX and PWM
>  	 * backlight control, and some only support AUX backlight control. All

-- 
Jani Nikula, Intel Open Source Graphics Center
