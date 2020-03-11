Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9700C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82188208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgCKIPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:15:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:5732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbgCKIPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:15:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 01:15:42 -0700
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="236353114"
Received: from mkuta-mobl.ger.corp.intel.com (HELO localhost) ([10.249.39.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 01:15:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 14/17] drm/i915: have *_debugfs_init() functions return void.
In-Reply-To: <20200310133121.27913-15-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200310133121.27913-1-wambui.karugax@gmail.com> <20200310133121.27913-15-wambui.karugax@gmail.com>
Date:   Wed, 11 Mar 2020 10:15:55 +0200
Message-ID: <87y2s7l32c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> Since commit 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> fails and should return void. Therefore, remove its use as the
> return value of debugfs_init() functions and have the functions return
> void.
>
> v2: convert intel_display_debugfs_register() stub to return void too.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++----
>  drivers/gpu/drm/i915/display/intel_display_debugfs.h | 4 ++--
>  drivers/gpu/drm/i915/i915_debugfs.c                  | 8 ++++----
>  drivers/gpu/drm/i915/i915_debugfs.h                  | 4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> index 1e6eb7f2f72d..424f4e52f783 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> @@ -1927,7 +1927,7 @@ static const struct {
>  	{"i915_edp_psr_debug", &i915_edp_psr_debug_fops},
>  };
>  
> -int intel_display_debugfs_register(struct drm_i915_private *i915)
> +void intel_display_debugfs_register(struct drm_i915_private *i915)
>  {
>  	struct drm_minor *minor = i915->drm.primary;
>  	int i;
> @@ -1940,9 +1940,9 @@ int intel_display_debugfs_register(struct drm_i915_private *i915)
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
> index a3bea1ce04c2..c922c1745bfe 100644
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
> +static inline void intel_display_debugfs_register(struct drm_i915_private *i915) {}
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
