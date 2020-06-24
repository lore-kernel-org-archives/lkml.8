Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C6E2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXNAQn0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgFXBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgFXBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:25:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65FDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:25:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so731253lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ym1pbvhecpjgkqBUHdG2jngAamnO8ZMTgtaxvGC8kU=;
        b=JXNAQn0JgEi7NOj8FqP/q4K0S7NkS/7ef+DDatTkE/hHyxYAHbsVnDE9mzYrDs+hkX
         9mShn9ffdkCCu8/U3QYDZ+AkPv/hOUT7dkhFN+JNrX65Y3wgHYGxm9j3jfBnnzUviybW
         Qbd44IEqMk4ZbczoGYdgIRY7AKtpbZwFEwNBsU5KGhdAPtEEq4JpdZvun7UaUALWah7K
         dviUIzGiwghBvkwszBPYodKzZwZ2MVz4LtcTxn82VoX6li+iuQ8nzjiwuVW8U1Ki+jRG
         BUZxhJQdzxCHoJW1sCDSuKGmOxKI0EJiEUeCJZRjk4mDCR4iC5G34i8WC//S/aIqzdde
         y1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ym1pbvhecpjgkqBUHdG2jngAamnO8ZMTgtaxvGC8kU=;
        b=J35uILOdkOSHBPSL090KQbEy3lxD+Zc95xKcE5sPW+svzsx5YPdsgrRf6qK8CHyU+N
         EznbmBmKFnLtz/ZXyP1et2JUyUaweK5TI54kQ4tLgnUrmnya5mm+DOL2nF1tNoBmU5Pv
         rq2FsC8Qn1CuZX2pe1U1gM5lGOxR+NP1bX+p6O8gglP+e3eFvEj6fkbViT+8KyJoOQ3Q
         kd2KSZ793pl2ytBAJBSUY5potujZJtXhNkWiEzoDu3pL30zTEcr9IbLx4U0/TK0j7ZpR
         l6/KGTY7da8HypiY8Meb4uWDWkfpKBwtrWLQ2gSwFOa/B/26osML3SJHYWfGeic/ARK4
         vrnQ==
X-Gm-Message-State: AOAM5318tRV2p59wCjU6614WIvzBqdCx+85rrW8XYeEFPxcyAjRezJ3W
        EEBEP0fUtHCb3JzeJsLosb5ThnK5mCEqv94tSnEOcw==
X-Google-Smtp-Source: ABdhPJyiAww+T1xHD4MOi+PiWUrYgooq+GRv77kONhLFxcRkhWS52y+8FVIf38NqpOBPsQVKcRktXBbVVST6VNDh0MM=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr12741935ljh.77.1592961928783;
 Tue, 23 Jun 2020 18:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200623184515.4132564-1-guro@fb.com> <20200623184515.4132564-3-guro@fb.com>
In-Reply-To: <20200623184515.4132564-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Jun 2020 18:25:17 -0700
Message-ID: <CALvZod4HuMHuSP9m=HW5cDTmCfpZ5he_2n4kDctF21WNwJwEpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: memcg/percpu: account percpu memory to memory cgroups
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:47 AM Roman Gushchin <guro@fb.com> wrote:
>
> Percpu memory is becoming more and more widely used by various subsystems,
> and the total amount of memory controlled by the percpu allocator can make
> a good part of the total memory.
>
> As an example, bpf maps can consume a lot of percpu memory, and they are
> created by a user.  Also, some cgroup internals (e.g.  memory controller
> statistics) can be quite large.  On a machine with many CPUs and big
> number of cgroups they can consume hundreds of megabytes.
>
> So the lack of memcg accounting is creating a breach in the memory
> isolation.  Similar to the slab memory, percpu memory should be accounted
> by default.
>
> To implement the perpcu accounting it's possible to take the slab memory
> accounting as a model to follow.  Let's introduce two types of percpu
> chunks: root and memcg.  What makes memcg chunks different is an
> additional space allocated to store memcg membership information.  If
> __GFP_ACCOUNT is passed on allocation, a memcg chunk should be be used.
> If it's possible to charge the corresponding size to the target memory
> cgroup, allocation is performed, and the memcg ownership data is recorded.
> System-wide allocations are performed using root chunks, so there is no
> additional memory overhead.
>
> To implement a fast reparenting of percpu memory on memcg removal, we
> don't store mem_cgroup pointers directly: instead we use obj_cgroup API,
> introduced for slab accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
