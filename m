Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E9C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDCA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgG0R3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:29:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgG0R3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:29:08 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MbRXd-1kWxmV0U0H-00bsPT for <linux-kernel@vger.kernel.org>; Mon, 27 Jul
 2020 19:29:06 +0200
Received: by mail-qv1-f48.google.com with SMTP id dd12so2817028qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:29:05 -0700 (PDT)
X-Gm-Message-State: AOAM532Y2LXw8f2qBzQjMlnyVT/PVsakijsAcgvYtAvMRvSQrhk3TKoI
        GwyVT32yOF4f6ATmH3A8v+/cbMcxd4Q1xqz7OGs=
X-Google-Smtp-Source: ABdhPJwHYsWXKrhNNBX9AEOv5Sdsb6KjcbZuv+0WO3CP9Kq043cRt3WR7NjDU7Z8EcYi1XY8MFGa51xQd9Do5CR2VNk=
X-Received: by 2002:ad4:44e5:: with SMTP id p5mr7056971qvt.197.1595870945046;
 Mon, 27 Jul 2020 10:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
 <K5Y0EQ.WYAK00ADM46F3@crapouillou.net> <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
 <20200726160616.GA2662@kozik-lap> <RO33EQ.546WD84D5N7K2@crapouillou.net>
 <20200726161545.GA6058@kozik-lap> <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
 <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com> <20200727170302.GA3507@kozik-lap>
In-Reply-To: <20200727170302.GA3507@kozik-lap>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 19:28:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3zM4M2y1shVnUYCArZxxf9FHbOkVCK0yAK8wbfQTVChg@mail.gmail.com>
Message-ID: <CAK8P3a3zM4M2y1shVnUYCArZxxf9FHbOkVCK0yAK8wbfQTVChg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DdrS4p3AlgVzFskaOuUv8WS2dhrkgzo4v5B6vozgO6ZtDTVPQod
 9egL03ZTZm8kbDYLZrAZsA5f5mo8Wlr9QzP+elJSekGPdLr44q9y9PBujB26DgxUrFsU/9M
 KtmpuctT9wVM/W9rBPyYXl9DPYy8XYqqYnHrhQy3RAabzFYf/nxNQunNgbvuSmQ0Dd5I2CE
 lZ3PH/YbMjFMwBkfGq17w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NRICqB9KG0o=:GDDUY+EW1cTnNYNFoGh6B9
 pupo3pZgu1ZR6HjC9SBBJcvSnrDaNKKuagZWbklGdwjvFrgIm4Jb/XS1dLQmHC+ck5CXJpNc+
 OqYHdyxPZE3+8xOcXRTwfyYy9KLhNNrNLKeP2ILPiNBlRioPhF3lVPZxo6pFe/WRcZhtCkp8j
 yq+ANikqfByRZZyPu4EJAR7pBzHJ5lzUYTGSVsOTHwHw1zv874I6WEdrCCoT0FrfBVbgBJjrG
 run4ud4juMoRzdoF/+Bjp4jx61m/CxSa6Kg0z51+8Xv043HxrTXHUEbrzY2LTk2aD+F+s1Xsp
 Ah/MqpPTs95+NkjoqgBc+UVuuDcIsRS5GfERqEPFcY/rYLPaW1nQfdLVGmI1k4bXqclzt7Wfi
 5XYJbUtIMrb27qPvWFj9t0hQlOmyRxDKA2GB4hu0ipkuPZhEHdhvgzJjUx6ep8AfeEjvLSnwQ
 5BSgrN+69JYb+dof/vtJWsY3aeEA8QgJMPyz4iei7p769vQ1cj2KiA2SQh14CsCZh6pPhACGh
 AFjCe0HvYbIzhKffyZxPIbggjK2MNkP/dQJfuyGmTqYhUQAbiHNVRcN9K0J6mMxGSG3VQvAxM
 cKjy6d2rz1vgGAhxLm0kPU0B6M5zPTEtRwiyBjfCjifCTkPiU1u9BcJZOll5rSRZhsAk3WSP1
 Rik2zQHn8l3kCUYLp+jGOtC+A6K8kFqheHTsGoLtzxdu3t96F6ouuqBZ13U7MSuhcf7GPKJU0
 rorR8U06PBb9ocjc5g6AMp5wVUB/PtdoDPEQod1zh0WzoB7f0MJ6tPY9CXYsDa5potoFFCnqC
 x4L66XDvRzGBwt2xxLOX6wGddW8rBnrK29MZjkGxE/g/RwOb2mDpsttiQjWnK2nUycDAYkH5L
 U5FQM+g10g58FxesdcwziBRYHpdsHISWGOnX6+eyozdLBkUC1e6pN1uh9bK7p9XekwPOhojVf
 rfgs8mghYd9m2evtuSCweRkfzxtST/H4NYZRbhErrE/2KqCxfwi36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 7:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Jul 27, 2020 at 09:55:54AM +0200, Arnd Bergmann wrote:
> >
> > The way we do it on Arm, the machine Kconfig identifiers stay around
> > even for multiplatform targets (which now make up basically actively
> > maintained machines).
> >
> > I don't think it makes any sense for a driver to depend on MIPS_GENERIC:
> > either it is a generic driver that should always be visible or it is specific
> > to a set of SoCs and should depend on some corresponding vendor
> > specific identifiers.
>
> If support for Ingenic is provided also by MIPS_GENERIC (without
> selecting MACH_INGENIC), then it makes sense. This would be just a
> different way than ARM of building multi-platform kernel.

Yes, it would work just as well, my point was just that it is somewhat
confusing to have every architecture do it differently, and that I
prefer the way Arm (and also ppc, x86 etc) handles it today.

On MIPS, most platforms are not yet part of MIPS_GENERIC, so
they are fairly free to pick whatever method works best and is
consistent with the rest of the kernel.

      Arnd
