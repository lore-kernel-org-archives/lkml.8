Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B0C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885FC2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBPjkmZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgEKP3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728084AbgEKP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:29:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:29:49 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s186so8301334qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbH9x/CkQSfgCR3TtI5p1rcbLe7fbAtxJCxzsNodcvw=;
        b=bBPjkmZZY6OYg37ybNNLJqNZByCg+jG6MuCltmYzWJou+SGdt466roOT1KPUcgUCVT
         DX6EBpghtV6V7MRYm23XiRUjYC4F8AOFie3GXhVqnx5tXJPLsP40EKI2CW4jEibQRNSq
         un/pkX3/ZhSTkua45qW4L3kIKAreoE1syQ4POBAlnFEELQCXwN7z6wV6OoI9n/rmcM96
         M+gmUMWsniny7+xvcm62yrk4XPBykbxY5gXGM51f1g+f8RQHn641fdLjnVtkMUUyJuZY
         IqNaLIXJggo48nT+/cffsgfpBt7KaiiqP3wFhUWbwgjvf/nT1UeD+eMivR5IQs8u6rIp
         k91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbH9x/CkQSfgCR3TtI5p1rcbLe7fbAtxJCxzsNodcvw=;
        b=psBY0FIiyCFHltyicXBYZjIwshMfha90USmWwxrUkAC32Utv9TG/4bT59h9lZuNImw
         BjcTc3phvbSnME3cBj91WA5NiNFZ4pa6Or+NRAvKvqVUAvXAol3rpnl7dL67dziEUYUW
         e69f9xMMobpxtp/zl/RM7LEPsmBlha73yA/pjxjo0BcorYt/a7euMHl7m9+FpEP+LxKL
         xuGcP1eSWvBpSkU71BVXm7wI8vdKrUvXxccwlKTikUPzd2Mo3p/Jfx8WajE5XApMpB0Z
         x0zXThsF6okBIKS0MCAyQ87zlL9AIC6nCP7u9neZumqPU1OmJmhZgW00XOl9g3U77B39
         YCfg==
X-Gm-Message-State: AGi0PubU9TNgV2rRQQmb1VMWwDScEDYRgO1EKw343AnNZQHoDDlPGEEF
        oi/hOE6V7A3qZgbFDnl+iwF0tXFeS1bsihnobTfbvprl1y0=
X-Google-Smtp-Source: APiQypKX0Q13t3+cRVtB2L1Y7CqsrZIP+WqU2HZA/8frKpvdFCRvz7+q+6PURIyWJPK/ouzO9Gvv/48W84FRFCrc4fU=
X-Received: by 2002:a37:9d55:: with SMTP id g82mr13974698qke.407.1589210987755;
 Mon, 11 May 2020 08:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au> <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
 <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com> <20200416103446.09cb27e1@canb.auug.org.au>
In-Reply-To: <20200416103446.09cb27e1@canb.auug.org.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 May 2020 17:29:35 +0200
Message-ID: <CACT4Y+YL1zCXp23NROvkry-WjPYTLbbduM5Mnwn1JJd6Bi9_PQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:34 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dmitry,
>
> On Tue, 14 Apr 2020 13:12:50 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > AI: we need to CC linux-next@ on linux-next build/boot failures. I
> > will work on this.
> > We have functionality to CC given emails on _all_ bugs on the given
> > tree, but we don't have this for build/boot bugs only. I will try to
> > add this soon.
> > Stephen, do you want to be CCed as well? Or just linux-next@?
>
> Please cc me as well, thanks.

To close the loop: I implemented and deployed 2 improvements:

1. Notion of per-repo "build maintainers":
https://github.com/google/syzkaller/commit/88cb3e92ba25303ab67aaceb083fe7304fccd32f
Now linux-next@ and Stephen should be CCed on all linux-next breakages
automatically.

2. Finding maintainers for build errors:
https://github.com/google/syzkaller/commit/65a44e22ba217ef7272b9d3735e9d12cfaa204f6
syzbot will attempt to extract the broken file name from make output
and then run get_matainers.pl on it to find relevant emails.
