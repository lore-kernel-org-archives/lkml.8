Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96278C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62253206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk3vJeFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgASVkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:40:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgASVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:40:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so12817704wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asiPmtRmLRuG8iYLNhrmmXL1PmWfY69n+vUdZEEnRBI=;
        b=mk3vJeFOLJiVoWCN/ieoID5pyZ+AjcVEy9Y5wvlqGVfGMIaL+RA5vFZ0nERUqnj3gT
         zpLJtZaj4+6gMq0mhXHBjexAtdSLpC+ectpziCEVc96JZ0oYykIAsdFW4QvRX3FaBYfx
         2tZoHzdVCSaPPy08gSaT2ECr+7Ymf1G572lJfiYOssEzN1/jhP3ncU77P/ug0/MUvnow
         zvJoxl1DAPYbcIhixSz/aFGOI7swKzRN+KINuVxAfnSOBehNKzX5S5LL0s5XIsWARQEd
         tA2xjSqE0AcnJo8IXT46sv8IC9AAnztAJc/5DwZccNHd4m17nY50iOepiv742jheKqPP
         JgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asiPmtRmLRuG8iYLNhrmmXL1PmWfY69n+vUdZEEnRBI=;
        b=jnZ/Cd96JXk2dgqtemX8JxtjH3NW3SdOKi+gBHtZjpBWVN3dXEUnyx0HILEYq2C2c9
         +jKVr+CE8diuWRwZTl6dr95a87pFlqlblM5YdC2KDdaTDqF8Kfm4fbHfJ8rRi3foT5g0
         J5PrLp4kEcGXSczTIYaF4NOHEMeINvhFxNTI43HSXs6l1ZWSVx9Dsx8SRF8lbuC5aXFi
         zXOnB09A8IWPnJR/YAyU02XFgITQWe25+QZTn7gN+3Zy0W8pVrUas2ZjldP4FPrcK+vA
         ZmCLatvT/8Fa92oGOkDNnnDQJA95+r8dL3FuDgZAZCCWo/HFGc2R5qBR9dsolgXd2pZz
         gk+A==
X-Gm-Message-State: APjAAAXlqvxhduvmZCS0U0wXqdDeXwZ7E3mqQdzT3xHGkwQ8yYVwpApn
        HQRmONLG0/GTC+YHZA+ANv3ody6aIn69XZSEBco=
X-Google-Smtp-Source: APXvYqxa29DZ8SIHSKa9e8RKhphlEYfnefUq8OEmoveTEJv1S3CzgFG5Q5HsQ6yWcpFLbs9pko3VHF12RmFrYMhwgv0=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr16601137wmk.68.1579470022651;
 Sun, 19 Jan 2020 13:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20191210212108.222514-1-brendanhiggins@google.com> <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 19 Jan 2020 22:40:11 +0100
Message-ID: <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        davidgow@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:40 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Brendan,
>
> On Tue, Dec 10, 2019 at 10:21 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> > be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> > UML_NET_PCAP; this is because glibc tries to load NSS which does not
> > support being statically linked. So make CONFIG_STATIC_LINK depend on
> > !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
> >
> > Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 2a6d04fcb3e91..1ddc8745123f2 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
> >
> >  config STATIC_LINK
> >         bool "Force a static link"
> > +       depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP
>
> "depends on !FORBID_STATIC_LINK"?
>
> Then all the drivers that are incompatible with static linking can just
> select FORBID_STATIC_LINK in their own Kconfig block.

Makes sense!

-- 
Thanks,
//richard
