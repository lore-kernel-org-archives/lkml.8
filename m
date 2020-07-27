Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA18C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EB420719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgG0OoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgG0OoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:44:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631AC061794;
        Mon, 27 Jul 2020 07:44:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 801122958A9
Message-ID: <44dcbbc97a06352169a2cc99536e41f2ad111238.camel@collabora.com>
Subject: Re: [PATCH 09/10] media: hantro: Don't require unneeded
 H264_SLICE_PARAMS
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date:   Mon, 27 Jul 2020 11:44:10 -0300
In-Reply-To: <CAPBb6MWG5aXuc7ExiaKvgtLL0o=HDYKFa4D4-v8hfvyGiNFBdA@mail.gmail.com>
References: <20200715202233.185680-1-ezequiel@collabora.com>
         <20200715202233.185680-10-ezequiel@collabora.com>
         <CAPBb6MWG5aXuc7ExiaKvgtLL0o=HDYKFa4D4-v8hfvyGiNFBdA@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Despite you've asked to ignore this review,
let me comment on it.

On Sat, 2020-07-25 at 23:45 +0900, Alexandre Courbot wrote:
> On Thu, Jul 16, 2020 at 5:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > Now that slice invariant parameters have been moved,
> > the driver no longer needs this control, so drop it.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  drivers/staging/media/hantro/hantro_drv.c  | 5 -----
> >  drivers/staging/media/hantro/hantro_h264.c | 5 -----
> >  drivers/staging/media/hantro/hantro_hw.h   | 2 --
> >  3 files changed, 12 deletions(-)
> > 
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > index 34797507f214..3cd00cc0a364 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -306,11 +306,6 @@ static const struct hantro_ctrl controls[] = {
> >                 .cfg = {
> >                         .id = V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS,
> >                 },
> > -       }, {
> > -               .codec = HANTRO_H264_DECODER,
> > -               .cfg = {
> > -                       .id = V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS,
> > -               },
> 
> Isn't this going to make the driver reject (as opposed to just ignore)
> this control altogether? Also, even though the control is not required
> anymore, don't we want to check that it is provided in order to ensure
> user-space follows the spec (granted, this would be better done in a
> common framework shared by all drivers).
> 

As you mentioned on your next reply, indeed frame-based drivers
can't really parse the slice headers.

I believe the above comment would make sense, if we want to avoid
breaking compatibility.

In our case, we are already breaking this (it's broken from the minute
you change any control in the API, as V4L2 reject mismatch sizes
for the controls).

So, I'd say it makes sense to drop it now while we can.

Also, Nicolas has suggested that this makes applications simpler. 

> I'd also suggest this patch (and the following one) to be merged into
> the previous one as they are just removing fields that have become
> unneeded because of it.

I'd like to keep the patches touching the uAPI separate from the
ones touching the driver, when possible (i.e. when the build
is not broken by API changes).

Thanks,
Ezequiel


