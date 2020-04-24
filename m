Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A3C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2931321569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgDXPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:13:00 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:41424 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgDXPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:12:59 -0400
Received: by mail-oo1-f67.google.com with SMTP id t3so2169417oou.8;
        Fri, 24 Apr 2020 08:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6TSxp621tHGXOK2SxkqJA3SlWKHV8D7dciTUE31bQE=;
        b=CK9y/WNdfkGDvRB1llmwGsKCMY0NXAxhh2HpWIxR2ncAZr234EfS8Lt7za7giJ6tDP
         d6XYhm7eMoGCLxyMo2mvDKBsISPN4lyjwJ58+CZiwrAdwwy/MYLdY1xSm4nJaPlGutAB
         4THqZzZ4b12ANpPic1rnZ1qy8Yic1rgMMe5CuLADIn8+vhZVHBpy+4gxits3W5ACYDCp
         VefQnQbKhOPrIRMSooS5s8GkVn9j3xfrKTWiA6HQrL+tyd6yNVDwb2a4CGeoD6J9OIwm
         d5Rrp76f5JLnal1+d603DzAz2o2iJ+QJjeofrkC0RlKa/EEZsaDIlaco2Hr3O2zsUZSp
         Zpbw==
X-Gm-Message-State: AGi0PuZsjmGtyxlsmnd5BNkpbd6UW5cQMMwRRAmGr64vpOoAKJI33/i5
        MZFL8uJ4EKjLjGxS2100smF4L2H19zko6nVCTEU=
X-Google-Smtp-Source: APiQypKPD3IaEYszA2svJVlIug3NVPE1rweeKaA/eUgVNED2La+srJpgUR6y8l7Tl8ej+pkYCBAaS/MY7hnuwDi5OGU=
X-Received: by 2002:a4a:d44a:: with SMTP id p10mr1884233oos.11.1587741178374;
 Fri, 24 Apr 2020 08:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200424121051.5056-1-geert@linux-m68k.org> <d2c14a2d-4e7b-d36a-be90-e987b1ea6183@gmail.com>
In-Reply-To: <d2c14a2d-4e7b-d36a-be90-e987b1ea6183@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Apr 2020 17:12:46 +0200
Message-ID: <CAMuHMdWVmP04cXEgAkOc9Qdb2Y2xjGd1YEOcMt7ehE70ZwdqjQ@mail.gmail.com>
Subject: Re: [PATCH] net: openvswitch: use do_div() for 64-by-32 divisions:
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        netdev <netdev@vger.kernel.org>, dev@openvswitch.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Apr 24, 2020 at 5:05 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 4/24/20 5:10 AM, Geert Uytterhoeven wrote:
> > On 32-bit architectures (e.g. m68k):
> >
> >     ERROR: modpost: "__udivdi3" [net/openvswitch/openvswitch.ko] undefined!
> >     ERROR: modpost: "__divdi3" [net/openvswitch/openvswitch.ko] undefined!
> >
> > Fixes: e57358873bb5d6ca ("net: openvswitch: use u64 for meter bucket")
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  net/openvswitch/meter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
> > index 915f31123f235c03..3498a5ab092ab2b8 100644
> > --- a/net/openvswitch/meter.c
> > +++ b/net/openvswitch/meter.c
> > @@ -393,7 +393,7 @@ static struct dp_meter *dp_meter_create(struct nlattr **a)
> >                * Start with a full bucket.
> >                */
> >               band->bucket = (band->burst_size + band->rate) * 1000ULL;
> > -             band_max_delta_t = band->bucket / band->rate;
> > +             band_max_delta_t = do_div(band->bucket, band->rate);
> >               if (band_max_delta_t > meter->max_delta_t)
> >                       meter->max_delta_t = band_max_delta_t;
> >               band++;
> >
>
> This is fascinating... Have you tested this patch ?

Sorry, I should have said this is compile-tested only.

> Please double check what do_div() return value is supposed to be !

I do not have any openvswitch setups, let alone on the poor m68k box.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
