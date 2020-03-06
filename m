Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1EC10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF02020709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPHSBH3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFUDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:03:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725922AbgCFUDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583524998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLV0eZu1glWbZE8lg3VCIfQvG/kVlmRarC+U2c4kgyM=;
        b=WPHSBH3T6k6nKzbF3KCHLuopnsu5Yk+hLD1jB3Q0APUXYJ8lwnPmf5sqEn4lSfLN1eytzk
        X+/54OqFN3ZLPX4ze4m7XOeC3ZrOnxveZsB+gHbNST/wC830pyu/LZ2U1cyr2IH4mCpTAy
        oOMIK2a7U9msHJtYbXwePyUgPQK6GEg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-Ix-oT4q6Ml67ohJOQEXZSA-1; Fri, 06 Mar 2020 15:03:07 -0500
X-MC-Unique: Ix-oT4q6Ml67ohJOQEXZSA-1
Received: by mail-qk1-f197.google.com with SMTP id w2so2308356qka.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dLV0eZu1glWbZE8lg3VCIfQvG/kVlmRarC+U2c4kgyM=;
        b=V7Qb2+esUmDMQWBvNb/sHz8Xje82Xi4h92AHxYl8Pg1/Aml8Pm1/2HHBVmOvILLm7L
         TNkybH/VSbVs3hF0V1wAeNZty/mNHmNVmrdN6clNkVDcVmeqd07nz6C/8WLDv3M2b3dz
         shRf6YZ2rnEXJ/VdeTVFAzmyjWFZAoXl094l5KOw0++zgmhbfa94k48kkkwFx6VSbiEx
         fNDbCg/1/7HbfeU/L+zk7Zk7HLbhrYx3cj9rrKXH1j5DHT7WF8zk5+i6gQoNiZSS/Wj8
         pllWu+sQBqYLzV8i5BEAyjidqYOLURKia2fJzy7Ffan0LbfPe9OBlEkOwfHM4Zdd1hHq
         763w==
X-Gm-Message-State: ANhLgQ3DNOMo/GaJOY5Blvbwb4Lr6tsV9qFNuYIApxOe9Zw8Q/BlSKbl
        olBIobtkT2jqYV0pM9yZhYVbjf6ahNI7NiapCJWHH6HoEGo0R2blwWB0NwudJ3+bXQSMoqTCbVH
        DkoHIb4lu2S/jQqlCx0a8WQ6Y
X-Received: by 2002:ac8:4250:: with SMTP id r16mr4651917qtm.23.1583524986565;
        Fri, 06 Mar 2020 12:03:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvvRFrhDPsM/Fa4LgFvlGizYhTEkcl9h5HIbw8fjc0rIMYtKufRSA8znZWWlcc0OuSwuzgJjw==
X-Received: by 2002:ac8:4250:: with SMTP id r16mr4651879qtm.23.1583524986115;
        Fri, 06 Mar 2020 12:03:06 -0800 (PST)
Received: from dhcp-10-20-1-196.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f93sm3373069qtd.26.2020.03.06.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:03:05 -0800 (PST)
Message-ID: <082a7ac697ade8145afe45001fdf9541d5304748.camel@redhat.com>
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
Date:   Fri, 06 Mar 2020 15:03:04 -0500
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

ok-me and Sean Paul did some playing around with available_pbn and full_pbn
(I'll get into this one in a moment), and I also played around with a couple
of different hubs and have a much better understanding of how this should work
now.

So: first off tl;dr available_pbn is absolutely not what we want in basically
any scenario, we actually want to use the full_pbn field that we get when
sending ENUM_PATH_RESOURCES. Second, full_pbn represents the _smallest_ bandwidth limitation encountered in the path between the root MSTB and each connected sink. Remember that there's technically a DisplayPort link trained between each branch device going down the topology, so that bandwidth limitation basically equates to "what is the lowest trained link rate that exists down the path to this port?". This also means that full_pbn will potentially change every time a new connector is plugged in, as some hubs will be clever and optimize the link rate they decide to use. Likewise, since there's not going to be anything trained on a disconnected port (e.g. ddps=0) there's no point in keeping full_pbn around for disconnected ports, since otherwise we might let userspace see a connected port with a stale full_pbn value.

So-IMHO the behavior of not letting connectors show as connected until we also
have their full_pbn probed should definitely be the right solution here.
Especially if we want to eventually start pruning modes based on full_pbn at
some point in the future.

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

