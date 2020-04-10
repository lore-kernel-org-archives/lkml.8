Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33447C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1300F206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDJOb1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:31:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38589 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:31:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id w2so1531003oic.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 07:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KmPT0kqXRKOHeqpvmmMJlgFcmC7GqFpKeaTOCrQ8Wtg=;
        b=DL85hDiACG72Tzsd/zX92WTvR8tj6mv9MiFDzWGq1j62yjWiWqsc951yVLqZZ+u9MS
         hZUZqhhtV6W5Qb6MZpLlVavDRZ8f7Ca2BCW1zeH/5920KXF6Lb9npdpwy07Xs3yL9R5T
         R16k2pd7s2bR3DIdePr1DJ4vfKhZQTxy8r2rGpb5tXQb0jUC+U7GOE5AjAO8PSfC/A4F
         bfU9XLBzJITkxjLDpnwFK+L5UT72BKQ5hzOgcd05sNVqHkaIAn0uhzPVmZ8m231qynZO
         5j0DfP8nK5S9u5ARJGuQNpMNj1Lnim65wGwWWpzVugFhI5qdL3bWUcIUrIOdDoX1pTDo
         DXqQ==
X-Gm-Message-State: AGi0Puay131HkzuHdx9nxJj14lUjX+PmsRfvyHo8Gadh5BVy5D6tjzAP
        vx8YH/aBKLbDZKL/nDL6EBGhOyMYY/DcolCKh5E=
X-Google-Smtp-Source: APiQypLr/SVeq2mdMekyoC1fUcboiqejAedCf/X8jFVX6LIVAyFSHTCwj5yNU/ZuaKgxmeqtpp5acBArep16IQooSIY=
X-Received: by 2002:aca:ac09:: with SMTP id v9mr3407739oie.148.1586529086780;
 Fri, 10 Apr 2020 07:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200410142648.18599-1-geert@linux-m68k.org>
In-Reply-To: <20200410142648.18599-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Apr 2020 16:31:15 +0200
Message-ID: <CAMuHMdUghCZuh1zGbi=_9s7pMB34TuawMQ-b6N+f+hDdPOAs0Q@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nft_fwd_netdev: Fix CONFIG_NET_CLS_ACT=n build
To:     Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 4:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If CONFIG_NET_CLS_ACT=n:
>
>     net/netfilter/nft_fwd_netdev.c: In function ‘nft_fwd_netdev_eval’:
>     net/netfilter/nft_fwd_netdev.c:32:10: error: ‘struct sk_buff’ has no member named ‘tc_redirected’
>       pkt->skb->tc_redirected = 1;
>               ^~
>     net/netfilter/nft_fwd_netdev.c:33:10: error: ‘struct sk_buff’ has no member named ‘tc_from_ingress’
>       pkt->skb->tc_from_ingress = 1;
>               ^~
>
> Fix this by protecting this code hunk with the appropriate #ifdef.
>
> Reported-by: noreply@ellerman.id.au
> Fixes: bcfabee1afd99484 ("netfilter: nft_fwd_netdev: allow to redirect to ifb via ingress")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Please ignore, wrong patch.
Sorry for the mess.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
