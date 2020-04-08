Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C962BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66532072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgDHNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:22:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36859 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgDHNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:22:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id l23so6736851otf.3;
        Wed, 08 Apr 2020 06:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsBlM99RauvjTzO4cMECailvdN8N/SOZ1nNE0x0n/wY=;
        b=mOb+/FtGgjiRV3/z3lHeixN+7ErTAhXBt+wshYhKK0cZ+Dd/KvVoFiKhULwn9KqF8S
         VuaErtw+ZugbcMGSISBaCJTBKrQzIyLezjEVHCjlFOjysBFkj/+XzV1RUjwVCeyOuBAu
         hp3O4edyzloXtBvL//yIfGcCXAnsF39s5YxIJwQ0hgDAZmO21F+KX7YVqoESavCGs8Ds
         vPCtmFbKgVOo/8VdCIHNjfgSoT++/4zm34K4fsdbFusGxS14wU5xe7pnuk0lMMU6ZK9+
         RSc+Ikb3ahuM2yjwERahS6yBXhfX9uHW7caYEqeFlFD+58uxbI/WHwteKZMwhAOsbzub
         siug==
X-Gm-Message-State: AGi0PuZgFWEUc0fYHsuHXEK8l8rpX/KhMmB9KiN1ZLC9p8qxazjxDV65
        a++V4QEboDKELO1cAG+dUU3vAK6HDCANneuBz8Y=
X-Google-Smtp-Source: APiQypJl67IlnBw+dOfrdCD5GX0SmK0PHwXHeZYswIOALl6udpQwHCvCMiwzZTrXWS3Vr/Lr5lpBNW0Z7DpzGBz35RQ=
X-Received: by 2002:a05:6830:15c2:: with SMTP id j2mr5341843otr.107.1586352140315;
 Wed, 08 Apr 2020 06:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200408091416.25725-1-geert+renesas@glider.be>
In-Reply-To: <20200408091416.25725-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Apr 2020 15:22:08 +0200
Message-ID: <CAMuHMdWBPS7hZZqPvSyns4OL37Dm21R+eReEAtmH8XUy=qsRqQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas: cmt: Convert to json-schema
To:     Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 11:14 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Convert the Renesas Compare Match Timer (CMT) Device Tree binding
> documentation to json-schema.
>
> Document missing properties.
> Update the example to match reality.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Oops, I forgot the dreaded "additionalProperties: false".

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
