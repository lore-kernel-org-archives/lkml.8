Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E8AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFBB2070C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxEabW/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGESlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGESlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:41:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F7C061794;
        Sun,  5 Jul 2020 11:41:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so37159143ion.13;
        Sun, 05 Jul 2020 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WMam9KMN4N8PeAEM40GNpNo2zYpfT1xm+vr06Ee2x14=;
        b=AxEabW/lzyZ2qlTf+PHt+KOYjnTp/SIT47axfbz/xNCoCqaeVUM3xzTmWeAcfiLKOW
         jJjegqyiMnpF8BtbFW7UCZm5RajW69M91jc+AUkZfmbju0UwEiLNrwvzGzGn7MkUiORs
         EVUnHKWbUMYyl0brpJVmufSrpUNtsg5n3E69x7mykxozCy/okobAZ7FObIAt05D2CxB/
         FROsqXlr7TddUDivxEFn3CDR6NVi78hVhVM/sYQI6xoT2VVTmliYTXrsCYlRIxOx681N
         HPnMVdz8wcjOw4cehpOuzxOjWNicCwQxlWLOqJtYFFPtup93zarw2kE9POpsdJXATGNn
         oE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=WMam9KMN4N8PeAEM40GNpNo2zYpfT1xm+vr06Ee2x14=;
        b=q+ouYmmRS+iEbnCz9jJr4b6CCm/R2gHYwl3papxt+dlNxVjxt5tFkYJaNP2uDKi4Dz
         4bbZcXf7UV+QBnxyve7MjeONAbkhYsOAZ7WD10xw2jN9zMGxm5ue4Fm9+cjDA0ChEPQz
         pado5hGPjIFRjyBWlGwNaknTtnWLmpOIaMUxPGgGAw+VDeaKALYd5P6yEi78ZusRLLlr
         B6euNL0522SF8ePMGO+Pr4ZD4lbS7Rtft3fin61BWxnoQDPYbu5wAVO+ipBLc+zpbsex
         nMd+hKBlrbPkmTAQPSUCh1jh4/I6jFGOTJnqmmDV4gPcCbRtGFD+/zG8fZHSDKfqHhs0
         rVng==
X-Gm-Message-State: AOAM532mk9WeXf72tHugjbOHewkExgRG9vK2RyJKlkqyw57PZ1jbz6fK
        apsvsaP7p7xpPHOAUxNhZbTLch47RyS1IM/Owsw=
X-Google-Smtp-Source: ABdhPJxK/S7BemaC7I1AoTKGocPOpRoy6dfNruNY70JrVKJMhu9vEH11u0LMDqGDvyIyydjnFOGfcx6Z3KHCmPW0okY=
X-Received: by 2002:a05:6638:252:: with SMTP id w18mr37241264jaq.42.1593974504022;
 Sun, 05 Jul 2020 11:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200705065917.22285-1-lukas.bulwahn@gmail.com> <20200705113017.mostxjvatkqkhqf6@core.my.home>
In-Reply-To: <20200705113017.mostxjvatkqkhqf6@core.my.home>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 5 Jul 2020 20:41:33 +0200
Message-ID: <CAKXUXMz_usPZw5-UPLxSqBRVP4-RFZTLO-tt5pEfiTPrxifFWg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust entry to renaming and conversion
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 1:30 PM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
>
> Hello Lukas,
>
> On Sun, Jul 05, 2020 at 08:59:17AM +0200, Lukas Bulwahn wrote:
> > Commit a74e81a56405 ("drm/panel: rocktech-jh057n00900: Rename the drive=
r to
> > st7703") and commit 7317f4574492 ("dt-bindings: panel: Convert
> > rocktech,jh057n00900 to yaml") renamed and converted the files mentione=
d in
> > DRM DRIVER FOR ROCKTECH JH057N00900 PANELS, but did not adjust the entr=
ies
> > in MAINTAINERS.
>
> A similar patch was already posted:
>
> https://lkml.kernel.org/lkml/20200701184640.1674969-1-megous@megous.com/
>

Thanks, Ondrej. This patch posted here shall be IGNORED.

Lukas
