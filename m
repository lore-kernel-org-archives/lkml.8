Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D64FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC832253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAVHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:34:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38909 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:34:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so5216613oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 23:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6dA8IVd2HWeSBvzpV4MKOYtjngHbr3aE8kcYPeC+Iw=;
        b=aTq1YakQK/whUaq4VU+ieSv6dJNiKA/QnHT59YSGyZoZnivYq90cVCpr7ZizfXFWF5
         axYZt2YVzR8jG4KJi6EOzbVkz3TkNRpQclr+Swd5EEck+6IaQw5CxV1mIK6oJ66acG+/
         IBGu5iiQorhTGbk+eVyWj8VIiFrnsv03Mid8tTkoyOcSMz/ePiDT3l4hs8GI4mb7f9rv
         V12mcefV3grCKA+qYPCTq+u7zUdM39KAdct8dSlTT66cmzBQHOtORzb65eS+DV+0BgoV
         JsGzE7a4D4Rvr+CCfAgjtlY7Bv5ThDvRqZNPPcIxui7BNeY+h5E+2Bgee7fp+oWTNwDg
         wZKw==
X-Gm-Message-State: APjAAAUomsQPcV0sBGE2v/JcDq2RDUsxFxnsW0IU1A1wDRno43DO8c0G
        1HaAak0mEamd2lhh+KTdq7+P3/Mb7kxAkqqRAZE=
X-Google-Smtp-Source: APXvYqzz9BRTgYbAttBsw72QwxdjFgTrmN154sWt4NXPuBUO2JwBwUb++MoNJraCo3FfeIs23pEkyRFPnQFId4CPRrg=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr5614749oic.131.1579678444390;
 Tue, 21 Jan 2020 23:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-12-geert+renesas@glider.be>
 <CAFBinCD=LTAT-HQ+wSSmLQux+W5Y6vBju6RQDwf_1t1FhZoXgw@mail.gmail.com>
In-Reply-To: <CAFBinCD=LTAT-HQ+wSSmLQux+W5Y6vBju6RQDwf_1t1FhZoXgw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jan 2020 08:33:53 +0100
Message-ID: <CAMuHMdW5x7H5gwja098XVMB+iX-eQ1u_85BHu+0=dtAU9iNuKg@mail.gmail.com>
Subject: Re: [PATCH 12/20] ARM: meson: Drop unneeded select of COMMON_CLK
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Jan 21, 2020 at 11:11 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Tue, Jan 21, 2020 at 12:47 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Support for Amlogic Meson SoCs depends on ARCH_MULTI_V7, and thus on
> > ARCH_MULTIPLATFORM.
> > As the latter selects COMMON_CLK, there is no need for ARCH_MESON to
> > select COMMON_CLK.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks!

> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: linux-amlogic@lists.infradead.org
> I assume that Kevin should take this through the linux-amlogic tree
> (instead of someone else applying the whole series directly to the
> arm-soc tree)?

Yes, that's the way to reduce the risk of conflicts.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
