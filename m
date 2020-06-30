Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB35DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B126D206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbgF3JlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:41:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:1826 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgF3JlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:41:17 -0400
IronPort-SDR: J7Z1DAyHGKw8UNk9SgLRiui3RWXhU1+xTPkgrvb36h/KrU5AX/BisrNensqMkCDKtb6c6Qhy/U
 UCistYH4xCmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="146175885"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="146175885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 02:41:16 -0700
IronPort-SDR: CAxgFpBBhNPa96ZUWaZgtD2EIjf2Fi+xqonxVo6fWUD8pjD30JRXcsiL/kMwvH6VYofFxvB+Vn
 yrLLABSqLB0A==
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="454543857"
Received: from rgrotewx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 02:41:13 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915: fix a couple of spelling mistakes in kernel parameter help text
In-Reply-To: <20200616082129.65517-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200616082129.65517-1-colin.king@canonical.com>
Date:   Tue, 30 Jun 2020 12:41:11 +0300
Message-ID: <87ftacnb60.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a couple of spelling mistakes in kernel parameter help text,
> namely "helpfull" and "paramters".  Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Pushed, thanks for the patch.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/i915_params.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> index a7b61e6ec508..8d8db9ff0a48 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -99,8 +99,8 @@ i915_param_named_unsafe(enable_psr, int, 0400,
>  
>  i915_param_named(psr_safest_params, bool, 0400,
>  	"Replace PSR VBT parameters by the safest and not optimal ones. This "
> -	"is helpfull to detect if PSR issues are related to bad values set in "
> -	" VBT. (0=use VBT paramters, 1=use safest parameters)");
> +	"is helpful to detect if PSR issues are related to bad values set in "
> +	" VBT. (0=use VBT parameters, 1=use safest parameters)");
>  
>  i915_param_named_unsafe(force_probe, charp, 0400,
>  	"Force probe the driver for specified devices. "

-- 
Jani Nikula, Intel Open Source Graphics Center
