Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FBFC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F920675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBLMZV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:25:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44280 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:25:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so1666186otj.11;
        Wed, 12 Feb 2020 04:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ZiL9siKE7XkZCgZqu6b2vONRR+3a8KiQl3qZgEgmeE=;
        b=g5JohOIlnQGNtFp92wC2rmcWv99k0FB61crK8zhRjPVU5793KJIuHb8Tf9JhbSatNS
         13mzdUdiiLttR8iSXXoxtCmoBTmHxOYMylHoXSAXjRAVm0dv8FliUUuPwL8PFeiW6FW0
         v7TlBBeNIZ0uSDA/BZmnOWMFv2lq1KPGVlIJ7HmWQi+YYPJhMVl0ioTihJHbHjsTKfcH
         bXUymMusnhEOW89ihKNOajvLI1STmHqm8ilT0L3M1NA3p23golG9NnS3xL4O36c4iDSI
         nAZt2uS5JyMckyQZKCpPjle+bSV9E33f52oq55dU0qErSpch16ErLSK4B8X5mAr76PTo
         YajA==
X-Gm-Message-State: APjAAAXteWGCnSbs3BrKf3EYqx/TmUBakymowi1jayUHJwqNlUJb1aGc
        Z8dRw2/bL3NAglhovI/26+zMVA+9TOylrtSP7ixa0A==
X-Google-Smtp-Source: APXvYqxmGlXr/EAwEwS6bZTnKJ7k87TTOgxf/vN5Qb27UlIEyVHcDP7C58ED8HUgPwgzR225uufjJyjdtXjeckYQfGs=
X-Received: by 2002:a9d:8f8:: with SMTP id 111mr8606343otf.107.1581510320462;
 Wed, 12 Feb 2020 04:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20200212101651.9010-1-geert+renesas@glider.be> <CAEbi=3fMRq++Eot+BEtCedeyhM65kTc+nS7=inCTR8MkT5srww@mail.gmail.com>
In-Reply-To: <CAEbi=3fMRq++Eot+BEtCedeyhM65kTc+nS7=inCTR8MkT5srww@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Feb 2020 13:25:09 +0100
Message-ID: <CAMuHMdU+VLpg5Yezo2Ea9v2vmvbA=nEcKObBgZYwjSV10OkY=A@mail.gmail.com>
Subject: Re: [PATCH] nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

On Wed, Feb 12, 2020 at 11:52 AM Greentime Hu <green.hu@gmail.com> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> 於 2020年2月12日 週三 下午6:16寫道：
> > The Andes platform code is not a clock provider, and just needs to call
> > of_clk_init().
> >
> > Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/nds32/kernel/time.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
> > index ac9d78ce3a818926..574a3d0a853980a9 100644
> > --- a/arch/nds32/kernel/time.c
> > +++ b/arch/nds32/kernel/time.c
> > @@ -2,7 +2,7 @@
> >  // Copyright (C) 2005-2017 Andes Technology Corporation
> >
> >  #include <linux/clocksource.h>
> > -#include <linux/clk-provider.h>
> > +#include <linux/of_clk.h>
> >
> >  void __init time_init(void)
> >  {
>
> Thank you, Geert.
>
> Let me know if you like to put in your tree or nds32's.
> Acked-by: Greentime Hu <green.hu@gmail.com>

Please take it in the nds32 tree.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
