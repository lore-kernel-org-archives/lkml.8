Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC3C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A8E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgDTRsw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:48:52 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:37376 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgDTRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:48:51 -0400
Received: by mail-oo1-f65.google.com with SMTP id g14so2326219ooa.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XCJB0Hcl+PXqI/c7jgEyi3+z3z4H8KBBmC1/eU1sakE=;
        b=MK8iwwvVRYIa+4IuNEPMBu2NqCZNZ5G6uz+J4NZvHzV5XIcn6RTdJwk8IwuzMEGGHO
         4zgmlXyg+zpjIMOypm4FVJZpE8yP6kWNg7wFwv+NL4ZaQBsAgOxdFkiGBx/Zgtc8SAfw
         ZHfKfeXxHTvXlw5BDRMOzfQUPP1fuHWmKZX//CdGc9kBtj4Rvz6OQF4R1hO+urC35KPG
         KGtYRcQVstoP1xBKEKp+K0YojENoekBxJye6sukGpQxQ7DoZ8lIHIV1/ITNq33Q8mmGL
         ef+Nzetrv7NqMs0K8aeD9uIKRLnEFn2UcMDFhFpjafgQXKKzr2BTcwJd5SfgRQlZSugf
         JuxQ==
X-Gm-Message-State: AGi0PuYBGrhyu3xOt1BXKGa6epfcgwnPIJS9GWppzBvpVnoVhWk7hsIL
        YlLG1x/J58Ijx9+c7iRKm73C4shsr5qY5iw4ZMLxKkWC
X-Google-Smtp-Source: APiQypIRNWURXfy5vvGFTZuaLtS69iEfcbgyAP/4zA04W6udHPCGK71Ysn1XP96uFhfXFb0sXwJNcakqyUVajulCwgw=
X-Received: by 2002:a4a:a126:: with SMTP id i38mr14002027ool.11.1587404930639;
 Mon, 20 Apr 2020 10:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585264062.git.gustavo@embeddedor.com> <14ff577604d25243c8a897f851b436ba87ae87cb.1585264062.git.gustavo@embeddedor.com>
 <CAMuHMdW4f-sPPY9sOU-xdVJ-0zsix4wcMTxUz48GopqnWDVTAg@mail.gmail.com> <50f85dd2-8250-1ca8-e2dd-4bba93a62736@embeddedor.com>
In-Reply-To: <50f85dd2-8250-1ca8-e2dd-4bba93a62736@embeddedor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 19:48:39 +0200
Message-ID: <CAMuHMdVaAV+bfEivzEpJh8SysVr7jziyBPknCUc1=DtOwu7ZrA@mail.gmail.com>
Subject: Re: [PATCH 2/2][next] m68k: amiga: config: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Mon, Apr 20, 2020 at 6:03 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 4/20/20 02:17, Geert Uytterhoeven wrote:
> > On Fri, Mar 27, 2020 at 12:25 AM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >> Mark switch cases where we are expecting to fall through.
> >>
> >> This patch fixes the following warning (Building: allmodconfig m68k):
> >>
> >> arch/m68k/amiga/config.c: In function ‘amiga_identify’:
> >> ./arch/m68k/include/asm/amigahw.h:42:50: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>  #define AMIGAHW_SET(name) (amiga_hw_present.name = 1)
> >>                            ~~~~~~~~~~~~~~~~~~~~~~~^~~~
> >> arch/m68k/amiga/config.c:223:3: note: in expansion of macro ‘AMIGAHW_SET’
> >>    AMIGAHW_SET(PCMCIA);
> >>    ^~~~~~~~~~~
> >> arch/m68k/amiga/config.c:224:2: note: here
> >>   case AMI_500:
> >>   ^~~~
> >>
> >> Replace the existing /* fall through */ comments and fix the issue above
> >> by using the new pseudo-keyword fallthrough;
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > i.e. will queue in the m68k for-v5.8 branch.
> >
>
> Geert,
>
> I wonder if you received the first patch of the series.

No I haven't, and lore also only has the cover latter and patch 2/2:
https://lore.kernel.org/linux-m68k/cover.1585264062.git.gustavo@embeddedor.com/

Can you please resend? Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
