Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CCAC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D87520C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIISgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:36:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:57279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIISgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:36:33 -0400
IronPort-SDR: /ra28IRa319nkk/kmRZRoP15zfIGSjHPWZbaM9i1CrQxEys6NY1nlKx1wsWZJ9Zmg1Q6OfK2VO
 9seVg4iX+ynQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146110869"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146110869"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 11:36:32 -0700
IronPort-SDR: LferYeSil/HEpv4GqJx+mklAYh2mncAbkxXr27unboEl0kX7kYbvMWJbwNpzT/RKr1ZIlSj9VH
 nb7d5HG38/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="343982758"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 09 Sep 2020 11:36:27 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 09 Sep 2020 21:36:27 +0300
Date:   Wed, 9 Sep 2020 21:36:27 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Subject: Re: [PATCH] drm/dp: For MST hub, Get max_link_rate&max_lane from
 extended rx capability field if EXTENDED_RECEIVER_CAPABILITY_FILED_PRESENT
 is set.
Message-ID: <20200909183627.GP6112@intel.com>
References: <20200827053053.11271-1-koba.ko@canonical.com>
 <CAJB-X+WPiUR8N5sLMS2UC-rPHj=TGJy2ezeBPjjeUXzbN5bfcg@mail.gmail.com>
 <b1dcaf433b7ebe2d0284693724f0e7d8a7fa4825.camel@redhat.com>
 <20200909182010.GO6112@intel.com>
 <aaf36e7a1be596f831ca2665375632aae9c8e350.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaf36e7a1be596f831ca2665375632aae9c8e350.camel@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 02:26:11PM -0400, Lyude Paul wrote:
> On Wed, 2020-09-09 at 21:20 +0300, Ville Syrjälä wrote:
> > On Wed, Sep 09, 2020 at 12:33:09PM -0400, Lyude Paul wrote:
> > > We just added a new helper for DPCD retrieval to drm_dp_helper.c (which
> > > also
> > > handles grabbing the extended receiver caps), we should probably make use
> > > of
> > > it here 
> > 
> > Someone should really rework this whole thing so that the driver can
> > pass in the link rate+lane count when setting up the link. There's no
> > reason to assume that the source device capabilities match or exceed
> > the MST device caps. It would also allow the driver the dynamically
> > adjust these in response to link failures.
> 
> I'm a bit confused, I also think we should pass the link rate+lane count in
> (especially since it'll be very helpful for when we start optimizing PBN
> handling in regards to bw constraints), but I'm not sure what you mean by
> "There's no reason to assume that the source device capabilities match or
> exceed the MST device caps", aren't we doing the opposite here by checking the
> MST device caps?

We assume only the MST device caps matter. Which is fine if the source
device caps are equal or higher. But if the source device isn't as
capable then we're going to calculate the MST things based on link bw
we can not actually achieve. End result is that we potentially try to
push too much data over the link.

I'm not really sure what actually happens if we just miscompute these
things but don't actually oversubscribe the link. Maybe the remote
end gets confused when we tell it some bogus VC parameters? Maybe it
doesn't care? Dunno.

> > 
> > > On Wed, 2020-09-09 at 14:31 +0800, Koba Ko wrote:
> > > > On Thu, Aug 27, 2020 at 1:30 PM Koba Ko <koba.ko@canonical.com> wrote:
> > > > > Currently, DRM get the capability of the mst hub only from DP_DPCD_REV
> > > > > and
> > > > > get the slower speed even the mst hub can run in the faster speed.
> > > > > 
> > > > > As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> > > > > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the
> > > > > DP_DP13_DPCD_REV
> > > > > to
> > > > > get the faster capability.
> > > > > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
> > > > > 
> > > > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > index 67dd72ea200e..3b84c6801281 100644
> > > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > @@ -3497,6 +3497,8 @@ static int drm_dp_get_vc_payload_bw(u8
> > > > > dp_link_bw,
> > > > > u8  dp_link_count)
> > > > >  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr
> > > > > *mgr,
> > > > > bool mst_state)
> > > > >  {
> > > > >         int ret = 0;
> > > > > +       u8 dpcd_ext = 0;
> > > > > +       unsigned int dpcd_offset = 0;
> > > > >         struct drm_dp_mst_branch *mstb = NULL;
> > > > > 
> > > > >         mutex_lock(&mgr->payload_lock);
> > > > > @@ -3510,9 +3512,15 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > > > > drm_dp_mst_topology_mgr *mgr, bool ms
> > > > >                 struct drm_dp_payload reset_pay;
> > > > > 
> > > > >                 WARN_ON(mgr->mst_primary);
> > > > > +               drm_dp_dpcd_read(mgr->aux,
> > > > > +                                DP_TRAINING_AUX_RD_INTERVAL,
> > > > > +                                &dpcd_ext, sizeof(dpcd_ext));
> > > > > +
> > > > > +               dpcd_offset =
> > > > > +                       ((dpcd_ext &
> > > > > DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV :
> > > > > DP_DPCD_REV);
> > > > > 
> > > > >                 /* get dpcd info */
> > > > > -               ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr-
> > > > > >dpcd,
> > > > > DP_RECEIVER_CAP_SIZE);
> > > > > +               ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr-
> > > > > >dpcd,
> > > > > DP_RECEIVER_CAP_SIZE);
> > > > >                 if (ret != DP_RECEIVER_CAP_SIZE) {
> > > > >                         DRM_DEBUG_KMS("failed to read DPCD\n");
> > > > >                         goto out_unlock;
> > > > > --
> > > > > 2.25.1
> > > > > 
> > > > Add Lyude Paul
> > > > 
> > > -- 
> > > Cheers,
> > > 	Lyude Paul (she/her)
> > > 	Software Engineer at Red Hat
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> -- 
> Cheers,
> 	Lyude Paul (she/her)
> 	Software Engineer at Red Hat

-- 
Ville Syrjälä
Intel
