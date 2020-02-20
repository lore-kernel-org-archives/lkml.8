Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D723C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="La4IJsdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgBTXmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:42:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51467 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgBTXmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:42:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so183026pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7FzECIoWmkTb4/abn5eV9Q3RdOU/PqnT/XPfJdQsEBE=;
        b=La4IJsdnldRGbfdjU9f/pqYDP/RLb1PwT3aUwAiXTY8MtUIsYRozdqHGvVDKOCLSRx
         kwsWSzgkfb7n2wrAKKbpIdJl59krWqvmkfBydZV3gWJHR3RDJPewKa8pVjremcOiFOZQ
         oFriUzJBwcFdgSQbFWPke8cXQqWZWx9Q8DAGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7FzECIoWmkTb4/abn5eV9Q3RdOU/PqnT/XPfJdQsEBE=;
        b=Wwnug/3G1eOm1KBzzkS6TkElvP0ZPV7Dp4S3MW2B+ZoEvOzWoYUEnnRj8sYsnKwG0Y
         FaK3MK6L56rKDVxlZLxdhytlFwJ7St2kDd0EQfWGJpXKUMrB7HpTTgCeh06OZyMECP7k
         kgVYlRmUs4x/ZLJWcMP+9/R/E11SiheSWPFzZKJ56wAwxjmmbmIOTXKtQ2beGMaZs0ac
         9INZO+6is2EIjJsU3JgqPiareR7gefn23xmchQNegl2TJKXYzclb42lwljpMDeh4fAQT
         lE1hCYJbnJkR4rNqoptgnINJ7qCJnPj/VOvLemK78gLc1WweBgFGNFZvELrDoaNpX5wv
         BW8Q==
X-Gm-Message-State: APjAAAUW+QSuZMalTysvP3RFYECPaTE03tL0vEBWLCEIkU/Le9jAT4Hs
        6RkPk/g2Q/tI1BNNyEDyex6Kjg==
X-Google-Smtp-Source: APXvYqwMg90ilP8hoc+lqhGNIEe4V0hc3sENaQ4Oc2P0UG4oCuJ2itQTtl4fbtfcyiDk8JW4TItdhg==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr6040144pjn.141.1582242133573;
        Thu, 20 Feb 2020 15:42:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m15sm385729pgn.40.2020.02.20.15.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:42:12 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:42:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alexander Potapenko <glider@google.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Distribute switch variables for initialization
Message-ID: <202002201541.1B5347ABAD@keescook>
References: <20200220062258.68854-1-keescook@chromium.org>
 <877e0hv9t1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877e0hv9t1.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:21:14PM +0200, Jani Nikula wrote:
> On Wed, 19 Feb 2020, Kees Cook <keescook@chromium.org> wrote:
> > Variables declared in a switch statement before any case statements
> > cannot be automatically initialized with compiler instrumentation (as
> > they are not part of any execution flow). With GCC's proposed automatic
> > stack variable initialization feature, this triggers a warning (and they
> > don't get initialized). Clang's automatic stack variable initialization
> > (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> > doesn't initialize such variables[1]. Note that these warnings (or silent
> > skipping) happen before the dead-store elimination optimization phase,
> > so even when the automatic initializations are later elided in favor of
> > direct initializations, the warnings remain.
> >
> > To avoid these problems, move such variables into the "case" where
> > they're used or lift them up into the main function body.
> >
> > drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
> > drivers/gpu/drm/i915/display/intel_display.c:12963:17: warning: statement will never be executed [-Wswitch-unreachable]
> > 12963 |    unsigned int port_mask;
> >       |                 ^~~~~~~~~
> >
> > drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_get_fifo_size’:
> > drivers/gpu/drm/i915/intel_pm.c:474:7: warning: statement will never be executed [-Wswitch-unreachable]
> >   474 |   u32 dsparb, dsparb2, dsparb3;
> >       |       ^~~~~~
> > drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_atomic_update_fifo’:
> > drivers/gpu/drm/i915/intel_pm.c:1997:7: warning: statement will never be executed [-Wswitch-unreachable]
> >  1997 |   u32 dsparb, dsparb2, dsparb3;
> >       |       ^~~~~~
> >
> > [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks!

> 
> If you look at i915/Makefile, you'll see that we don't shy away from
> enabling lots of extra warnings, and we run our CI with -Werror to keep
> it clean. It does not seem like -Wswitch-unreachable does me any good,
> though... is it new?

It's already enabled by default, but the GCC feature that tweaks it
doesn't exist yet. But it points out a problem that exists for Clang
today, but Clang doesn't actually warn on (yet). So this is a fix to
avoid the silent Clang problem and fix future warnings before they
happen.

-Kees

> 
> BR,
> Jani.
> 
> 
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c |    6 ++++--
> >  drivers/gpu/drm/i915/intel_pm.c              |    4 ++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index 064dd99bbc49..c829cd26f99e 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -12960,14 +12960,15 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
> >  		WARN_ON(!connector_state->crtc);
> >  
> >  		switch (encoder->type) {
> > -			unsigned int port_mask;
> >  		case INTEL_OUTPUT_DDI:
> >  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
> >  				break;
> >  			/* else, fall through */
> >  		case INTEL_OUTPUT_DP:
> >  		case INTEL_OUTPUT_HDMI:
> > -		case INTEL_OUTPUT_EDP:
> > +		case INTEL_OUTPUT_EDP: {
> > +			unsigned int port_mask;
> > +
> >  			port_mask = 1 << encoder->port;
> >  
> >  			/* the same port mustn't appear more than once */
> > @@ -12976,6 +12977,7 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
> >  
> >  			used_ports |= port_mask;
> >  			break;
> > +		}
> >  		case INTEL_OUTPUT_DP_MST:
> >  			used_mst_ports |=
> >  				1 << encoder->port;
> > diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> > index bd2d30ecc030..17d8833787c4 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -469,9 +469,9 @@ static void vlv_get_fifo_size(struct intel_crtc_state *crtc_state)
> >  	struct vlv_fifo_state *fifo_state = &crtc_state->wm.vlv.fifo_state;
> >  	enum pipe pipe = crtc->pipe;
> >  	int sprite0_start, sprite1_start;
> > +	u32 dsparb, dsparb2, dsparb3;
> >  
> >  	switch (pipe) {
> > -		u32 dsparb, dsparb2, dsparb3;
> >  	case PIPE_A:
> >  		dsparb = I915_READ(DSPARB);
> >  		dsparb2 = I915_READ(DSPARB2);
> > @@ -1969,6 +1969,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
> >  	const struct vlv_fifo_state *fifo_state =
> >  		&crtc_state->wm.vlv.fifo_state;
> >  	int sprite0_start, sprite1_start, fifo_size;
> > +	u32 dsparb, dsparb2, dsparb3;
> >  
> >  	if (!crtc_state->fifo_changed)
> >  		return;
> > @@ -1994,7 +1995,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
> >  	spin_lock(&uncore->lock);
> >  
> >  	switch (crtc->pipe) {
> > -		u32 dsparb, dsparb2, dsparb3;
> >  	case PIPE_A:
> >  		dsparb = intel_uncore_read_fw(uncore, DSPARB);
> >  		dsparb2 = intel_uncore_read_fw(uncore, DSPARB2);
> >
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Kees Cook
