Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3FC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1297022B4B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWIQWpSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGRRYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgGRRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:24:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F22C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:24:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so7842529pjg.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iCm2YtXH023pz1F7fKyIw7mxMySdID8uzb2LgkkHspE=;
        b=GWIQWpSx/gXpm4+29AvUW9eiPQ+/bRdxbw27V8hPqrw5tlmrv+HzIQE/VmfmBAv6zB
         B3CI9b8nv/s9i95x82s+QBLvNBBRCnAon3Q3DkK2mnqrvmO1GZqS2QGM+5QAnB3QXEga
         XEUiP1kbW1sI36lb9+Yp/9tBF2nN3OVRSxceRRFYFJ5Z+T2rTj+ApLMQWBJ8hg8/kyq1
         fFhWtAw6iFj9UKnWqSvD28GCvTI1MU8gkL8KvtnwTTCQPkOd0pBrw3qkq4jU1lyf3qDs
         pPsl4vWDcuDmWebotIVU39nia5PdmQfICUZV3u/32c7SXoiRaXU/9qwWVuVk3prul59+
         M0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iCm2YtXH023pz1F7fKyIw7mxMySdID8uzb2LgkkHspE=;
        b=tPYK03DKlHHejO+O92iBppcH4t0cxg7L4cwI2JI3VGmCceKwss9owuL3j58uvcadQ1
         IvYdghbCkokVWq8rDo18LQdsfbVvUO/KJxIAOVOnf1sVrPnXxitQIhqjcTeslKQZcOYO
         HC8Sr+aQglLe5qab921BSVAsmUTYnOZfnoL6FNqOQULeykScfIKmgMfoMe3SsnGXzWXg
         gw3NdeB9xqw6ko1P5z8t7XB9hOOcFVkhKZ9w+duicV+if8YUcJ19ExazmPvd50tywK/C
         xiwaE4YCweQwO7s5d1ZiAu9oquKH4v4Th6erN5AB6dDnRjwof9q5Rgh7M/2kx2Un4F+k
         MB5Q==
X-Gm-Message-State: AOAM533CmZN7OFQiaMKmvIBHmNORI6KZjRRNK2eN0SkjwKRjAyL/8MqO
        fkj2CFD9OlVQW94PPNFK2h0=
X-Google-Smtp-Source: ABdhPJwuy41SbHQ1FpBg+wbrIZOW4OWZmRXhSq1sgPl5lPAxEa2yWQybDC+9aZgF3MGapHKIBxZP9A==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr11609572pls.273.1595093090529;
        Sat, 18 Jul 2020 10:24:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u26sm11252251pfn.54.2020.07.18.10.24.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 10:24:50 -0700 (PDT)
Date:   Sat, 18 Jul 2020 10:24:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200718172449.GA48060@roeck-us.net>
References: <20200623174037.3951353-1-guro@fb.com>
 <20200623174037.3951353-18-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623174037.3951353-18-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:40:35AM -0700, Roman Gushchin wrote:
> Instead of having two sets of kmem_caches: one for system-wide and
> non-accounted allocations and the second one shared by all accounted
> allocations, we can use just one.
> 
> The idea is simple: space for obj_cgroup metadata can be allocated on
> demand and filled only for accounted allocations.
> 
> It allows to remove a bunch of code which is required to handle kmem_cache
> clones for accounted allocations.  There is no more need to create them,
> accumulate statistics, propagate attributes, etc.  It's a quite
> significant simplification.
> 
> Also, because the total number of slab_caches is reduced almost twice (not
> all kmem_caches have a memcg clone), some additional memory savings are
> expected.  On my devvm it additionally saves about 3.5% of slab memory.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

This patch results in:

{standard input}: Assembler messages:
{standard input}:140: Warning: macro instruction expanded into multiple instructions
mm/slub.c: In function 'slab_alloc.constprop':
mm/slub.c:2897:30: error: inlining failed in call to always_inline 'slab_alloc.constprop': recursive inlining
 static __always_inline void *slab_alloc(struct kmem_cache *s,

and many similar messages when trying to build mips:64r6el_defconfig
or mips:defconfig. Bisect log attached.

Guenter

---

# bad: [aab7ee9f8ff0110bfcd594b33dc33748dc1baf46] Add linux-next specific files for 20200717
# good: [11ba468877bb23f28956a35e896356252d63c983] Linux 5.8-rc5
git bisect start 'HEAD' 'v5.8-rc5'
# good: [4d55a7a1298d197755c1a0f4512f56917e938a83] Merge remote-tracking branch 'crypto/master'
git bisect good 4d55a7a1298d197755c1a0f4512f56917e938a83
# good: [e63bf5dcce255302e355cb2277a3a39c83752c92] Merge remote-tracking branch 'devicetree/for-next'
git bisect good e63bf5dcce255302e355cb2277a3a39c83752c92
# good: [94d932ec3afb923efd8c736974f8316413175a5b] Merge remote-tracking branch 'thunderbolt/next'
git bisect good 94d932ec3afb923efd8c736974f8316413175a5b
# good: [5ddd2e0dbe8fceb80b0b36bd38a32217be7a04a5] Merge remote-tracking branch 'livepatching/for-next'
git bisect good 5ddd2e0dbe8fceb80b0b36bd38a32217be7a04a5
# bad: [40346f79983caf46fb92f779b0353422d43580a9] ipc/shm.c: Remove the superfluous break
git bisect bad 40346f79983caf46fb92f779b0353422d43580a9
# bad: [0b917599517f71ddef5f7274a8199a33cecd49b2] kasan: update required compiler versions in documentation
git bisect bad 0b917599517f71ddef5f7274a8199a33cecd49b2
# good: [7822c5f77725d5bf4ea48f155b0aa3827db19423] tmpfs: per-superblock i_ino support
git bisect good 7822c5f77725d5bf4ea48f155b0aa3827db19423
# bad: [c5b15b89803e3ed2810be285def5f4836e5ee629] mm, memcg: reclaim more aggressively before high allocator throttling
git bisect bad c5b15b89803e3ed2810be285def5f4836e5ee629
# good: [2b6d98a0b0cb5ff828228c6a094813c4919727da] mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
git bisect good 2b6d98a0b0cb5ff828228c6a094813c4919727da
# bad: [d32b702628530c68b4147d410b4cdf21610e9f93] mm: memcg/percpu: per-memcg percpu memory statistics
git bisect bad d32b702628530c68b4147d410b4cdf21610e9f93
# bad: [b109396be9be1b8fd91fa4c70bd73a0e93722274] percpu: return number of released bytes from pcpu_free_area()
git bisect bad b109396be9be1b8fd91fa4c70bd73a0e93722274
# bad: [6cee58aca5d334ee8195a711e4eb61a05e5f7eb5] kselftests: cgroup: add kernel memory accounting tests
git bisect bad 6cee58aca5d334ee8195a711e4eb61a05e5f7eb5
# bad: [2528f5d4f3c139035dc3adcbfb6c63ca14c840f0] mm: memcg/slab: use a single set of kmem_caches for all allocations
git bisect bad 2528f5d4f3c139035dc3adcbfb6c63ca14c840f0
# first bad commit: [2528f5d4f3c139035dc3adcbfb6c63ca14c840f0] mm: memcg/slab: use a single set of kmem_caches for all allocations
