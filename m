Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17036C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA52B20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgAaJHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:07:00 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40908 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgAaJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:06:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so5906075otr.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD1m1C7Z6owu7pJKCcZNi0kfjnO20uBFbl49wSgK5Lg=;
        b=hle8MrtlObbp8du0+KnsTcFFRKRJGmAa/SeuW6xqbXWTh6BX+cc9XkiWMy6K0324Oh
         Y4j15FnY57MLGdpt93p3OheNy7jmhyzS9XEC04vFiyE9hIYV3oJkxOBdwwJ+w59erd+I
         M/PFHx5c4tA1KJlBG7jro/bnZQKPa/YbpjftnLWcQD0xwTEpZ19RtvAAxkZCpduRLAmZ
         bhz07Xa6a/bPDBp0Fp2/Mhq13Lcpaql9dLmgGJkz39Bp5qIDISCbTuCUKuXBszzwUKP7
         o5gqqB63cCWsq7PEuc5/BNREGie/NZvxRj7QTemHY4lRi7QPnCwXtXKvz5aQgHK26IsL
         p+jQ==
X-Gm-Message-State: APjAAAUAidzduP409qFszsqJ3XQ7yJAlvvkXS0deKpkT8F6/pkB4yvCp
        ZxcuU3uQT7d/mJVAqWVopzB1m0Fa0zlj+abFxAuUtA==
X-Google-Smtp-Source: APXvYqxXnQrTWkpOmfZ4c1F1M3YsJErcFXJpAlowXPQwo2N4eVzTPJn2pP+D0bi+mHOGRWxfvp5vAPdvsTIebEfZIQg=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr6833651oth.145.1580461618754;
 Fri, 31 Jan 2020 01:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20200130191049.190569-1-edumazet@google.com> <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
In-Reply-To: <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Jan 2020 10:06:47 +0100
Message-ID: <CAMuHMdVSyD62nvRmN-v6CbJ2UyqH=d7xdVeCD8_X5us+mvCXUQ@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
        Joerg Roedel <jroedel@suse.de>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Jan 31, 2020 at 12:46 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-01-30 7:10 pm, Eric Dumazet via iommu wrote:
> > Increasing the size of dma_entry_hash size by 327680 bytes
> > has reached some bootloaders limitations.
>
> [ That might warrant some further explanation - I don't quite follow how
> this would relate to a bootloader specifically :/ ]

Increasing the size of a static array increases kernel size.
Some (all? ;-) bootloaders have limitations on the maximum size of a
kernel image they can boot (usually something critical gets overwritten
when handling a too large image).  While boot loaders can be fixed and
upgraded, this is usually much more cumbersome than updating the
kernel.

Besides, a static array always consumes valuable unswapable memory,
even when the feature would not be used (e.g. disabled by a command
line option).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
