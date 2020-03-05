Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40A7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB020716
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXDVmytO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCESw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:52:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50917 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgCESw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583434376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RH9rmtOcZDthbsyDXEkU3rwq+PLEuDnB80nQoDiyIKk=;
        b=RXDVmytOqo6s5KCXYJq0mbs/ctZifZqkoJlcL5GoXbe9y6TR/x4R0fXIWo5L8YQslrJTlr
        3UH7w7yTM0JiV7LaDPYk0dDpGauYWORyXqwxZUXUA1GKLgRyxTuErHegPr29BRsQ+y5UrV
        Uhk+MezAMwyaM4jn31SsKkEI8ROFW2Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-iwx7Wkn_NWSL09suexWebQ-1; Thu, 05 Mar 2020 13:52:53 -0500
X-MC-Unique: iwx7Wkn_NWSL09suexWebQ-1
Received: by mail-qk1-f198.google.com with SMTP id l27so4484873qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RH9rmtOcZDthbsyDXEkU3rwq+PLEuDnB80nQoDiyIKk=;
        b=aSWIJgIukh4VERjG29yTpEeLY8TtjU9GVsWiWiMyeuALfa27ayPzCqIxx9TC1zgKtF
         fyTpfecA+wNdOpgFvLXOjasl2IEc6+xF2DJM1S9pkgy4vV1+WRAX4ZMDQxhYI7vuWjHI
         ZicHJnIoh1/BNBanU5YuDWIxWHNlvxaqDoGueoUIei/CSw2UO42BdHWLe6fq34y3Uxjw
         +jhQe8ywVIMtDJz7UGJae3Bl6skZAeuD9DR91zmGi+mp51Ddh28JvZq8SGCNMsTMUuDw
         h8bh1KDlyobaaGsGydMIJ1W3oSHWxbST50/TEobmFbZ7gi3OTXvEo/6md5bIjOLht9Yo
         gxmw==
X-Gm-Message-State: ANhLgQ2nS2A1kzGMUnEPfjwbeldteeyBHO4CQT3Xp8Gl8gExSc3kpppd
        F+HlX17K4HRZhUtwPr4/qjX7VELWA/FEHzFv2vKGBBZHT0y9V0w45jwtVs/a0RVhHX82yJggj5p
        j8GkxdBfZmzkDiRtaEXIupmAt
X-Received: by 2002:ac8:6f79:: with SMTP id u25mr109675qtv.180.1583434372236;
        Thu, 05 Mar 2020 10:52:52 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvJXz2ZSsIo3bYzKu/1CSKGSWGjbmWcq9syd6DB4n7dJrhaY4trWfVTG96f/HjSNPw356xESQ==
X-Received: by 2002:ac8:6f79:: with SMTP id u25mr109650qtv.180.1583434371935;
        Thu, 05 Mar 2020 10:52:51 -0800 (PST)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id b5sm6777932qkk.16.2020.03.05.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:52:51 -0800 (PST)
Message-ID: <efe5fc9895eaab47200e813280873894c0f98c8b.camel@redhat.com>
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
Date:   Thu, 05 Mar 2020 13:52:50 -0500
In-Reply-To: <20200305182942.GP13686@intel.com>
References: <20200304223614.312023-1-lyude@redhat.com>
         <20200304223614.312023-3-lyude@redhat.com>
         <20200305131119.GJ13686@intel.com>
         <73f52c392431cd21a80a118dd2fd1986e2c535df.camel@redhat.com>
         <20200305182942.GP13686@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 20:29 +0200, Ville Syrjälä wrote:
> On Thu, Mar 05, 2020 at 01:13:36PM -0500, Lyude Paul wrote:
> > On Thu, 2020-03-05 at 15:11 +0200, Ville Syrjälä wrote:
> > > On Wed, Mar 04, 2020 at 05:36:12PM -0500, Lyude Paul wrote:
> > > > It's next to impossible for us to do connector probing on topologies
> > > > without occasionally racing with userspace, since creating a connector
> > > > itself causes a hotplug event which we have to send before probing the
> > > > available PBN of a connector. Even if we didn't have this hotplug
> > > > event
> > > > sent, there's still always a chance that userspace started probing
> > > > connectors before we finished probing the topology.
> > > > 
> > > > This can be a problem when validating a new MST state since the
> > > > connector will be shown as connected briefly, but without any
> > > > available
> > > > PBN - causing any atomic state which would enable said connector to
> > > > fail
> > > > with -ENOSPC. So, let's simply workaround this by telling userspace
> > > > new
> > > > MST connectors are disconnected until we've finished probing their
> > > > PBN.
> > > > Since we always send a hotplug event at the end of the link address
> > > > probing process, userspace will still know to reprobe the connector
> > > > when
> > > > we're ready.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to
> > > > MST
> > > > atomic check")
> > > > Cc: Mikita Lipski <mikita.lipski@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Sean Paul <seanpaul@google.com>
> > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > index 207eef08d12c..7b0ff0cff954 100644
> > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > @@ -4033,6 +4033,19 @@ drm_dp_mst_detect_port(struct drm_connector
> > > > *connector,
> > > >  			ret = connector_status_connected;
> > > >  		break;
> > > >  	}
> > > > +
> > > > +	/* We don't want to tell userspace the port is actually
> > > > plugged into
> > > > +	 * anything until we've finished probing it's available_pbn,
> > > > otherwise
> > > 
> > > "its"
> > > 
> > > Why is the connector even registered before we've finished the probe?
> > > 
> > Oops, I'm not sure how I did this by accident but the explanation I gave
> > in
> > the commit message was uh, completely wrong. I must have forgotten that I
> > made
> > sure we didn't expose connectors before probing their PBN back when I
> > started
> > my MST cleanup....
> > 
> > So: despite what I said before it's not actually when new connectors are
> > created, it's when downstream hotplugs happen which means that the
> > conenctor's
> > always going to be there before we probe the available_pbn.
> 
> Not sure I understand. You're saying this is going to change for already
> existing connectors when something else gets plugged in, and either we
> zero it out during the probe or it always was zero to begin with for
> whatever reason?

So: you just made me realize that I'm not actually sure whether there's any
point to us clearing port->available_pbn here since the available_pbn (at
least the value that we cache on initial link address probing for bandwidth
constraint checking) shouldn't actually change on a port just because of a
hotplug. I bet this is probably causing more problems on it's own as well,
since reprobing the available_pbn might actually give us a value that reflects
allocations on other ports that are already in place.

So: I think what I'm going to do instead is make it so that we never clear
port->available_pbn; mainly to make things less complicated during
suspend/resume, since we want to make sure there's always some sort of PBN
value populated even during the middle of reprobing the link address on
resume. That way we don't have to pretend that it's ever disconnected either.
Will send a respin in a bit.

> 
> > I did just notice
> > though that we send a hotplug on connection status notifications even
> > before
> > we've finished the PBN probe, so I might be able to improve on that as
> > well.
> > We still definitely want to report the connector as disconnected before we
> > have the available PBN though, in case another probe was already going
> > before
> > we got the connection status notification.
> > 
> > I'll make sure to fixup the explanation in the commit message on the next
> > respin
> > 
> > > > +	 * userspace will see racy atomic check failures
> > > > +	 *
> > > > +	 * Since we always send a hotplug at the end of probing
> > > > topology
> > > > +	 * state, we can just let userspace reprobe this connector
> > > > later.
> > > > +	 */
> > > > +	if (ret == connector_status_connected && !port->available_pbn) 
> > > > {
> > > > +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] not ready yet (PBN
> > > > not
> > > > probed)\n",
> > > > +			      connector->base.id, connector->name);
> > > > +		ret = connector_status_disconnected;
> > > > +	}
> > > >  out:
> > > >  	drm_dp_mst_topology_put_port(port);
> > > >  	return ret;
> > > > -- 
> > > > 2.24.1
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > -- 
> > Cheers,
> > 	Lyude Paul (she/her)
> > 	Associate Software Engineer at Red Hat
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

