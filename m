Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4706A20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFVtLzwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgEURS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgEURS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:18:27 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:18:25 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id o8so1884463vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpkOZJGzlOyjMi6E4aGEVw8elxqv6cvMyDakUdm0E6w=;
        b=bFVtLzwvUKDWNkBK6dWkJEda5wjM89UHYfYNcjTYN4P+nB39oDCq/kKc6ofSZmqeHb
         tYGLDZacFX5B7LUfcjyoApF8wnLcDU72LTunks9leoZ7KG9aU5PYcikSU0WRj1soGSZ0
         o9xx2KoC3JM4VZSOcSG9U3hJuNoLmnM21QhfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpkOZJGzlOyjMi6E4aGEVw8elxqv6cvMyDakUdm0E6w=;
        b=Adk4L7WffUeqH9CXUfpO8ZEkRydrcdPUOyynxCt5/zEtIwW/fBcQy60PCKXB59o7Iu
         3OZK+Ru2T1bZOSxHz2v0nLzpi1ym8mr2rUxJQokIiPQ+FSIf/oX31zyX3VFh/bU3otWl
         Uce41eNsBVxNEJUxJ2pQWsvSwuf4LTDkXJxvy++2jxh03OICyN7ROgpp0KHlWKy9WbdY
         WVALKQ2AWh0J7wWZXycHHxO8X/rQQNjyUEO/ny3xJRBc0iyRx00fPKGoSQs3Uu/5f0Ae
         NQFJKfADycRFE+ErgA0hyDejfa4cIhb7xtByc68f09hdaFBehhDGrYGHBSqNjZ/653Hw
         BnQg==
X-Gm-Message-State: AOAM5308Re1va9U2gx3eJBnPDTrUDalbOWXcgmqOgBYvMyBXahv9nyi1
        +S9WvwkTPOPcyCEZsuhCicaq9fAxX9A=
X-Google-Smtp-Source: ABdhPJzmaYWUKBOQXwnbX8pop/7Tj8q06k7NS0QkDATadIVz3bTYV+Kml1gPl9WfpgI/Uo7MgvLULQ==
X-Received: by 2002:a1f:ad86:: with SMTP id w128mr8670068vke.30.1590081504474;
        Thu, 21 May 2020 10:18:24 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id y12sm898093vko.40.2020.05.21.10.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 10:18:23 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id f9so2843039uaq.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:18:23 -0700 (PDT)
X-Received: by 2002:ab0:69cc:: with SMTP id u12mr7668622uaq.22.1590081503114;
 Thu, 21 May 2020 10:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200429170804.880720-1-daniel.thompson@linaro.org>
 <20200430161741.1832050-1-daniel.thompson@linaro.org> <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
In-Reply-To: <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 May 2020 10:18:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xut=5y-MyJSu+ERdMRkKbSf8SGMhUHg5OP=y8zA1N-xQ@mail.gmail.com>
Message-ID: <CAD=FV=Xut=5y-MyJSu+ERdMRkKbSf8SGMhUHg5OP=y8zA1N-xQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: kgdboc: Allow earlycon initialization to be deferred
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 9:47 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 30, 2020 at 9:18 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently there is no guarantee that an earlycon will be initialized
> > before kgdboc tries to adopt it. Almost the opposite: on systems
> > with ACPI then if earlycon has no arguments then it is guaranteed that
> > earlycon will not be initialized.
> >
> > This patch mitigates the problem by giving kgdboc_earlycon a second
> > chance during console_init(). This isn't quite as good as stopping during
> > early parameter parsing but it is still early in the kernel boot.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >
> > Notes:
> >     v2: Simplified, more robust, runs earlier, still has Doug's
> >         recent patchset as a prerequisite. What's not to like?
> >
> >     More specifically, based on feedback from Doug Anderson, I
> >     have replaced the initial hacky implementation with a console
> >     initcall.
> >
> >     I also made it defer more aggressively after realizing that both
> >     earlycon and kgdboc_earlycon are handled as early parameters
> >     (meaning I think the current approach relies on the ordering
> >     of drivers/tty/serial/Makefile to ensure the earlycon is enabled
> >     before kgdboc tries to adopt it).
> >
> >     Finally, my apologies to Jason and kgdb ML folks, who are seeing
> >     this patch for the first time. I copied the original circulation
> >     list from a patch that wasn't kgdb related and forgot to update.
> >
> >  drivers/tty/serial/kgdboc.c | 41 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
>
> Thanks, this looks great!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Are you planning to rebase this patch atop what landed?  It seems like
a useful feature.  If you want me to give a shot a rebasing, let me
know!

-Doug
