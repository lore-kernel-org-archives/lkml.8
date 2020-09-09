Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E282C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B220C20770
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXDUwAzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIS6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgIIS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599677900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CazTvBrlRJQ8zfa4RcIvyWhiLyNZLfwdpoVOC/dALOc=;
        b=BXDUwAzwXy0baErvElGTmC6nDm/Si+l/ur+a9cRDT9UyLrSNp93nW/kxQroDw/NPgAvmqu
        avtK70/wHwui1X+zdqCtNseaAZhco3w0WNHkSAn8Dxc6qeB13LgPBk7/JNldh1/1C2sBdi
        8r9xI+XsxkaADQcKyCibMHEsjWUOHXI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-URkbCeOCMXuPp6LYu0Dp1Q-1; Wed, 09 Sep 2020 14:58:15 -0400
X-MC-Unique: URkbCeOCMXuPp6LYu0Dp1Q-1
Received: by mail-qk1-f197.google.com with SMTP id v16so1937828qka.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 11:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=CazTvBrlRJQ8zfa4RcIvyWhiLyNZLfwdpoVOC/dALOc=;
        b=oU+lsP7Ev6q7zaiEt6xPsXqI+2YdI4Bx9NOj3d1oDSTb54b6fkLp2ZGAyW00Tm7CT+
         ILKw+ZcWCIrmb+1PJ9DstSqMu7381id+UGj6f63U73tPXG4VV9DfAEMgyp8Vpe1Xq1Qr
         m8GqaL92kiC+Ya2zftxGo1HANwo6ft0sCBem8FFx9L45NRpj8WnGebE62D+QNIjuqMf9
         e3i/DDxhhaf+a9bpYlxfHAKafoSGL0+cDa0C2+ftgpYFAiJ0lhmttQg8nLP5fMhA69hz
         LmgOVM6sNorDOWL3IqqNG8nZYPCQg0hySnxInkp8JBkTp9oUH/rYQL0HEPAOEyT6yjQs
         4nTQ==
X-Gm-Message-State: AOAM531THJsCyR6lmpQfKmhqSDaFo8M1pIRRMn9TUQVedn40Czi5Q5Gf
        nXNjl2IpVotcyterlOt3/+skV7hllaO9qiZTHpRiYM9Z39zrClBi6N15ivQ7OLQKQ/e7S63jT67
        phRbrH5/LgWRgTdF2A8unzvUn
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr4825624qtj.148.1599677894678;
        Wed, 09 Sep 2020 11:58:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMrfJHUr1BuZ8QHwSbIINRJrStEdMAiEEDw4kOnseUMVwZfUyFpay3iO3YT70h465ee+wZ7w==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr4825605qtj.148.1599677894379;
        Wed, 09 Sep 2020 11:58:14 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id i62sm3470781qkf.36.2020.09.09.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 11:58:13 -0700 (PDT)
Message-ID: <a2aa760dd795d8798efc5f07d80cec8dd3147dcc.camel@redhat.com>
Subject: Re: [PATCH] drm/dp: For MST hub, Get max_link_rate&max_lane from
 extended rx capability field if EXTENDED_RECEIVER_CAPABILITY_FILED_PRESENT
 is set.
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Date:   Wed, 09 Sep 2020 14:58:12 -0400
In-Reply-To: <20200909183627.GP6112@intel.com>
References: <20200827053053.11271-1-koba.ko@canonical.com>
         <CAJB-X+WPiUR8N5sLMS2UC-rPHj=TGJy2ezeBPjjeUXzbN5bfcg@mail.gmail.com>
         <b1dcaf433b7ebe2d0284693724f0e7d8a7fa4825.camel@redhat.com>
         <20200909182010.GO6112@intel.com>
         <aaf36e7a1be596f831ca2665375632aae9c8e350.camel@redhat.com>
         <20200909183627.GP6112@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 21:36 +0300, Ville Syrjälä wrote:
> On Wed, Sep 09, 2020 at 02:26:11PM -0400, Lyude Paul wrote:
> > On Wed, 2020-09-09 at 21:20 +0300, Ville SyrjÃƒÂ¤lÃƒÂ¤ wrote:
> > > On Wed, Sep 09, 2020 at 12:33:09PM -0400, Lyude Paul wrote:
> > > > We just added a new helper for DPCD retrieval to drm_dp_helper.c
> > > > (which
> > > > also
> > > > handles grabbing the extended receiver caps), we should probably make
> > > > use
> > > > of
> > > > it here 
> > > 
> > > Someone should really rework this whole thing so that the driver can
> > > pass in the link rate+lane count when setting up the link. There's no
> > > reason to assume that the source device capabilities match or exceed
> > > the MST device caps. It would also allow the driver the dynamically
> > > adjust these in response to link failures.
> > 
> > I'm a bit confused, I also think we should pass the link rate+lane count
> > in
> > (especially since it'll be very helpful for when we start optimizing PBN
> > handling in regards to bw constraints), but I'm not sure what you mean by
> > "There's no reason to assume that the source device capabilities match or
> > exceed the MST device caps", aren't we doing the opposite here by checking
> > the
> > MST device caps?
> 
> We assume only the MST device caps matter. Which is fine if the source
> device caps are equal or higher. But if the source device isn't as
> capable then we're going to calculate the MST things based on link bw
> we can not actually achieve. End result is that we potentially try to
> push too much data over the link.
> 
> I'm not really sure what actually happens if we just miscompute these
> things but don't actually oversubscribe the link. Maybe the remote
> end gets confused when we tell it some bogus VC parameters? Maybe it
> doesn't care? Dunno.

Ah-I understand what you mean. From my understanding I think MST devices parse
some of the bandwidth information (since a lot of hubs seem to have a
different full_pbn based on the source caps from what I've seen). But yes-we
probably should also start processing all of the relevant DPCD caps on the
source device's side instead of just trusting MST. I'll add this to my todo
list

> 
> > > > On Wed, 2020-09-09 at 14:31 +0800, Koba Ko wrote:
> > > > > On Thu, Aug 27, 2020 at 1:30 PM Koba Ko <koba.ko@canonical.com>
> > > > > wrote:
> > > > > > Currently, DRM get the capability of the mst hub only from
> > > > > > DP_DPCD_REV
> > > > > > and
> > > > > > get the slower speed even the mst hub can run in the faster speed.
> > > > > > 
> > > > > > As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> > > > > > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the
> > > > > > DP_DP13_DPCD_REV
> > > > > > to
> > > > > > get the faster capability.
> > > > > > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
> > > > > > 
> > > > > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++++++-
> > > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > index 67dd72ea200e..3b84c6801281 100644
> > > > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > > @@ -3497,6 +3497,8 @@ static int drm_dp_get_vc_payload_bw(u8
> > > > > > dp_link_bw,
> > > > > > u8  dp_link_count)
> > > > > >  int drm_dp_mst_topology_mgr_set_mst(struct
> > > > > > drm_dp_mst_topology_mgr
> > > > > > *mgr,
> > > > > > bool mst_state)
> > > > > >  {
> > > > > >         int ret = 0;
> > > > > > +       u8 dpcd_ext = 0;
> > > > > > +       unsigned int dpcd_offset = 0;
> > > > > >         struct drm_dp_mst_branch *mstb = NULL;
> > > > > > 
> > > > > >         mutex_lock(&mgr->payload_lock);
> > > > > > @@ -3510,9 +3512,15 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > > > > > drm_dp_mst_topology_mgr *mgr, bool ms
> > > > > >                 struct drm_dp_payload reset_pay;
> > > > > > 
> > > > > >                 WARN_ON(mgr->mst_primary);
> > > > > > +               drm_dp_dpcd_read(mgr->aux,
> > > > > > +                                DP_TRAINING_AUX_RD_INTERVAL,
> > > > > > +                                &dpcd_ext, sizeof(dpcd_ext));
> > > > > > +
> > > > > > +               dpcd_offset =
> > > > > > +                       ((dpcd_ext &
> > > > > > DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV :
> > > > > > DP_DPCD_REV);
> > > > > > 
> > > > > >                 /* get dpcd info */
> > > > > > -               ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr-
> > > > > > > dpcd,
> > > > > > DP_RECEIVER_CAP_SIZE);
> > > > > > +               ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr-
> > > > > > > dpcd,
> > > > > > DP_RECEIVER_CAP_SIZE);
> > > > > >                 if (ret != DP_RECEIVER_CAP_SIZE) {
> > > > > >                         DRM_DEBUG_KMS("failed to read DPCD\n");
> > > > > >                         goto out_unlock;
> > > > > > --
> > > > > > 2.25.1
> > > > > > 
> > > > > Add Lyude Paul
> > > > > 
> > > > -- 
> > > > Cheers,
> > > > 	Lyude Paul (she/her)
> > > > 	Software Engineer at Red Hat
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > -- 
> > Cheers,
> > 	Lyude Paul (she/her)
> > 	Software Engineer at Red Hat
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

