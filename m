Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBDFC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD11207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeXPIm+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHaOkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgHaOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:40:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F55C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:40:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so3976676ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPSqj5hFIPGTyO7lh981GDp+TXnOtHBASn3RvL7Epes=;
        b=SeXPIm+AHj0Qf+3vNfhXciscqUdpDnei3CTwlmJ3ECw+JJX62FZGyZj34aJbxF7MHT
         A7t6pHhnVdftJTMq/p3NFn6gNaqNb9bp4eg47QKNZveAf9BB3De0o8nrD3u8FtYU5LwF
         roK2Zbvn8/jO2c8Wk0lHgVBDxhWFxXS4/8sOU/JXCcI+5QlBrOu0dbKspkGoDqklfmJl
         OzWlofbJasZYGNIkUZMK6hGOVqYJrjpKx2C/8jOuR91QjD32jia8+NH+cInBQjcWeVMk
         ogfwev8Aq6R1byneK54x81HVJD0zI6VrtqGL3n4q55KYXjaZtYVSezvabxhm122BhczJ
         7dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPSqj5hFIPGTyO7lh981GDp+TXnOtHBASn3RvL7Epes=;
        b=BvhMHYsn3/T5OAxNU5DLvoYERGSmknUj/MkNUQM16NAuYm/SQ6401cJxJ81HKcXESq
         y+y8T6337+LJ8XwgvpXYBuwQ3ghJNWBcLs5GqMy7/fEx6cTuf0e1Xi+cS3AlC0b0UVDt
         ve0tocu7WWqVi/vqhY3bKD9PNhsDQ9GLMzUmOZFaUmwiU3DOLkef+GdlGz/QLa9sfvJb
         jHRmmD1Qoy1MOwH7LmbqouDfhBjAfhOM2jciPCZvzl/qLrlj0uRMDkI4pWQ3YkLqVgbC
         p+YHFpjjjt0pgkIqMswiJC4VL8nngl6KzzS5IhIBB7c3PYk7QzdQAuLOl3KF8gauFn7D
         VJyg==
X-Gm-Message-State: AOAM530DFmxZtmCa5Efbea87xsFY5a5CBZK51pKB0WJwdZToJCuq7ifD
        Bz09NVBmMHTSJV4eynNAtTlAwmYYkszX6Y2/U2Hf7g==
X-Google-Smtp-Source: ABdhPJxKhqneFyPz1YbBKIJfjdrx6iMgdDyxAGp2l4ViVDxHjMNh4ZG4w4LWplUEZzwSRj7P5fWrO5fjBZkCAaIA7PM=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr859612ljj.270.1598884818405;
 Mon, 31 Aug 2020 07:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301358020.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301358020.5954@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 Aug 2020 07:40:07 -0700
Message-ID: <CALvZod4nV4pwqx82JZr5MqV1e5i1zwb_d+sL-=VpftMJT_9mjQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] ksm: reinstate memcg charge on copied pages
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 1:59 PM Hugh Dickins <hughd@google.com> wrote:
>
> In 5.8 some instances of memcg charging in do_swap_page() and unuse_pte()
> were removed, on the understanding that swap cache is now already charged
> at those points; but a case was missed, when ksm_might_need_to_copy() has
> decided it must allocate a substitute page: such pages were never charged.
> Fix it inside ksm_might_need_to_copy().
>
> This was discovered by Alex Shi's prospective commit "mm/memcg: warning
> on !memcg after readahead page charged".
>
> But there is a another surprise: this also fixes some rarer uncharged
> PageAnon cases, when KSM is configured in, but has never been activated.
> ksm_might_need_to_copy()'s anon_vma->root and linear_page_index() check
> sometimes catches a case which would need to have been copied if KSM
> were turned on.  Or that's my optimistic interpretation (of my own old
> code), but it leaves some doubt as to whether everything is working as
> intended there - might it hint at rare anon ptes which rmap cannot find?
> A question not easily answered: put in the fix for missed memcg charges.
>
> Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.8

Reviewed-by: Shakeel Butt <shakeelb@google.com>
