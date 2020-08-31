Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A07207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aH/j8WKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHaOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHaOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:41:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96746C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:41:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j15so3624504lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jdf7Yr1a6XX4TRwS1JHRRHr0CFyp0wrlJUOIn8FHr8=;
        b=aH/j8WKXZPdvikd5WEObfSDw9GR1wJDjg8Q3jQu4nRVY9eQMhZVxWM6/5we9KIEqbG
         dEL/W1lGnc4l5SckXCn8cshObUaR3qEffqA4aJ1jnqH+OHCZQA0TjM7SyTFMRscUPOqU
         p9+/ggGI6gxE5rfLwBkj2Pd9U7EfrTXd7A2ff4+FhWHr8PSG+gcNWLoibjGbSQTcHBNt
         kLxaT7IxEGAYoT1p4dkzBiY9HqNaZ3YL4qctWQ8QDjbfiqLje6MQtdUr0x5L25/dXVDw
         xx8fbfrVbGopBll7Hf8nNsmdFOuFyWnUA8itQlXufL86bh3cM9BfEEF1jBSp4pnucC7Y
         18FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jdf7Yr1a6XX4TRwS1JHRRHr0CFyp0wrlJUOIn8FHr8=;
        b=UgXZYpqgUsAkMWmCSi81yas/STj0N4kLkw+f/O6InAKgp5bnAQB0S5kB/5zTHGZsZX
         5kLq3yZYT50uIy0TrWSzDT+jJXi8umMuLMGmR7cp96Oe7CxBrtb3MoGY3E2cxeeUjymC
         NAPiYqVn+EmKMFFKd74Fi4/4ppXybCI/yMFW+eSpOOcM1+SohSHqjyHdCn602O7FuRER
         f/NTi+rUB+7SXzPEOUgR6vXdg2TGFWLqPILP+T2+j83xWPnSyyQ0XNdu+0+Lwd6xN2j+
         IGbrBDmRPbs0xjrdorKySq/ugYyMW8rVnwtPHAi3QpZI89ViL5dopp6dZD+ZAcuwE+3Z
         KIEw==
X-Gm-Message-State: AOAM53173R4UwAkzk8q4D0g+We2EU/m8M2dnkp+iPKcxxIfO1wbKDYC5
        bxeJ6xGqu0jaEp2Mabiq/NNw/RB8/CxXq0xfY5nMCg==
X-Google-Smtp-Source: ABdhPJzyliB5lE1nzTQObWc+yrnVQDwbEMzPDyzwKQjR4ExISbfjpW4peJBU8buMyH9dXJeEg+86459vcjM6z2maAYI=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr889283lfp.124.1598884876690;
 Mon, 31 Aug 2020 07:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 Aug 2020 07:41:05 -0700
Message-ID: <CALvZod5zQZR8_vSMCRC7bXv2Ou2A9YF1V9ZTRCmwuVW2TaWODQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
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

On Sun, Aug 30, 2020 at 2:04 PM Hugh Dickins <hughd@google.com> wrote:
>
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c contains a shmem_writeback()
> which calls shmem_writepage() from a shrinker: that usually works well
> enough; but if /sys/kernel/mm/transparent_hugepage/shmem_enabled has
> been set to "force" (documented as "Force the huge option on for all -
> very useful for testing"), shmem_writepage() is surprised to be called
> with a huge page, and crashes on the VM_BUG_ON_PAGE(PageCompound) (I
> did not find out where the crash happens when CONFIG_DEBUG_VM is off).
>
> LRU page reclaim always splits the shmem huge page first: I'd prefer not
> to demand that of i915, so check and split compound in shmem_writepage().
>
> Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.3+

Reviewed-by: Shakeel Butt <shakeelb@google.com>
