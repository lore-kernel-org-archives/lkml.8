Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5F520773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHI5glD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGAGS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgGAGS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:18:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA385C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:18:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so21158435qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mrmTZmnOtw4qO5wq5D6v7IlGV7qQRDmhjYP9i2HjtA0=;
        b=dHI5glD50UnPuu677fam1ZaQF5rT/cKadHXJt2ZyQc3/14VxnkXNz2t2Sg8df4eFPX
         CI2xqKfz1q6qb+dAoOWQKhztATFIruJK76kHxp9aUWFlic5V+ciQ5t/FJJ5YqJj+jRD3
         a0pbuWGEhPALo3a9ebrMNoO2SK97IoSWEqo9PnHiagCwm7tRp+gk6ssbmwnbsc2rBPoG
         PVm+0nxvT+OtL9MSauvJG0dyuHv2YkUdej/KxAhIcz6JEPVlHeTIdgOvm0zmia4Wjv+0
         +Qwsw9fUOiAOLd8Q0sJzj8xjVCekLrMavcBmElNfXNcG2Ex+3TphT9bhQQTsDDxkUYIC
         p+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mrmTZmnOtw4qO5wq5D6v7IlGV7qQRDmhjYP9i2HjtA0=;
        b=XSzovIXUd8vdOSQcekLqJ9zuLlwNgBJdCoFVs+9l7nZWop9xuiUlZs9nFjEyl9zoly
         UBTN1qlubUigceoVhBc5HvmlNghS2HTZ/HLSN/7uk0D4mQty3whMdkAWj3AuDE5YhYSb
         OkqWEpArWRtMLGfhjeKgN4nuonXHr8P9ypw2HW2IZb1f7m1A4fOq40eSZnrIR93VfR95
         wBV4c6qp1rpuePzYLFewHYXSqWbzQ6xSe98S1zUgu2t4o/fzKrqoOaJsB0vRQg8wNl6q
         h4Ba/TlX0ameF6SFM7GO+qXfsG50/783qiv9FrjZKdNE8c2DNNJ1gM0a09z0Avfzaedb
         5Z4A==
X-Gm-Message-State: AOAM530agQsWvKAYv6jM7AkMj3l9tn8pjBGaSxVIAN16tL1W/A6yh5iD
        1kerXPxBA2v4Zd9Yq6jPGnxaEYxYnOeQnUI/E7w=
X-Google-Smtp-Source: ABdhPJzUk20AhrOT78yKkoIsAOBFs/Y51ri5z57YlLZDocB+kim2j+V5MFNtbXx3zIvbkM852miwdQXOr7b8GwKfPlI=
X-Received: by 2002:a37:7d86:: with SMTP id y128mr16397859qkc.343.1593584308177;
 Tue, 30 Jun 2020 23:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-2-git-send-email-iamjoonsoo.kim@lge.com> <7a5c8298-a1e5-93f9-eea6-214b0732ca33@suse.cz>
In-Reply-To: <7a5c8298-a1e5-93f9-eea6-214b0732ca33@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 1 Jul 2020 15:18:12 +0900
Message-ID: <CAAmzW4P6Co3Y4KMLFps6BsZvvt2vwQ4g2bUUZCMbNy_tE40xCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] mm/vmscan: make active/inactive ratio as 1:1 for
 anon lru
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 1=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 2:27, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/17/20 7:26 AM, js1304@gmail.com wrote:
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
>
> "Restore" sounds as if the protection used to be there and then it was re=
moved.
> If it's the case, it should be said what commit did that. Otherwise I wou=
ld say
> "implement", not "restore"?
>
> > case, newly created or swap-in pages are started their lifetime on the
>
> I would rephrase it: "After the following patch, newly created or swap-in=
 pages
> will start their lifetime... "
>
> > inactive list. If inactive list is too small, there is not enough chanc=
e
> > to be referenced and the page cannot become the workingset.
> >
> > In order to provide enough chance to the newly anonymous pages, this pa=
tch
>
> "In order to provide the newly anonymous pages enough chance to be refere=
nced
> again..."
>
> > makes active/inactive LRU ratio as 1:1.
>
> Here I would add:
>
> This is just a temporary measure. Later patch in the series introduces
> workingset detection for anonymous LRU that will be used to better decide=
 if
> pages should start on the active and inactive list. Afterwards this patch=
 is
> effectively reverted.
>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

I will change the commit description as you suggested.

Thanks.
