Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2B620DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdQJzqUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgGFIo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:44:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C39C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:44:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q198so34055371qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1gn4tP1a3mQ0vHJtA5M9X20sZ0Yx6VV0+93sudXEwpQ=;
        b=cdQJzqUGdpZJEb5c20KqBi5IyiJX6jlv+5wpixruD3h7iTrHeUp6CWbiT1mtPFf35W
         AI5DH43th8SHrAGlwHViOUIJAO4oZqSa1Sl8k8uJ1AF0rn/HAa1RXBf0asQstvovFnXQ
         oQhythpoL3CircgvR/XSp48jqH8t60zel9R2+EpXMv9nZ2xsQxEdjDbcsqtdWtJMFHAs
         wsloBxalpVfzqchepeJ5XGmWQ4HjZd/HlCXgT5ECjgr4A0ICqKP9Gfr2QtRKB0nOLFOM
         nkq1RLSU2vWC5z4OZqrUrK4xEO4q3phx4caQUi0ObM4fDPHc9NVU6ATZAiJMUtJplRky
         hJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1gn4tP1a3mQ0vHJtA5M9X20sZ0Yx6VV0+93sudXEwpQ=;
        b=dRaCdOHUR4BPIwNa6woH2w4W70tRWPn/XyiN3X4ZFecel0mzwUL6/pY2KLsK5Wzb1d
         7Jl/EBCDI0btEeoqEsoZSDYEfivNNiq3kg4QM8DPIJt2HuoOBvKmjyaOs3+vQVGkjsNv
         rNVG3BsFED/dab1+bfxV8gdu/gG72dla11LSRbIkzlET1ei6hc6s+mjzlsmKrUdGlGd7
         XJeixclx0MMhBXKYak2pNz9wLRSP78S4pAcVN91yEoXElBVHXABWUe1fy+o3wzLvfgfc
         GrRK1HI/v+BN8OG97vmCvaeLy5UsHTWZ3SAlu6EEvpdJzt3P/1LN5bJGEdU4uD40YK5g
         Lj2Q==
X-Gm-Message-State: AOAM533Xh/iC735TusA59+pmyNXcBQhj0AHnaO3VHorxrIOc8asxf6zT
        QYYgOAibNqI851BieMQA482aaTQJJcjGzuOUGWU=
X-Google-Smtp-Source: ABdhPJzZUVL5o8BCUoCBFqtyIPeg7e3XR2TIpizms/2OXb5Q5c5XHfTYyZg0aJGM+abWNaEIiI3FmWc2blK3/WvlOLw=
X-Received: by 2002:a37:7d86:: with SMTP id y128mr36550994qkc.343.1594025067131;
 Mon, 06 Jul 2020 01:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-9-git-send-email-iamjoonsoo.kim@lge.com> <fe0df827-e9d0-ec92-f4e1-99cfc6a6b9e9@suse.cz>
In-Reply-To: <fe0df827-e9d0-ec92-f4e1-99cfc6a6b9e9@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 6 Jul 2020 17:44:16 +0900
Message-ID: <CAAmzW4PZfyXTFo6FVGfx3f8Ys1qpp4TUet05i=tpM7MvfyVXow@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/page_alloc: remove a wrapper for alloc_migration_target()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 1:18, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/23/20 8:13 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There is a well-defined standard migration target callback.
> > Use it directly.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> But you could move this to patch 5/8 to reduce churn. And do the same wit=
h

Yes, I now realize that it is possible to make this change earlier.
However, reordering
the patches would cause additional change so I will not change the
order in the next
version. Result would be the same. :)

> mm/memory-failure.c new_page() there really, to drop the simple wrappers.=
 Only

Okay. As you suggested below, with NUMA_NO_NODE handling, we can remove
the more wrappers. I will do it.

> new_node_page() is complex enough.
> Hm wait, new_node_page() is only called by do_migrate_range() which is on=
ly
> called by __offline_pages() with explicit test that all pages are from a =
single
> zone, so the nmask could also be setup just once and not per each page, m=
aking
> it possible to remove the wrapper.

I have tried this suggestion and found that code is not simpler than before=
.
However, there would be minor performance benefit so I will include
this change, too.

> But for new_page() you would have to define that mtc->nid =3D=3D NUMA_NO_=
NODE means
> alloc_migrate_target() does page_to_nid(page) by itself.

Yes, I will use this suggestion.

Thanks.
