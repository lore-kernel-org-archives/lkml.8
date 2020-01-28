Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF2C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6132468A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgA1IiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:38:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34798 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgA1IiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:38:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so11231636otf.1;
        Tue, 28 Jan 2020 00:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lM+EMxmDAUToXA01z4vnAcpu5kuFLx/qsygIzPZ8TjI=;
        b=VGjQz3rsht4XDfLoAxLDqH56wDwyPQI4EKvtYBu35N22yv2ud34s0h6p6uIj2DI66t
         3GR4KybylvcbC+4qV4alpmuCJgK+j23qzYHtkueShyl0paJZwOkNCOxHJeyXUTI58243
         5uCqsYJgMs6jS5C0yEcDmkedsMupiMT+n4ezSrH2Za7bn/Ib0bo5zI0x0c/CjbAJCl3S
         QArxGB0qC/roqnWEf4HP3hMS9H9GiLbN0fyj3/BR4lvC2IyJn6cna+gi9wegKtxys+er
         PGmw7SvhFNWS09cE9uaDnJDn+SkMi5JQ4ICeRHkJvJ4g8aBRCqdOMXT/Z2OO8/50LP27
         j1MA==
X-Gm-Message-State: APjAAAUUa+B1VWrscTI7z35mH4Mx/BPv5i+jqaTv+bUfh08HPu50t9jw
        oq+kooSOdSU+/Li3SLMxailVXcfsEqdbvx1g0z/lHw==
X-Google-Smtp-Source: APXvYqyXgbIEA2p/A3WTi723yG6Nw//TYGPvtIWqa407cBskdum5TXbedSRTDXy5Y/YfK0lwCoDo2VGAqi47xrrGE44=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr15557631oth.145.1580200685033;
 Tue, 28 Jan 2020 00:38:05 -0800 (PST)
MIME-Version: 1.0
References: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jan 2020 09:37:54 +0100
Message-ID: <CAMuHMdUTDMeA=GOR7Mp79BynARgSG8AiwJSa_zQi-Rh1GsRoDQ@mail.gmail.com>
Subject: Re: [PATCH v2] of: Documentation: change overlay example to use
 current syntax
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 1:38 AM <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> The overlay implementation details in the compiled (DTB) file are
> now properly implemented by the dtc compiler and should no longer
> be hard coded in the source file.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> changes since v1:
>   - fixed typo in patch comment (implementation)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
