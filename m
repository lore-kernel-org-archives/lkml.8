Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A90C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5553524671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5klrh3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBTCwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:52:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35605 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBTCwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:52:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so2926224wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 18:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuWiXIN7XrPBswL6JTvBTnA9S2sBls11R96m1WANlyo=;
        b=o5klrh3/3wd1oTH83CHITX2HjsAgiUZqzzfFNQYgD/25JUi2xTL73kpzR38ZYkjqC2
         YvWVsIYC/WwQ7fGUCnMee68k1n0KICdiLNLuHlFvosd/ZIRqWJR0M9SFK4V4oPauadKL
         ishStQZPADOyqb+g3oHC+JiGaX7vk5WiCRcqflJsQNvc3ZuPYHMxS3eXrSzRbK/m1duB
         DIJKPAgccYfsk7mC4eJOYMP4Zk/2NYGBWlWbFIO9UitHsgqhCBUoq6psvoCP84nQhqj8
         Jd0XLJrFx/8BikrYAELAwKnEC8q3Msd9WCTgTdLuGeHdmRV7yCryU0RcxIpZ58scazWr
         XK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuWiXIN7XrPBswL6JTvBTnA9S2sBls11R96m1WANlyo=;
        b=QVSq8BBQIM8zRu5c04lrENvVC/2EHhJptO1A5ciNM9UX/ejodML5Y9C1OQskyWhus4
         swFW2Jw8DiRLj1VzVJpf6SZS0UX0lihGRSEqun7Ab1rJkbIePtQEJNKavY3/DJegFCqo
         C0Mpt/l+17eN7woNErdZWU8TgwLxUsJvD+3yurT2Nx0PynHBPS9MCIpFZ3Te99pSCThW
         S2rfsJWHGDidHJTxaQtxhCD55uaaNlDBxn7A6MrOpgyz+x/5x6FHQ5qstHoIwimLIk5K
         aC0Rv5wPFsxsbv/+wvWxg70PXq0t6xb/xEKDtuPKb9uPK21/1GxXYSMUqGRbMsh8sAA4
         G41w==
X-Gm-Message-State: APjAAAVXoR0rAfpoYz6bgPULszjTkeSjVshYBQwQwVjttK9y40U4R8cZ
        enm4Nu1h5dIzhUL3mg9FDGpQvk2Wj3GmD/X2gmO9Sw==
X-Google-Smtp-Source: APXvYqxCjFBBhSBoM7ZiaO3hBmW4TV2UmaN3lmngAU+dIZ63atObMRwgd6ZEif74hNS3w/ghnG/Gi6HpzHjjtuHGurs=
X-Received: by 2002:adf:b254:: with SMTP id y20mr38664106wra.362.1582167163536;
 Wed, 19 Feb 2020 18:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20200220004232.GA28048@paulmck-ThinkPad-P72>
In-Reply-To: <20200220004232.GA28048@paulmck-ThinkPad-P72>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 19 Feb 2020 21:52:32 -0500
Message-ID: <CADnq5_OJSHV5XotA6hORgQSrC4A-ZFzfXN_NRMGYFka+MTyjGg@mail.gmail.com>
Subject: Re: drm_dp_mst_topology.c and old compilers
To:     paulmck@kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 7:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> A box with GCC 4.8.3 compiler didn't like drm_dp_mst_topology.c.  The
> following (lightly tested) patch makes it happy and seems OK for newer
> compilers as well.
>
> Is this of interest?

How about a memset instead?  That should be consistent across compilers.

Alex


>
>                                                         Thanx, Paul
>
> -----------------------------------------------------------------------
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 20cdaf3..232408a 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -5396,7 +5396,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>  {
>         struct drm_dp_mst_port *immediate_upstream_port;
>         struct drm_dp_mst_port *fec_port;
> -       struct drm_dp_desc desc = { 0 };
> +       struct drm_dp_desc desc = {{{ 0 }}};
>         u8 endpoint_fec;
>         u8 endpoint_dsc;
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
