Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B90BC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FAA208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBULbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:31:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:53292 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBULbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:31:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 03:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; 
   d="scan'208";a="229824548"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 21 Feb 2020 03:30:58 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 21 Feb 2020 13:30:57 +0200
Date:   Fri, 21 Feb 2020 13:30:57 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Distribute switch variables for
 initialization
Message-ID: <20200221113057.GL13686@intel.com>
References: <202002201602.92CADF7D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202002201602.92CADF7D@keescook>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:05:17PM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
> drivers/gpu/drm/i915/display/intel_display.c:12963:17: warning: statement will never be executed [-Wswitch-unreachable]
> 12963 |    unsigned int port_mask;
>       |                 ^~~~~~~~~
> 
> drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_get_fifo_size’:
> drivers/gpu/drm/i915/intel_pm.c:474:7: warning: statement will never be executed [-Wswitch-unreachable]
>   474 |   u32 dsparb, dsparb2, dsparb3;
>       |       ^~~~~~
> drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_atomic_update_fifo’:
> drivers/gpu/drm/i915/intel_pm.c:1997:7: warning: statement will never be executed [-Wswitch-unreachable]
>  1997 |   u32 dsparb, dsparb2, dsparb3;
>       |       ^~~~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: remove port_mask entirely (Ville Syrjälä)
> v1: https://lore.kernel.org/lkml/20200220062258.68854-1-keescook@chromium.org
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 7 ++-----
>  drivers/gpu/drm/i915/intel_pm.c              | 4 ++--
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 064dd99bbc49..5f8c61932e82 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -12960,7 +12960,6 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  		WARN_ON(!connector_state->crtc);
>  
>  		switch (encoder->type) {
> -			unsigned int port_mask;
>  		case INTEL_OUTPUT_DDI:
>  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
>  				break;
> @@ -12968,13 +12967,11 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  		case INTEL_OUTPUT_DP:
>  		case INTEL_OUTPUT_HDMI:
>  		case INTEL_OUTPUT_EDP:
> -			port_mask = 1 << encoder->port;
> -
>  			/* the same port mustn't appear more than once */
> -			if (used_ports & port_mask)
> +			if (used_ports & BIT(encoder->port))
>  				ret = false;
>  
> -			used_ports |= port_mask;
> +			used_ports |= BIT(encoder->port);

Thanks. Looks good.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  			break;
>  		case INTEL_OUTPUT_DP_MST:
>  			used_mst_ports |=
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index bd2d30ecc030..17d8833787c4 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -469,9 +469,9 @@ static void vlv_get_fifo_size(struct intel_crtc_state *crtc_state)
>  	struct vlv_fifo_state *fifo_state = &crtc_state->wm.vlv.fifo_state;
>  	enum pipe pipe = crtc->pipe;
>  	int sprite0_start, sprite1_start;
> +	u32 dsparb, dsparb2, dsparb3;
>  
>  	switch (pipe) {
> -		u32 dsparb, dsparb2, dsparb3;
>  	case PIPE_A:
>  		dsparb = I915_READ(DSPARB);
>  		dsparb2 = I915_READ(DSPARB2);
> @@ -1969,6 +1969,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
>  	const struct vlv_fifo_state *fifo_state =
>  		&crtc_state->wm.vlv.fifo_state;
>  	int sprite0_start, sprite1_start, fifo_size;
> +	u32 dsparb, dsparb2, dsparb3;
>  
>  	if (!crtc_state->fifo_changed)
>  		return;
> @@ -1994,7 +1995,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
>  	spin_lock(&uncore->lock);
>  
>  	switch (crtc->pipe) {
> -		u32 dsparb, dsparb2, dsparb3;
>  	case PIPE_A:
>  		dsparb = intel_uncore_read_fw(uncore, DSPARB);
>  		dsparb2 = intel_uncore_read_fw(uncore, DSPARB2);
> -- 
> 2.20.1
> 
> 
> -- 
> Kees Cook
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
