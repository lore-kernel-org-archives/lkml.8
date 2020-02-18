Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673DCC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCAF246BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXtXrgDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRS7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:59:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41551 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:59:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so21166019oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZFvoNuat14DefXi3vC+e4qmKLvk+S8JScj25aPSjJM=;
        b=RXtXrgDuvdnL5sCqfStcIcksH2FbUwtj3cgM6nLEKhgSNXkXrcUMffZk6UldfpqpMG
         X6dh/gjt88bBu4+jBnuobt1v8D2N4tLZeLUjKr4WEUTxePmfxQ3neGT+mn0nUdnLNK5o
         9Jut24B90o864Pp7Xjs5gL/IozPfu/Rp0O+FFh8ztNqkQO/ZNx2SqLTFu6YNgO7r6GVs
         FBhMpai3M7D+zRzuhqGr9Ty2NLoujyfdLdmTXnwyjtBrOh5tTLyRhNrq15Sj1JFoJNiZ
         6RBAYTOui7DFY2bim6bgI7GQQIudoc7j2qirGJO2qcAWK/BIVqKIeYLgX1r/1bW0yv05
         B7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZFvoNuat14DefXi3vC+e4qmKLvk+S8JScj25aPSjJM=;
        b=pHihBuTHfBwq5IQ/L0D+D+WDP2K+BMEZSq+fsxIqKKyEVqYaIJQ7SspU6EpjuUGQWR
         9suG/fgbHH60yAeiJbhbdFp4T55pb5lzroRhl5kGTLdNcISna2UjlKnoDTFc5nr1v9tY
         DeJDJWDvE9FCV8zowaaoxcKXIhCbjy0fixDesjUlw5qVo/+5CyVdnSL6hCk+hFsIq3Rk
         h9BMn70D0jM5ApqnWl+dms+Gpo4zHSxiW0RO08zSCjwooChl2OvWtAAVkwiGXUn9D/F7
         i7PQbYj4bK4Ew+vQubKWk8PkL2tEQwY97ONwrVKhvmvkIgME2oUKe7JYmYq9sBO+/d5k
         hM4Q==
X-Gm-Message-State: APjAAAVzg97BNZvVCcYXpLtltTyh3A2C8NQfyULn9zVmAXtUQ9AyA1fn
        PZzo/S8azArgeBlSSTnnCLC3V9HQp4+uJsU1/IhiOQ==
X-Google-Smtp-Source: APXvYqylpO5JT+CurUke29eYbKzZ/jRMwJkbZDTpcSIntjBC4fek57WNX05I0F0OMeYPrhF7xnCa0VuzpBDAMOXPJIQ=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr2306419oig.103.1582052345973;
 Tue, 18 Feb 2020 10:59:05 -0800 (PST)
MIME-Version: 1.0
References: <1581953454-10671-1-git-send-email-cai@lca.pw>
In-Reply-To: <1581953454-10671-1-git-send-email-cai@lca.pw>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 18 Feb 2020 10:58:54 -0800
Message-ID: <CAHS8izMrJ3CNB_6W7VJ8+8TXZw0bnUsA5et7jF4iFn8T4QH=4A@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: fix a -Wunused-but-set-variable
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 7:31 AM Qian Cai <cai@lca.pw> wrote:
>
> The commit c32300516047 ("hugetlb_cgroup: add interface for
> charge/uncharge hugetlb reservations") forgot to remove an unused
> variable,
>
> mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_migrate':
> mm/hugetlb_cgroup.c:777:25: warning: variable 'h_cg' set but not used
> [-Wunused-but-set-variable]
>   struct hugetlb_cgroup *h_cg;
>                          ^~~~
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/hugetlb_cgroup.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index ad777fecad28..8a86a2b62bef 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -774,7 +774,6 @@ void __init hugetlb_cgroup_file_init(void)
>   */
>  void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>  {
> -       struct hugetlb_cgroup *h_cg;
>         struct hugetlb_cgroup *h_cg_rsvd;
>         struct hstate *h = page_hstate(oldhpage);
>
> @@ -783,7 +782,6 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>
>         VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
>         spin_lock(&hugetlb_lock);
> -       h_cg = hugetlb_cgroup_from_page(oldhpage);
>         h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
>         set_hugetlb_cgroup(oldhpage, NULL);
>
> --
> 1.8.3.1
>

Hi Qian,

Thank you very much for the fix to remove the warning, but actually
the real fix is I'm missing a 'set_hugetlb_cgroup(newhpage, h_cg);'
which will use the variable and set the cgroup on newhpage which is
needed. I'll submit the proper fix.

What bothers me though is that locally when I checkout the broken
patch and try to build I don't see the warning:

make -j80 mm/hugetlb_cgroup.o
no warning.
make -j80 mm/hugetlb_cgroup.o CFLAGS_KERNEL="-Wall"
no warning
make -j80 mm/hugetlb_cgroup.o CFLAGS_KERNEL="-Wunused-but-set-variable"
I see the warning.

So it seems there is a bunch of warnings I need to explicitly turn on
otherwise I will continually submit patches that introduce warnings in
your build. Any idea why I'm running into this? Do you also have to
turn on these warnings manually on your make line? Is it related to
gcc version? My gcc version is:
gcc version 9.2.1 20190909 (Debian 9.2.1-8)
