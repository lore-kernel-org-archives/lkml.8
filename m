Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168992083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fvA9b4tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEEVZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728356AbgEEVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:25:41 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21217C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:25:41 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i5so91282uaq.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD6x55Qhc8P/MQPIZ2l6eEcYMnu118KHZyq+VyyY6KU=;
        b=fvA9b4tWrD/H0GLbXPEs6tOAK8UDJwvrvOiaBXGDoleVtHqp6BYMLM+ltfgx/p5gGm
         LwoaRBfPSkzoqh3TIhzjxtbDYblUMcqBZBysucb+19H1nqGwdJsX/IL9K9qBxJ5AZJo2
         DsCRTaiymbtLV9sjkfLLVI0ujcE7nd8j8d/m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD6x55Qhc8P/MQPIZ2l6eEcYMnu118KHZyq+VyyY6KU=;
        b=WBkHb8hiKqnhW+Bx+Eqt7N9IV/Lw+MDPhzkaYoEagpYsWMJWh+3Hd/iKq9EicVAshR
         ETrRLzINE/CXs0PVL0nMsAOZr15p7Sz8V6OGe3ktoUYemuNUcVdg8cFoTJgz09+9EshL
         ALCUebPsvK4Si+25rkdVeElQ/AYvYRRnV1LCROxcCosIKEZRTMBzdaUPv8L/YGJ/ArmT
         pW71DgFlNdpaTa24XsCcQGXUc0UyvzuH4w49o8j4NobeGMB32Z/uWrOM3Htf8tm71N28
         YPdrGh4E0RwqOu7UCx0A0paxJkgJ3kKsyfYng4nFvwg0ecS82JaTIsUuR/uz2srvltxV
         PW0A==
X-Gm-Message-State: AGi0PuYNNolxiJZtqb4YP4g+mGmSAWwXT0u6XYWXDU10hc6Vjdw2V153
        GBdczpsTSIqh/Eyh47o9impu3N9b/tg=
X-Google-Smtp-Source: APiQypJvd9+mFPqJ1qKTTuz5N5L1JeJ+5mcTZvOJ+mjlIH/bfVw7saStutr8fuQmdLrK+mvrfUEylw==
X-Received: by 2002:ab0:32d2:: with SMTP id f18mr4019098uao.141.1588713940091;
        Tue, 05 May 2020 14:25:40 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id u63sm1706133vsc.13.2020.05.05.14.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:25:38 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id s11so129590vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:25:38 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr4978460vsk.106.1588713937569;
 Tue, 05 May 2020 14:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200504213624.1.Ibc8eeddcee94984a608d6900b46f9ffde4045da4@changeid>
 <20200505082436.GD9658@pendragon.ideasonboard.com> <CAD=FV=WjUpwu5204K8yHzqsJv4vQX5S5CArH1Kj_kqjhZzTc9A@mail.gmail.com>
 <20200505210609.GA6094@pendragon.ideasonboard.com> <CAD=FV=UnGOYh8JX2=fEAqPN7wqANc0QevTirNO-WUDYMPqXcrg@mail.gmail.com>
 <20200505212055.GA17960@ravnborg.org>
In-Reply-To: <20200505212055.GA17960@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 May 2020 14:25:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Viwon0KV297H55Cv0XTaf5p2JFnzjc97m1srpbbmVMnQ@mail.gmail.com>
Message-ID: <CAD=FV=Viwon0KV297H55Cv0XTaf5p2JFnzjc97m1srpbbmVMnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement lane reordering + polarity
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 5, 2020 at 2:21 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Dough.
>
> > >
> > > If we don't want to test that, I would at least document it in the DT
> > > bindings. It will be a good occasion to switch the bindings to YAML ;-)
> >
> > Interesting that you bring this up.  Conversion to yaml is sitting
> > waiting to land (or additional review comments):
> >
> > https://lore.kernel.org/r/20200430124442.v4.4.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid/
>
> Whole series is on my TODO list.
> But it needs a few hours so do not expect anything until the weekend.

No problem.  I know how hard it is to find time for big chunks like
this.  I'll hope for something next week.  :-)

-Doug
