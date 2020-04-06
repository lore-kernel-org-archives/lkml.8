Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5218D20768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJkSmRhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDFWLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:11:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbgDFWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2Ct5V3S1c+UJwUTQhQD51UKnmSY4RKZxhEZvTjd+3g=;
        b=EJkSmRhmL5JmRoJom2bl5XIKhIO8JKPCC1vD+uhVt4RRbuvmIfhGwfqJVRY25QzgyVWgwz
        kaSJReq0168fCihhN79g1ryi1tZGKWuGUKf1v8Icg4MCWDmISlPqWZbKZJEEBxS/eSqJm4
        jt0YyQXfZbGdzSN678YSABBafpJZqVc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-ToekIsGCMGurPXnvA_4o9A-1; Mon, 06 Apr 2020 18:11:46 -0400
X-MC-Unique: ToekIsGCMGurPXnvA_4o9A-1
Received: by mail-qk1-f199.google.com with SMTP id b21so1290814qkl.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=v2Ct5V3S1c+UJwUTQhQD51UKnmSY4RKZxhEZvTjd+3g=;
        b=FyU5gNdIx8JmvSs3R68SnEDtr2hTlYZ1lEI3OPMKwV0I43zkBYlQd0mIet05n+lRg+
         i2bwwk71ljMGCyGjtoiqTC3sEJP/Yye3GQcTUrX6Bky7nsh+z0Ha+fB/wcCcdp8DaGMl
         yraU5LY1wtu1ZibsMRxcAf0uy12rk/XOw9h7TH81brKncfeU/YLSRwbFVNQ+BO2t62Hv
         J5zLtEa8nrhX8tPlsbsfIbF0xkFrhgyk4OXULjh/9zv7fr9Bn+agrdDvRJ7sPqXJDePq
         lmAJA8obrfYRSHg0St4WQiEaPDIpmPUM1kQmEJaGFhn9L8aRatUFL9zhxOF18Bx+NjMr
         epWg==
X-Gm-Message-State: AGi0Pua1RSNeCgSCRLhht4HWp/Y4G9G/Lk1m3NzWyEov4DhzYC3qW1co
        ML7bud0Y71ZK4CBxpViJ1LtLe2QYgygcT1ZFn89G+o3xMeozUtRyeqk5wr69xofnXC0HUZl2br9
        g6R3bvOsfDBW5tbY5FqYnxEUR
X-Received: by 2002:ad4:4862:: with SMTP id u2mr2024805qvy.67.1586211106318;
        Mon, 06 Apr 2020 15:11:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTNRaNp7gCT0J9NM4r/XGioMC4sIDsu3UdzD5Ww7wPzKSkKyTKco6lQte0PWEVnkxoeZOI5A==
X-Received: by 2002:ad4:4862:: with SMTP id u2mr2024783qvy.67.1586211106090;
        Mon, 06 Apr 2020 15:11:46 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id m5sm14413184qtk.85.2020.04.06.15.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:11:45 -0700 (PDT)
Message-ID: <bb25bdd85b0dba09292923e448447dec15994768.camel@redhat.com>
Subject: Re: [PATCH 2/4] drm/dp_mst: Reformat drm_dp_check_act_status() a bit
From:   Lyude Paul <lyude@redhat.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        stable <stable@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Todd Previte <tprevite@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Apr 2020 18:11:44 -0400
In-Reply-To: <CAMavQKL6G9QsUE7ZzGXNpjjEVdZGQZkbN3oke-M=Lz=pHOn70A@mail.gmail.com>
References: <20200403200757.886443-1-lyude@redhat.com>
         <20200403200757.886443-3-lyude@redhat.com>
         <CAMavQKL6G9QsUE7ZzGXNpjjEVdZGQZkbN3oke-M=Lz=pHOn70A@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 15:23 -0400, Sean Paul wrote:
> On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
> > Just add a bit more line wrapping, get rid of some extraneous
> > whitespace, remove an unneeded goto label, and move around some variable
> > declarations. No functional changes here.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > [this isn't a fix, but it's needed for the fix that comes after this]
> > Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper
> > (v0.6)")
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: <stable@vger.kernel.org> # v3.17+
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 2b9ce965f044..7aaf184a2e5f 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -4473,33 +4473,31 @@ static int drm_dp_dpcd_write_payload(struct
> > drm_dp_mst_topology_mgr *mgr,
> >   */
> >  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
> >  {
> > +       int count = 0, ret;
> >         u8 status;
> > -       int ret;
> > -       int count = 0;
> > 
> >         do {
> > -               ret = drm_dp_dpcd_readb(mgr->aux,
> > DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
> > -
> > +               ret = drm_dp_dpcd_readb(mgr->aux,
> > +                                       DP_PAYLOAD_TABLE_UPDATE_STATUS,
> > +                                       &status);
> >                 if (ret < 0) {
> > -                       DRM_DEBUG_KMS("failed to read payload table status
> > %d\n", ret);
> > -                       goto fail;
> > +                       DRM_DEBUG_KMS("failed to read payload table status
> > %d\n",
> > +                                     ret);
> > +                       return ret;
> >                 }
> > 
> >                 if (status & DP_PAYLOAD_ACT_HANDLED)
> >                         break;
> >                 count++;
> >                 udelay(100);
> > -
> >         } while (count < 30);
> > 
> >         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> > -               DRM_DEBUG_KMS("failed to get ACT bit %d after %d
> > retries\n", status, count);
> > -               ret = -EINVAL;
> > -               goto fail;
> > +               DRM_DEBUG_KMS("failed to get ACT bit %d after %d
> > retries\n",
> 
> Should we print status in base16 here?

jfyi - I realized we don't actually need to do this, because we do this in the
next patch whoops. Just figured I'd point that out

> 
> Otherwise:
> 
> Reviewed-by: Sean Paul <sean@poorly.run>
> 
> > +                             status, count);
> > +               return -EINVAL;
> >         }
> >         return 0;
> > -fail:
> > -       return ret;
> >  }
> >  EXPORT_SYMBOL(drm_dp_check_act_status);
> > 
> > --
> > 2.25.1
> > 
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

