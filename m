Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D7C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8021835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KspJjLsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAVXn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:43:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgAVXn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579736634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xB1GttdbT3t+7BmVYHCi+SL61EAOwYzXDDXUKLb+yKA=;
        b=KspJjLsH9M5bovlkfAM1opXbj2Rgqgioukzp3Vb2xh5hy+4V1+JwgePoOjfntrwBVxvi/9
        ynIM4SU8T6/htlGr2pKPm3vABakC4nW1xgb/m9WPFmvRb4GUQ2ryc8ZdYfdAJkYtcPHbYh
        Bc/Kkd5tGAtwAj6dk5iu9sAnky+O0Fg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-C9fVhW0CM-uPOdN8Y6LGEg-1; Wed, 22 Jan 2020 18:43:53 -0500
X-MC-Unique: C9fVhW0CM-uPOdN8Y6LGEg-1
Received: by mail-qt1-f199.google.com with SMTP id a13so977712qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 15:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=xB1GttdbT3t+7BmVYHCi+SL61EAOwYzXDDXUKLb+yKA=;
        b=dqaDWIl23x8uBGm2Ikrlw/M4BAM/GsNWKuLd/4ZG1j3F8oBSyhMYmWSfmb4C6urvWH
         OvYzzTea2wpWz3vNisEgvVPewk9ADeck9wQuyQ1lzfLqdhSfR2vgsjrbfJfIow7pqPSK
         UjIiUmTcMc0xIT9++dLzRvXwZhtYKOlC5sxUIlwMqkXF5kJVSL546ADZkGqND7AbiIrw
         LSuind7Sy10pQCJ8RD3aFdzo/nyiBx8xtETQ2c/Gk1yCglunx8OizHyMPAYSUzP8lmWP
         nC+OuHi0PCyrOwtMS1S/Dy4erUJzM5wEGZ3TXFT9yx15tG2Tco6qqy2MMVw84cd6Y2kF
         LpiQ==
X-Gm-Message-State: APjAAAW6F1Hb6vXabEugld0eZG0u3vcyPCIniH/0UvArkRM2jvBsiCIc
        S4RYqowJhY43r4WIj8kHLHNONIVGHwHsUM/XjBbYkvbxIQXXGuaLLMNc6KcRwbWQrz9ZDkItahv
        VjgZ7HB5CtAVs33VFq3+Kmp5H
X-Received: by 2002:a05:620a:4db:: with SMTP id 27mr13443395qks.146.1579736632702;
        Wed, 22 Jan 2020 15:43:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzg0UCKLKoVY9Z3OtxOCjftnbr7zi/VmqEuXqfcFBxwvH7MQrJvnBBVQhlwACialzg1m07iuQ==
X-Received: by 2002:a05:620a:4db:: with SMTP id 27mr13443368qks.146.1579736632418;
        Wed, 22 Jan 2020 15:43:52 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id i5sm94751qtv.80.2020.01.22.15.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 15:43:51 -0800 (PST)
Message-ID: <bedb14c54b1cbd93117e2a64675ea31ad4b23d5a.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] drm/dp_mst: Fix clearing payload state on
 topology disable
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jan 2020 18:43:50 -0500
In-Reply-To: <20200122205153.GJ13686@intel.com>
References: <20200122194321.14953-1-lyude@redhat.com>
         <20200122205153.GJ13686@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-22 at 22:51 +0200, Ville Syrjälä wrote:
> On Wed, Jan 22, 2020 at 02:43:20PM -0500, Lyude Paul wrote:
> > The issues caused by:
> > 
> > 64e62bdf04ab ("drm/dp_mst: Remove VCPI while disabling topology mgr")
> > 
> > Prompted me to take a closer look at how we clear the payload state in
> > general when disabling the topology, and it turns out there's actually
> > two subtle issues here.
> > 
> > The first is that we're not grabbing &mgr.payload_lock when clearing the
> > payloads in drm_dp_mst_topology_mgr_set_mst(). Seeing as the canonical
> > lock order is &mgr.payload_lock -> &mgr.lock (because we always want
> > &mgr.lock to be the inner-most lock so topology validation always
> > works), this makes perfect sense. It also means that -technically- there
> > could be racing between someone calling
> > drm_dp_mst_topology_mgr_set_mst() to disable the topology, along with a
> > modeset occurring that's modifying the payload state at the same time.
> > 
> > The second is the more obvious issue that Wayne Lin discovered, that
> > we're not clearing proposed_payloads when disabling the topology.
> > 
> > I actually can't see any obvious places where the racing caused by the
> > first issue would break something, and it could be that some of our
> > higher-level locks already prevent this by happenstance, but better safe
> > then sorry. So, let's make it so that drm_dp_mst_topology_mgr_set_mst()
> > first grabs &mgr.payload_lock followed by &mgr.lock so that we never
> > race when modifying the payload state. Then, we also clear
> > proposed_payloads to fix the original issue of enabling a new topology
> > with a dirty payload state. This doesn't clear any of the drm_dp_vcpi
> > structures, but those are getting destroyed along with the ports anyway.
> > 
> > Changes since v1:
> > * Use sizeof(mgr->payloads[0])/sizeof(mgr->proposed_vcpis[0]) instead -
> >   vsyrjala
> > 
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Wayne Lin <Wayne.Lin@amd.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 3649e82b963d..23cf46bfef74 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -3501,6 +3501,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > drm_dp_mst_topology_mgr *mgr, bool ms
> >  	int ret = 0;
> >  	struct drm_dp_mst_branch *mstb = NULL;
> >  
> > +	mutex_lock(&mgr->payload_lock);
> >  	mutex_lock(&mgr->lock);
> >  	if (mst_state == mgr->mst_state)
> >  		goto out_unlock;
> > @@ -3559,7 +3560,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > drm_dp_mst_topology_mgr *mgr, bool ms
> >  		/* this can fail if the device is gone */
> >  		drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL, 0);
> >  		ret = 0;
> > -		memset(mgr->payloads, 0, mgr->max_payloads * sizeof(struct
> > drm_dp_payload));
> > +		memset(mgr->payloads, 0,
> > +		       mgr->max_payloads * sizeof(mgr->payloads[0]));
> > +		memset(mgr->proposed_vcpis, 0,
> > +		       mgr->max_payloads * sizeof(mgr->proposed_vcpis[0]));
> >  		mgr->payload_mask = 0;
> >  		set_bit(0, &mgr->payload_mask);
> >  		mgr->vcpi_mask = 0;
> > @@ -3568,6 +3572,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > drm_dp_mst_topology_mgr *mgr, bool ms
> >  
> >  out_unlock:
> >  	mutex_unlock(&mgr->lock);
> > +	mutex_unlock(&mgr->payload_lock);
> 
> Locking order looks sane. Not entirely sure what the implications of
> clearing all that stuff outside of a proper modeset is, but at least
> it matches what we already do. So

fwiw - it's not clearing anything currently programmed in hw at that point,
it's just clearing the arrays we use for keeping track of pending/current
payload allocations so there's nothing in them the next time we enable MST on
a display. This is basically what we want anyway - once we disable MST through
the DPCD, we won't end up sending any payload updates anyway so these don't
get used in the modesets that follow.

tbh, part of me wonders if we could handle more of this in atomic state in the
future, but I haven't seen a good enough reason to try that yet.
> 
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> >  	if (mstb)
> >  		drm_dp_mst_topology_put_mstb(mstb);
> >  	return ret;
> > -- 
> > 2.24.1
-- 
Cheers,
	Lyude Paul

