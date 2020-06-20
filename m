Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B060C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090862256E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiDbVtnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgFTAQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbgFTAQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:16:16 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085BC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:16:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d27so6525608lfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yH96O9ee+Uh/yst0CCmNawAFM7J3cnfjN7OBaXkMBuo=;
        b=kiDbVtnDRJrd0GU7d+nWT7DQSV0scWLq3IyR0O/sZHnovyNUR/N8Bpwh6t3PlP0oWE
         Leao5UmXekcawPaolmYTpEHrGtcFt+V59dfF+BpyaYEC5smEW+cpE/ofJ5Mz4M+JVy8h
         XFCzI5u5VGSoaobU+A0Cfrz5i8RSUIlKq/r90lYVIFW0EOkTVgweezwves/J7cakSLFL
         8RJMOlrhDtCTKOP0bsuoLdh4yI53KWbNy2T/77Cp8VqlGPCq4Tt3oyvLd95hz3tLXTVV
         bLxqKp1uD4nF41KEeRvHqGEjaQM5x4+cd+WA6usKphDfHFyoddYNg0EqCh3PKHP0/V59
         s16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yH96O9ee+Uh/yst0CCmNawAFM7J3cnfjN7OBaXkMBuo=;
        b=dXMeB2jvO4rpaHUJq7Nog6I/d+uxyKoyK/M6Sj2SSb+9QwEoKea5zR6NXi3Bvv29rn
         U4AbNuEjEmvx3AC3xMpWDPf1Xyhc9w1wAiCC9v7TkV5IzNXr0rhO6ClVojOFJCruXxb5
         A/Pao7ZbsDy/EZeM62eU1s5TGCXMnk9ZOirZzI51VQC7HuE5WJIY5IEniZj1Ke/1yVym
         8nSX9mut0k/RXCXjlI1U75L0WXZjDvL2ZhfL6mKMPa/6yQxeSGxnEsRXCJNWARtgk5iu
         XVGoXhlyUuwf9Fh16gOIhpr8TqYr4w9sOYS6jzMFMgUqlRv9oH0rbNUKq1LtGW+8fYGn
         5voA==
X-Gm-Message-State: AOAM531DF1QYBwOeJAfr84L4STyc3EZUq/EPJKTeT1/SDdkv42f1X35M
        Kwnx7h1ox6iik2JZOBTwn4TdajWSTdCnrflBERIRuw==
X-Google-Smtp-Source: ABdhPJy8ryuL3BCw9hMm/5NTZWmr36I40dkkLmQ/Ajt7q/cXxbYe2hymUNmDHkhdO7xsvm0E319wYDL7TZ6lkrF+vfI=
X-Received: by 2002:a19:4301:: with SMTP id q1mr3259839lfa.96.1592612173404;
 Fri, 19 Jun 2020 17:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-9-guro@fb.com>
In-Reply-To: <20200608230654.828134-9-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 17:16:02 -0700
Message-ID: <CALvZod67=97-thcR0QhhazFChWZ5p=ZjFLXYNnpj0ft5trRgjg@mail.gmail.com>
Subject: Re: [PATCH v6 08/19] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
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

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> Store the obj_cgroup pointer in the corresponding place of
> page->obj_cgroups for each allocated non-root slab object.
> Make sure that each allocated object holds a reference to obj_cgroup.
>
> Objcg pointer is obtained from the memcg->objcg dereferencing
> in memcg_kmem_get_cache() and passed from pre_alloc_hook to
> post_alloc_hook. Then in case of successful allocation(s) it's
> getting stored in the page->obj_cgroups vector.
>
> The objcg obtaining part look a bit bulky now, but it will be simplified
> by next commits in the series.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

One nit below otherwise:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
[snip]
> +static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +                                             struct obj_cgroup *objcg,
> +                                             size_t size, void **p)
> +{
> +       struct page *page;
> +       unsigned long off;
> +       size_t i;
> +
> +       for (i = 0; i < size; i++) {
> +               if (likely(p[i])) {
> +                       page = virt_to_head_page(p[i]);
> +                       off = obj_to_index(s, page, p[i]);
> +                       obj_cgroup_get(objcg);
> +                       page_obj_cgroups(page)[off] = objcg;
> +               }
> +       }
> +       obj_cgroup_put(objcg);

Nit: we get the objcg reference in memcg_kmem_get_cache(), doesn't it
look cleaner to put that reference in memcg_kmem_put_cache() instead
of here.

> +       memcg_kmem_put_cache(s);
> +}
> +
