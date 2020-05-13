Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB03CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2696420769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISrIrAZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgEML6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEML6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:58:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D28C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:58:24 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so8689515ion.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+yjaeld2PBj1DS6qWHzYu9fpGryCbzHIvMWkAYrCUk=;
        b=ISrIrAZrYHnzqsnWSvHoYupqOCrNT0K+dNdpbHtAtPdZMtxvyF5i6pYN2by/dpPPrE
         A4Kpx2isHY7i8fnq/djtg9R8qvBzz7diOVPL9IQxIiZm6UD2Bnhk5VANNDqv3oWv3GSW
         c2Vv4N/hXEv+ECiegDxRSRPqMp1snKiasE86DSIYqWf920nkypUZuTisswlLOYRFunuj
         EY9nMmY0/v28GymMqxdu6KbHg1Lgbff05777hmxVrOzu4o0icOxMueY/aisxZfRG8Rpv
         xa+5c1Rpynqtl/Tu/c9uY5pf78M0d8vzuuULavsUyGICWp9Eb1oBadfjHnoPF5Mf03LZ
         efgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+yjaeld2PBj1DS6qWHzYu9fpGryCbzHIvMWkAYrCUk=;
        b=OCC3ivjn6beqswo4By+UyWb004XUiMNKAMsJ4557s3fT1K1OZaANSStt2Q1tY/Q2m9
         bZdVXHcifQD5zODsVk2zMRVpNvm8nuO9ZrZ4MQAHcIeihR2X8A5KcDY+IsTX5K83Mhv3
         Cz6CVHdUuaIZrhYPRvs8z1WEZr98iLdcZk0gDKfiq6iKd8o2+CQMfRbDSg4sSRgl59IH
         3QoYV7L6AkPXC8OcGKMg89JTOnMNjZBByYwspwFy28osLsoIVAWwQ/L3uym6+eLkVhjr
         oTi6buLFL+cY16UEox+95FnUIZAjtsgKlOL7kc1A5kk8RbJCU7pYvZnToQ2QakvBNo0h
         90SA==
X-Gm-Message-State: AGi0PuaPflVCNeyTQStBrNbwTI833pqn7cJ00StPC+bxaxZLAlTrSoYA
        4M19mle78uID6LRUnzt7K44yIBinPF0DdjZCs65GbQ==
X-Google-Smtp-Source: APiQypKW1Wrr93d3GpImjL4KvoIYV1trrA9n192ffeYzbo2d8Rmdcp9R+EASNUQYTNJQBz4Ewjmp5YiOdrQ97lsBC5Y=
X-Received: by 2002:a02:860e:: with SMTP id e14mr24559308jai.109.1589371103852;
 Wed, 13 May 2020 04:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200513074523.21086-1-steves.lee@maximintegrated.com> <20200513105144.GC4803@sirena.org.uk>
In-Reply-To: <20200513105144.GC4803@sirena.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 13 May 2020 19:58:12 +0800
Message-ID: <CA+Px+wU_tjgWgG_xPR6SNBC5oM3nzVnhxjD85mrxfZW+_w6mKQ@mail.gmail.com>
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Lee <steves.lee.maxim@gmail.com>, jack.yu@realtek.com,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ckeepax@opensource.cirrus.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, nuno.sa@analog.com,
        geert@linux-m68k.org, dmurphy@ti.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        rf@opensource.wolfsonmicro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 04:45:23PM +0900, Steve Lee wrote:
>
> > Changes since V2:
> >       * Removed warn massage in max98390_dsm_calib_get func
> >         and add comment.
>
> The problem isn't the warning, the problem is that you have an empty
> operation.  You should either implement the function (eg, by caching the
> value written) or remove it and fix whatever problems you were running
> into further up the stack when it's missing.

The purpose for the mixer control is: to signal max98390 to start to
calibrate from userspace.
Thus,
max98390_dsm_calib_get() -> do nothing.
max98390_dsm_calib_put() -> call max98390_dsm_calibrate().
