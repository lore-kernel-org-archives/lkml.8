Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3148A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgDTOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:55:14 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:38477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgDTOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:55:13 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCKJw-1jZrEY0cAU-009PoS; Mon, 20 Apr 2020 16:55:12 +0200
Received: by mail-qv1-f51.google.com with SMTP id p13so4773811qvt.12;
        Mon, 20 Apr 2020 07:55:11 -0700 (PDT)
X-Gm-Message-State: AGi0Pubxz03kPh4DKVHMED0LQ1anagflpz6GCD1agmXV6pU0T5ZmnJnt
        ieeRN4oDcwUZ054MhgYlh5r9E2VhZWyN4knRvGI=
X-Google-Smtp-Source: APiQypKWrHVYOKBMKrwP3X81L+YYkEVR4lL90xIhItw0MwavntIxfWMqFxQTBi3BwHurb3fl60VCjHkTdMkxYN7WaX8=
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr15324382qvp.197.1587394510979;
 Mon, 20 Apr 2020 07:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200420123844.3998746-1-arnd@arndb.de> <20200420123844.3998746-2-arnd@arndb.de>
 <CAMuHMdVpMP1NrXSO=4MJRpkXVgbuahvbZGVaAy3YJ2Oew9kGAQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVpMP1NrXSO=4MJRpkXVgbuahvbZGVaAy3YJ2Oew9kGAQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 16:54:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1gestyLni0Jem56=u6u=StN2VzSi_2osqRVSkGfO5wYw@mail.gmail.com>
Message-ID: <CAK8P3a1gestyLni0Jem56=u6u=StN2VzSi_2osqRVSkGfO5wYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: remove unused sh5 files
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wUUMv9mVyE75zmzWJSie0TFjua/tjOlRvoEqYUXsc3QzDh7OqAU
 ABHnyH32Bzq8qokp5u2XMwzQeyatcOO5HPSuf/13vFaGjs1mNAdpkugZE1NWgQHvRhu2Ae5
 VeWnzMeu5wDtq/iEYxe6B5sj1RsMe0d8OYojzNiXBYGXLZ6e7yHQQy8VCHWH9Xh6v/uquBZ
 JeZnBQrwyflrpG6LJzbYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGAvSjaEaCY=:Yv5IyT77mom2S1+9WGJP0Z
 Pw6LTdZxe7iOyl3I9a5CZNKViaBkw8XM+7UMFYPFUmAvuKVJDZ0LlXhHR/BhafjDlSEtAdXfR
 15kaZU8JjqksbO7SWssRII925vjBKmruFj5R0MTfRblmDZPQFIhmaebsBruLy9rj+x/1Hf1ZP
 CVer9zGRcFtpMt6F4PXLqld24mnbQeWkGKvEzL0F051OfNTSWknT9p2nXH2/rbC3Oy733/VLP
 BrXc2cOXBC0YwOQJUe/DrEjVUK4zOC3KHm/niqNRLYUCyXpdxlivUImALCHHHiKS1socwq+YM
 sHbxdDwdN7V21gr/dK9IuXHf9BCAyUSNB2cDtJiw1uIQUzLXOatUGKCl7j2wn5sRYvtmcAZeh
 M66eYlckDPjH2tfaS2Ldt9gl89KC4t+WL5wH7Evw+akX4aqpYWjSdAucBkuT0/B5Y7PDRFbwi
 jYpdyVwqK9+scbU+YmAZ0xmhloZT95JbjBrlkXeIa0oCShfUtnPz74dfXMj3S6es+qfDwnF2d
 wMTz2xFk8x5AxtPbHcweVVXNFBIrviD4qJvwyhtUWDgBF2fbiyXew5NU/pg35xEJU1MfsS6Oh
 WeMdtcEdi90XOlSxNYZo2bQ3kNbwYdUIbERdBjSGNgIvP2PpHJcdec81ys/W9q+1z7NlPP0tU
 AEZc0aW+1L0dC81m76rNX5j1zEWGGdKtWOne0lb7gszxqa1nuoe3SaQAx7RHbt2A9JbxChM5i
 5q++LI38gEkZXaPvYfofAcYPq/LzkE4J3gs9TaoxHv5PUImGc6e8q3ufo8m2o5U7r/3ZvI/Fe
 usEY184Nr2+PSpBlDQFPj1VF1tcDouDo7UluEXRYpPkU6HVKRQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Mon, Apr 20, 2020 at 2:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > None of these files are used now that sh5 has been
> > disabled, so they can be completely removed.
>
> Thanks a lot!
>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> The following can be removed, too:
>     arch/sh/boot/compressed/head_64.S
>     arch/sh/mm/extable_64.c
>     arch/sh/mm/tlbex_64.c
>     arch/sh/mm/tlbflush_64.c

Thanks, added this to the patch now, along with the corresponding
Makefile changes I missed as well. I left the definition of $(BITS)
in the Makefile, but removed all uses of it.

       Arnd
