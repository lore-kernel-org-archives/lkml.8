Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B067C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3852070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IZlhPDfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgG2H0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2H0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:26:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF371C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:26:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so19945268oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDmmebkXIz4CjLiFs9kSGs/6GlucFeZ7qPJxtjmG4sA=;
        b=IZlhPDfY6bld0s6GMWo7mrYppG162jxfqsGG5h60rx90fVE1Q/X7tVUH2nzrp4yk1Z
         riMb3hViLjhGc25J41okCk+gUPWr2KPAQK0YbOtlwvH8dVlNu0DrKz98jRbJeqOyfdc5
         V6gyhGAvxs+tO64kWF8AH+le5f+EnYvb3dsXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDmmebkXIz4CjLiFs9kSGs/6GlucFeZ7qPJxtjmG4sA=;
        b=N99lusYBWqUsGQ/SbRJs9+hWrBSb1iabgk3Z5B0xSQeDPC2/3fPcRzJ2hSaRMBooHf
         rDsti5FGNw3oK0QasPS1mob4NlYzkfm/YsDoRey2zjc2kZPMSTr6noX4/NmnkKfYtXt4
         mlVPJETgFHAr2vkiAfzHCw9XRhYOlJUjjl/vRT7nXcCtKQTtpck9G1URwpd/YS77Qm9d
         jKWPXw2DiuJP8HnlRhl8q9oTE/qZZ9fzIc5FettmTCR9b4vN5oImRWjQNbp17wN7xc60
         30N6OTBYTNj88AQ74MbF4M2fGxNeScU/OAAZibQTcXZmE9gO+DHaSmIuzxP+r5tYv/xY
         bkLg==
X-Gm-Message-State: AOAM533lCN745MqiNOBDRQzE+EvN0dSOZcFFqHPKRJhmzzB8QlxSzMoW
        Q8ARi/iQyEK03qSE39U/jExx0a5A7pLS5Earqot1uA==
X-Google-Smtp-Source: ABdhPJyeoc7J2ZuPX6yN1xkaadXh+SXP0p+C+fIAhj+NB33LrYWtHdKkCD1jXJiQnKbwCMIwIq63lFM2VlygcOWgyII=
X-Received: by 2002:aca:da03:: with SMTP id r3mr6666859oig.14.1596007568182;
 Wed, 29 Jul 2020 00:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200725063429.172139-1-weiyongjun1@huawei.com>
 <20200728220205.GJ6419@phenom.ffwll.local> <20200728223543.GU13753@pendragon.ideasonboard.com>
 <20200729002944.GA11598@xilinx.com>
In-Reply-To: <20200729002944.GA11598@xilinx.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 29 Jul 2020 09:25:57 +0200
Message-ID: <CAKMK7uEKRrfHzmZ2mh++bQTmNeBuhpKsz2K2b83oM0SXBMOGFg@mail.gmail.com>
Subject: Re: [PATCH -next] drm: xlnx: Fix typo in parameter description
To:     Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Michal Simek <michals@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 2:33 AM Hyun Kwon <hyun.kwon@xilinx.com> wrote:
>
> Hello,
>
> On Tue, Jul 28, 2020 at 03:35:43PM -0700, Laurent Pinchart wrote:
> > On Wed, Jul 29, 2020 at 12:02:05AM +0200, daniel@ffwll.ch wrote:
> > > Hi Hyun Kwon,
> > >
> > > Are you all sorted with drm-misc commit rights so you can push the 3
> > > (maybe there's more) xlnx fixup patches to drm-misc-next-fixes?
> >
> > Thanks Daniel for bringing this up.
> >
> > Hyun, would that work for you ?
> >
>
> Should I commit small fixups directly to,
> https://cgit.freedesktop.org/drm/drm-misc/log/?h=drm-misc-next-fixes?

Well these patches right now need to go there, but that's not always
the case. We have a flowchart for that now:

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#where-do-i-apply-my-patch

> I received the account for drm-misc a couple years ago, and was able to access
> back then. But now someting has changed, and I can't access at the moment. I'll
> need some time to fix my setup. Maybe some help would be appreciated to speed
> up. I may ping you offline if you don't mind.

Sure, happy to help out.
-Daniel

>
> Thanks,
> -hyun
>
> > > On Sat, Jul 25, 2020 at 06:34:29AM +0000, Wei Yongjun wrote:
> > > > Fix typo in parameter description.
> > > >
> > > > Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > > ---
> > > >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > index 821f7a71e182..3d53638ab15e 100644
> > > > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > > @@ -44,7 +44,7 @@ MODULE_PARM_DESC(aux_timeout_ms, "DP aux timeout value in msec (default: 50)");
> > > >   */
> > > >  static uint zynqmp_dp_power_on_delay_ms = 4;
> > > >  module_param_named(power_on_delay_ms, zynqmp_dp_power_on_delay_ms, uint, 0444);
> > > > -MODULE_PARM_DESC(aux_timeout_ms, "DP power on delay in msec (default: 4)");
> > > > +MODULE_PARM_DESC(power_on_delay_ms, "DP power on delay in msec (default: 4)");
> > > >
> > > >  /* Link configuration registers */
> > > >  #define ZYNQMP_DP_LINK_BW_SET0x0
> >
> > --
> > Regards,
> >
> > Laurent Pinchart



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
