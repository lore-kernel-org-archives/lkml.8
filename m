Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F34C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DE92078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J00KvQn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHSR3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgHSR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597858145;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KvgaCYohQhokdvpsCdvRkGWCDtbthJZmZ4XIsksp3I=;
        b=J00KvQn00MPEtzdrtj7AbZEbs7JaRg0tmxNmvBqyhf57Pfr8dEpxpSc/HGGHkWHS4/ZMXs
        sQgzwVBcX/oSsTJFQevTWL5KfQJk4e0vohmBf8TTqmKr3pkEDe6GsFhcMPAYvhZdQS5wll
        2g7PIb8n6yYBImSBAagZ7YcBeFwznag=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-IHmoj3mMOpePeyOay1u_dQ-1; Wed, 19 Aug 2020 13:29:00 -0400
X-MC-Unique: IHmoj3mMOpePeyOay1u_dQ-1
Received: by mail-qk1-f198.google.com with SMTP id q3so15865213qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=2KvgaCYohQhokdvpsCdvRkGWCDtbthJZmZ4XIsksp3I=;
        b=db/GFsNg6+1TwFXJCd0bPenR/ezL0yZSEmaC8m3q+sr9YwfOw0rNWhrlMhkBefNlqN
         okW6gakwt9ZbQyI3VzVcIJWEmDbNjVzu/iasJV3lLQIvmmI/RBq1cOGR8DPBPGcBpHGS
         nfL09osc2TSHSkpxIM3DQpCxKjJy3hC2j+Ii+QUt1DIJosaAnsjP4cyB9DJHMhqB0sJR
         hCvY/Ee7TUn+WjNKDA8kw+fBmYHxwdmmi92shJmVGDAngABKDJ2QsQnkfBnC1hvyzcBn
         82HkJjcnAS+iOi/u0umfEwQa2JkuuAPAq51Awl2FYU2OnlJX4CRnrTMIDxhMdtJlMn9t
         6iLQ==
X-Gm-Message-State: AOAM533vb3MO5tXknTEN5mSF1PU/RJZGfvQdhdkP5sc2IIjbd/+ELm7z
        xnjGXEG++sxz9Om8FqdngQfX8QGXhnarIx8+lSrK4k3h9dpG8cw2wbOE6HwhkUJyzZFVBqGvSyJ
        r8Gawxcg1NRkMCI/Q3bgHmC/w
X-Received: by 2002:aed:2f44:: with SMTP id l62mr22414138qtd.207.1597858140092;
        Wed, 19 Aug 2020 10:29:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIqzNjwxOOu6zLyJjLqOnz+3XI2ZOYHaFSMcNnljH/NqEhnUQEvbxwdlKjcIiBIoyuwTy9hw==
X-Received: by 2002:aed:2f44:: with SMTP id l62mr22414117qtd.207.1597858139794;
        Wed, 19 Aug 2020 10:28:59 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id t8sm28688880qtc.50.2020.08.19.10.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:28:58 -0700 (PDT)
Message-ID: <e949791af3a41321c10bec8b862914e3c9952f4f.camel@redhat.com>
Subject: Re: [RFC 13/20] drm/i915/dp: Extract drm_dp_downstream_read_info()
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Sean Paul <sean@poorly.run>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Wambui Karuga <wambui.karugax@gmail.com>
Date:   Wed, 19 Aug 2020 13:28:57 -0400
In-Reply-To: <20200819151547.GB46474@art_vandelay>
References: <20200811200457.134743-1-lyude@redhat.com>
         <20200811200457.134743-14-lyude@redhat.com>
         <20200819151547.GB46474@art_vandelay>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 11:15 -0400, Sean Paul wrote:
> On Tue, Aug 11, 2020 at 04:04:50PM -0400, Lyude Paul wrote:
> > We're going to be doing the same probing process in nouveau for
> > determining downstream DP port capabilities, so let's deduplicate the
> > work by moving i915's code for handling this into a shared helper:
> > drm_dp_downstream_read_info().
> > 
> > Note that when we do this, we also do make some functional changes while
> > we're at it:
> > * We always clear the downstream port info before trying to read it,
> >   just to make things easier for the caller
> > * We skip reading downstream port info if the DPCD indicates that we
> >   don't support downstream port info
> > * We only read as many bytes as needed for the reported number of
> >   downstream ports, no sense in reading the whole thing every time
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c         | 32 +++++++++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_dp.c | 14 ++---------
> >  include/drm/drm_dp_helper.h             |  3 +++
> >  3 files changed, 37 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c
> > b/drivers/gpu/drm/drm_dp_helper.c
> > index 4c21cf69dad5a..9703b33599c3b 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -423,6 +423,38 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux
> > *aux,
> >  }
> >  EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
> >  
> > +/**
> > + * drm_dp_downstream_read_info() - read DPCD downstream port info if
> > available
> > + * @aux: DisplayPort AUX channel
> > + * @dpcd: A cached copy of the port's DPCD
> > + * @downstream_ports: buffer to store the downstream port info in
> > + *
> > + * Returns: 0 if either the downstream port info was read successfully or
> > + * there was no downstream info to read, or a negative error code
> > otherwise.
> > + */
> > +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> > +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > +				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS])
> > +{
> > +	int ret;
> > +	u8 len;
> > +
> > +	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
> > +
> > +	/* No downstream info to read */
> > +	if (!drm_dp_is_branch(dpcd) ||
> > +	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> > +	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
> > +		return 0;
> > +
> > +	len = (dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_PORT_COUNT_MASK) * 4;
> 
> I'm having a hard time rationalizing DP_MAX_DOWNSTREAM_PORTS being 16, but
> only
> having 4 ports worth of data in the DP_DOWNSTREAM_PORT_* registers. Do you
> know
> what's supposed to happen if dpcd[DP_DOWN_STREAM_PORT_COUNT] is > 4?

I thought I had addressed this bit but I guess I missed some parts here.

So; there's actually two different possible lengths for how long each downstream
port's capabilities can be: 1 byte long (if DETAILED_CAP_INFO_AVAILABLE in the
DOWN_STREAM_PORT_PRESENT is 0, e.g. 005h bit 4), and 4 bytes long if that bit is
1. What's unfortunately not as clear, is whether or not 1 byte long cap fields
mean "each port has four bytes, but only one byte is used" or "each port truly
only has one byte". The DP spec says:

   DFPX_CAP
   1 byte/DFP
   X = DFP number. Port_x capability is stored at the DFP number’s address plus
   80h

Which at first seems to imply that each cap is at 80 + X, e.g. only one byte
long. However, the explanation for when DETAILED_CAP_INFO_AVAILABLE == 1 says
almost the same thing:

   DFPX_CAP
   X = DFP number. Port_x capability is stored at the DFP number’s address plus
   80h.

Although right above that unlike the previous section, they mention that DFP0
goes from 80-83, DFP1 84-87, etc...

Not entirely sure what to think here since I don't really have any devices (nor
do I think I've ever seen any) that have more then one DFP. As well, for the
case where we have multiple DFPs (which according to the spec appears to only be
something we need to worry about for SST) they're not really explicit on how to
combine the downstream capabilities from each DFP. My guess is maybe you
determine the max downstream clock and bpp from the lowest clock limits
advertised across each port?
(if you have a DP device with multiple DFPs and can test this, that would rock
:), but I have a feeling you probably don't have one either)
> 
> Sean
> 
> > +	ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0, downstream_ports,
> > +			       len);
> > +
> > +	return ret == len ? 0 : -EIO;
> > +}
> > +EXPORT_SYMBOL(drm_dp_downstream_read_info);
> > +
> >  /**
> >   * drm_dp_downstream_max_clock() - extract branch device max
> >   *                                 pixel rate for legacy VGA
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 1e29d3a012856..984e49194ca31 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -4685,18 +4685,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
> >  			return false;
> >  	}
> >  
> > -	if (!drm_dp_is_branch(intel_dp->dpcd))
> > -		return true; /* native DP sink */
> > -
> > -	if (intel_dp->dpcd[DP_DPCD_REV] == 0x10)
> > -		return true; /* no per-port downstream info */
> > -
> > -	if (drm_dp_dpcd_read(&intel_dp->aux, DP_DOWNSTREAM_PORT_0,
> > -			     intel_dp->downstream_ports,
> > -			     DP_MAX_DOWNSTREAM_PORTS) < 0)
> > -		return false; /* downstream port status fetch failed */
> > -
> > -	return true;
> > +	return drm_dp_downstream_read_info(&intel_dp->aux, intel_dp->dpcd,
> > +					   intel_dp->downstream_ports) == 0;
> >  }
> >  
> >  static bool
> > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > index 5c28199248626..1349f16564ace 100644
> > --- a/include/drm/drm_dp_helper.h
> > +++ b/include/drm/drm_dp_helper.h
> > @@ -1613,6 +1613,9 @@ int drm_dp_dpcd_read_link_status(struct drm_dp_aux
> > *aux,
> >  bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
> >  				    u8 real_edid_checksum);
> >  
> > +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> > +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > +				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS]);
> >  int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> >  				const u8 port_cap[4]);
> >  int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > -- 
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

