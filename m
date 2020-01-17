Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB4C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4DC20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me3lnXCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgAQUYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:24:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727519AbgAQUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579292661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf9AA1Vrd3DLvKm6Ua6uODP6RU9/ZU9r8t0dJGIFs0Q=;
        b=Me3lnXCdvVCtxDfHvpElbM7ysmXPPBSBDWyxn5OnXjRB6Zwp1vZy9x56rCOg0XdlLjtl1f
        4iI1726fs8DN55v11cuGq1FbH+4fAQ/W53J4NYKUbqxjuYTsXE88yByfr0BqCpPYK+V9Bp
        CEHj/LIzxni6SUCV50KG0XQqvbnjpxA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-IGH7PCvtNcSWqha0y5CM5w-1; Fri, 17 Jan 2020 15:24:16 -0500
X-MC-Unique: IGH7PCvtNcSWqha0y5CM5w-1
Received: by mail-qv1-f69.google.com with SMTP id e10so16317830qvq.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mf9AA1Vrd3DLvKm6Ua6uODP6RU9/ZU9r8t0dJGIFs0Q=;
        b=NgFN480wqlutQbnP5iwWxq98PDFo6IwHkmWAq/ZLqyI1vRnpQBpxvTQKO1l5LmZqmA
         U8ZKD78HZ976+NDOOD32gk7nzRlQkgrE1KxdnmjGYS7++dbwMc6nyGOcPUilAnU6s7Y5
         Em+EZ8nRrWbrG17mIJc0hK0MQgmaBgBho8U/stMLKzHGuxNYc7BOVcCE0ZzZgzAd0fn/
         8nastFZEM/GL9FVAHtKq0mguxySoHjbXoEmMkjDmsf5t4UCWL6KlMJxOomdtD7NKBKuj
         DmnWD05kWHCWSMVDQOQrHtyNRjTuDx9E1t3STr6Bx8uj+/52qCC+FLvMlU8a7gtowQXH
         H+2Q==
X-Gm-Message-State: APjAAAUfPfi75rKZJBX/WT+I9wLJjHovObc9hdlMzpdTfvlDIykswq2y
        18VLumDXR9dDbTYpqRw06huu3Z+R6JiLnoxNyXpxAaWSZyS2Fx2jNXoSCx/DBhD6O0XQqUb5VnB
        P6Ww0REg4Trxp2Ci75+/mTIFQ
X-Received: by 2002:a37:4894:: with SMTP id v142mr34009522qka.220.1579292655446;
        Fri, 17 Jan 2020 12:24:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwlUDiTuA85gc4BfifYDTWJNreGhhsYLQMYYCP9814iR0p9cnrDza9FwVuJ5nHHKd2SwlXFlg==
X-Received: by 2002:a37:4894:: with SMTP id v142mr34009504qka.220.1579292655192;
        Fri, 17 Jan 2020 12:24:15 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id q130sm12169501qka.114.2020.01.17.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:24:14 -0800 (PST)
Message-ID: <05569e0b86c62589e67a9355159e9db8e42c0820.camel@redhat.com>
Subject: Re: [PATCH v3 4/5] drm/i915: Don't use VBT for detecting DPCD
 backlight controls
From:   Lyude Paul <lyude@redhat.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, Perry Yuan <pyuan@redhat.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Jan 2020 15:24:13 -0500
In-Reply-To: <87zhemgvrn.fsf@intel.com>
References: <20200116211623.53799-1-lyude@redhat.com>
         <20200116211623.53799-5-lyude@redhat.com> <87zhemgvrn.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-17 at 13:36 +0200, Jani Nikula wrote:
> On Thu, 16 Jan 2020, Lyude Paul <lyude@redhat.com> wrote:
> > Despite the fact that the VBT appears to have a field for specifying
> > that a system is equipped with a panel that supports standard VESA
> > backlight controls over the DP AUX channel, so far every system we've
> > spotted DPCD backlight control support on doesn't actually set this
> > field correctly and all have it set to INTEL_BACKLIGHT_DISPLAY_DDI.
> > 
> > While we don't know the exact reason for this VBT misuse, talking with
> > some vendors indicated that there's a good number of laptop panels out
> > there that supposedly support both PWM backlight controls and DPCD
> > backlight controls as a workaround until Intel supports DPCD backlight
> > controls across platforms universally. This being said, the X1 Extreme
> > 2nd Gen that I have here (note that Lenovo is not the hardware vendor
> > that informed us of this) PWM backlight controls are advertised, but
> > only DPCD controls actually function. I'm going to make an educated
> > guess here and say that on systems like this one, it's likely that PWM
> > backlight controls might have been intended to work but were never
> > really tested by QA.
> > 
> > Since we really need backlights to work without any extra module
> > parameters, let's take the risk here and rely on the standard DPCD caps
> > to tell us whether AUX backlight controls are supported or not. We still
> > check the VBT, but only to make sure that we don't enable DPCD backlight
> > controls on a panel that uses something other then the standard VESA
> > interfaces over AUX. Since panels using such non-standard interfaces
> > should probably have support added to i915, we'll print a warning when
> > seeing this in the VBT. We can remove this warning later if we end up
> > adding support for any custom backlight interfaces.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=112376
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Perry Yuan <pyuan@redhat.com>
> > Cc: AceLan Kao <acelan.kao@canonical.com>
> > ---
> >  .../drm/i915/display/intel_dp_aux_backlight.c    | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > index 77a759361c5c..3002b600635f 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > @@ -330,13 +330,17 @@ int intel_dp_aux_init_backlight_funcs(struct
> > intel_connector *intel_connector)
> >  	struct intel_panel *panel = &intel_connector->panel;
> >  	struct drm_i915_private *dev_priv = to_i915(intel_connector-
> > >base.dev);
> >  
> > -	if (i915_modparams.enable_dpcd_backlight == 0 ||
> > -	    (i915_modparams.enable_dpcd_backlight == -1 &&
> > -	    dev_priv->vbt.backlight.type !=
> > INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE))
> > -		return -ENODEV;
> > -
> > -	if (!intel_dp_aux_display_control_capable(intel_connector))
> > +	if (i915_modparams.enable_dpcd_backlight == 0)
> >  		return -ENODEV;
> > +	if (i915_modparams.enable_dpcd_backlight == -1) {
> > +		if (dev_priv->vbt.backlight.type
> > +		    == INTEL_BACKLIGHT_PANEL_DRIVER_INTERFACE) {
> > +			DRM_WARN("VBT says panel uses custom panel driver
> > interface, not using DPCD backlight controls\n");
> > +			return -ENODEV;
> > +		}
> > +		if (!intel_dp_aux_display_control_capable(intel_connector))
> > +			return -ENODEV;
> 
> Functionally, I'm fine with trying this. But perhaps we should check aux
> and early return first, and then check what vbt says, to reduce the
> dmesg noise.
> 
> I'll probably want to see a debug message if we're enabling aux
> backlight even if dev_priv->vbt.backlight.type !=
> INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE. It's the kind of debug trace
> you'll really want to get first.

Good point, I'll send a respin of this patch with those changes
> 
> BR,
> Jani.
> 
> 
> 
> > +	}
> >  
> >  	panel->backlight.setup = intel_dp_aux_setup_backlight;
> >  	panel->backlight.enable = intel_dp_aux_enable_backlight;
-- 
Cheers,
	Lyude Paul

