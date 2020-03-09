Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D8C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D540A20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCIKPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:15:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34194 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCIKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:15:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so9000293otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmfuuzmTFi4k79NsaDmZHy6xnZN1vJQHvghwYzN+k7w=;
        b=J/3JeW/xwdU9lQc0D3Q6wAZWec5HYeOh73Ah8Z54pej2RUX9W9K4xaGZjKR4MNAUZF
         AKeBkxKcSAoL7UEc9Inwm9zZ+ntygHNZvpktl+GWiHzddHkTlO+/95DxX91hh4LRBWKV
         wGwwTWnP2I79IqKGbAhxp5Vu1mC2n4NGEvz3y1Oa7dUovXXmsit8ozdX2yrkcvOMVk6w
         oQ7Psf0uy/uXkr7akFEiCUi1LyG+KGFH36183di4TgIv4U2mtbf/v40GX6/TIVS9oiHX
         EksHRMfJjXODUTH+db6DnUUimEgGW54jm3kofiA8IpJWlGnsPPcHppgDbsuUFeWiqXSd
         Z5+Q==
X-Gm-Message-State: ANhLgQ2R0ZFKLBLD9walgDbxMMrubdNetSTLn8nd3okF56d13LOjiKsq
        zb5sojg0bg5o/IrqIOu8STm32iMea/B1nvDxIGw=
X-Google-Smtp-Source: ADFU+vv/0Man9LaI0hn/iw6+xcPTW+sOqC1GF04v4Opz3X6BiKISx73z+nqXV7DAZQidRgIZTYsmkCfgsETHH8jL5jE=
X-Received: by 2002:a9d:b89:: with SMTP id 9mr12549687oth.297.1583748943084;
 Mon, 09 Mar 2020 03:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200131124531.623136425@infradead.org> <CAMuHMdX-Vj-ewD7Kh+d5FdRs16eebwtM6hykZH62ha0Wq8dukQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX-Vj-ewD7Kh+d5FdRs16eebwtM6hykZH62ha0Wq8dukQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Mar 2020 11:15:31 +0100
Message-ID: <CAMuHMdWz7BZ4_mbSRFbb0iDW7wMFcALD5NvHFHKX_nAoE+sHQQ@mail.gmail.com>
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Will

On Mon, Feb 10, 2020 at 12:16 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jan 31, 2020 at 1:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > In order to faciliate Will's READ_ONCE() patches:
> >
> >   https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> >
> > we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> > are tested using ARAnyM/68040.
> >
> > Michael tested the previous version on his Atari Falcon/68030.
> >
> > Build tested for sun3/coldfire.
> >
> > Please consider!
>
> Thanks, applied and queued for v5.7, using an immutable branch named
> pgtable-layout-rewrite.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=pgtable-layout-rewrite

Any plans to use this? Looks like it's still part of linux-next through the m68k
tree only.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
