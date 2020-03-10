Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E59C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F621D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmhfD4+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCJTrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:47:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727272AbgCJTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583869653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSuNQN7bkbnRo2jTjLcey0ERJ9aP7xPAWWvzSr4tTJ4=;
        b=TmhfD4+jH5xrLyAPUR/Tu6+KQ4fTnwIi5RH4yuFZhhc1wR/ud/zC1S34NHvxIM0wyHCjPQ
        VoIRTWReakLyV9iq9kkiIDWVZQet7cRRUhOPU1cBQeZDLoa/vPIu3RHKQFOofXx32vEHOe
        wIE1Opzb+q18f9E/uLqW9MWH6bjNc6o=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-N7Y34cshNmGjyePHaF9UQw-1; Tue, 10 Mar 2020 15:47:31 -0400
X-MC-Unique: N7Y34cshNmGjyePHaF9UQw-1
Received: by mail-yw1-f71.google.com with SMTP id o79so22781916ywo.14
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=iSuNQN7bkbnRo2jTjLcey0ERJ9aP7xPAWWvzSr4tTJ4=;
        b=YtJDIAds/abj9Kn0wfm5skOWHC6YXqa2xzyOY/nCPKQNe8IEMLToegQTeG3ldYr+bZ
         7SqIaWOlV3MlhBXdy7f7meakKrlKwxSSMEBti5VnD6wTvC15QWa2OXbnj8YNecP2HeVt
         aKaeES+ihag2YvczFdOCYNrGvFaOxmSDxZdp3axXvmQXdsWvEIJzmFkFGtTbA7b3iUS/
         K7ll3nokqJrYLkqWtEdJlmkWTrQjl8LWfzHK0uUlm8PCfTKOmUDvJ5g2o0ZuWQED5leU
         cmDYc6LPZLQxrWowz+nRsbsT+9K21rsPKYAcK03+eHnLymUtHufdqo5VGw6etipZSeTk
         8dig==
X-Gm-Message-State: ANhLgQ3GrMm00JCZ20o78niAstkn2WaWs+LEiyzFz+bRh6qxavLuRBZ8
        nPsb8rBw0xGyvfz44QwoILQHMaq/qsmJV8nGTpEwMPap7gsNqm6SDKYZ1sEp9Z0f7wHF21NtvSs
        y057MYkT6pZQCPOY1bRGThSkh
X-Received: by 2002:a25:6b06:: with SMTP id g6mr23941423ybc.416.1583869651353;
        Tue, 10 Mar 2020 12:47:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+gjt5dPcZNpRF0gGOOsUFCPRSfZuJFDt5ztKFhVFxuvZF6Q/wbM92HD0h6S4jndbT/LEJAQ==
X-Received: by 2002:a25:6b06:: with SMTP id g6mr23941403ybc.416.1583869651122;
        Tue, 10 Mar 2020 12:47:31 -0700 (PDT)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id x126sm2883969ywx.90.2020.03.10.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:47:30 -0700 (PDT)
Message-ID: <a6ef7b4c7e55aa81168e60473b412e6b7efc37b3.camel@redhat.com>
Subject: Re: [PATCH v2] drm/i915/mst: Hookup DRM DP MST
 late_register/early_unregister callbacks
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Manasi Navare <manasi.d.navare@intel.com>,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 15:47:28 -0400
In-Reply-To: <20200310190604.GP13686@intel.com>
References: <20200310185417.1588984-1-lyude@redhat.com>
         <20200310190604.GP13686@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 21:06 +0200, Ville Syrjälä wrote:
> On Tue, Mar 10, 2020 at 02:54:16PM -0400, Lyude Paul wrote:
> > i915 can enable aux device nodes for DP MST by calling
> > drm_dp_mst_connector_late_register()/drm_dp_mst_connector_early_unregister
> > (),
> > so let's hook that up.
> > 
> > Changes since v1:
> > * Call intel_connector_register/unregister() from
> >   intel_dp_mst_connector_late_register/unregister() so we don't lose
> >   error injection - Ville Syrjälä
> > 
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp_mst.c | 28 +++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > index d53978ed3c12..9311c10f5b1b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > @@ -548,12 +548,36 @@ static int intel_dp_mst_get_ddc_modes(struct
> > drm_connector *connector)
> >  	return ret;
> >  }
> >  
> > +static int
> > +intel_dp_mst_connector_late_register(struct drm_connector *connector)
> > +{
> > +	struct intel_connector *intel_connector =
> > to_intel_connector(connector);
> > +	int ret;
> > +
> > +	ret = drm_dp_mst_connector_late_register(connector,
> > +						 intel_connector->port);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return intel_connector_register(connector);
> 
> Don't we have to undo the damage if this fails?

Yep, whoops. Will send out another respin with this fixed

> 
> > +}
> > +
> > +static void
> > +intel_dp_mst_connector_early_unregister(struct drm_connector *connector)
> > +{
> > +	struct intel_connector *intel_connector =
> > to_intel_connector(connector);
> > +
> > +	intel_connector_unregister(connector);
> > +	drm_dp_mst_connector_early_unregister(connector,
> > +					      intel_connector->port);
> > +}
> > +
> >  static const struct drm_connector_funcs intel_dp_mst_connector_funcs = {
> >  	.fill_modes = drm_helper_probe_single_connector_modes,
> >  	.atomic_get_property = intel_digital_connector_atomic_get_property,
> >  	.atomic_set_property = intel_digital_connector_atomic_set_property,
> > -	.late_register = intel_connector_register,
> > -	.early_unregister = intel_connector_unregister,
> > +	.late_register = intel_dp_mst_connector_late_register,
> > +	.early_unregister = intel_dp_mst_connector_early_unregister,
> >  	.destroy = intel_connector_destroy,
> >  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> >  	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
> > -- 
> > 2.24.1
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

