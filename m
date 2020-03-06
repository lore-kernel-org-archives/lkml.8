Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA4DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412B6206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQGCtrfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFVW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:22:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54429 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgCFVW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583529747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9C8zNDia4xA9aMPRQB8U/bUKEi1VeFjgjTx3pCkBjXg=;
        b=fQGCtrfhBLVkHOaXfns4VXfAxELVIoMY+iY0g3ay+lJMLrhdOaXjNPfoM5Vah4pMs7YjxG
        6E9j7xlHhgFeiVUaRT2BTXDZQ2lt6eLIDwxwUMFm3X5qgvVdef/g2aa0Lkp9TtfOQOPQ5h
        h+tF5+sZSF86aH0uyaqDtijfHqC386E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-oHP5jdDsO5CifbG_MeVPNg-1; Fri, 06 Mar 2020 16:22:23 -0500
X-MC-Unique: oHP5jdDsO5CifbG_MeVPNg-1
Received: by mail-qt1-f200.google.com with SMTP id j35so2272557qte.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=9C8zNDia4xA9aMPRQB8U/bUKEi1VeFjgjTx3pCkBjXg=;
        b=jDFvlQkrgqNHUyagj45eoAvEWzdewMDlGemubRf5JyuJx6ejJEuLDwCD43NcQe0jcv
         nDhI1XBGrajkSLanbH4YDKSB1BC1s708srmJn1DEhsJ1kRdlFav/C37+zVsOYKmJLKWK
         5E6+UgXYWecUrDJP6f1hKFOVyg7ASSIoy/l+1/3ac0wlPn9ceKYDu6nvMMjTl04aBW8o
         IwbLQ5CFO1ohTkIdlIqFCfbt/Ep5I6AzC70u1Ij1ZCip57xqoke8RIW7NqUF6rZJydcu
         MeawioVDPprvHI8WA+fLH1/0Qs34d6PBMakX2qabZhi3iJ3ey3msa5OC0xvpgw0vVbr3
         oFRA==
X-Gm-Message-State: ANhLgQ34ll0+ZtINkcfs+EJxhnRmIwWaN159oB77ETaGGIzn1MFInjKj
        351kCW/L/n6yftBDYHvvFk9zUK8psv4b10WsPVpXIJCOzNj/z66s2BtA/SMlHzNgdYOsTNI6L8R
        ft8YIAnz0K2aInAgstCI6ZvSY
X-Received: by 2002:a05:6214:11e6:: with SMTP id e6mr4948470qvu.68.1583529743098;
        Fri, 06 Mar 2020 13:22:23 -0800 (PST)
X-Google-Smtp-Source: ADFU+vux6ciun4jfPY5Fa86Bi/Lwf3b2QeqaTRrhbE9qQ2nW32qe44DzI3gid9H4BD37hC6B21aalw==
X-Received: by 2002:a05:6214:11e6:: with SMTP id e6mr4948462qvu.68.1583529742849;
        Fri, 06 Mar 2020 13:22:22 -0800 (PST)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id z8sm213593qta.85.2020.03.06.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:22:21 -0800 (PST)
Message-ID: <eec59ee986aa161458fcaf2de29e5a702ad1fdb0.camel@redhat.com>
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
Date:   Fri, 06 Mar 2020 16:22:20 -0500
In-Reply-To: <082a7ac697ade8145afe45001fdf9541d5304748.camel@redhat.com>
References: <20200304223614.312023-1-lyude@redhat.com>
         <20200304223614.312023-3-lyude@redhat.com>
         <20200305131119.GJ13686@intel.com>
         <73f52c392431cd21a80a118dd2fd1986e2c535df.camel@redhat.com>
         <20200305182942.GP13686@intel.com>
         <082a7ac697ade8145afe45001fdf9541d5304748.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

final correction: I probably could actually get rid of this patch and do this
a bit more nicely by just making sure that we reprobe path resources for
connectors while under drm_dp_mst_topology_mgr->base.lock on CSNs, instead of
punting it off to the link address work like we seem to be doing. So, going to
try doing that instead.

On Fri, 2020-03-06 at 15:03 -0500, Lyude Paul wrote:
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
> ok-me and Sean Paul did some playing around with available_pbn and full_pbn
> (I'll get into this one in a moment), and I also played around with a couple
> of different hubs and have a much better understanding of how this should
> work
> now.
> 
> So: first off tl;dr available_pbn is absolutely not what we want in
> basically
> any scenario, we actually want to use the full_pbn field that we get when
> sending ENUM_PATH_RESOURCES. Second, full_pbn represents the _smallest_
> bandwidth limitation encountered in the path between the root MSTB and each
> connected sink. Remember that there's technically a DisplayPort link trained
> between each branch device going down the topology, so that bandwidth
> limitation basically equates to "what is the lowest trained link rate that
> exists down the path to this port?". This also means that full_pbn will
> potentially change every time a new connector is plugged in, as some hubs
> will be clever and optimize the link rate they decide to use. Likewise,
> since there's not going to be anything trained on a disconnected port (e.g.
> ddps=0) there's no point in keeping full_pbn around for disconnected ports,
> since otherwise we might let userspace see a connected port with a stale
> full_pbn value.
> 
> So-IMHO the behavior of not letting connectors show as connected until we
> also
> have their full_pbn probed should definitely be the right solution here.
> Especially if we want to eventually start pruning modes based on full_pbn at
> some point in the future.
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

