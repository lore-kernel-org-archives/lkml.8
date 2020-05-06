Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8130C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FE120735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFXjgemc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgEFVx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729665AbgEFVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:53:54 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72874C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:53:54 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id i16so1796962ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0EebI0wRb/tvCNXlsGxxNrmG0tMY7mj+ffgbYSbdE0=;
        b=UFXjgemcco3wS+VML2EXMGYsw4wBSNxjKeNKGP2VQLQpBCDRbOWS3ejRsjb8/MLwVB
         i44cyTIAOyIGEL+wG8PZ0kJ9esTwBGXdx1zh1tGCCnHhNK7xnhqyfssDgOfJsCnc6LBq
         Y/o2XLAjh5ZzlmDVZ4/xuF759eOvsb+adnnL9vX2PtjVSDSxvuwI/7S3i836Ws1zEaJr
         HttwrrK4q8cCP7sMvkDPaC9kC2+rXJ9azKf15LY7RvcFueycEHCNZ6g32E2lhLfRpyFn
         GwI02VwqdYfZze5r4HE4SrZYbdMcWEv54HwOEWeME7Qh0f2TtH+Y7LpKH2iSuGul9/Hw
         hjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0EebI0wRb/tvCNXlsGxxNrmG0tMY7mj+ffgbYSbdE0=;
        b=KlKBCPrw+oKa/PkY27SDDg8mzG6zwzHUicMDEo2ywB85TZ6LnD/RvXf7g0LmZtm6Eb
         fiTlWdAyv7YkN4XNNE9GxWxYz60jCIF7arq4GEuLM3H9QhNDnpwJC54D9JB/h+mw+qDw
         MhLW9FpN46wwQLzMomjH3nSvFUDm1YOxbar+WWwQ/XZAN3S9BLKaWKkKivafW0csrumn
         nNtSo6fJQF9czpNmCmUggl6t0Q13cSaNLeyoWTRNK+nrX2wd34anb9Fwh0yzZ5Q++86a
         rVSoXHokf3dNIPrZZmNk9J11eeK4Qn1MejhiRkv2aFW33LCuLdvtIJCtIASBAtXxEm+q
         dG6g==
X-Gm-Message-State: AGi0PuZfI1Yr26j/8grwCjV1YWlVkLaiVWJWiVo9rDGYTFipagsTRyFs
        0eqldP79Ahh3X0EiwVUOM7GEddBYNBuXFma3GduHxg==
X-Google-Smtp-Source: APiQypIZ2lS5JPETs/hxM32Qe7xXAMoWoXTnHt9xQRKtH2nGeflyJrnujdzb/J6oXE99NJCr1duB3JFM88kNT6eEST0=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr15709759ybc.47.1588802033385;
 Wed, 06 May 2020 14:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200506205257.8964-1-irogers@google.com> <20200506205257.8964-3-irogers@google.com>
 <CAEf4BzYJanGO+XrTBQoEzGoB_D6xQYYm9tT70+Kie4hyKCxhjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYJanGO+XrTBQoEzGoB_D6xQYYm9tT70+Kie4hyKCxhjQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 May 2020 14:53:41 -0700
Message-ID: <CAP-5=fW97DB0CTLN=5iKPUF_tJW-yZgC+jiikdU0goSD_ADYkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/bpf hashmap: fixes to hashmap__clear
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 2:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 1:55 PM Ian Rogers <irogers@google.com> wrote:
> >
> > hashmap_find_entry assumes that if buckets is NULL then there are no
> > entries. NULL the buckets in clear to ensure this.
> > Free hashmap entries and not just the bucket array.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> This is already fixed in bpf-next ([0]). Seems to be 1-to-1 character
> by character :)
>
>   [0] https://patchwork.ozlabs.org/project/netdev/patch/20200429012111.277390-5-andriin@fb.com/

Thanks!
Ian

> >  tools/lib/bpf/hashmap.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
> > index 54c30c802070..1a1bca1ff5cd 100644
> > --- a/tools/lib/bpf/hashmap.c
> > +++ b/tools/lib/bpf/hashmap.c
> > @@ -59,7 +59,13 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
> >
> >  void hashmap__clear(struct hashmap *map)
> >  {
> > +       struct hashmap_entry *cur, *tmp;
> > +       size_t bkt;
> > +
> > +       hashmap__for_each_entry_safe(map, cur, tmp, bkt)
> > +               free(cur);
> >         free(map->buckets);
> > +       map->buckets = NULL;
> >         map->cap = map->cap_bits = map->sz = 0;
> >  }
> >
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
