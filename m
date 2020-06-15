Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6675C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34DD207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhc1djqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgFOVYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:24:09 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A1C061A0E;
        Mon, 15 Jun 2020 14:24:09 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k13so10219135vsm.13;
        Mon, 15 Jun 2020 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mdu8X+Q7CqBtC/GLB2icKvUv+XOLxvfh0ORFA3IvD2U=;
        b=dhc1djqDcafE5BR0hNJ7YzYzE0xG3+kRVdlEAA7+5Vdy6rvya4U5eD/OBiqQr6yaIb
         Q69HGbizyWmvOvLLVsjD7Re3mYqiTearF3vcfrmfW60mkafC8zGPiSFbm2j6QCwgecoN
         Yv523l9WIBb4DlH+/LOsuq0CY06PDtpr21EjhWj5dsNZdlRozNlfoHGBRGrVpWQyUL7R
         tGoVsWDsKy0v2+7PElbivcnBSfUw4hU4DSQKHdxlJyOxv3oUhzhEOlfK7hUi/iMit4wd
         xbGhOI9Smc6JZeuoo9kFji/zIJRxSUMMPRGv8JbpHvDmSSEC4LgngYJozCG1cWXR5DXp
         p4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mdu8X+Q7CqBtC/GLB2icKvUv+XOLxvfh0ORFA3IvD2U=;
        b=JZnAgmRcTYbK0Oyh3BkIKbA57bHPPyLf+D0871IL8WQtyo4Ld+PCryczP+YcXn7ptk
         zyCbSzKw3xf+bfAvw/QzJyex1qinjaLTwAqUck/8R3FgKWzMiZylhYvdaWi8wVTBJgjK
         Z/KesZbaSfglk4QNlZExei2Jgjr23U5UclQ5shHFQBwBF0y+cjqIuulpsFFj215AEs65
         KCdFm4EA3NLOe10w+SC1kPFKSFIZqIlnH9y1xaLfym6XFNFUg4RUJFupW8DRZX2fhDA5
         Zjg0/6/dmOEWARaqTubgW2AV4IV5sjVXDbSoJw2tnFRk9qvpuxi719eilk1xuMC6Yo8p
         OuiA==
X-Gm-Message-State: AOAM531AZFrMIgaSE9xrCphg604NrExTNsB5GWja3kYNI2/AxMO4A3nl
        X8/wSLhDxc2mKSMUvXXJoUq0wkY6wcgurpPphVI=
X-Google-Smtp-Source: ABdhPJzXrIs+SUF0pylq1xp8/iremWFjDjUX4s9YS4mC3ANMJzk0FVhHmuVLovqwSKQhHNbapA9FF6FCdnfIK5ySESo=
X-Received: by 2002:a67:b149:: with SMTP id z9mr20148246vsl.85.1592256248206;
 Mon, 15 Jun 2020 14:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
 <20200610120131.3069-4-matthias.schiffer@ew.tq-group.com> <20200610145954.GA135509@ravnborg.org>
 <44d3b82a11fc292f0aa3f60a8ccebd4e8ce5d3e8.camel@ew.tq-group.com>
In-Reply-To: <44d3b82a11fc292f0aa3f60a8ccebd4e8ce5d3e8.camel@ew.tq-group.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Jun 2020 22:20:27 +0100
Message-ID: <CACvgo50UoeCQ7ta0VPCWbskKL+s=C1ADyEz8P9bEtgebYcTZ0Q@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH 3/4] drm/panel: simple: add CDTech
 S070PWS19HP-FC21 and S070SWV29HG-DC44
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, 11 Jun 2020 at 08:54, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
> On Wed, 2020-06-10 at 16:59 +0200, Sam Ravnborg wrote:
> > On Wed, Jun 10, 2020 at 02:01:30PM +0200, Matthias Schiffer wrote:

> > > +   .vrefresh = 60,
> >
> > .vrefresh is no longer present, please drop.
>
> I based my patches on the branch drm-next of
> https://cgit.freedesktop.org/drm/drm, should I have used a different
> branch?
>
Small tip for the future:

The best way to find the correct tree is to check with the MAINTAINERS
file or via ./scripts/get_maintainer --scm ...

-Emil
