Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C82FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8B2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZjawoTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDFTnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:43:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36471 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgDFTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586202194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FgxeFtNjl0qouniLNN2YFmv27Dp9D+qfMG9VLSyC7M=;
        b=UZjawoTGBxvtVsQxQldbKHet7RQ7CaT3y2kr62gpMpDC+zMSKxwJlXaz+5kdCvGMwaG7k6
        OK4r8nxYLSsN2mykk4bfVJxeY1ufytf7MkV29o/0GALrhedGomXjaZE5wHeU7HBgCshlfy
        kAc7rEmTUJO3gh1+sMZTUi01fngmTIA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-RNZT9VtuM6Gr5-xi8d3a8Q-1; Mon, 06 Apr 2020 15:43:12 -0400
X-MC-Unique: RNZT9VtuM6Gr5-xi8d3a8Q-1
Received: by mail-qk1-f197.google.com with SMTP id c1so891919qkg.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4FgxeFtNjl0qouniLNN2YFmv27Dp9D+qfMG9VLSyC7M=;
        b=I0EWoh1FB5p7Gyzetf/t4vZLQ3hTKtIB3U56a/a5zkUsBWIzT6bGJtQGSzCI1e0x6D
         8+Tz7CKrPeuZe5IOQH8rWT5qqZzynagdLPDDHzKPs8aZLNNwHpmlziqcyIyCGUpU9czf
         M/tXKFuBhFIbq52o1x+v4CElLG7VnxfJ5//fGhIzT8m5CDYuGgnVHPPVo18+zlRUHk9e
         k78NkiXHBrjKULxNUYf8IgSvhvL5YML3BiLj8Ux2RjAkIrSbi1/p7C7PGI8snymi0NGy
         L5n2rh+QB+t0C3P4gDF1RZVwE1q/XkULHLvt4N/MLed4a6tRtIi/ge9XP02s3vNmZIDA
         QspQ==
X-Gm-Message-State: AGi0PuZivwcN2/mY4ZbxDBMAN5pzSmcPDP4n+qDn3PyviYjX6X47q7ZO
        SlFYPxQFTlJJJeKQdSP4m1x4tER9GA/g5U4BL1lwhCOSyHQ3V+qP7xkv/iwqcHEzqwOFkH7E6Q7
        uCZgImMATJy6EntkpoJ9HNncD
X-Received: by 2002:a0c:a181:: with SMTP id e1mr1465939qva.19.1586202191874;
        Mon, 06 Apr 2020 12:43:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypII+D3hQ4rA9orAMNS9EzduyFbgdxN85HHsI1cVwQUC0pNc/rMKoEF1qBT7Oy32pVztz1+9pA==
X-Received: by 2002:a0c:a181:: with SMTP id e1mr1465915qva.19.1586202191527;
        Mon, 06 Apr 2020 12:43:11 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id p14sm1159088qkp.63.2020.04.06.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:43:10 -0700 (PDT)
Message-ID: <3eccd492237ee8797a8af2ea757594bc13ae055f.camel@redhat.com>
Subject: Re: [PATCH 3/4] drm/dp_mst: Increase ACT retry timeout to 3s
From:   Lyude Paul <lyude@redhat.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        stable <stable@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Todd Previte <tprevite@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Apr 2020 15:43:09 -0400
In-Reply-To: <CAMavQK+yVxFYNUR1wdfwB_UhRS2ziy0N5k+WTwAqUwRovX3GMA@mail.gmail.com>
References: <20200403200757.886443-1-lyude@redhat.com>
         <20200403200757.886443-4-lyude@redhat.com>
         <CAMavQK+yVxFYNUR1wdfwB_UhRS2ziy0N5k+WTwAqUwRovX3GMA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 15:41 -0400, Sean Paul wrote:
> On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
> > Currently we only poll for an ACT up to 30 times, with a busy-wait delay
> > of 100µs between each attempt - giving us a timeout of 2900µs. While
> > this might seem sensible, it would appear that in certain scenarios it
> > can take dramatically longer then that for us to receive an ACT. On one
> > of the EVGA MST hubs that I have available, I observed said hub
> > sometimes taking longer then a second before signalling the ACT. These
> > delays mostly seem to occur when previous sideband messages we've sent
> > are NAKd by the hub, however it wouldn't be particularly surprising if
> > it's possible to reproduce times like this simply by introducing branch
> > devices with large LCTs since payload allocations have to take effect on
> > every downstream device up to the payload's target.
> > 
> > So, instead of just retrying 30 times we poll for the ACT for up to 3ms,
> > and additionally use usleep_range() to avoid a very long and rude
> > busy-wait. Note that the previous retry count of 30 appears to have been
> > arbitrarily chosen, as I can't find any mention of a recommended timeout
> > or retry count for ACTs in the DisplayPort 2.0 specification. This also
> > goes for the range we were previously using for udelay(), although I
> > suspect that was just copied from the recommended delay for link
> > training on SST devices.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper
> > (v0.6)")
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: <stable@vger.kernel.org> # v3.17+
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 7aaf184a2e5f..f313407374ed 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -4466,17 +4466,30 @@ static int drm_dp_dpcd_write_payload(struct
> > drm_dp_mst_topology_mgr *mgr,
> >   * @mgr: manager to use
> >   *
> >   * Tries waiting for the MST hub to finish updating it's payload table by
> > - * polling for the ACT handled bit.
> > + * polling for the ACT handled bit for up to 3 seconds (yes-some hubs
> > really
> > + * take that long).
> >   *
> >   * Returns:
> >   * 0 if the ACT was handled in time, negative error code on failure.
> >   */
> >  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
> >  {
> > -       int count = 0, ret;
> > +       /*
> > +        * There doesn't seem to be any recommended retry count or timeout
> > in
> > +        * the MST specification. Since some hubs have been observed to
> > take
> > +        * over 1 second to update their payload allocations under certain
> > +        * conditions, we use a rather large timeout value.
> > +        */
> > +       const int timeout_ms = 3000;
> > +      unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> > +       int ret;
> > +       bool retrying = false;
> >         u8 status;
> > 
> >         do {
> > +               if (retrying)
> > +                       usleep_range(100, 1000);
> > +
> >                 ret = drm_dp_dpcd_readb(mgr->aux,
> >                                         DP_PAYLOAD_TABLE_UPDATE_STATUS,
> >                                         &status);
> > @@ -4488,13 +4501,12 @@ int drm_dp_check_act_status(struct
> > drm_dp_mst_topology_mgr *mgr)
> > 
> >                 if (status & DP_PAYLOAD_ACT_HANDLED)
> >                         break;
> > -               count++;
> > -               udelay(100);
> > -       } while (count < 30);
> > +               retrying = true;
> > +       } while (jiffies < timeout);
> 
> Somewhat academic, but I think there's an overflow possibility here if
> timeout is near ulong_max and jiffies overflows during the usleep. In
> that case we'll be retrying for a very loong time.
> 
> I wish we had i915's wait_for() macro available to all drm...

Maybe we could add it to the kernel library somewhere? I don't see why we'd
need to stop at DRM

> 
> Sean
> 
> >         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> > -               DRM_DEBUG_KMS("failed to get ACT bit %d after %d
> > retries\n",
> > -                             status, count);
> > +               DRM_DEBUG_KMS("failed to get ACT bit %d after %dms\n",
> > +                             status, timeout_ms);
> >                 return -EINVAL;
> >         }
> >         return 0;
> > --
> > 2.25.1
> > 
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

