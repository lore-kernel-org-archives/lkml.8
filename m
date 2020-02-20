Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A20C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE252465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBTKVV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:21:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:14094 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTKVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:21:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 02:21:19 -0800
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="224819481"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 02:21:16 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Distribute switch variables for initialization
In-Reply-To: <20200220062258.68854-1-keescook@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200220062258.68854-1-keescook@chromium.org>
Date:   Thu, 20 Feb 2020 12:21:14 +0200
Message-ID: <877e0hv9t1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020, Kees Cook <keescook@chromium.org> wrote:
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

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

If you look at i915/Makefile, you'll see that we don't shy away from
enabling lots of extra warnings, and we run our CI with -Werror to keep
it clean. It does not seem like -Wswitch-unreachable does me any good,
though... is it new?

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/intel_display.c |    6 ++++--
>  drivers/gpu/drm/i915/intel_pm.c              |    4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 064dd99bbc49..c829cd26f99e 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -12960,14 +12960,15 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  		WARN_ON(!connector_state->crtc);
>  
>  		switch (encoder->type) {
> -			unsigned int port_mask;
>  		case INTEL_OUTPUT_DDI:
>  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
>  				break;
>  			/* else, fall through */
>  		case INTEL_OUTPUT_DP:
>  		case INTEL_OUTPUT_HDMI:
> -		case INTEL_OUTPUT_EDP:
> +		case INTEL_OUTPUT_EDP: {
> +			unsigned int port_mask;
> +
>  			port_mask = 1 << encoder->port;
>  
>  			/* the same port mustn't appear more than once */
> @@ -12976,6 +12977,7 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  
>  			used_ports |= port_mask;
>  			break;
> +		}
>  		case INTEL_OUTPUT_DP_MST:
>  			used_mst_ports |=
>  				1 << encoder->port;
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
>

-- 
Jani Nikula, Intel Open Source Graphics Center
