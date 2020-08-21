Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7952C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5EF20855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEcCpYEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHURny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:43:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgHURnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598031829;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ck1HzmegM7CDR1tYNecg1aO5vculeTIQw9+caxg5syU=;
        b=YEcCpYEnZjIomgC3bSepUCN5wxRAPnmaEzJd8s9uJOkPX6BNp184DgMpyhorr+LGJvP3Er
        1tmLzgGj9cgOAqViZ+oakfTUXMG+do4yMRzLGhHXWuNtfdjdUF3Dq4q1GxOdktJR3jZE0d
        NQvGZ72kdAR66FidRxXvIyVzjOYKgkU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-3gUTAt0eMLCNGgURPlMGiw-1; Fri, 21 Aug 2020 13:43:42 -0400
X-MC-Unique: 3gUTAt0eMLCNGgURPlMGiw-1
Received: by mail-qk1-f199.google.com with SMTP id j7so1914249qki.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ck1HzmegM7CDR1tYNecg1aO5vculeTIQw9+caxg5syU=;
        b=Xws1oSFtODq5d0cFRuZ0oHzo/OlPlTYQ08SkDWlz4nDz7GuTFmICkueN55PGMuCotF
         fRbDgOW135fFPyeuBCioBVoeg/0P+IHWL5td8Y/M8sKTagQbhYoOlcc3/eB80t15SOSe
         pllTvzrjng2I+f12WvJtXpnExmkJCG9HrKIVctSFAcaLNGPGUkEW6Z40FjsqWg6lzUDO
         a40KBdZ2kqyo4Jp5NaNUEOpauEur32CbFsTLIjQLncflJtX7uWUMtYSa7XQk+p1naJfj
         6fGMFDOsWQxb4eqU738j6IJTc77aiBOTDd9YI4I9aDgw8sUM4i3xxmbSomrW67P7oHhh
         /S1w==
X-Gm-Message-State: AOAM530u171vSCFUjgPk+kEn9RRVl1HmAmb+PBEGfDLynd6gPMGjfevv
        bf2yL1rX9zliQxybMVmOrCPVCg4cJJRU2WDcE3kP+sfnNFccFlKOuvPjuEj22McMx+yGKfSeE0k
        v0YPAvSXCgsPtQLJZP7Ex8ejC
X-Received: by 2002:ad4:446a:: with SMTP id s10mr3439697qvt.2.1598031821792;
        Fri, 21 Aug 2020 10:43:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH9Jn6UgjudBPLj7x1v5DjX0yu6K7hIJo8gzCYd2/h1H2hOWOzRN2KkFrZWF/+fngCMyrh/Q==
X-Received: by 2002:ad4:446a:: with SMTP id s10mr3439672qvt.2.1598031821496;
        Fri, 21 Aug 2020 10:43:41 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id c9sm2202769qkm.44.2020.08.21.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:43:40 -0700 (PDT)
Message-ID: <597b83ace909f97bfefbe15ffbb0370c2101ff0f.camel@redhat.com>
Subject: Re: [RFC 13/20] drm/i915/dp: Extract drm_dp_downstream_read_info()
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     imre.deak@intel.com
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
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Wambui Karuga <wambui.karugax@gmail.com>
Date:   Fri, 21 Aug 2020 13:43:39 -0400
In-Reply-To: <20200820223754.GA17451@ideak-desk.fi.intel.com>
References: <20200811200457.134743-1-lyude@redhat.com>
         <20200811200457.134743-14-lyude@redhat.com>
         <20200819151547.GB46474@art_vandelay>
         <4d74a74aefcd8d0ea048b70252efda18820bc911.camel@redhat.com>
         <20200820223754.GA17451@ideak-desk.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 01:37 +0300, Imre Deak wrote:
> On Wed, Aug 19, 2020 at 05:34:15PM -0400, Lyude Paul wrote:
> > (adding Ville and Imre to the cc here, they might be interested to know
> > about
> > this, comments down below)
> > 
> > On Wed, 2020-08-19 at 11:15 -0400, Sean Paul wrote:
> > > On Tue, Aug 11, 2020 at 04:04:50PM -0400, Lyude Paul wrote:
> > > > We're going to be doing the same probing process in nouveau for
> > > > determining downstream DP port capabilities, so let's deduplicate the
> > > > work by moving i915's code for handling this into a shared helper:
> > > > drm_dp_downstream_read_info().
> > > > 
> > > > Note that when we do this, we also do make some functional changes while
> > > > we're at it:
> > > > * We always clear the downstream port info before trying to read it,
> > > >   just to make things easier for the caller
> > > > * We skip reading downstream port info if the DPCD indicates that we
> > > >   don't support downstream port info
> > > > * We only read as many bytes as needed for the reported number of
> > > >   downstream ports, no sense in reading the whole thing every time
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_dp_helper.c         | 32 +++++++++++++++++++++++++
> > > >  drivers/gpu/drm/i915/display/intel_dp.c | 14 ++---------
> > > >  include/drm/drm_dp_helper.h             |  3 +++
> > > >  3 files changed, 37 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_dp_helper.c
> > > > b/drivers/gpu/drm/drm_dp_helper.c
> > > > index 4c21cf69dad5a..9703b33599c3b 100644
> > > > --- a/drivers/gpu/drm/drm_dp_helper.c
> > > > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > > > @@ -423,6 +423,38 @@ bool drm_dp_send_real_edid_checksum(struct
> > > > drm_dp_aux
> > > > *aux,
> > > >  }
> > > >  EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
> > > >  
> > > > +/**
> > > > + * drm_dp_downstream_read_info() - read DPCD downstream port info if
> > > > available
> > > > + * @aux: DisplayPort AUX channel
> > > > + * @dpcd: A cached copy of the port's DPCD
> > > > + * @downstream_ports: buffer to store the downstream port info in
> > > > + *
> > > > + * Returns: 0 if either the downstream port info was read successfully
> > > > or
> > > > + * there was no downstream info to read, or a negative error code
> > > > otherwise.
> > > > + */
> > > > +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> > > > +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > > +				u8
> > > > downstream_ports[DP_MAX_DOWNSTREAM_PORTS])
> > > > +{
> > > > +	int ret;
> > > > +	u8 len;
> > > > +
> > > > +	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
> > > > +
> > > > +	/* No downstream info to read */
> > > > +	if (!drm_dp_is_branch(dpcd) ||
> > > > +	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> > > > +	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] &
> > > > DP_DWN_STRM_PORT_PRESENT))
> > > > +		return 0;
> > > > +
> > > > +	len = (dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_PORT_COUNT_MASK) *
> > > > 4;
> > > 
> > > I'm having a hard time rationalizing DP_MAX_DOWNSTREAM_PORTS being 16, but
> > > only
> > > having 4 ports worth of data in the DP_DOWNSTREAM_PORT_* registers. Do you
> > > know
> > > what's supposed to happen if dpcd[DP_DOWN_STREAM_PORT_COUNT] is > 4?
> > > 
> > ok!! Taking a lesson from our available_pbn/full_pbn confusion in the past,
> > I
> > squinted very hard at the specification and eventually found something that
> > I
> > think clears this up. Surprise - we definitely had this implemented
> > incorrectly
> > in i915
> 
> To me it looks correct, only DFP0's cap info is used, by also handling
> the DP_DETAILED_CAP_INFO_AVAILABLE=0/1 cases.
Ended up realizing this right after I sent this version of the RFC - yeah, it
definitely shouldn't be causing any real problems as of now

> 
> The wording is a bit unclear, but as I understand the Standard only
> calls for the above:
> 
> """
> A DP upstream device shall read the capability from DPCD Addresses 00080h
> through 00083h. A DP Branch device with multiple DFPs shall report the
> detailed
> capability information of the lowest DFP number to which a downstream device
> is connected, consistent with the DisplayID or legacy EDID access routing
> policy
> of an SST-only DP Branch device as described in Section 2.1.4.1.
> """

So-I saw this too, but notice the use of the language "A /DP Branch/ device with
multiple DFPs shall report the detailed…". This makes me think it's implying
that this is a requirement for MSTBs and not SST sinks, just a guess.
> 
> > From section 5.3.3.1:
> > 
> >    Either one or four bytes are used, per DFP type indication. Therefore, up
> > to
> >    16 (with 1-byte descriptor) or four (with 4-byte descriptor) DFP
> > capabilities
> >    can be stored.
> > 
> > So, a couple takeaways from this:
> > 
> >  * A DisplayPort connector can have *multiple* different downstream port
> > types,
> >    which I think actually makes sense as I've seen an adapter like this
> > before.
> >  * We actually added the ability to determine the downstream port type for
> > DP
> >    connectors using the subconnector prop, but it seems like if we want to
> > aim
> >    for completeness we're going to need to come up with a new prop that can
> >    report multiple downstream port types :\.
> 
> This makes sense to me.
> 
> >  * It's not explicitly mentioned, but I'm assuming the correct way of
> > handling
> >    multiple downstream BPC/pixel clock capabilities is to assume the max
> >    BPC/pixel clock is derived from the lowest max BPC/pixel clock we find on
> >    *connected* downstream ports (anything else wouldn't really make sense,
> > imho)
> 
> This would limit the case where the user only cares about the output
> with a higher BW requirement on a DFP even if another DFP with a lower
> BW cap is also connected. Not sure if it's a real world use-case though.

hm, true.
> 
> > So I'm going to rewrite this so we handle this properly in
> > drm_dp_downstream_read_info() and related helpers. I don't currently have
> > the
> > time to do this, but if there's interest upstream in properly reporting the
> > downstream port types of DP ports in userspace someone might want to
> > consider
> > coming up with another prop that accounts for multiple different downstream
> > port
> > types.
> > 
> > > Sean
> > > 
> > > > +	ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0,
> > > > downstream_ports,
> > > > +			       len);
> > > > +
> > > > +	return ret == len ? 0 : -EIO;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dp_downstream_read_info);
> > > > +
> > > >  /**
> > > >   * drm_dp_downstream_max_clock() - extract branch device max
> > > >   *                                 pixel rate for legacy VGA
> > > > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > > > b/drivers/gpu/drm/i915/display/intel_dp.c
> > > > index 1e29d3a012856..984e49194ca31 100644
> > > > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > > > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > > > @@ -4685,18 +4685,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
> > > >  			return false;
> > > >  	}
> > > >  
> > > > -	if (!drm_dp_is_branch(intel_dp->dpcd))
> > > > -		return true; /* native DP sink */
> > > > -
> > > > -	if (intel_dp->dpcd[DP_DPCD_REV] == 0x10)
> > > > -		return true; /* no per-port downstream info */
> > > > -
> > > > -	if (drm_dp_dpcd_read(&intel_dp->aux, DP_DOWNSTREAM_PORT_0,
> > > > -			     intel_dp->downstream_ports,
> > > > -			     DP_MAX_DOWNSTREAM_PORTS) < 0)
> > > > -		return false; /* downstream port status fetch failed */
> > > > -
> > > > -	return true;
> > > > +	return drm_dp_downstream_read_info(&intel_dp->aux, intel_dp-
> > > > >dpcd,
> > > > +					   intel_dp->downstream_ports)
> > > > == 0;
> > > >  }
> > > >  
> > > >  static bool
> > > > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > > > index 5c28199248626..1349f16564ace 100644
> > > > --- a/include/drm/drm_dp_helper.h
> > > > +++ b/include/drm/drm_dp_helper.h
> > > > @@ -1613,6 +1613,9 @@ int drm_dp_dpcd_read_link_status(struct drm_dp_aux
> > > > *aux,
> > > >  bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
> > > >  				    u8 real_edid_checksum);
> > > >  
> > > > +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> > > > +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > > +				u8
> > > > downstream_ports[DP_MAX_DOWNSTREAM_PORTS]);
> > > >  int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > >  				const u8 port_cap[4]);
> > > >  int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > > > -- 
> > > > 2.26.2
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > -- 
> > Sincerely,
> >       Lyude Paul (she/her)
> >       Software Engineer at Red Hat
> > 
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

