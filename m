Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53AFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C3920720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOA54ZJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgGGWNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgGGWNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:13:33 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDCC061755;
        Tue,  7 Jul 2020 15:13:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q3so26698202ilt.8;
        Tue, 07 Jul 2020 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebHoea24iBgPzS9O9JOWhIPUCQLUd/MkaP3rwV0k9ns=;
        b=uOA54ZJ49ZliLtaMBtzWa5R5sdXU4fhkaJKt2aCHbDZsQBe1W0jp5Qq3LXByql3TxN
         4XUc3A9Iu76iEPLukx5bh41xAcUIodCr3M4Oo1Rsau2XU0ZvPy0eixQqD4w4Gyg0gaEH
         865ii0tPiRcqpMFW0mMsUGRWqkoDflk/7SuawIqWZ5QEqLo7zXAa7dYXFZ6EcrKGiSa9
         Gg0k7M/L9Q5vwFCV4n5OiFaz5uej/I20sdyNh4B3C4DRMiFpJYxJUueMdhbOc4LQosNl
         Oq//UHgVN88QzCLO+dIst+Ggl+TQP/0yNXry8JVXytjamagrRFgEZDX/0S1zdIKV/C+1
         brTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebHoea24iBgPzS9O9JOWhIPUCQLUd/MkaP3rwV0k9ns=;
        b=Y3xi1jQYlWo1bsSOoz7zAenC7GvUotCh95q9TiWUq6RLNv2siwo0Djq/IrfF62pi4Z
         ASmeQvdIfw5iiwNvpw5CAbT67Uq7xloY86X23bDCLGV2EPrVAnLvPSmqgtENpqNEBfNs
         XpI/YLaH8CJxMx0+BdyaQSDhR+cHREt2zj5FTu9xNg2Cydob/5MBEwl59h1YhM12q3O/
         y3I+91okEbYkE3vwREcF7qOYT59IVdvfQW0DsskhHXE44e90a/kEL+dybbqVMDsIY70C
         vTNwJ8cHIWGJn5l0oaxAN4GaoEd2ZWBqCeNKrr5L4D6EwMMV//2MY4Ew3EO98FVPWAL9
         rHyw==
X-Gm-Message-State: AOAM533yXtNk08IJ/cM7XWRDquZ5HBYLL5VfKoBAU7vvZT6bhafCHP9N
        TmPKGuekaBPZIxNthMm2tPViFDnWlk8VTBxwgNc=
X-Google-Smtp-Source: ABdhPJxqwaGXwz83DTFQOUjRKXL59dDxJXKiaYLJtLhFWxFQTpza0ByW2F7SfF9q63gthTZDzoQzQ4Hv3IBDoSHXfj0=
X-Received: by 2002:a92:5b4b:: with SMTP id p72mr7632967ilb.285.1594160012404;
 Tue, 07 Jul 2020 15:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
 <CAOMZO5DctkSWri+6Zh1HfSWFJcz=nb8eUHZsvwFwRZ_B9ZCSTg@mail.gmail.com>
In-Reply-To: <CAOMZO5DctkSWri+6Zh1HfSWFJcz=nb8eUHZsvwFwRZ_B9ZCSTg@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 7 Jul 2020 15:13:21 -0700
Message-ID: <CAFXsbZrVxE4fGhwfax7C5tJCLnbihxB6=Q4VxUisXd2OE_ut4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: update MDIO speed and preamble for zii-ultra device
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 2:54 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Chris,
>
> The subject pattern used for ARM64 i.MX patches is like:
>
> arm64: dts: zii-ultra: update MDIO speed and preamble

Thanks for pointing this out.  I have to make a change to this patch
anyway so I will resubmit with the correct subject pattern.

>
> On Sat, Jul 4, 2020 at 10:26 PM Chris Healy <cphealy@gmail.com> wrote:
> >
> > Update MDIO configuration with zii-ultra device to fully utilize
> > MDIO endpoint capabilities.  Device supports 12.5MHz clock and
> > doesn't require MDIO preamble.
> >
> > Signed-off-by: Chris Healy <cphealy@gmail.com>
>
> Other than that:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
