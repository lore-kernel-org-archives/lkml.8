Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4280C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30EE206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="zFqMJydT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgEMMgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbgEMMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:36:06 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C43C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:36:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so15975887qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XPrK4VVoXQ0vmjjlKF3mWEEfj4+VgK3r8tZECPQos5E=;
        b=zFqMJydTAPVLxNLXFDGmaVOy8rh6YFK1hKv2Qx0WWlU5242a2O1SoY314bSQ3vHLYG
         fnm+ll+8xNx0LDpF6ao7AIhPzgBKjsrAzDSVrxXrFWjn0wXikhgApqIaBZ6RRowBmUQr
         TUHGa7lNx1EMlc4ISPqhND0a1EIPh/7bboJjlqyL+qejWBjIlcT2We1UYz8lcIF8MLfW
         qfVBuPWRVXCRGYQqNlL/jtMkttkRSBjwdJyyusuu69L1QxXCCbZoUKdMgs67WIohRC9o
         wilWL6mdq85EgIOi/9ZWphJ3CgLHhOjTSLJM16IGS3GGtyZSM0LJFF+1GAyQb0+JP1J3
         cqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XPrK4VVoXQ0vmjjlKF3mWEEfj4+VgK3r8tZECPQos5E=;
        b=O69/ZjMtAIYKI9x73vswa+Mekw7KlTZkE9P8jr10GfH5Fh0AKDjKOCoBz1dhwE26Aj
         Pla9k1zIpN+lEAVpjKhNp6ppdqH8aQrUdKDlO7JSx0LY5KfncQF7m64zBJIYKmWRAT9P
         jtutcWJ8tze6fa15lXqQsG4iY8SmA/7qE6m2iUQ7EyMJxTCNpZ7a68s0s5pnL9h6tnuW
         LqQpAzIQSd1GMc3YzN7BIAqNoA/wBftgT9KiWdwJjO3jt7yveicpA7kf4iSTr7wFdLjp
         w8uGDUuFMNFMst6+JAvNb2Uuq8EiaWKeolFBi03jJaaGfQrGpni8YU1wwPLWDvsHE9DF
         nz+A==
X-Gm-Message-State: AGi0PubX/NRDTFIwmJkTfeIE4mVGx6vDFpDuDtF1JTmjflFdH64Rcooq
        9D6xiIxoH2oNHBX49rneo5NPOw==
X-Google-Smtp-Source: APiQypKyjeVvaBEXNHX6gs8IWZmhdLxlbCAn4XHSVARLevo9HOXc4orsg8JkQKHilUhQQLczQ8MybQ==
X-Received: by 2002:a05:620a:1509:: with SMTP id i9mr23815994qkk.445.1589373365539;
        Wed, 13 May 2020 05:36:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id v44sm12093056qtk.79.2020.05.13.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:36:04 -0700 (PDT)
Date:   Wed, 13 May 2020 08:35:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/19 V2] mm: memcontrol: charge swapin pages on
 instantiation
Message-ID: <20200513123545.GB488426@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200513113032.GA93568@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513113032.GA93568@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Balbir!

On Wed, May 13, 2020 at 11:30:32AM +0000, Balbir Singh wrote:
> On Fri, May 08, 2020 at 02:30:47PM -0400, Johannes Weiner wrote:
> > To eliminate the page->mapping dependency, memcg needs to ditch its
> > private page type counters (MEMCG_CACHE, MEMCG_RSS, NR_SHMEM) in favor
> > of the generic vmstat counters and accounting sites, such as
> > NR_FILE_PAGES, NR_ANON_MAPPED etc.
> 
> Could you elaborate on what this means and the implications of this on
> user space programs?

This has no bearing on userspace. It's just simplifying how
memory.stat is implemented. The output is the same.

For the full story:

In the past, memcg has done its own accounting to produce a breakdown
of consumers in memory.stat. When a page was charged, we relied on
knowing whether it's a file, anon or shmem page, and had our own
MEMCG_RSS, MEMCG_CACHE, MEMCG_SHMEM counters.

As the general VM code already does this type of classification to
produce /proc/vmstat, this meant unnecessary duplication: more places
to bump counters, more places that have to make sure the page state is
stable in all the right ways, more dependencies on when it's safe to
call the charge and the uncharge callbacks.

A while ago we added per-cgroup arrays of the vmstat counters and a
cgroup-aware accounting callback (mod_lruvec_state) that can be a
drop-in replacement for the generic VM code (mod_node_state and
friends). We already had some counters converted over to that.

These patches just do more of that conversion from private memcg
accounting to having callbacks into generic VM accounting sites.

Instead of testing PageAnon() and accounting MEMCG_CACHE/MEMCG_RSS in
the charge code, we switch __add_to_page_cache_locked() and
page_add_new_anon_rmap() to the cgroup-aware mod_lruvec_page_state()
to bump our per-cgroup NR_FILE_PAGES and NR_ANON_MAPPED counters along
with the node and global counters.

As a result, the memcg gets a breakdown for memory.stat without having
to have private knowledge of what a page cache page is - how to test
it, when it's safe to test it, whether there can be huge pages in the
page cache, etc. pp. Memcg can focus on counting bytes, and the VM
code that is specialized in dealing with the page cache (or anon
pages, or shmem pages) can fill in those kinds of details for us.

Less dependencies, less duplication, simpler API rules.

The memory.stat output is the same, it's just much simpler code.
