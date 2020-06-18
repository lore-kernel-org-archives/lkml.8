Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998DE208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRbcC693"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgFROzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbgFROzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:55:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED34C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:55:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so3643262lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dqnJj0lECjZQUIylFPZhd0nKb0VZ/tVZQGVsKEkM4E=;
        b=pRbcC6935U5lV8EqLRLMS/rBbwozTHCWmNLsUUnX8q6t5IqwEyHjaTZrDJ03waT7ub
         xkj7GxRjPPGqB+LL5DE8sScJV6/dWsNLm/LeyHNcdKWJsnd/aMgX4YUvN2APoxM8rLv4
         W3EDRnWRrF8w4HYQrvhJsOT0M2xQR6rlZe7vsxXtNGk1uzOXOy/Qi0doKSMHR65WVJ5R
         dMzX7bNeEBgH88Z29ngyXeBIAQGnpzimCXZmqPrCzXEsmy1VqTsmpqEql+6LZKWsWHUj
         3drti1PdZ6eeLuiPZp7QFQb/eBSGy1BgpPjnbpbdxqcXxf+9xq0bOBs7u+O8j07mP4aB
         DGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dqnJj0lECjZQUIylFPZhd0nKb0VZ/tVZQGVsKEkM4E=;
        b=NWKET3AEOm7E1IWmRmwpoe2+qqH4vT6aQUX+bjm6g+9vZql6W/7q44LYOak7QJdMLz
         p7Efo/25ww8Nr5inB/rW28dGsFLwjuXjT4RTJPEII106F5F6TaWArqYfJWV78nU9juYz
         ag+Dvyu60+bqD9VTTN50SSE7cxW26sDNz2WXuEPjDqzGutIt1pu9xx2pucot2vy31Zd7
         yPlsMma9db3ChQ48jUI/g2UorHkqtYU2fL/rHeJon3CmVc3fZT0IVifzmfGe9NeKLWzA
         cfCT61MVXKCG0g4eLAID/eSFmiSWzygEL8zE18Uf6jecBEbWgYKMrrk0cfe60PRkNpGb
         Zehg==
X-Gm-Message-State: AOAM530+ztsDfDSf01rRKgP02f0nlyQE8TIpK1L1+UpvkuDFID3Igfyx
        OE3WilToLFt2QyJWS1ibZbWEQKkReESna/n1aVEiag==
X-Google-Smtp-Source: ABdhPJzfDtsd2nNokfLfe5eRCVq78SAuKBGFd2B0mMG2zNcO/senzmcip6cwovel39rl1gA+VUj6u/ad46PEd4u30+8=
X-Received: by 2002:a19:11:: with SMTP id 17mr2620971lfa.125.1592492147402;
 Thu, 18 Jun 2020 07:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-6-guro@fb.com>
In-Reply-To: <20200608230654.828134-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Jun 2020 07:55:35 -0700
Message-ID: <CALvZod4Jur7EFPPWzoBvQgF0m3hXyohBrBirEySWoPTV23rvUg@mail.gmail.com>
Subject: Re: [PATCH v6 05/19] mm: memcontrol: decouple reference counting from
 page accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if my email went through, so, re-sending.

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
[...]
> @@ -3003,13 +3004,16 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>   */
>  void mem_cgroup_split_huge_fixup(struct page *head)
>  {
> +       struct mem_cgroup *memcg = head->mem_cgroup;
>         int i;
>
>         if (mem_cgroup_disabled())
>                 return;
>

A memcg NULL check is needed here.

> -       for (i = 1; i < HPAGE_PMD_NR; i++)
> -               head[i].mem_cgroup = head->mem_cgroup;
> +       for (i = 1; i < HPAGE_PMD_NR; i++) {
> +               css_get(&memcg->css);
> +               head[i].mem_cgroup = memcg;
> +       }
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
