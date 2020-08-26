Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F065C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D975E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xoog88EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHZRKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbgHZRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598461850;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcBa7RmDpyrfsqq3prem5Mbj7x2aZK4SMmHyJpvaSdY=;
        b=Xoog88EJ5RXwQngL7VjP/P4W4+QHaJeHcRWJq7//Z1oZ8pc5RkxLH6Rt+zPoTFXpfSk5BO
        Ae5I+88fOfSC97mqW+60wpyPqb1pEVr5BT0vCSCQfnC9vQf6wlh6kervwhnXoiesyBzbCj
        JdCAuxZ9lcYBK4lqRh3AkrEpc+ulDRQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-ob3OiZ2fNF6hAaRvQeJG6w-1; Wed, 26 Aug 2020 13:10:48 -0400
X-MC-Unique: ob3OiZ2fNF6hAaRvQeJG6w-1
Received: by mail-qt1-f197.google.com with SMTP id f11so2248247qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=DcBa7RmDpyrfsqq3prem5Mbj7x2aZK4SMmHyJpvaSdY=;
        b=LblxXvewMk6R3iFbt9HJxYbT/ci5gV09DQUlNobIN9z3IRqSJZTdORJihamX3y4Ncu
         8WMHPV31ivhuew20tPq+excslFbhrr3JXNx1oSxE7ZRpRiZ0TKNrO+nP6wX0m/Ex7PkL
         fD3h5HyrkyDzdDlxjkphgpXPM69Alrcwl+FT7gBp5rC6XUNh7SK+cxZv7+BKfgJzQiMk
         pI12N80xp7Yo/m8YcuXmb1vdTMs6vdPKTHZmz23Cws2U0xGRou7pUXcpvAdk1MRyma6C
         cChQC7nRSH4sPtztZX8Im2c6Q9Jy3OQIVYne5tTF9X40Cw62VaDVrfI2DgSXa4F3QCZX
         xU7w==
X-Gm-Message-State: AOAM531OGjkGWO4dgUhSYM1cLthB28wYAXujUaH8mbEzlP2brSRINGGz
        WjjniDt6cvu7zdPP5yiShE+cjtiooltcV1YzIlfd6ALRLDPmYvk/KabrThDKdG2/A62Qq36eRJK
        lh1qZlMDqSkJ+aywMs5sV5CFn
X-Received: by 2002:a37:8047:: with SMTP id b68mr13950675qkd.299.1598461848049;
        Wed, 26 Aug 2020 10:10:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLRLZZCBpS2vogSRffieTXOoNMCSrfZDg6zygX9GtwQ4vjjoF4TebV9dib0yFK6rSBjIZF/Q==
X-Received: by 2002:a37:8047:: with SMTP id b68mr13950638qkd.299.1598461847705;
        Wed, 26 Aug 2020 10:10:47 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id x137sm2133134qkb.47.2020.08.26.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:10:46 -0700 (PDT)
Message-ID: <2c1f86e1688e866dbae1e49d5032a7d4d8a2ca1c.camel@redhat.com>
Subject: Re: [RFC v4 16/20] drm/i915/dp: Extract drm_dp_get_sink_count()
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 13:10:45 -0400
In-Reply-To: <87o8mx6g6a.fsf@intel.com>
References: <20200825195027.74681-1-lyude@redhat.com>
         <20200825195027.74681-17-lyude@redhat.com> <87o8mx6g6a.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 10:05 +0300, Jani Nikula wrote:
> On Tue, 25 Aug 2020, Lyude Paul <lyude@redhat.com> wrote:
> > And of course, we'll also need to read the sink count from other drivers
> > as well if we're checking whether or not it's supported. So, let's
> > extract the code for this into another helper.
> > 
> > v2:
> > * Fix drm_dp_dpcd_readb() ret check
> > * Add back comment and move back sink_count assignment in
> > intel_dp_get_dpcd()
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Reviewed-by: Sean Paul <sean@poorly.run>
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c         | 22 ++++++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++------
> >  include/drm/drm_dp_helper.h             |  1 +
> >  3 files changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c
> > b/drivers/gpu/drm/drm_dp_helper.c
> > index 863e0babc1903..67ad05eb05b7e 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -736,6 +736,28 @@ bool drm_dp_has_sink_count(struct drm_connector
> > *connector,
> >  }
> >  EXPORT_SYMBOL(drm_dp_has_sink_count);
> >  
> > +/**
> > + * drm_dp_get_sink_count() - Retrieve the sink count for a given sink
> 
> From the department of bikeshedding...
> 
> Should we have a naming scheme where it's obvious whether a function
> will do DPCD access, or just shuffle existing data?
> 
> For example, drm_dp_read_foo() for anything with DPCD access
> vs. drm_dp_get_foo() or even simpler for anything that only processes
> pre-read data?
> 
> > + * @aux: The DP AUX channel to use
> > + *
> > + * Returns: The current sink count reported by @aux, or a negative error
> > code
> > + * otherwise.
> > + */
> > +int drm_dp_get_sink_count(struct drm_dp_aux *aux)
> > +{
> > +	u8 count;
> > +	int ret;
> > +
> > +	ret = drm_dp_dpcd_readb(aux, DP_SINK_COUNT, &count);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != 1)
> > +		return -EIO;
> 
> Makes me wonder if that shouldn't be at drm_dp_dpcd_read() level, for
> reads returning 0..len-1 bytes. Not necessarily part of this series, but
> seems silly to set a precedent to start handling that return value all
> over the place.
> 
Yeah definitely - I'm probably going to keep this code here for now, but I would
like to convert drm_dp_dpcd_readb/writeb() to just return 0 on success (all
bytes written, I've never once seen a situation where we got less bytes than we
read - it's always all or nothing) and negative error code on failure. I'll get
to that soon

> BR,
> Jani.
> 
> > +
> > +	return DP_GET_SINK_COUNT(count);
> > +}
> > +EXPORT_SYMBOL(drm_dp_get_sink_count);
> > +
> >  /*
> >   * I2C-over-AUX implementation
> >   */
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 35a4779a442e2..4337321a3be4f 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -4648,6 +4648,8 @@ intel_dp_has_sink_count(struct intel_dp *intel_dp)
> >  static bool
> >  intel_dp_get_dpcd(struct intel_dp *intel_dp)
> >  {
> > +	int ret;
> > +
> >  	if (!intel_dp_read_dpcd(intel_dp))
> >  		return false;
> >  
> > @@ -4664,11 +4666,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
> >  	}
> >  
> >  	if (intel_dp_has_sink_count(intel_dp)) {
> > -		u8 count;
> > -		ssize_t r;
> > -
> > -		r = drm_dp_dpcd_readb(&intel_dp->aux, DP_SINK_COUNT, &count);
> > -		if (r < 1)
> > +		ret = drm_dp_get_sink_count(&intel_dp->aux);
> > +		if (ret < 0)
> >  			return false;
> >  
> >  		/*
> > @@ -4676,7 +4675,7 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
> >  		 * a member variable in intel_dp will track any changes
> >  		 * between short pulse interrupts.
> >  		 */
> > -		intel_dp->sink_count = DP_GET_SINK_COUNT(count);
> > +		intel_dp->sink_count = ret;
> >  
> >  		/*
> >  		 * SINK_COUNT == 0 and DOWNSTREAM_PORT_PRESENT == 1 implies that
> > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > index a1413a531eaf4..0c141fc81aaa8 100644
> > --- a/include/drm/drm_dp_helper.h
> > +++ b/include/drm/drm_dp_helper.h
> > @@ -1635,6 +1635,7 @@ struct drm_dp_desc;
> >  bool drm_dp_has_sink_count(struct drm_connector *connector,
> >  			   const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> >  			   const struct drm_dp_desc *desc);
> > +int drm_dp_get_sink_count(struct drm_dp_aux *aux);
> >  
> >  void drm_dp_remote_aux_init(struct drm_dp_aux *aux);
> >  void drm_dp_aux_init(struct drm_dp_aux *aux);
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

