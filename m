Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650AA208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKL6FAM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCESNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:13:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbgCESNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583432030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CISWnYCTgIHs8Q99tWvsNfg16hI8DJbFk1pD+36Cny4=;
        b=AKL6FAM49eHEL63EyLnRh/qfmeWhcunRtggMgZb/0Z3uY0aCqGYgS44v+XRyr9ruEMIQ/P
        tUhZUrCWSP4xPTgCy0/d/cfT5Wa3Wz6Jk3zHPzFsdd5myDkWIUqNX5/+aoPHe6CxAJAioi
        gQbpYYL7Wwefg6n23jQgjnp1sg66LZA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-d58nCAtcMYCc-4SjiJ04RQ-1; Thu, 05 Mar 2020 13:13:46 -0500
X-MC-Unique: d58nCAtcMYCc-4SjiJ04RQ-1
Received: by mail-qk1-f199.google.com with SMTP id e13so4355831qkm.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=CISWnYCTgIHs8Q99tWvsNfg16hI8DJbFk1pD+36Cny4=;
        b=PZYX+f4TayFKX/CetgXoujy4NN/eWDOklIOCWziixfOHGG02xQfEHAMJvDZFcCRe/N
         h2GRpLrdNB04vqBoV+QcjDzu4Z76Xgrwx1CEnMrt+DrfRB1uksgsFUGA12vGHyIGmvQ4
         0dvRGz4PdFjLHs2nLiML/FWO7cgEXXbjWLdcasm1bTjjeOvT40iX8NV7XPOxNfwEJADv
         0QB0tGd7PLyA1bNw/DLVphN76wREfiLy4CHa094ctKmdNI9s7nC1qFftS+azUDUKgsWA
         3z6/tMEagd0FtBxu7MXuJf4mUs5gIyZOuU8Lal67DB+qFZ4tBfEznxjoBQ4oPa0NXdYk
         POzg==
X-Gm-Message-State: ANhLgQ1R6TWfxl7h1c/U8Svh8caTsGal80oO3B5qIpwEoEumdJjhr212
        7i4GAPl+wP4R1e3DkYR+6v66cftHVBSCu+F0nmAeN4aN9nkhlcvCruZTfTvLNIVQ1ESef7OkbVx
        rQ4M6HBd4VhvAF2L0CTHiE35C
X-Received: by 2002:a37:e47:: with SMTP id 68mr8996556qko.17.1583432026339;
        Thu, 05 Mar 2020 10:13:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu9Di0TJjle9QFCxhPtgKkfebQZ/w1X7INadpj/G0J6OCnioF3WigU5h2qVIMfKm/UJg8NJJg==
X-Received: by 2002:a37:e47:: with SMTP id 68mr8996532qko.17.1583432026089;
        Thu, 05 Mar 2020 10:13:46 -0800 (PST)
Received: from Ruby ([172.58.220.228])
        by smtp.gmail.com with ESMTPSA id z19sm2921705qts.86.2020.03.05.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:13:45 -0800 (PST)
Message-ID: <73f52c392431cd21a80a118dd2fd1986e2c535df.camel@redhat.com>
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
Date:   Thu, 05 Mar 2020 13:13:36 -0500
In-Reply-To: <20200305131119.GJ13686@intel.com>
References: <20200304223614.312023-1-lyude@redhat.com>
         <20200304223614.312023-3-lyude@redhat.com>
         <20200305131119.GJ13686@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 15:11 +0200, Ville Syrjälä wrote:
> On Wed, Mar 04, 2020 at 05:36:12PM -0500, Lyude Paul wrote:
> > It's next to impossible for us to do connector probing on topologies
> > without occasionally racing with userspace, since creating a connector
> > itself causes a hotplug event which we have to send before probing the
> > available PBN of a connector. Even if we didn't have this hotplug event
> > sent, there's still always a chance that userspace started probing
> > connectors before we finished probing the topology.
> > 
> > This can be a problem when validating a new MST state since the
> > connector will be shown as connected briefly, but without any available
> > PBN - causing any atomic state which would enable said connector to fail
> > with -ENOSPC. So, let's simply workaround this by telling userspace new
> > MST connectors are disconnected until we've finished probing their PBN.
> > Since we always send a hotplug event at the end of the link address
> > probing process, userspace will still know to reprobe the connector when
> > we're ready.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST
> > atomic check")
> > Cc: Mikita Lipski <mikita.lipski@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Sean Paul <seanpaul@google.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 207eef08d12c..7b0ff0cff954 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -4033,6 +4033,19 @@ drm_dp_mst_detect_port(struct drm_connector
> > *connector,
> >  			ret = connector_status_connected;
> >  		break;
> >  	}
> > +
> > +	/* We don't want to tell userspace the port is actually plugged into
> > +	 * anything until we've finished probing it's available_pbn, otherwise
> 
> "its"
> 
> Why is the connector even registered before we've finished the probe?
> 
Oops, I'm not sure how I did this by accident but the explanation I gave in
the commit message was uh, completely wrong. I must have forgotten that I made
sure we didn't expose connectors before probing their PBN back when I started
my MST cleanup....

So: despite what I said before it's not actually when new connectors are
created, it's when downstream hotplugs happen which means that the conenctor's
always going to be there before we probe the available_pbn. I did just notice
though that we send a hotplug on connection status notifications even before
we've finished the PBN probe, so I might be able to improve on that as well.
We still definitely want to report the connector as disconnected before we
have the available PBN though, in case another probe was already going before
we got the connection status notification.

I'll make sure to fixup the explanation in the commit message on the next
respin

> > +	 * userspace will see racy atomic check failures
> > +	 *
> > +	 * Since we always send a hotplug at the end of probing topology
> > +	 * state, we can just let userspace reprobe this connector later.
> > +	 */
> > +	if (ret == connector_status_connected && !port->available_pbn) {
> > +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] not ready yet (PBN not
> > probed)\n",
> > +			      connector->base.id, connector->name);
> > +		ret = connector_status_disconnected;
> > +	}
> >  out:
> >  	drm_dp_mst_topology_put_port(port);
> >  	return ret;
> > -- 
> > 2.24.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

