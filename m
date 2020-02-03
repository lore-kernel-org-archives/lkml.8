Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F41C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B31C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XMlXhfYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBCQME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:12:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39994 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgBCQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:12:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so11833717qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UE45wlqzCyQq4DipWwUCK35G6cE2qZRpII/okw53kug=;
        b=XMlXhfYNGnmRvER9HoY+Xnnw0D/suIrufuWQl0h4duypoSxdwVuiLXbrkUforCoibD
         GhXuJfUSbCmHAbSs52G1+aKpEl//HosHAK7z3SPDVWiL7E3bfg5ga2YHl5EhbfOVb/Wk
         42hKzfJvQYHLzrf/TMCJncMuoJBOzMGImede+/RJtPCdi71B3DseyvtZuhB33n+R8h0z
         rAXOGvgRUOKUuBAbw7V7vbqJd/LpLzsfZHVO0X3A2FZet8CBICxWabi8x1aAzifsH0r7
         SjSbp316QZGdUO3NrYYOwcqIHyXad3g07ZO09bXhnjcvTNIhWzvzj3bqY9/H62YOptTB
         FasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UE45wlqzCyQq4DipWwUCK35G6cE2qZRpII/okw53kug=;
        b=s2y6UH6ndzFyQ0dLvaq+XKkyIR14iETnuEwz2n2sAxGKxZRObZ/wy/kpYqUvfnmfbv
         J3FLRs8klPwBzEcni/RAuKAYtEdia37KkSUXENLOjiI4C/iTkoPjFfZL//gLu/Qj+ZmL
         kAUyzRfQ/u+6jGA6tsRsSOpZriPqBigJMfPPLOFeWtuhd2px31ZI1dN+sxdelJEZodEj
         0ioq+baj5tIojieOpagTihslC8xpygUAv1Rt1iyuGfR+zw73ERlJk7u+FbXeUlhkowQs
         OZSgRurBVBHQmaTPUZ8i/nDoqVIGM7gAf7wmT29/2vp5MtZPx/pTwAjkxK5rdWzkXf+P
         Z/Rw==
X-Gm-Message-State: APjAAAU+0radARN4tag2b/XXbXuSsW6l6/uRF0gw9RgQqQjHWQntj2Li
        AGoLS2Tc+DFfL2iDXoWifd3elg==
X-Google-Smtp-Source: APXvYqy4dvSwM7XD81xosD/MUAnkK1M8AXFs0CyTqVihq91B3jNrdNGp6aiO98KFBVDey97WnRWJCA==
X-Received: by 2002:ac8:1e8e:: with SMTP id c14mr22792744qtm.330.1580746321918;
        Mon, 03 Feb 2020 08:12:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:c810])
        by smtp.gmail.com with ESMTPSA id i6sm9515899qkk.7.2020.02.03.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:12:01 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:12:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 08/28] mm: fork: fix kernel_stack memcg stats for
 various stack implementations
Message-ID: <20200203161200.GB1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-9-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-9-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:33AM -0800, Roman Gushchin wrote:
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
> In order to fix it, let's introduce a mod_memcg_obj_state() helper,
> which takes a pointer to a kernel object as a first argument, uses
> mem_cgroup_from_obj() to get a RCU-protected memcg pointer and
> calls mod_memcg_state(). It allows to handle all possible
> configurations (CONFIG_VMAP_STACK and various THREAD_SIZE/PAGE_SIZE
> values) without spilling any memcg/kmem specifics into fork.c .

The change looks good to me, but it sounds like this is a bug with
actual consequences to userspace. Can you elaborate on that in the
changelog please? Maybe add a Fixes: line, if applicable?
