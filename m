Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B12BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DB24685
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgANLKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:10:37 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40882 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:10:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so11397658oib.7;
        Tue, 14 Jan 2020 03:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrWzIX6qYyMpfItDa3kBYmyWrGKPz22fUvmhKWgo9oA=;
        b=QvuFFVhBChC45iKClxpr0r90NqAXWYgtuF4xXusIFxzMvLV0+RgtbhbtbhZfZWA8Zv
         TfHf1Rlq0H0FVIOdjfNsojxz0AsDPN6mVSanX1URoaArpVRtXLCea6Yixf9rJESBnEm3
         HeQEZB47MZ+ZoEedJaTn3ORqHzN1HOXVo1bif0+eOAhpw4/IfKnMOyhBhDK9Idw6gjEV
         QxTYHWEx7OmB5VvTVOg339dN8zfppHfYJr0JyanCZQGFHS2F+HAIPK3fNZIW2EPRWPbR
         NHfqcJb0jW6jpuet6fX7y3ISDB0+HuIDf4sNz0uGKcSLSCP/HG4xiaKerZZd2WdXkl3a
         eXnQ==
X-Gm-Message-State: APjAAAUUPWmDqllSv8ZqmqtDs56we1kOwhUvXIJbNEEduohVW+ZddSI8
        NlE6SBGOpO8Kp4SzXxL+MSywQaY58GGf3NAIPl/Jy2Ys
X-Google-Smtp-Source: APXvYqxyzQFtBwWP7Xn7GB+eCXCJR4AQlJOs631jOtltuOZUnZwBQ/CG+Ozs+vg1Pu1tQWgJ2ZHhjibqD2wWL6cBX7s=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr17072540oia.102.1579000236600;
 Tue, 14 Jan 2020 03:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20200108131234.24128-1-sravanhome@gmail.com> <20200108131234.24128-2-sravanhome@gmail.com>
 <20200108155820.GB4036@sirena.org.uk>
In-Reply-To: <20200108155820.GB4036@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jan 2020 12:10:24 +0100
Message-ID: <CAMuHMdXmwpOSTMNo2nTvURMVJ0+bQYTQaNjvp0oOOmBwRx7fqg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add an entry for Monolithic Power
 System, MPS
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>, icenowy@aosc.io,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jan 8, 2020 at 5:11 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jan 08, 2020 at 02:12:31PM +0100, Saravanan Sekar wrote:
> >    "^mitsubishi,.*":
> >      description: Mitsubishi Electric Corporation
> > +  "^mps,.*":
> > +    description: Monolithic Power Systems, Inc.
> >    "^mosaixtech,.*":
>
> This isn't sorted properly, since someone else already added MPS in the
> correct place I'll just drop this.

Seems like you applied it a few minutes later regardless?

9399e5dc6b679994 ("dt-bindings: Add an entry for Monolithic Power System, MPS")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
