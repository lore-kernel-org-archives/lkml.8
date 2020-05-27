Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1956F208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgE0HiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:38:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34613 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgE0HiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:38:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id b18so18502157oti.1;
        Wed, 27 May 2020 00:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNLv5z8EKY1yuhWqFKsZJ0tNJNt2riKYrmpKQdpJCq4=;
        b=syxooSn8MTa3f2hzeY9xQvNzJ1q7Fcd6JOD5UuYQheaxtT/zgqp5BJy9MD/02ipNek
         uKzF1cluwJ4Ju+1S3ALLDbNlpLP9VsfLGIoEzw3oFi6AUuu9+AmbS1AnEj3DWJwBFvzQ
         P4Y8uhDEnxaUNxmG8VonaSTQIDL1Lny5AS3N7Q/u6W6rYh5Nirktew9dc43jGcSEUqdk
         UQg/YPtCOYxMt4rAKQOvqTgI2bNeKS5GBs/jRa5Rp/yS0xC71wvY/4ZbwFCI2T7M4fiy
         IIkXFOT8MytJnbe5HJv6T8urHJoiMOWgYqppASUMVxA31forL4OFsygtj5yWCWMY9MpE
         x3aQ==
X-Gm-Message-State: AOAM531ySmx8on6XLprfAJFlgw1U8PwOJhWhiD7DV3I7tU6sZJIufJ9t
        FtF7GNgxZhH5UR1WoGzYxVw+IcZizaagBpJrocE=
X-Google-Smtp-Source: ABdhPJxm2iQnKGPaQ8cudthAdTY+DMCSTWHl/gI3LFICJOmziwdjskV5xtEX0AQPODgatzLU0HkSgXSO28tDFRH9NJs=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr3628517otp.145.1590565100227;
 Wed, 27 May 2020 00:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <1590526904-13855-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590526904-13855-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590526904-13855-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 May 2020 09:38:08 +0200
Message-ID: <CAMuHMdVZJoRYTohMs+Qt9oYF+2MSHVNDa56BNj6VJNnqPXPvhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: ASoC: renesas,rsnd: Add r8a7742 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:02 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
