Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BDFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFB620809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIMvTjtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0WST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0WST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:18:19 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA384C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:18:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id y134so4314733yby.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4AToGLC11QYNl1KBQKdNwb699xIlG7oY11nGnEUTfA=;
        b=KIMvTjtLLu0JWoYkFxxc+Q5rdhiSz5F+OZkV6KRHA6e3kswH8KYnEwn6bs0qbiP/Ak
         vVyrG9jIViM11sAULg/9Nq2CqW7CVmD2COUBCwyTN4gBrOYFopnixQkyWQVsd+goexyl
         zxz0Y+4SlI17pkcxFGlYHODA+jQxawFXMxPcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4AToGLC11QYNl1KBQKdNwb699xIlG7oY11nGnEUTfA=;
        b=AX3nsXc6FZnpwrTzcGWtwU3wdypOkF+OaNVumOb/HmidhwzQMySfmukCayk3Bo4r+d
         om27XHKKX7f7W+/EVlJEhMoEfxKk1LrhTz4XP3AR2rcGW1QhQ+7b5nkPokBg/K76I62q
         ruNhFRtGqbe4mN+3N5Z9+ceAL5epxPALfCxybt4hdJANQWwD+o9hQxGWE9psftiPdro4
         yimIMI5Ixw3Cyt2mJtD05Prqlkd+26T6Y9iK88VTIyyzjBhJc4vr/B4VRVTaEqwryt2B
         v9p/N/jC3ZtFNyC/aWdKxpw2yklmWnbMlsDyMFvNRj33ENlHpA2DlOV793EgCapXTE3Z
         1IIQ==
X-Gm-Message-State: AOAM533oashuXHEBXOZKwvfzzjSIrSZABwJqaxxqs5TBlDDgfi5VkA4l
        E4/s7rzrzOR0vbHBuR8HcKd19qOBDLAlgLgP5qEyvg==
X-Google-Smtp-Source: ABdhPJzr6zcw+sS34LGrszkKhgELMUGJ6TrMhI9DYMWTLPhj1VElRqJgWMT+dAOcspBFUxlXGZtz5ihBrdYU19W9RgI=
X-Received: by 2002:a25:c60c:: with SMTP id k12mr36831638ybf.407.1595888297688;
 Mon, 27 Jul 2020 15:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200727134914.312934924@linuxfoundation.org> <20200727134917.124943291@linuxfoundation.org>
 <20200727212933.pkt6kgescdz7akht@duo.ucw.cz> <20200727220112.GV1665100@dtor-ws>
In-Reply-To: <20200727220112.GV1665100@dtor-ws>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Mon, 27 Jul 2020 15:18:06 -0700
Message-ID: <CAGAzgsrTBm0UWM5QwxzePRrpz2xOUsJ4cuyj28q=ik++OQ-dkw@mail.gmail.com>
Subject: Re: [PATCH 4.19 54/86] Input: elan_i2c - only increment wakeup count
 on touch
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 3:01 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Mon, Jul 27, 2020 at 11:29:33PM +0200, Pavel Machek wrote:
> > Hi!
> >
> > > From: Derek Basehore <dbasehore@chromium.org>
> > >
> > > [ Upstream commit 966334dfc472bdfa67bed864842943b19755d192 ]
> > >
> > > This moves the wakeup increment for elan devices to the touch report.
> > > This prevents the drivers from incorrectly reporting a wakeup when the
> > > resume callback resets then device, which causes an interrupt to
> > > occur.
> >
> > Contrary to the changelog, this does not move anything... unlike
> > mainline, it simply adds two pm_wakeup_events.
> >
> > It may still be correct, but maybe someone wants to double-check?
>
> Good catch, I believe the backport is busted.

I don't believe it will break anything, but the backport isn't needed
in 4.19 since "Input: elan_i2c - increment wakeup count if wake
source" wasn't merged into 4.19. It's probably best to drop the
backport.

>
> Thanks.
>
> --
> Dmitry
