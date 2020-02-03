Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90A2C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89092086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="D0HqVX8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBCTuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:50:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46299 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:50:51 -0500
Received: by mail-qv1-f68.google.com with SMTP id y2so7375973qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JkD/cmKgVjvJlz/chODMXHldUAezWfjEz1crchIilbE=;
        b=D0HqVX8rRbpc4IzpqW25Gk9bjTIyvGbGYetkvw/RwCmCIqfcOw8EVpr7YFX3GEFZcp
         6ZS1B2GGkxKcJYrsn+Xq4k6aHTHS+HBr/qCyVhEaLF2AATpxfIJsee+0Nnv+NaAqxC4x
         N7C9I2+16X32dpCYRt1mBSH53WEUVpouETToOgMfYUQ4UfI4cmiTg7rZEdF7Ao39uKN4
         4Id4zIGnV7kRpHUY1N7/Bh9XPiy66Vn/GJdDeTicwg77mbZfCttn2TcL3A/sAyUJEDPA
         yX576BqEXKqfp9KFDDKudOg1ZKdM4xjN6wSxswAZ3PdL6D4REh62T3oDqLyM8TQ22oEz
         KThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkD/cmKgVjvJlz/chODMXHldUAezWfjEz1crchIilbE=;
        b=INJp59WMypzftY30TnFyDUW2E9TTgKPsAXKkwFWd/ECO9wEZzNiuj3vonaVTBmseWc
         2PpDyg+sZyPW3F2v3Pdl1sQ+P/91oA1W9KOx2nJ1KJxMrXx+wUo5WuZGC0GOYbIwUmkP
         uTw759zTULsbVs4XXvz2jJ0d6aUYvtT3f+b7X/dHS1CIk6tOQAKNSqp3ErVtipefeg4S
         k4bYL+W3r33UY+K5i5EuKxMoYzlAyvoF6fXw+7QVzIgJjd90/ieCzgzdX0PIs4/wpILb
         RM8xz53U8AOYsLH5w+9uIOsBNAhRpoz6DWX4crvXFT3oakthLonpyLGwqp49qSnLe9Dv
         BIKw==
X-Gm-Message-State: APjAAAWi/3vyz6j9aSESe+7X8+dUp/lTqyfs4GMA1seQZLdZ0XUE4qCp
        b3ZQ6UnvaZyrTkvsqWxwQXN4gA==
X-Google-Smtp-Source: APXvYqwbuIXO8OPwibdyKO2L/CKGknuXkY8tzebGCWk45IElHKm9B5GgSBi2flYSqXhDle/vy6Y+eQ==
X-Received: by 2002:a0c:f485:: with SMTP id i5mr24637963qvm.8.1580759450480;
        Mon, 03 Feb 2020 11:50:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id n4sm10348107qti.55.2020.02.03.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:50:49 -0800 (PST)
Date:   Mon, 3 Feb 2020 14:50:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200203195048.GA4396@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-22-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> This is fairly big but mostly red patch, which makes all non-root
> slab allocations use a single set of kmem_caches instead of
> creating a separate set for each memory cgroup.
> 
> Because the number of non-root kmem_caches is now capped by the number
> of root kmem_caches, there is no need to shrink or destroy them
> prematurely. They can be perfectly destroyed together with their
> root counterparts. This allows to dramatically simplify the
> management of non-root kmem_caches and delete a ton of code.

This is definitely going in the right direction. But it doesn't quite
explain why we still need two sets of kmem_caches?

In the old scheme, we had completely separate per-cgroup caches with
separate slab pages. If a cgrouped process wanted to allocate a slab
object, we'd go to the root cache and used the cgroup id to look up
the right cgroup cache. On slab free we'd use page->slab_cache.

Now we have slab pages that have a page->objcg array. Why can't all
allocations go through a single set of kmem caches? If an allocation
is coming from a cgroup and the slab page the allocator wants to use
doesn't have an objcg array yet, we can allocate it on the fly, no?
