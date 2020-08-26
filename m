Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B149C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3508D20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc5fZDZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHZRNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgHZRM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598461976;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNxk+EQ8wQ8tVIGqRrZql9fbdwG5Cj1VEgrvd+qiq60=;
        b=Wc5fZDZp7jdCf/2ZLfB7hAsiqL761hpHzJsyIOQqTFsmdQMT9wUrXNWHnkEG5c8/3yXue1
        P0JRciT3f6Yr1+xgXZd499mPdjH4d+5/mY9XnZoaJSOrh3WG1JkZwR1L91lYQ9g4BRwCng
        AoCvEbOqUBNHg8PzYVM8S00faXrSg4E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-X-4eoZCAOf6wZmXJrCymrA-1; Wed, 26 Aug 2020 13:12:55 -0400
X-MC-Unique: X-4eoZCAOf6wZmXJrCymrA-1
Received: by mail-qv1-f69.google.com with SMTP id y12so2086571qva.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=HNxk+EQ8wQ8tVIGqRrZql9fbdwG5Cj1VEgrvd+qiq60=;
        b=dRrR5a5nPELQsdwWeLbLnXKW736b08SHL8bRNo68Xv/ziS8C/yFhXFIUdEd3XY5b7a
         xnmIdYlO+a7MADlXSB2FsVTa2hbmCl//rn8eF7+mhplPoS5uRAxIp3WsD9+qTA26df2U
         FF0UGMNG38Wtj8nTtqUVRHqkY56NXB2gV2AsETK4RNJupk+ISaoQbqCIZSvHfFBohDdV
         e/lbsI8FSjKegjsC7MyjcXZnxOQlfG0pKqPs4v6BOOkhWZBEYqXZh2qZJRV4GpFbTOEc
         szDV0VDb+SMoeYHXkcNqnTaalK8tB4p0nIjijyxq5QHjL6ROA6QVPcir+7szMuzSjdbK
         +qBw==
X-Gm-Message-State: AOAM5306IS4PYdsxPDTG4HtaGLGWphkNXS8qSut84Uo3LKZ7LEUf/KOV
        vyfYGlSxqpfq0Wq90MT2L7l4PXGfHx3ChpjAURoCjLnT5iWKzfvC+5OVPdUIGXv2/0LpwAdzScz
        UdrQgASIDCm1g8aBWxvY1lqQj
X-Received: by 2002:ac8:458a:: with SMTP id l10mr14982585qtn.345.1598461974855;
        Wed, 26 Aug 2020 10:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPN0gfqk25wNBQ7pctyKxl91Z5N9+T1TGM7wzP+o65H/927i5DVjZXXu0XPikzyIsh50ev/w==
X-Received: by 2002:ac8:458a:: with SMTP id l10mr14982565qtn.345.1598461974593;
        Wed, 26 Aug 2020 10:12:54 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id r73sm2063390qka.76.2020.08.26.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:12:54 -0700 (PDT)
Message-ID: <0b9fe80d058320b4e8e4fdf51a5445eddb1b0467.camel@redhat.com>
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
Date:   Wed, 26 Aug 2020 13:12:52 -0400
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

Forgot to address this comment - yeah, I think that would be a good idea. I'll
go through my previous patches and make sure that they match this naming scheme
as well.
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

