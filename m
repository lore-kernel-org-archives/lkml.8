Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C126C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093E620707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UARv+KNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgFVQ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbgFVQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:56:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C070C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:56:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id o4so10048599lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G56zBNbNj4Y3AhZRviN3/Dliwnmszp2+kuGZcYcuXG4=;
        b=UARv+KNJ4IB6uvPhHnkaASaBO2vDIEAMREBIbByZVBFC0SPsL8qncmblpxRoI4JhYN
         ILm+FhPJQkpJwbeD0auf/LVMUJ3xxZ8g0aHv4vAlokd+dgstpyte3AuJDIZoFnK+DMRO
         Tb03VRZG77XLcq1guQ+3SH1IgIfRyqMHwejTPNXu9o+nDnqpLZqfJmXI/fki9tbO5xqA
         QeodAxelUumcXGY6AVNRpVSNNsN8GrcWs/SZjX+Zs58UN7nty71TfQMCBEDWyLM378YW
         37HUgm+71D1TUTxh4Ek8uRoPMHYAD3VINYLco9JXvyMnrpyVcjo90UXk8IR6+Eky1Gv1
         BlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G56zBNbNj4Y3AhZRviN3/Dliwnmszp2+kuGZcYcuXG4=;
        b=IpIK1iu8FYCZgwKT0lpJ0CecHZJlfjAz3f2+P4Jznkf+JnUW3YWS7wGCPVkQc73Kat
         pwYs3eL2x8kj/tl87IPCVqX1JJ4kDut7T8a7ddgsRl7W7Km/NttPcJd1WKcdrXSab+cT
         mxuIdY4VCK8PyIPCEErcB8+1Lr99GegeUJHTVEG2ArqTHwPZYe5gHeg6dHt0hTt9mfI4
         51QdlJKYmIWzEbpcni4mMg+6il747V0ZZIzzXV5WzFZwmgF3B9SO0l4AsxpNP4McW2qp
         IZVbcQvodpiVEn8eXLyBBa5dD+dCkSfDeOXXroEpfLuHelqDz+0Bjuu4s1mHVhhZbHAu
         zgwg==
X-Gm-Message-State: AOAM530ufBAe0RBkwRxflBI0PFiso+m+n4xuwm37cHBTIvCbkDu8hV91
        WUksQofU7NXnpUlcpgKjlFjHXrFIFUSaqZH9Uxt6tg==
X-Google-Smtp-Source: ABdhPJx+G3gCV2EIKYJWvVKwOMIN3Vwwb/ohIo/VPRgtLAyZMxdbSuPNlS7zIdjKZJLVvxtayYF2h3DUTcApcYcZ3w0=
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr10462732lfg.33.1592845012258;
 Mon, 22 Jun 2020 09:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-13-guro@fb.com>
In-Reply-To: <20200608230654.828134-13-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 09:56:41 -0700
Message-ID: <CALvZod6xjB6kioQ8uRT3VoMQYmT-b4Z-wue0CPim3J8u12KZtA@mail.gmail.com>
Subject: Re: [PATCH v6 12/19] mm: memcg/slab: use a single set of kmem_caches
 for all accounted allocations
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
> This is fairly big but mostly red patch, which makes all accounted
> slab allocations use a single set of kmem_caches instead of
> creating a separate set for each memory cgroup.
>
> Because the number of non-root kmem_caches is now capped by the number
> of root kmem_caches, there is no need to shrink or destroy them
> prematurely. They can be perfectly destroyed together with their
> root counterparts. This allows to dramatically simplify the
> management of non-root kmem_caches and delete a ton of code.
>
> This patch performs the following changes:
> 1) introduces memcg_params.memcg_cache pointer to represent the
>    kmem_cache which will be used for all non-root allocations
> 2) reuses the existing memcg kmem_cache creation mechanism
>    to create memcg kmem_cache on the first allocation attempt
> 3) memcg kmem_caches are named <kmemcache_name>-memcg,
>    e.g. dentry-memcg
> 4) simplifies memcg_kmem_get_cache() to just return memcg kmem_cache
>    or schedule it's creation and return the root cache
> 5) removes almost all non-root kmem_cache management code
>    (separate refcounter, reparenting, shrinking, etc)
> 6) makes slab debugfs to display root_mem_cgroup css id and never
>    show :dead and :deact flags in the memcg_slabinfo attribute.
>
> Following patches in the series will simplify the kmem_cache creation.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

This is a very satisfying patch.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
