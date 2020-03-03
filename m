Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86275C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D25920866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuPLToiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgCCXyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:54:37 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46330 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgCCXyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:54:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so194280oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 15:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/AZ7U0KHmcr9QXvwZlQmeLdBD0j8SEt/BJmgUku3Ig=;
        b=BuPLToiByk/bx7Wu2BMsoB3elyNG+L/DRg5LKFbkWa6X6b0EwIvfkdejfsQ5zJmGk7
         aI0NT/6ojh5joNirrWv/cYnjAZKUHbUxjodu3BQBfXaOlnxsaDgcZmgz33RuCyOl41N6
         ApY08xTTc5Pp82cNM848Bd1K7V/F2GoBZFsDbxeHv5jv2aKG5bxfNwFCTKn+zdj/baC1
         lEQ6mtT1ul2femrlG0iGDgfCwSQAkTMRDzBCTCEE5dAOJtPCPZYvK8pQ/mu7/OhBNNsz
         aIcphStoDNK76S5JPz/wdMl7GkLFrbrruHkrHPsu1/oT8QYdMs4VimVxtYIn5KsKOclI
         2Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/AZ7U0KHmcr9QXvwZlQmeLdBD0j8SEt/BJmgUku3Ig=;
        b=CTHng49JN71PnfSa8vBMhfAV7nHrUBmgWyFc5DTg1HJMqXJ9Rce4X9n7LjGHwnDlEr
         HXFJPIjUUc/nFh9z9BZjllhJcKPcbrfUJgOmgvmJTVf2ptnurla2R71BjpH/fDrw6SCM
         KxOu0A1fBD+uU2PjtC0PWd1nOsoG5Xirx3jDfip3woNEPykWG4atcXwspeeQkncWaACU
         eqUC0Z0VXnXeDUUl2WJQsoXRgK4pxZC7jgu0oTkpKSssrCcnNJ9AVX55S3Ab7Mvvzvpf
         IgMtWIJyHX26yBB7tdtMQVwOxNMzQd3RxY+LQLWAHKgoP4Nxq2nBKOddhYHG7jYU9DG+
         vFoQ==
X-Gm-Message-State: ANhLgQ36O6Xun1XkhQTdo51dfxolb9t4r7mQI+NWK0syw4orflgv/unE
        MrS/EM75rgqw2gi9FxU2wIRGZSeCldD977XlVywDAQ==
X-Google-Smtp-Source: ADFU+vvMae7IcKXiyLTUwR+cYqi/whefWdi0hnRgoORjgCw4UX0cLXu/XpZOSZnamdQslkSPH1Io7MPYVuJLg92ghas=
X-Received: by 2002:aca:3bc6:: with SMTP id i189mr6540oia.142.1583279675263;
 Tue, 03 Mar 2020 15:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20200303233550.251375-1-guro@fb.com>
In-Reply-To: <20200303233550.251375-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Mar 2020 15:54:24 -0800
Message-ID: <CALvZod5c_B3akg75UmzS-0pUAmBL_9-xmztw3gEkVLZMwgPs3g@mail.gmail.com>
Subject: Re: [PATCH] mm: fork: fix kernel_stack memcg stats for various stack implementations
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 3:36 PM Roman Gushchin <guro@fb.com> wrote:
>
> Depending on CONFIG_VMAP_STACK and the THREAD_SIZE / PAGE_SIZE ratio
> the space for task stacks can be allocated using __vmalloc_node_range(),
> alloc_pages_node() and kmem_cache_alloc_node(). In the first and the
> second cases page->mem_cgroup pointer is set, but in the third it's
> not: memcg membership of a slab page should be determined using the
> memcg_from_slab_page() function, which looks at
> page->slab_cache->memcg_params.memcg . In this case, using
> mod_memcg_page_state() (as in account_kernel_stack()) is incorrect:
> page->mem_cgroup pointer is NULL even for pages charged to a non-root
> memory cgroup.
>
> It can lead to kernel_stack per-memcg counters permanently showing 0
> on some architectures (depending on the configuration).
>
> In order to fix it, let's introduce a mod_memcg_obj_state() helper,
> which takes a pointer to a kernel object as a first argument, uses
> mem_cgroup_from_obj() to get a RCU-protected memcg pointer and
> calls mod_memcg_state(). It allows to handle all possible
> configurations (CONFIG_VMAP_STACK and various THREAD_SIZE/PAGE_SIZE
> values) without spilling any memcg/kmem specifics into fork.c .
>
> Note: this patch has been first posted as a part of the new slab
> controller patchset. This is a slightly updated version: the fixes
> tag has been added and the commit log was extended by the advice
> of Johannes Weiner. Because it's a fix that makes sense by itself,
> I'm re-posting it as a standalone patch.
>
> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
