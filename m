Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156A520674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHTWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:38:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:45376 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbgHTWiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:38:02 -0400
IronPort-SDR: lA52nH3DulRNJHUj9oPP3WxNSSFsL8StsnggIg44qIEF+7v0/cI7YYS8lMtynn7gKMdHkTfa2n
 hM1Zy5L/iSvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="155404262"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="155404262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 15:38:01 -0700
IronPort-SDR: 56GHsub0ZbS7dKgKU0Y7VCiNcICQ2w+MnV3IdgCvvNmvhgz1+XfJjBINfxX75DKMA1kmoAAVm7
 FrNdTs90N5Tw==
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="321054249"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 15:37:57 -0700
Date:   Fri, 21 Aug 2020 01:37:54 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Sean Paul <sean@poorly.run>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [RFC 13/20] drm/i915/dp: Extract drm_dp_downstream_read_info()
Message-ID: <20200820223754.GA17451@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20200811200457.134743-1-lyude@redhat.com>
 <20200811200457.134743-14-lyude@redhat.com>
 <20200819151547.GB46474@art_vandelay>
 <4d74a74aefcd8d0ea048b70252efda18820bc911.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d74a74aefcd8d0ea048b70252efda18820bc911.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 05:34:15PM -0400, Lyude Paul wrote:
> (adding Ville and Imre to the cc here, they might be interested to know about
> this, comments down below)
> 
> On Wed, 2020-08-19 at 11:15 -0400, Sean Paul wrote:
> > On Tue, Aug 11, 2020 at 04:04:50PM -0400, Lyude Paul wrote:
> > > We're going to be doing the same probing process in nouveau for
> > > determining downstream DP port capabilities, so let's deduplicate the
> > > work by moving i915's code for handling this into a shared helper:
> > > drm_dp_downstream_read_info().
> > > 
> > > Note that when we do this, we also do make some functional changes while
> > > we're at it:
> > > * We always clear the downstream port info before trying to read it,
> > >   just to make things easier for the caller
> > > * We skip reading downstream port info if the DPCD indicates that we
> > >   don't support downstream port info
> > > * We only read as many bytes as needed for the reported number of
> > >   downstream ports, no sense in reading the whole thing every time
> > > 
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/drm_dp_helper.c         | 32 +++++++++++++++++++++++++
> > >  drivers/gpu/drm/i915/display/intel_dp.c | 14 ++---------
> > >  include/drm/drm_dp_helper.h             |  3 +++
> > >  3 files changed, 37 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_helper.c
> > > b/drivers/gpu/drm/drm_dp_helper.c
> > > index 4c21cf69dad5a..9703b33599c3b 100644
> > > --- a/drivers/gpu/drm/drm_dp_helper.c
> > > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > > @@ -423,6 +423,38 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux
> > > *aux,
> > >  }
> > >  EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
> > >  
> > > +/**
> > > + * drm_dp_downstream_read_info() - read DPCD downstream port info if
> > > available
> > > + * @aux: DisplayPort AUX channel
> > > + * @dpcd: A cached copy of the port's DPCD
> > > + * @downstream_ports: buffer to store the downstream port info in
> > > + *
> > > + * Returns: 0 if either the downstream port info was read successfully or
> > > + * there was no downstream info to read, or a negative error code
> > > otherwise.
> > > + */
> > > +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> > > +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > +				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS])
> > > +{
> > > +	int ret;
> > > +	u8 len;
> > > +
> > > +	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
> > > +
> > > +	/* No downstream info to read */
> > > +	if (!drm_dp_is_branch(dpcd) ||
> > > +	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> > > +	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
> > > +		return 0;
> > > +
> > > +	len = (dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_PORT_COUNT_MASK) * 4;
> > 
> > I'm having a hard time rationalizing DP_MAX_DOWNSTREAM_PORTS being 16, but
> > only
> > having 4 ports worth of data in the DP_DOWNSTREAM_PORT_* registers. Do you
> > know
> > what's supposed to happen if dpcd[DP_DOWN_STREAM_PORT_COUNT] is > 4?
> > 
> ok!! Taking a lesson from our available_pbn/full_pbn confusion in the past, I
> squinted very hard at the specification and eventually found something that I
> think clears this up. Surprise - we definitely had this implemented incorrectly
> in i915

To me it looks correct, only DFP0's cap info is used, by also handling
the DP_DETAILED_CAP_INFO_AVAILABLE=0/1 cases.

The wording is a bit unclear, but as I understand the Standard only
calls for the above:

"""
A DP upstream device shall read the capability from DPCD Addresses 00080h
through 00083h. A DP Branch device with multiple DFPs shall report the detailed
capability information of the lowest DFP number to which a downstream device
is connected, consistent with the DisplayID or legacy EDID access routing policy
of an SST-only DP Branch device as described in Section 2.1.4.1.
"""

> 
> From section 5.3.3.1:
> 
>    Either one or four bytes are used, per DFP type indication. Therefore, up to
>    16 (with 1-byte descriptor) or four (with 4-byte descriptor) DFP capabilities
>    can be stored.
> 
> So, a couple takeaways from this:
> 
>  * A DisplayPort connector can have *multiple* different downstream port types,
>    which I think actually makes sense as I've seen an adapter like this before.
>  * We actually added the ability to determine the downstream port type for DP
>    connectors using the subconnector prop, but it seems like if we want to aim
>    for completeness we're going to need to come up with a new prop that can
>    report multiple downstream port types :\.

This makes sense to me.

>  * It's not explicitly mentioned, but I'm assuming the correct way of handling
>    multiple downstream BPC/pixel clock capabilities is to assume the max
>    BPC/pixel clock is derived from the lowest max BPC/pixel clock we find on
>    *connected* downstream ports (anything else wouldn't really make sense, imho)

This would limit the case where the user only cares about the output
with a higher BW requirement on a DFP even if another DFP with a lower
BW cap is also connected. Not sure if it's a real world use-case though.

> So I'm going to rewrite this so we handle this properly in
> drm_dp_downstream_read_info() and related helpers. I don't currently have the
> time to do this, but if there's interest upstream in properly reporting the
> downstream port types of DP ports in userspace someone might want to consider
> coming up with another prop that accounts for multiple different downstream port
> types.
> 
> > Sean
> > 
> > > +	ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0, downstream_ports,
> > > +			       len);
> > > +
> > > +	return ret == len ? 0 : -EIO;
> > > +}
> > > +EXPORT_SYMBOL(drm_dp_downstream_read_info);
> > > +
> > >  /**
> > >   * drm_dp_downstream_max_clock() - extract branch device max
> > >   *                                 pixel rate for legacy VGA
> > > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > > b/drivers/gpu/drm/i915/display/intel_dp.c
> > > index 1e29d3a012856..984e49194ca31 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > > @@ -4685,18 +4685,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
> > >  			return false;
> > >  	}
> > >  
> > > -	if (!drm_dp_is_branch(intel_dp->dpcd))
> > > -		return true; /* native DP sink */
> > > -
> > > -	if (intel_dp->dpcd[DP_DPCD_REV] == 0x10)
> > > -		return true; /* no per-port downstream info */
> > > -
> > > -	if (drm_dp_dpcd_read(&intel_dp->aux, DP_DOWNSTREAM_PORT_0,
> > > -			     intel_dp->downstream_ports,
> > > -			     DP_MAX_DOWNSTREAM_PORTS) < 0)
> > > -		return false; /* downstream port status fetch failed */
> > > -
> > > -	return true;
> > > +	return drm_dp_downstream_read_info(&intel_dp->aux, intel_dp->dpcd,
> > > +					   intel_dp->downstream_ports) == 0;
> > >  }
> > >  
> > >  static bool
> > > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > > index 5c28199248626..1349f16564ace 100644
> > > --- a/include/drm/drm_dp_helper.h
> > > +++ b/include/drm/drm_dp_helper.h
> > > @@ -1613,6 +1613,9 @@ int drm_dp_dpcd_read_link_status(struct drm_dp_aux
> > > *aux,
> > >  bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
> > >  				    u8 real_edid_checksum);
> > >  
> > > +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> > > +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > +				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS]);
> > >  int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > >  				const u8 port_cap[4]);
> > >  int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > -- 
> > > 2.26.2
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> -- 
> Sincerely,
>       Lyude Paul (she/her)
>       Software Engineer at Red Hat
> 
