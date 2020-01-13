Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7EEC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7038F207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAMN5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:57:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:12818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgAMN5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:57:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:57:15 -0800
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="217411967"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:57:13 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chen Zhou <chenzhou10@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        chenzhou10@huawei.com, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH next] drm/i915: fix build error without ACPI
In-Reply-To: <20200113132724.143687-1-chenzhou10@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200113132724.143687-1-chenzhou10@huawei.com>
Date:   Mon, 13 Jan 2020 15:57:10 +0200
Message-ID: <874kwzmpc9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Chen Zhou <chenzhou10@huawei.com> wrote:
> If CONFIG_ACPI=n and CONFIG_BACKLIGHT_CLASS_DEVICE=m, compilation complains
> with undefined references:
>
> drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_register':
> intel_panel.c:(.text+0x4dd9): undefined reference to `backlight_device_register'
> drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_unregister':
> intel_panel.c:(.text+0x4e96): undefined reference to `backlight_device_unregister'
>
> This patch select BACKLIGHT_CLASS_DEVICE directly.

i915 does not unconditionally require backlight.

See e.g. [1] for the details.

BR,
Jani.


[1] http://lore.kernel.org/r/87o8veotf9.fsf@intel.com

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/gpu/drm/i915/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index ba95959..6b69dab 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -16,7 +16,7 @@ config DRM_I915
>  	select IRQ_WORK
>  	# i915 depends on ACPI_VIDEO when ACPI is enabled
>  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
> -	select BACKLIGHT_CLASS_DEVICE if ACPI
> +	select BACKLIGHT_CLASS_DEVICE
>  	select INPUT if ACPI
>  	select ACPI_VIDEO if ACPI
>  	select ACPI_BUTTON if ACPI

-- 
Jani Nikula, Intel Open Source Graphics Center
