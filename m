Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D36C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2213B24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgB0NJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:09:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:45400 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgB0NJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:09:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 05:09:05 -0800
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="227136570"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 05:09:01 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>, daniel@ffwll.ch,
        airlied@linux.ie,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 16/21] drm/i915: make *_debugfs_register() functions return void.
In-Reply-To: <20200227120232.19413-17-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200227120232.19413-1-wambui.karugax@gmail.com> <20200227120232.19413-17-wambui.karugax@gmail.com>
Date:   Thu, 27 Feb 2020 15:08:58 +0200
Message-ID: <87zhd4qis5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> Since 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> fails and should return void. Therefore, remove its use as the
> return value of i915_debugfs_register() and
> intel_display_debugfs_register() and have both functions return void.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++----
>  drivers/gpu/drm/i915/display/intel_display_debugfs.h | 4 ++--
>  drivers/gpu/drm/i915/i915_debugfs.c                  | 8 ++++----
>  drivers/gpu/drm/i915/i915_debugfs.h                  | 4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> index 46954cc7b6c0..3b877c34c420 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> @@ -1922,7 +1922,7 @@ static const struct {
>  	{"i915_edp_psr_debug", &i915_edp_psr_debug_fops},
>  };
>  
> -int intel_display_debugfs_register(struct drm_i915_private *i915)
> +void intel_display_debugfs_register(struct drm_i915_private *i915)
>  {
>  	struct drm_minor *minor = i915->drm.primary;
>  	int i;
> @@ -1935,9 +1935,9 @@ int intel_display_debugfs_register(struct drm_i915_private *i915)
>  				    intel_display_debugfs_files[i].fops);
>  	}
>  
> -	return drm_debugfs_create_files(intel_display_debugfs_list,
> -					ARRAY_SIZE(intel_display_debugfs_list),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(intel_display_debugfs_list,
> +				 ARRAY_SIZE(intel_display_debugfs_list),
> +				 minor->debugfs_root, minor);
>  }
>  
>  static int i915_panel_show(struct seq_file *m, void *data)
> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.h b/drivers/gpu/drm/i915/display/intel_display_debugfs.h
> index a3bea1ce04c2..a5cf7a6d3d34 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.h
> @@ -10,10 +10,10 @@ struct drm_connector;
>  struct drm_i915_private;
>  
>  #ifdef CONFIG_DEBUG_FS
> -int intel_display_debugfs_register(struct drm_i915_private *i915);
> +void intel_display_debugfs_register(struct drm_i915_private *i915);
>  int intel_connector_debugfs_add(struct drm_connector *connector);
>  #else
> -static inline int intel_display_debugfs_register(struct drm_i915_private *i915) { return 0; }
> +static inline int intel_display_debugfs_register(struct drm_i915_private *i915) {}

You don't actually change the return type.

Otherwise, LGTM.

BR,
Jani.

>  static inline int intel_connector_debugfs_add(struct drm_connector *connector) { return 0; }
>  #endif
>  
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 8f2525e4ce0f..de313199c714 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -2392,7 +2392,7 @@ static const struct i915_debugfs_files {
>  	{"i915_guc_log_relay", &i915_guc_log_relay_fops},
>  };
>  
> -int i915_debugfs_register(struct drm_i915_private *dev_priv)
> +void i915_debugfs_register(struct drm_i915_private *dev_priv)
>  {
>  	struct drm_minor *minor = dev_priv->drm.primary;
>  	int i;
> @@ -2409,7 +2409,7 @@ int i915_debugfs_register(struct drm_i915_private *dev_priv)
>  				    i915_debugfs_files[i].fops);
>  	}
>  
> -	return drm_debugfs_create_files(i915_debugfs_list,
> -					I915_DEBUGFS_ENTRIES,
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(i915_debugfs_list,
> +				 I915_DEBUGFS_ENTRIES,
> +				 minor->debugfs_root, minor);
>  }
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.h b/drivers/gpu/drm/i915/i915_debugfs.h
> index 6da39c76ab5e..1de2736f1248 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.h
> +++ b/drivers/gpu/drm/i915/i915_debugfs.h
> @@ -12,10 +12,10 @@ struct drm_i915_private;
>  struct seq_file;
>  
>  #ifdef CONFIG_DEBUG_FS
> -int i915_debugfs_register(struct drm_i915_private *dev_priv);
> +void i915_debugfs_register(struct drm_i915_private *dev_priv);
>  void i915_debugfs_describe_obj(struct seq_file *m, struct drm_i915_gem_object *obj);
>  #else
> -static inline int i915_debugfs_register(struct drm_i915_private *dev_priv) { return 0; }
> +static inline void i915_debugfs_register(struct drm_i915_private *dev_priv) {}
>  static inline void i915_debugfs_describe_obj(struct seq_file *m, struct drm_i915_gem_object *obj) {}
>  #endif

-- 
Jani Nikula, Intel Open Source Graphics Center
