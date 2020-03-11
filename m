Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE514C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E020637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgCKDYw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:24:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37014 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgCKDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:24:51 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jBrzF-0007My-Ac
        for linux-kernel@vger.kernel.org; Wed, 11 Mar 2020 03:24:49 +0000
Received: by mail-pl1-f198.google.com with SMTP id t12so455555plo.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oRt0r5cQTWUQ10ZviHACsht2XJOWhlaJ3TIQeyqnNOc=;
        b=um3DeKnPNlGoubwL4i1LOqlLusYMjIVoPtM62m7X0h4KbfszP8iiIhrdib+wWJdycE
         PZorGmuzzrkfcXY4jJC7JJk7nx8Y2vFY5ON16HHAH7RjpXW44Xmla4f5BcaBK0DHDjyK
         F9fY4C4nCyhmoQjeSM6GuYPQvUD8KAoftP3NZc9Dar6dE6j//SHqB9OfXLyOBtQ9uzQq
         zx0eIdp+KVrwiEiOIOTkqvPip5i/BXCjio7GeUC4azDYobvCWuIl0LizVsAbamkVj+aH
         enXhpkeAkGenj10UMnEClTwTuFJLj/obWElr7QNxQBZN3C782FeafdrEBycsJwOOEAWF
         8v1Q==
X-Gm-Message-State: ANhLgQ1jsLf5JfaAiundoHak9i4ABXrUL4CsepuL6itp2Xxn9kPVMlCc
        b/kHwebEOQqq+xUX4O12E9ySfz+pTVZYefB4EXTQpB/9CsSxZTwrwriKpxKjppeWGyPK4LFlsd2
        4nIvMoolagUHMumfe24+Nvf3o62B4Y3D4FoxBSeDgTg==
X-Received: by 2002:a17:90a:32c1:: with SMTP id l59mr1218852pjb.36.1583897087296;
        Tue, 10 Mar 2020 20:24:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtb3Z/ZhpW29byvyayNnkOxyFhRWMBPu8qji7cSAN4BTEGvxgPVg080tlWXF4JQh+s6ylKB9w==
X-Received: by 2002:a17:90a:32c1:: with SMTP id l59mr1218820pjb.36.1583897086766;
        Tue, 10 Mar 2020 20:24:46 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id h24sm7942000pfn.49.2020.03.10.20.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 20:24:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v4] drm/i915: Init lspcon after HPD in intel_dp_detect()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200214175646.25532-1-kai.heng.feng@canonical.com>
Date:   Wed, 11 Mar 2020 11:24:37 +0800
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6AA2A997-76BB-4BF9-B292-67A5F0C4770B@canonical.com>
References: <20200214175646.25532-1-kai.heng.feng@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        ville.syrjala@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2020, at 01:56, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
> becomes useless and never responds to cable hotplugging:
> [    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
> [    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D
> 
> Seems like the lspcon chip on the system in question only gets powered
> after the cable is plugged.
> 
> So let's call lspcon_init() dynamically to properly initialize the
> lspcon chip and make HDMI port work.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping.

> ---
> v4:
> - Trust VBT in intel_infoframe_init().
> - Init lspcon in intel_dp_detect().
> 
> v3:
> - Make sure it's handled under long HPD case.
> 
> v2: 
> - Move lspcon_init() inside of intel_dp_hpd_pulse().
> 
> drivers/gpu/drm/i915/display/intel_ddi.c  | 17 +----------------
> drivers/gpu/drm/i915/display/intel_dp.c   | 13 ++++++++++++-
> drivers/gpu/drm/i915/display/intel_hdmi.c |  2 +-
> 3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 33f1dc3d7c1a..ca717434b406 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4741,7 +4741,7 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
> 		&dev_priv->vbt.ddi_port_info[port];
> 	struct intel_digital_port *intel_dig_port;
> 	struct intel_encoder *encoder;
> -	bool init_hdmi, init_dp, init_lspcon = false;
> +	bool init_hdmi, init_dp;
> 	enum phy phy = intel_port_to_phy(dev_priv, port);
> 
> 	init_hdmi = port_info->supports_dvi || port_info->supports_hdmi;
> @@ -4754,7 +4754,6 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
> 		 * is initialized before lspcon.
> 		 */
> 		init_dp = true;
> -		init_lspcon = true;
> 		init_hdmi = false;
> 		DRM_DEBUG_KMS("VBT says port %c has lspcon\n", port_name(port));
> 	}
> @@ -4833,20 +4832,6 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
> 			goto err;
> 	}
> 
> -	if (init_lspcon) {
> -		if (lspcon_init(intel_dig_port))
> -			/* TODO: handle hdmi info frame part */
> -			DRM_DEBUG_KMS("LSPCON init success on port %c\n",
> -				port_name(port));
> -		else
> -			/*
> -			 * LSPCON init faied, but DP init was success, so
> -			 * lets try to drive as DP++ port.
> -			 */
> -			DRM_ERROR("LSPCON init failed on port %c\n",
> -				port_name(port));
> -	}
> -
> 	intel_infoframe_init(intel_dig_port);
> 
> 	return;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index c7424e2a04a3..43117aa86292 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5663,8 +5663,19 @@ intel_dp_detect(struct drm_connector *connector,
> 	/* Can't disconnect eDP */
> 	if (intel_dp_is_edp(intel_dp))
> 		status = edp_detect(intel_dp);
> -	else if (intel_digital_port_connected(encoder))
> +	else if (intel_digital_port_connected(encoder)) {
> +		if (intel_bios_is_lspcon_present(dev_priv, dig_port->base.port) &&
> +		    !dig_port->lspcon.active) {
> +			if (lspcon_init(dig_port))
> +				DRM_DEBUG_KMS("LSPCON init success on port %c\n",
> +					      port_name(dig_port->base.port));
> +			else
> +				DRM_DEBUG_KMS("LSPCON init failed on port %c\n",
> +					      port_name(dig_port->base.port));
> +		}
> +
> 		status = intel_dp_detect_dpcd(intel_dp);
> +	}
> 	else
> 		status = connector_status_disconnected;
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 93ac0f296852..27a5aa8cefc9 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -3100,7 +3100,7 @@ void intel_infoframe_init(struct intel_digital_port *intel_dig_port)
> 		intel_dig_port->set_infoframes = g4x_set_infoframes;
> 		intel_dig_port->infoframes_enabled = g4x_infoframes_enabled;
> 	} else if (HAS_DDI(dev_priv)) {
> -		if (intel_dig_port->lspcon.active) {
> +		if (intel_bios_is_lspcon_present(dev_priv, intel_dig_port->base.port)) {
> 			intel_dig_port->write_infoframe = lspcon_write_infoframe;
> 			intel_dig_port->read_infoframe = lspcon_read_infoframe;
> 			intel_dig_port->set_infoframes = lspcon_set_infoframes;
> -- 
> 2.17.1
> 

