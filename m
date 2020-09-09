Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B51C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DC72087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/I50b6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbgIIQeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:34:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730785AbgIIQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599669195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydUEDRTQHx4pHV71ApF5AUGdVHqxSu2qaRj9XnFjsic=;
        b=A/I50b6+iIOFoBouKQ9QAcX3gxZHYxXobclpABD4MCGR4lQWDLX3jRWU26/N++PeT5RpCF
        Jzl57CXuiIMeSx7GnuuvSt2DkeT0FVG3IvLeEWs8yCtfyykDuRwFhnzue858OOtNu3dbkx
        TFubooXKcjxqmDZRPesP1rky06UMNT8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-LTenLOsKN0uXNW8wYQpxfQ-1; Wed, 09 Sep 2020 12:33:12 -0400
X-MC-Unique: LTenLOsKN0uXNW8wYQpxfQ-1
Received: by mail-qk1-f197.google.com with SMTP id w126so1710131qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ydUEDRTQHx4pHV71ApF5AUGdVHqxSu2qaRj9XnFjsic=;
        b=NXJoe7l6jbpdTflC3z/fWpj/fpak2765GtoLVQD1kptLMVZwN1qy7eVeIKZzuVMFF6
         VTxwQQ3AEfNeo88KnhENxWoNyur8lHWaO92jR7aAopNBNe/ZAvOg1ED+XwEC3jKIoARg
         VbaQsO/ALoKCs7IQW4/nWyL7xppmWwgKsLyel9QIwmqpKQPKUeqs4WHOV0u+699KtNto
         eIiBDVYbSop57EQdP88wTlhaWkLErvn8dU1HEhtBsxkGC3X/w1mfF17qjqUl4VAt6E0k
         ZaGvd4IPHoGQIAN2Jphr8H2aBU8rZqT39/FnwDwdHMaXq0k740iJe549XXpF3iH8JA8G
         /YQg==
X-Gm-Message-State: AOAM532bbt5VIgQFUflTGGHZzVNOnv4hExX37yT7cnW6L4K/IwMcK6aj
        UCPjPxUCmk32FNwk9DPytcICIez5dbamXnRvRVx6Xc2JN/bFhTem8kOr+SsFmvlhLMO9tWNOGOO
        hVHrdlpgQDGrdhvHO1ecXEczm
X-Received: by 2002:aed:2946:: with SMTP id s64mr3916122qtd.335.1599669191404;
        Wed, 09 Sep 2020 09:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlPSv1t4uQJliUFOWasTHsIqACn1sYRHgZH9OsiLyUio1qii1cEYYNP86dD7m0A9TE/nxZxw==
X-Received: by 2002:aed:2946:: with SMTP id s64mr3916097qtd.335.1599669191102;
        Wed, 09 Sep 2020 09:33:11 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 192sm3225151qkn.9.2020.09.09.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:33:10 -0700 (PDT)
Message-ID: <b1dcaf433b7ebe2d0284693724f0e7d8a7fa4825.camel@redhat.com>
Subject: Re: [PATCH] drm/dp: For MST hub, Get max_link_rate&max_lane from
 extended rx capability field if EXTENDED_RECEIVER_CAPABILITY_FILED_PRESENT
 is set.
From:   Lyude Paul <lyude@redhat.com>
To:     Koba Ko <koba.ko@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Anthony Wong <anthony.wong@canonical.com>
Date:   Wed, 09 Sep 2020 12:33:09 -0400
In-Reply-To: <CAJB-X+WPiUR8N5sLMS2UC-rPHj=TGJy2ezeBPjjeUXzbN5bfcg@mail.gmail.com>
References: <20200827053053.11271-1-koba.ko@canonical.com>
         <CAJB-X+WPiUR8N5sLMS2UC-rPHj=TGJy2ezeBPjjeUXzbN5bfcg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just added a new helper for DPCD retrieval to drm_dp_helper.c (which also
handles grabbing the extended receiver caps), we should probably make use of
it here 

On Wed, 2020-09-09 at 14:31 +0800, Koba Ko wrote:
> On Thu, Aug 27, 2020 at 1:30 PM Koba Ko <koba.ko@canonical.com> wrote:
> > Currently, DRM get the capability of the mst hub only from DP_DPCD_REV and
> > get the slower speed even the mst hub can run in the faster speed.
> > 
> > As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV
> > to
> > get the faster capability.
> > If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
> > 
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 67dd72ea200e..3b84c6801281 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -3497,6 +3497,8 @@ static int drm_dp_get_vc_payload_bw(u8 dp_link_bw,
> > u8  dp_link_count)
> >  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,
> > bool mst_state)
> >  {
> >         int ret = 0;
> > +       u8 dpcd_ext = 0;
> > +       unsigned int dpcd_offset = 0;
> >         struct drm_dp_mst_branch *mstb = NULL;
> > 
> >         mutex_lock(&mgr->payload_lock);
> > @@ -3510,9 +3512,15 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> > drm_dp_mst_topology_mgr *mgr, bool ms
> >                 struct drm_dp_payload reset_pay;
> > 
> >                 WARN_ON(mgr->mst_primary);
> > +               drm_dp_dpcd_read(mgr->aux,
> > +                                DP_TRAINING_AUX_RD_INTERVAL,
> > +                                &dpcd_ext, sizeof(dpcd_ext));
> > +
> > +               dpcd_offset =
> > +                       ((dpcd_ext &
> > DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV :
> > DP_DPCD_REV);
> > 
> >                 /* get dpcd info */
> > -               ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
> > DP_RECEIVER_CAP_SIZE);
> > +               ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd,
> > DP_RECEIVER_CAP_SIZE);
> >                 if (ret != DP_RECEIVER_CAP_SIZE) {
> >                         DRM_DEBUG_KMS("failed to read DPCD\n");
> >                         goto out_unlock;
> > --
> > 2.25.1
> > 
> Add Lyude Paul
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

