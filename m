Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA67C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5482467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umPiQ/Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgA1G0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:26:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35004 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgA1G0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:26:11 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so5754423qvi.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qvkTLwVKoGDoIQ0qZA+h5T3eIEbfaZcuduwqWx0fOQ=;
        b=umPiQ/Jc483p2aL2/oJAHwfr4tIc7mtr3ZJq4N/f1VORKo0TAa5SRG8G77mYww8Av7
         hrVngEqDPr0QBwpbKQhzICex0V1ldJ61rmWhIXtfawr8bvS2RsS6oQzeewh1FT4w6zdo
         hR2a5zDv30tcCVdZ9Tm0PPwDOxBAHEQiKIVZPFxVSOzIPp1wewtLYjgHwehtWdB6M3RR
         Ptl12HYJ2DRV5tH26RCssSzh0nHBTcUsB6XQVzTQx6+W61J2JOTqdEYHj4+CLt59Rg4n
         EbQw/kFGbbKp2SoCItM2cgGi07f1Pql5jjHzDdwYWHLS3kWqBZhPWyTloanFaR3KDljb
         XoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qvkTLwVKoGDoIQ0qZA+h5T3eIEbfaZcuduwqWx0fOQ=;
        b=Wxfa95DtbpHQN2Xp855KxjITLqap8WzqgtrT1g//cFCNbzhJYm14A5r1BM76kLQMmv
         76igfroJPxM3zLX+UrzjJIxlPhe/EvPW2twWTupASVtCnDNXzHG34cLIJO2sZSCR1iZ1
         ltoSodkeUtwWVuaRQkqZp360UxKaZwhyk0yc9Mx5JiLjF6V4OI4Zt7AwgAr/+R43W8jZ
         kCVBdacAk/YOMAJd0LmM9tc/CDQLbJVzu1+DdtQb82aEYzhE+I6kXQnxGv48SrqugTdk
         Dmj9I+QfHtL1zcm2x35/AFSwpWEHHBPuMAYGOrywuszsNxJuwZin981aqTetyAWLACkk
         /rcA==
X-Gm-Message-State: APjAAAWMx/9hi/Tjqf5AjBRUf5BZlsDjPFPZUbNyo0Q3hf0C9u/A1tYx
        Nyh0Fcf9ZtPF37JYX2UeT4Ibe4bNQAoex+OeJBRv0A==
X-Google-Smtp-Source: APXvYqwlp9eMndZLbPF7wU3j9cmpZgXD7WkbLqp0gyMi+lDMoN5F3scc8NmK6lgOR0CJQQ7lXYmcbspCgKeURS6lznU=
X-Received: by 2002:a0c:ee91:: with SMTP id u17mr20061495qvr.22.1580192770479;
 Mon, 27 Jan 2020 22:26:10 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
 <E600649B-A8CA-48D3-AD86-A2BAAE0BCA25@lca.pw>
In-Reply-To: <E600649B-A8CA-48D3-AD86-A2BAAE0BCA25@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jan 2020 07:25:59 +0100
Message-ID: <CACT4Y+a5q1dWrm+PhWH3uQRfLWZ0HOyHA6Er4V3bn9tk85TKYA@mail.gmail.com>
Subject: Re: mmotm 2020-01-23-21-12 uploaded (efi)
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 7:15 AM Qian Cai <cai@lca.pw> wrote:
> > Should be fixed by
> >
> > https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/
>
> Cc kasan-devel@
>
> If everyone has to disable KASAN for the whole subdirectories like this, I am worried about we are losing testing coverage fairly quickly. Is there a bug in compiler?

My understanding is that this is invalid C code in the first place,
no? It just happened to compile with some compilers, some options and
probably only with high optimization level.
There is a known, simple fix that is used throughout the kernel -
provide empty static inline stub, or put whole calls under ifdef.
