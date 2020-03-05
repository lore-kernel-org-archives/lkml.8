Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E54FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38C2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/k4ramE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCEToz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:44:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725938AbgCEToz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583437493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqSWwZ6DsapB8lrNL+jBy6XB4zsOmjjEG2eb8VnPGNQ=;
        b=W/k4ramEclo7hsLwXlfH9ZSqhaqmk2p/6n0PmiY6ZOdInOGWBSMD3FC9p8wYiFdxrsj/v6
        VhfWTumje0i53YxsqvlJv3sNwF0TgxwSNUQE5RvbywMArvHEinapE/hbngs0SMAWX+TBbX
        0ixINeByr64yYbRKkBKHzgwZJXI4x6c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418--bpBaEsWMVeWMqEN-FCAQw-1; Thu, 05 Mar 2020 14:44:49 -0500
X-MC-Unique: -bpBaEsWMVeWMqEN-FCAQw-1
Received: by mail-qk1-f198.google.com with SMTP id q123so4592217qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 11:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=lqSWwZ6DsapB8lrNL+jBy6XB4zsOmjjEG2eb8VnPGNQ=;
        b=iBMaCcr+DEFZuD4dEDELKHKAvwriMxZm8BN4osATrV+HN2FIzhd6qC0p7NnIxoqxUj
         alJoyylom3FY1dRWL/lSEkE/RO6DOaTIQWn3Ivwj6ZzgD7daIOZUskFvXmIegfQJaW+j
         ZRbX2in8/0fGscUq4cJmli/S2ExSXymQtwAAwX050iKycDQaxoqJ/d3px7HHfMt1Bd7g
         17dVbe5SAyWnHmPgQJCNu1D/s5tyPtWqFoJkCFlOiUm8sr7TSNuFk5TB0LiiyT97RNGQ
         UvXK+4sKxsFtU7DEQSBNLWV/hjeIj5wpLuvLrQ0o2lJPc7R/L04AzqDSCT1OFzzOWqE/
         kRbA==
X-Gm-Message-State: ANhLgQ1rdVqsb/XWQEZH/gMBbZPIN/TodQ+a7P0Lj2wMre3WKAmDV4cp
        SdPndxJi7au6tADJ97IJgCnIv6uRyGiL3vul3vdR4Cpnj/fQisu1WrfIxucgBAn0TXLTHpUM9P4
        LLDeBGU2+658fOIgvVOZwtOoW
X-Received: by 2002:a37:af02:: with SMTP id y2mr9658500qke.73.1583437489482;
        Thu, 05 Mar 2020 11:44:49 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvOSVjsk/292akdGchAAJ12xFsVlNHzlHYiTU5k1qsXWdSiHdmbtMzH3qYs0XwaYQ9ZW96Cgw==
X-Received: by 2002:a37:af02:: with SMTP id y2mr9658465qke.73.1583437489081;
        Thu, 05 Mar 2020 11:44:49 -0800 (PST)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id h28sm10282281qkk.59.2020.03.05.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 11:44:48 -0800 (PST)
Message-ID: <1d67c05ace278fd0f7de31a560ac5ebafdb04eca.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Don't show connectors as connected
 before probing available PBN
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>
Date:   Thu, 05 Mar 2020 14:44:43 -0500
In-Reply-To: <efe5fc9895eaab47200e813280873894c0f98c8b.camel@redhat.com>
References: <20200304223614.312023-1-lyude@redhat.com>
         <20200304223614.312023-3-lyude@redhat.com>
         <20200305131119.GJ13686@intel.com>
         <73f52c392431cd21a80a118dd2fd1986e2c535df.camel@redhat.com>
         <20200305182942.GP13686@intel.com>
         <efe5fc9895eaab47200e813280873894c0f98c8b.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 13:52 -0500, Lyude Paul wrote:
> On Thu, 2020-03-05 at 20:29 +0200, Ville Syrjälä wrote:
> > On Thu, Mar 05, 2020 at 01:13:36PM -0500, Lyude Paul wrote:
> > > On Thu, 2020-03-05 at 15:11 +0200, Ville Syrjälä wrote:
> > > > On Wed, Mar 04, 2020 at 05:36:12PM -0500, Lyude Paul wrote:
> > > > > It's next to impossible for us to do connector probing on topologies
> > > > > without occasionally racing with userspace, since creating a
> > > > > connector
> > > > > itself causes a hotplug event which we have to send before probing
> > > > > the
> > > > > available PBN of a connector. Even if we didn't have this hotplug
> > > > > event
> > > > > sent, there's still always a chance that userspace started probing
> > > > > connectors before we finished probing the topology.
> > > > > 
> > > > > This can be a problem when validating a new MST state since the
> > > > > connector will be shown as connected briefly, but without any
> > > > > available
> > > > > PBN - causing any atomic state which would enable said connector to
> > > > > fail
> > > > > with -ENOSPC. So, let's simply workaround this by telling userspace
> > > > > new
> > > > > MST connectors are disconnected until we've finished probing their
> > > > > PBN.
> > > > > Since we always send a hotplug event at the end of the link address
> > > > > probing process, userspace will still know to reprobe the connector
> > > > > when
> > > > > we're ready.
> > > > > 
> > > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > > Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to
> > > > > MST
> > > > > atomic check")
> > > > > Cc: Mikita Lipski <mikita.lipski@amd.com>
> > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: Sean Paul <seanpaul@google.com>
> > > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > index 207eef08d12c..7b0ff0cff954 100644
> > > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > @@ -4033,6 +4033,19 @@ drm_dp_mst_detect_port(struct drm_connector
> > > > > *connector,
> > > > >  			ret = connector_status_connected;
> > > > >  		break;
> > > > >  	}
> > > > > +
> > > > > +	/* We don't want to tell userspace the port is actually
> > > > > plugged into
> > > > > +	 * anything until we've finished probing it's available_pbn,
> > > > > otherwise
> > > > 
> > > > "its"
> > > > 
> > > > Why is the connector even registered before we've finished the probe?
> > > > 
> > > Oops, I'm not sure how I did this by accident but the explanation I gave
> > > in
> > > the commit message was uh, completely wrong. I must have forgotten that
> > > I
> > > made
> > > sure we didn't expose connectors before probing their PBN back when I
> > > started
> > > my MST cleanup....
> > > 
> > > So: despite what I said before it's not actually when new connectors are
> > > created, it's when downstream hotplugs happen which means that the
> > > conenctor's
> > > always going to be there before we probe the available_pbn.
> > 
> > Not sure I understand. You're saying this is going to change for already
> > existing connectors when something else gets plugged in, and either we
> > zero it out during the probe or it always was zero to begin with for
> > whatever reason?
> 
> So: you just made me realize that I'm not actually sure whether there's any
> point to us clearing port->available_pbn here since the available_pbn (at
> least the value that we cache on initial link address probing for bandwidth
> constraint checking) shouldn't actually change on a port just because of a
> hotplug. I bet this is probably causing more problems on it's own as well,
> since reprobing the available_pbn might actually give us a value that
> reflects
> allocations on other ports that are already in place.
> 
> So: I think what I'm going to do instead is make it so that we never clear
> port->available_pbn; mainly to make things less complicated during
> suspend/resume, since we want to make sure there's always some sort of PBN
> value populated even during the middle of reprobing the link address on
> resume. That way we don't have to pretend that it's ever disconnected
> either.
> Will send a respin in a bit.
Wait, nope, I believe I am the fool here - _supposedly_ available bw is
supposed to reflect the smallest link rate that occurs in a patch to a branch
device. I think, me and sean paul are looking at this a bit more closely. I
think I might need to do some more playing around with my hubs to make sure
this value is actually what we think it is because unfortunately the spec is
pretty vague on this from what I can tell :( 

> 
> > > I did just notice
> > > though that we send a hotplug on connection status notifications even
> > > before
> > > we've finished the PBN probe, so I might be able to improve on that as
> > > well.
> > > We still definitely want to report the connector as disconnected before
> > > we
> > > have the available PBN though, in case another probe was already going
> > > before
> > > we got the connection status notification.
> > > 
> > > I'll make sure to fixup the explanation in the commit message on the
> > > next
> > > respin
> > > 
> > > > > +	 * userspace will see racy atomic check failures
> > > > > +	 *
> > > > > +	 * Since we always send a hotplug at the end of probing
> > > > > topology
> > > > > +	 * state, we can just let userspace reprobe this connector
> > > > > later.
> > > > > +	 */
> > > > > +	if (ret == connector_status_connected && !port-
> > > > > >available_pbn) 
> > > > > {
> > > > > +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] not ready yet (PBN
> > > > > not
> > > > > probed)\n",
> > > > > +			      connector->base.id, connector->name);
> > > > > +		ret = connector_status_disconnected;
> > > > > +	}
> > > > >  out:
> > > > >  	drm_dp_mst_topology_put_port(port);
> > > > >  	return ret;
> > > > > -- 
> > > > > 2.24.1
> > > > > 
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > -- 
> > > Cheers,
> > > 	Lyude Paul (she/her)
> > > 	Associate Software Engineer at Red Hat
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

