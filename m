Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF0C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBAD22522
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZQaiuQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCJSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:43:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgCJSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583865824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DpR2+rDRm/5siffJtWBBI9nbBmh//iyJt6PJfdkXrk=;
        b=UZQaiuQHUAoTBnGSCKNi74x0YkvZZMDaguZKIkzGowUUibDF3mJlIp/rTOckNVfV97zG4Q
        M8yXG6GjEL+bNOChGKIIWYZaRhgmmuTXMUaa9KQ6hoE9cVwZJ628YP5OYmXXui0aoM2bb1
        BbCiTRiqPMT1didlmMIIQIzDSWCgQE0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-1qpvov7LMsCGhowew-NY4w-1; Tue, 10 Mar 2020 14:43:43 -0400
X-MC-Unique: 1qpvov7LMsCGhowew-NY4w-1
Received: by mail-qt1-f197.google.com with SMTP id y11so7576034qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=/DpR2+rDRm/5siffJtWBBI9nbBmh//iyJt6PJfdkXrk=;
        b=R2qYH38Catieiwctq04v+qGeNhtt1OA7giFEsjoA/8tpVZiJo/YvYb1WF16jxoDepc
         w+5auUfmDyJ7LpTD8wjwyrIaYMzDzRBhuw2DKSLOWyMMCk70X70fHzz95fI0R0BZ3jUU
         yyX/kK718YgCHnz1bq9L+fwlt+B9PRBKEyofZcJx3rGAXIPTL5DUeTu0LT+wzj+PUcAV
         ZKS/4tT6lWyoVHlDO7+7bysOmR1XYW1EKpRX9xxGPPks9CkvsiHUlnWGieAUUQY77Ijf
         Xyfkg6zPaYyZqeBw+BBb0hGAqSTPLBrU/7U6Lfgf1ZlRMCPxQfhHavRoRueGHAGTovy0
         6BWg==
X-Gm-Message-State: ANhLgQ0wSy8hEGlZngxjxK0eHxG4VkNvPbsl40ybWMglY9VM0LFLxM7O
        2rhygwDcj8/Z2K5EqEgS1me3WGQ7+W44VRBgurtnFzZrdKhMKfL/YITGlQCmpUgVA1B4XNhYm5Y
        yCT8d2eoadQfvPOqPq1/nCPsI
X-Received: by 2002:a37:5c9:: with SMTP id 192mr21570876qkf.103.1583865822625;
        Tue, 10 Mar 2020 11:43:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsSZqFX3FEhejcb1/uccPf30JOj4XcmJWeGyzmJm+MgbADKlbO5BpXSG6UdLpMUnjzhVGxUtg==
X-Received: by 2002:a37:5c9:: with SMTP id 192mr21570854qkf.103.1583865822404;
        Tue, 10 Mar 2020 11:43:42 -0700 (PDT)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id d73sm6419455qkg.113.2020.03.10.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:43:41 -0700 (PDT)
Message-ID: <b336c114f09cfe79824c4fe0b33960f80edd00b1.camel@redhat.com>
Subject: Re: [PATCH] drm/i915/mst: Hookup DRM DP MST
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 14:43:40 -0400
In-Reply-To: <20200310184220.GO13686@intel.com>
References: <20200310182856.1587752-1-lyude@redhat.com>
         <20200310184220.GO13686@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 20:42 +0200, Ville Syrjälä wrote:
> On Tue, Mar 10, 2020 at 02:28:54PM -0400, Lyude Paul wrote:
> > i915 can enable aux device nodes for DP MST by calling
> > drm_dp_mst_connector_late_register()/drm_dp_mst_connector_early_unregister
> > (),
> > so let's hook that up.
> 
> Oh, we didn't have that yet? I thought it got hooked up for everyone
> but I guess not.
> 
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp_mst.c | 22 +++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > index d53978ed3c12..bcff2e06ead6 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > @@ -548,12 +548,30 @@ static int intel_dp_mst_get_ddc_modes(struct
> > drm_connector *connector)
> >  	return ret;
> >  }
> >  
> > +static int
> > +intel_dp_mst_connector_late_register(struct drm_connector *connector)
> > +{
> > +	struct intel_connector *intel_connector =
> > to_intel_connector(connector);
> > +
> > +	return drm_dp_mst_connector_late_register(connector,
> > +						  intel_connector->port);
> > +}
> > +
> > +static void
> > +intel_dp_mst_connector_early_unregister(struct drm_connector *connector)
> > +{
> > +	struct intel_connector *intel_connector =
> > to_intel_connector(connector);
> > +
> > +	drm_dp_mst_connector_early_unregister(connector,
> > +					      intel_connector->port);
> > +}
> > +
> >  static const struct drm_connector_funcs intel_dp_mst_connector_funcs = {
> >  	.fill_modes = drm_helper_probe_single_connector_modes,
> >  	.atomic_get_property = intel_digital_connector_atomic_get_property,
> >  	.atomic_set_property = intel_digital_connector_atomic_set_property,
> > -	.late_register = intel_connector_register,
> 
> Dunno if we want to lose the error injection...

Gotcha, will send out a fixed respin in just a moment
> 
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

