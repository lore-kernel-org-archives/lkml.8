Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1B1206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="dC65Usoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDFTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:49:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45377 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:49:12 -0400
Received: by mail-il1-f193.google.com with SMTP id x16so684935ilp.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GhiJnLkPCog87xcd0QbX7Ukmz7B9K91Y4lcbxRM4PwA=;
        b=dC65UsoclV5SJSavPY9/ekwH+KupIATDfcVMHqYy5vkbYdlW3CqsEpSyWyf5G/5VZ5
         54dOsqpCRSsih3zf4sYYodRtSrF+6jyfbS2/Ru+RV3v4sgxi4zDctlTqZkugbmHdFOuM
         dVRTojsfBekOyLDm/FjEvGrZYeyzPc///xwUjUjCT65vAZKla98VKdBLZ8VTz79GH4o2
         92JMbZPau4jrnzuqpnEHGjkgEDuGr3taYAqRIDa9LbgthAkOarXym1rJNzO1hDJJYtwv
         Qo26vHSP4XpLCxUcu5I/mZVlqQltHBQ0mecg4noq/darXIH7D4MUdp+gCGz1MUs7J83d
         GOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GhiJnLkPCog87xcd0QbX7Ukmz7B9K91Y4lcbxRM4PwA=;
        b=LMp7A5JTqrtMfCv0SkW8QbFdTkHbaV2I52AROEhxD+Iof2MoTeoU0cQQdXcyZG2JW1
         4qJS9NWRiYwzwQVBRTuX5IfAepcln15a6tAUmdAdktrdgA7z6Z8KzMYdfY6W5U8DghJu
         GtZQuagR5Stup5wpyBRhGbJgDCFnZp42NdEmrtZi/Ab5o9MKZ542q2S3ZyFW1f2sjIQE
         eN1GhVYhFyz/+hiEmlOu6rW8qp/MKDvlaNcvY7KHLXw3w4+9TFOBF7OOS2qOLwlrLS+W
         sQkcTsbpCNYbDDYBnKMTSTIx4n5N51qN42ZMC7gDOLP4N7EcDsIu/Yx4+n8KouiTlwYh
         V12A==
X-Gm-Message-State: AGi0PuYbQYk6HvSL6v7x6tMaQY6Zm769IF4EST+0FBiN/D4tqude8g2Q
        DV5n3xoK0cTCnx5e2XyNeAah6tjAlwlxQPPBrwlBHg==
X-Google-Smtp-Source: APiQypIyzTB/RjlY+sJEU5dPf6dbdqhacd2IztQ3y9a+Fw0TAzaCPbxSpgCUfwT2Yl26XpHlcZrKwZVmvz6I3n5zhLU=
X-Received: by 2002:a92:91d6:: with SMTP id e83mr1069130ill.165.1586202550664;
 Mon, 06 Apr 2020 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200403200757.886443-1-lyude@redhat.com> <20200403200757.886443-4-lyude@redhat.com>
 <CAMavQK+yVxFYNUR1wdfwB_UhRS2ziy0N5k+WTwAqUwRovX3GMA@mail.gmail.com> <3eccd492237ee8797a8af2ea757594bc13ae055f.camel@redhat.com>
In-Reply-To: <3eccd492237ee8797a8af2ea757594bc13ae055f.camel@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:48:34 -0400
Message-ID: <CAMavQKJdh22Xa82W19UuQ+6P-XYgK-f+VV9maTFO7kE0Zs+hwg@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/dp_mst: Increase ACT retry timeout to 3s
To:     Lyude Paul <lyude@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 3:43 PM Lyude Paul <lyude@redhat.com> wrote:
>
> On Mon, 2020-04-06 at 15:41 -0400, Sean Paul wrote:
> > On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
> > > Currently we only poll for an ACT up to 30 times, with a busy-wait de=
lay
> > > of 100=C2=B5s between each attempt - giving us a timeout of 2900=C2=
=B5s. While
> > > this might seem sensible, it would appear that in certain scenarios i=
t
> > > can take dramatically longer then that for us to receive an ACT. On o=
ne
> > > of the EVGA MST hubs that I have available, I observed said hub
> > > sometimes taking longer then a second before signalling the ACT. Thes=
e
> > > delays mostly seem to occur when previous sideband messages we've sen=
t
> > > are NAKd by the hub, however it wouldn't be particularly surprising i=
f
> > > it's possible to reproduce times like this simply by introducing bran=
ch
> > > devices with large LCTs since payload allocations have to take effect=
 on
> > > every downstream device up to the payload's target.
> > >
> > > So, instead of just retrying 30 times we poll for the ACT for up to 3=
ms,
> > > and additionally use usleep_range() to avoid a very long and rude
> > > busy-wait. Note that the previous retry count of 30 appears to have b=
een
> > > arbitrarily chosen, as I can't find any mention of a recommended time=
out
> > > or retry count for ACTs in the DisplayPort 2.0 specification. This al=
so
> > > goes for the range we were previously using for udelay(), although I
> > > suspect that was just copied from the recommended delay for link
> > > training on SST devices.
> > >
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper
> > > (v0.6)")
> > > Cc: Sean Paul <sean@poorly.run>
> > > Cc: <stable@vger.kernel.org> # v3.17+
> > > ---
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 26 +++++++++++++++++++------=
-
> > >  1 file changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index 7aaf184a2e5f..f313407374ed 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -4466,17 +4466,30 @@ static int drm_dp_dpcd_write_payload(struct
> > > drm_dp_mst_topology_mgr *mgr,
> > >   * @mgr: manager to use
> > >   *
> > >   * Tries waiting for the MST hub to finish updating it's payload tab=
le by
> > > - * polling for the ACT handled bit.
> > > + * polling for the ACT handled bit for up to 3 seconds (yes-some hub=
s
> > > really
> > > + * take that long).
> > >   *
> > >   * Returns:
> > >   * 0 if the ACT was handled in time, negative error code on failure.
> > >   */
> > >  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
> > >  {
> > > -       int count =3D 0, ret;
> > > +       /*
> > > +        * There doesn't seem to be any recommended retry count or ti=
meout
> > > in
> > > +        * the MST specification. Since some hubs have been observed =
to
> > > take
> > > +        * over 1 second to update their payload allocations under ce=
rtain
> > > +        * conditions, we use a rather large timeout value.
> > > +        */
> > > +       const int timeout_ms =3D 3000;
> > > +      unsigned long timeout =3D jiffies + msecs_to_jiffies(timeout_m=
s);
> > > +       int ret;
> > > +       bool retrying =3D false;
> > >         u8 status;
> > >
> > >         do {
> > > +               if (retrying)
> > > +                       usleep_range(100, 1000);
> > > +
> > >                 ret =3D drm_dp_dpcd_readb(mgr->aux,
> > >                                         DP_PAYLOAD_TABLE_UPDATE_STATU=
S,
> > >                                         &status);
> > > @@ -4488,13 +4501,12 @@ int drm_dp_check_act_status(struct
> > > drm_dp_mst_topology_mgr *mgr)
> > >
> > >                 if (status & DP_PAYLOAD_ACT_HANDLED)
> > >                         break;
> > > -               count++;
> > > -               udelay(100);
> > > -       } while (count < 30);
> > > +               retrying =3D true;
> > > +       } while (jiffies < timeout);
> >
> > Somewhat academic, but I think there's an overflow possibility here if
> > timeout is near ulong_max and jiffies overflows during the usleep. In
> > that case we'll be retrying for a very loong time.
> >
> > I wish we had i915's wait_for() macro available to all drm...
>
> Maybe we could add it to the kernel library somewhere? I don't see why we=
'd
> need to stop at DRM

So You Want To Build A Bikeshed...

Seriously though, I'd be very happy with that. Alternatively you could
shoehorn this into readx_poll_timeout as well.

Sean

>
> >
> > Sean
> >
> > >         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> > > -               DRM_DEBUG_KMS("failed to get ACT bit %d after %d
> > > retries\n",
> > > -                             status, count);
> > > +               DRM_DEBUG_KMS("failed to get ACT bit %d after %dms\n"=
,
> > > +                             status, timeout_ms);
> > >                 return -EINVAL;
> > >         }
> > >         return 0;
> > > --
> > > 2.25.1
> > >
> --
> Cheers,
>         Lyude Paul (she/her)
>         Associate Software Engineer at Red Hat
>
