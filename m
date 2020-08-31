Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2CC207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYK5uN2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHaOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHaOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:44:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8794C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:44:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c15so3654767lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LO0Fe9S4KXntDSdPtGJ0g7vkmoOwVpiEPeR5HEYJGqs=;
        b=CYK5uN2cdn+PR1F+kdmzuT1zEVTHfVMmBiA8cTXpVQn9DRC+ZJaVejbpm21TqkNO3o
         g9I0P1rDgyPEpnLbyfL4lYLtTbIHpikbHvEHLOVFWlIT49rbPIGIifEjZQs1qvDYMPCv
         mRPgPXtftSSVxLGt3w97d9vsBVWrAgJeFVeFnPYQKthNEjF5a1CCE3J38KBc7D/dMf7O
         tRukyS/rk++VOyl9IJUtMJx1JTeK/wt1X+m5mDiF0FKxO0DQ1ou/r3ZEmZXd1cN6kaUP
         0D1JTuqRJFIB6NtzxK4RCqi7D4DX8ULJAf199cWTOZKeb0Gd7++pQ7IrRlV9LQGIoXEO
         n8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LO0Fe9S4KXntDSdPtGJ0g7vkmoOwVpiEPeR5HEYJGqs=;
        b=gAKzuf35uuTzaUmJ8/R7UByFexZGaY7e/R0DiXJxCtI9bDFJXrICVj8/MTgzDktE9W
         HKnoGQm49NS8fCCKbM/HmgZEFdf2aAkQ+BXLZhXby/ZMItXIrkIUdfdCRLbhCRBrNA+Z
         30vbrqUI+XLSPzcXZ4WnhRVT5fKyIJMiz2rQB/Lrs/hBdP5m4rbkZSL1gzu5oi/PFjck
         EKcOK99YGvE2JFxm/CluAxDzwyvGS+ZeZNRy1a8W7jM3KTLLpjs7qlkLz4jAdBvCLiZA
         nEd9s0vab0wrfJ+o3E8sNBDlBDMblAV2LsD/oZ35xLDnD+a4NbjO1c2Bo4n9oPa2znBP
         PHqA==
X-Gm-Message-State: AOAM532Fyfkp230HXoukc/IfbriWHl5BnKpNZVr6umVllewz4ByHOwSy
        MYBSfkGGfV/FncHAfmouVFwhX3yEvPAFxZQNvujYYA==
X-Google-Smtp-Source: ABdhPJwO4rm8CgWBhE1kUdAsFzVfjoQWIqLLSp92sStxvVNvA18Wt+IiMA3i3b0ha2ZJ6tsqC+o1QOEY4SVcpXebS4k=
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr850506lff.125.1598885084870;
 Mon, 31 Aug 2020 07:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 Aug 2020 07:44:33 -0700
Message-ID: <CALvZod793qTH_i82nrcFCuyXVW2YoDDqcRoXrgkEd2E2_7rTrA@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:08 PM Hugh Dickins <hughd@google.com> wrote:
>
> check_move_unevictable_pages() is used in making unevictable shmem pages
> evictable: by shmem_unlock_mapping(), drm_gem_check_release_pagevec() and
> i915/gem check_release_pagevec().  Those may pass down subpages of a huge
> page, when /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force".
>
> That does not crash or warn at present, but the accounting of vmstats
> unevictable_pgs_scanned and unevictable_pgs_rescued is inconsistent:
> scanned being incremented on each subpage, rescued only on the head
> (since tails already appear evictable once the head has been updated).
>
> 5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
> established that vm_events in general (and unevictable_pgs_rescued in
> particular) should count every subpage: so follow that precedent here.
>
> Do this in such a way that if mem_cgroup_page_lruvec() is made stricter
> (to check page->mem_cgroup is always set), no problem: skip the tails
> before calling it, and add thp_nr_pages() to vmstats on the head.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks for catching this.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
