Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A9AC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 05:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8872074B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 05:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFumfnUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgCMFs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 01:48:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38590 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMFs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 01:48:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so10649924qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 22:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m9MFNcc+y7BnxIlUyyIEFrAkeijCup1s4J6796SAm2Q=;
        b=cFumfnUC4vpRsLESERKQ5tDiX/KfiQ73qno74S9iUUhRuy9e1VcXxrTkm44Zcv7DVP
         1Rocb3rHm1Kf+GDINKx0dr0QL9lL2o9yA8jS4xB4SFTR9zOzevu+1Ql3wnyBiOLhb5Xs
         4D1tXXjJkZXKEozNYTTLx4KXDwZQTQYn8nNoW/6fpS6uxNwovph1b6XDHxsutSHLCiv3
         bqxwXATvPzRVrnuW1C/5fTCv04H0MbZpElN0D7xyrE4J3fPkdD16ttZmS9QaNataXXLr
         +0dvAbmpNSTq7p00s4p8VNe6mFGMdLDkQMCHZHzS1/fx3T9MDfj5ZbQ9R4awJaiL1QbU
         CT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m9MFNcc+y7BnxIlUyyIEFrAkeijCup1s4J6796SAm2Q=;
        b=iUS7ztg2lVij6DmRiTXL5jRfo8zPw/esfwjVEnYrPjRhUJKjeu6xu6VBK8irSCa8vj
         ZUEAC/NJo7uET1mbvEwk+9VWLN4h0rEZSKs1sAR5Ur6M3yOeoZP2iasqfH2xzeoXz5zz
         cRV1r5rfTlmLif3UH9Vj0gPEMHDklv4xfTKHWjxnLrr2mraV4fVP9OF6DP59gAZZ/5pD
         Ecy/OWlflfApNHxMN+LkAdTDTn2wLzCK28JqzqnvDsjQJpCSnW7m9Po4GjIxuy4MNCmm
         BZEY/0bo0vDnrFOXnZuKKyu5O6n1i9CRlvuDYSiXKr0+HqxlPKVB8e8iR9y8cIqi5g1L
         +eTA==
X-Gm-Message-State: ANhLgQ1tvRlLQCwqo5Npow3tBRYu7kzt4kp3JD/J25EIVtehhPUZSswR
        ZGJX3kx/onUplZu+8LT1OJFr7WMTNrJzyWyqIVL+1vfQ
X-Google-Smtp-Source: ADFU+vsx71CZkfhyyVe1+8xbSgG99TRVWCS11dogIyt9i5CCu5skH4iM4B161jiPal6da4d1mdyP/rjZaneX9XQLxMg=
X-Received: by 2002:a37:546:: with SMTP id 67mr11034239qkf.272.1584078537208;
 Thu, 12 Mar 2020 22:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-2-git-send-email-iamjoonsoo.kim@lge.com> <20200312144749.GG29835@cmpxchg.org>
In-Reply-To: <20200312144749.GG29835@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 13 Mar 2020 14:48:46 +0900
Message-ID: <CAAmzW4PW8Z7r7PoFUsAqSY9JpGB4iqxKodO5aath+2QrMSUeJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mm/vmscan: make active/inactive ratio as 1:1 for
 anon lru
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 11:47, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Feb 20, 2020 at 02:11:45PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Current implementation of LRU management for anonymous page has some
> > problems. Most important one is that it doesn't protect the workingset,
> > that is, pages on the active LRU list. Although, this problem will be
> > fixed in the following patchset, the preparation is required and
> > this patch does it.
> >
> > What following patchset does is to restore workingset protection. In th=
is
> > case, newly created or swap-in pages are started their lifetime on the
> > inactive list. If inactive list is too small, there is not enough chanc=
e
> > to be referenced and the page cannot become the workingset.
> >
> > In order to provide enough chance to the newly anonymous pages, this pa=
tch
> > makes active/inactive LRU ratio as 1:1.
>
> Patch 8/9 is a revert of this patch. I assume you did this for the
> series to be bisectable and partially revertable, but I'm not sure
> keeping only the first and second patch would be safe: they reduce
> workingset protection quite dramatically on their own (on a 10G system
> from 90% of RAM to 50% e.g.) and likely cause regressions.
>
> So while patch 2 is probably a lot better with patch 1 than without,

Yes, it is what I intended.

> it seems a bit unnecessary since we cannot keep patch 2 on its own. We
> need the rest of the series to make these changes.

Yes, you're right.

> On the other hand, the patch is small and obviously correct. So no
> strong feelings either way.

Okay. I will keep the patches since I think that these patches will
help someone who want to understand the LRU management.

> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
