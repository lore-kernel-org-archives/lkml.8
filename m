Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41739C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103282080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IH12sAJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgH0V7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0V7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:59:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465AC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:59:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so8143167ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVBJKgtv1iibetL73LRoXtok8/V4hB+ZfdXFnvRXGf4=;
        b=IH12sAJg8v6bzG3oDO+EpY2xw6hug1HwrUC0SsDTCfrC590GxvUo5KAml9BPQ+MRlH
         AQC+MxY12YD1Q9Jlc7koXumjtj80Thyoi/1D7ry0RtVkS/ztATEE8Fc9/e4JbVQS3G2W
         QCjSur0oCdHdftsGdiJD9FqxuAzToRJRtHE7da6qN8lzUg07yb+hpLSfiWWBkjvpNK9o
         FuAuXhyy9KE/s5rOgDMHUICzE85Z4Sp8JO7Ng6FOCbgFvUxafHEVz9DJbb7Hf4QRPstZ
         fXxjUiLeXkaApdCevoO+YQp4j7ubJmzou2UAJhA4mKkO6so7smARy85wBfXiKl3D3Mmp
         MeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVBJKgtv1iibetL73LRoXtok8/V4hB+ZfdXFnvRXGf4=;
        b=kFHq401SWZQVABflmy3jf3DDzDVDi/bG62vxFv1MFbrHexYHFCcp3DLYGxCWyPuPnv
         8yC0hOBTmvWKR81SHyB0u3Ht7BsHlQjKa+jQUd6SWXYHuE7yhOXrhIWWs5C08AIkEqH4
         pbY2NBdnubTY/ymzjAINvICzb/K8NeyXzTWsq7CaRilXbjljObpF5X+rw91xDKPNDBfN
         KVQNAFyINSJxvV+2il4prJLfA7Nga0+dVlR+u3OZIGJGu0mWYgYvX6796FO3g4r2sbgN
         dWa7E/f6r/SuLk1BiIFvA6DCKQVenj/1/YGoJqKegEKbNR9XIQDjkYTDmCZoTYtk7QKc
         7Cfg==
X-Gm-Message-State: AOAM5311BWcHtA0C318SZ9x06V907FcKlZjGNanNUu62FQl/nQV7GT+J
        asNv97/4hBykDVi8s0uspOIqAXeLcvrDRR7qFJfbmw==
X-Google-Smtp-Source: ABdhPJzOo9PgEobHK8X5GAiYkmGBf8E1YvBdOfP74zzNTqV3ejOIMe30xqY6sCRKr0JbCmCXQ9JDUfF9jzJtV3dD67E=
X-Received: by 2002:a2e:2a04:: with SMTP id q4mr9882666ljq.192.1598565541451;
 Thu, 27 Aug 2020 14:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200827175215.319780-1-guro@fb.com> <20200827175215.319780-4-guro@fb.com>
In-Reply-To: <20200827175215.319780-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 27 Aug 2020 14:58:50 -0700
Message-ID: <CALvZod7p3Ju-OSoYPonfjWwVm9fgxbDUzPzvrenkEqPNPLD88w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] mm: kmem: prepare remote memcg charging infra for
 interrupt contexts
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:52 AM Roman Gushchin <guro@fb.com> wrote:
>
> Remote memcg charging API uses current->active_memcg to store the
> currently active memory cgroup, which overwrites the memory cgroup
> of the current process. It works well for normal contexts, but doesn't
> work for interrupt contexts: indeed, if an interrupt occurs during
> the execution of a section with an active memcg set, all allocations
> inside the interrupt will be charged to the active memcg set (given
> that we'll enable accounting for allocations from an interrupt
> context). But because the interrupt might have no relation to the
> active memcg set outside, it's obviously wrong from the accounting
> prospective.
>
> To resolve this problem, let's add a global percpu int_active_memcg
> variable, which will be used to store an active memory cgroup which
> will be sued from interrupt contexts. set_active_memcg() will

*used

> transparently use current->active_memcg or int_active_memcg depending
> on the context.
>
> To make the read part simple and transparent for the caller, let's
> introduce two new functions:
>   - struct mem_cgroup *active_memcg(void),
>   - struct mem_cgroup *get_active_memcg(void).
>
> They are returning the active memcg if it's set, hiding all
> implementation details: where to get it depending on the current context.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

I like this patch. Internally we have a similar patch which instead of
per-cpu int_active_memcg have current->active_memcg_irq. Our use-case
was radix tree node allocations where we use the root node's memcg to
charge all the nodes of the tree and the reason behind was that we
observed a lot of zombies which were stuck due to radix tree nodes
charges while the actual pages pointed by the those nodes/entries were
in used by active jobs (shared file system and the kernel is older
than the kmem reparenting).

Reviewed-by: Shakeel Butt <shakeelb@google.com>
