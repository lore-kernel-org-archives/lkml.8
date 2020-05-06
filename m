Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B341C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF572076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqErgpFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEFWOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbgEFWOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:14:05 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C975C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:14:04 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o8so695616ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5seMAfg/V9IKlpMN7xejCaTLjyWdju1CY7lui7OxwBs=;
        b=OqErgpFAnFtDzsIwLFxC5R1yRWO7kawz9wrlJN5IVsCLmaZh+cNFX7aac9daeT8aXu
         JyLg1kvfN4RYMiFbBebROwAweaFyzWRZ0uRjF66OsXfKaRRIIpgbkF34EAW3klLl3NO4
         RNiEF+zwcz3XG8CiXmaqZFK7Shy5fzutwMUZ3guxL8pBTQOktU7qvu0yhOYFROPf6hi/
         5ZI0agfyjjlIp+sDg18gGPl7TpnPl7fG5HVWZSuDWnJCl8dPdXA+EVef2tnracXPQm0s
         yd//RdLhfEkryPciEoFEM3+1239isEvhjUbd/DrmIdYmMVGTQETdiWWWNMfCCB72lRt5
         nFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5seMAfg/V9IKlpMN7xejCaTLjyWdju1CY7lui7OxwBs=;
        b=a9V1PYGFgnenyjA3kJv0VMKVwqu6D10BihdKmxOGIPCPPj8h7USmylcxlvF2a1U36u
         QFe8rWbd9qik+DC+PD03LQ51U4kdL3cBwvg5uzkbi2+dCvZy0gI9y0vzBOZh6OC9Huf8
         ZPnolBzsRBx4Pbe8C/tahjd+BenK+hwZuRBqu06jRoTPAi8QmekLXu0UMIcJRyZwd4BA
         ft83V+G6LSibPc4iy6aKQ3BwUYp1FsIn9gBZGJp2zz1lCbPT1ioUpF04R1FNGh8m4R5z
         sbuUQP5RMBzdKeKNXMKFPMkhxL747HwbkRHT1ENb793vgRe1v8n2AloO1jHnj6k4IN+N
         zw+w==
X-Gm-Message-State: AGi0PuaUQ0sONViXzqrEGc/r3ZsstMnOnfQIfvNtywCMqNW/95LMVudQ
        4iOWbTp/XQ3OqRq9I74ex6C+tTOsFVGtwSvl8LPYBw==
X-Google-Smtp-Source: APiQypJ0Gbbt5GtTiUTjtfkgqcIR1Bvzw1yf+uU7LUdAPHzx0wjrWiZXl/QayU3OVMt4dcX/L2A0Ipz8Qv2ODlnl5EY=
X-Received: by 2002:a25:4443:: with SMTP id r64mr16498352yba.41.1588803243107;
 Wed, 06 May 2020 15:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200506205257.8964-1-irogers@google.com> <20200506205257.8964-2-irogers@google.com>
 <CAEf4BzZRmiEds_8R8g4vaAeWvJzPb4xYLnpF0X2VNY8oTzkphQ@mail.gmail.com>
 <CAP-5=fXUxcGZbrJMONLBasui2S=pvta7YZENEqSkenvZis58VA@mail.gmail.com> <CAEf4BzYxTTND7T7X0dLr2CbkEvUuKtarOeoJYYROefij+qds0w@mail.gmail.com>
In-Reply-To: <CAEf4BzYxTTND7T7X0dLr2CbkEvUuKtarOeoJYYROefij+qds0w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 May 2020 15:13:51 -0700
Message-ID: <CAP-5=fVvybBywqTYmyEQPK4ai7qc7ye2-eDoFj87r2KDeOZnsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/bpf hashmap: increase portability
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

On Wed, May 6, 2020 at 2:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 2:47 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, May 6, 2020 at 2:33 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, May 6, 2020 at 1:54 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > Don't include libbpf_internal.h as it is unused and has conflicting
> > > > definitions, for example, with tools/perf/util/debug.h.
> > > > Fix a non-glibc include path.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/bpf/hashmap.h | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> > > > index bae8879cdf58..d5ef212a55ba 100644
> > > > --- a/tools/lib/bpf/hashmap.h
> > > > +++ b/tools/lib/bpf/hashmap.h
> > > > @@ -13,9 +13,8 @@
> > > >  #ifdef __GLIBC__
> > > >  #include <bits/wordsize.h>
> > > >  #else
> > > > -#include <bits/reg.h>
> > > > +#include <linux/bitops.h>
> > >
> > > why this change? It might be ok for libbpf built from kernel source,
> > > but it will break Github libbpf.
> >
> > Without this change my debian based machine wasn't able to build
> > within the kernel tree. I see bits/wordsize.h on the machine. Perhaps
> > the __WORDSIZE computation could just be based on __LP64__ to remove
> > any #include?
>
> It might work. Do you mind forking https://github.com/libbpf/libbpf
> and trying to execute travis CI tests with such change? It compiles
> across a range of distros and arches. You might need to set up Travis
> CI login, hope that's not a problem. Thanks!

I'll try to find time. Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> > > >  #endif
> > > > -#include "libbpf_internal.h"
> > >
> > > Dropping this seems ok, don't remember why I had it here in the first place.
> > >
> > > >
> > > >  static inline size_t hash_bits(size_t h, int bits)
> > > >  {
> > > > --
> > > > 2.26.2.526.g744177e7f7-goog
> > > >
