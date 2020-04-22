Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B60EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2956720781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLGEo+u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDVWU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDVWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:20:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C1C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:20:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g10so3055295lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RkYliGFMdqXvO717N2pm4NnCZwapAsCgxwoREIwOrQ=;
        b=CLGEo+u6Ol6OoAJw6QXk0qHvTJvCNzFarr5oZ0N0OMVK0XtleuSdVK7pspDWG+k8jZ
         Fm6/J0Sa0R+dGQWLaH2Zbx07U2d3gIJZb/HPrE7IkZdmhaPk23GjxGZsP3sxqcHhkuVA
         JFsolmPT4jwkqogLz/cwAuqgpFa1+OvRlp9T/mP0vAcqFi9KKYNHf8q8DT6m0kVrJ82t
         ETNo6nwSIlWJd3Fqek4NNLkYj1sNQgBMjr3ocYfmpru/Jzn4futMt2nX5p4XBcZb4SMq
         bxL7eaGouhPxxZIK/cYUP5Ge4aZsfSmKI5MYbgEpRXPj6Idx+OiBwCRD++V/dck67C/g
         FrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RkYliGFMdqXvO717N2pm4NnCZwapAsCgxwoREIwOrQ=;
        b=IeaQy4XP3r2LuLukNG4u54wCrcfX69GVsoRlPMQ7RJPP+HETbUXfoFUCLWdFYQOxzy
         E3IEdO1DzO0fY5Ob4qzGNjfgnnSXmpGQP6nxNWlPxo7VVGieR27tHnJ4M2e9A8rLdU94
         CzSUl0doXhV2dnz1i/L599T9EY1cAHKpA4gfRNCzBQAs4ogiXxQNbvmkHtoYKlpsgBxS
         OdA7EEcXmwMILoYRlXOBVU+aMNiRLAj08ooo2QLzRzfBXXS1XYUhWMZ7TXhbE66ClPpd
         bfgXyZl/IUIPZmBi9UoHhX76AUlpCXS1cm/vJSQvIWRvuVMhVKBfP2sDoq75pbWKjDGQ
         1/ow==
X-Gm-Message-State: AGi0PubhCg4HRs5/s5zBgKYSCYlbMDfUPgesK37+CQVKdI1OBQtrAIBi
        V8mDzabX0wIuY1rDJySCe/mcDyOIyXjG76fyswmBwQ==
X-Google-Smtp-Source: APiQypLuGzni3dbzxyWjvGmOnHKp8BVo+fq+dqIX0XL8GnwTi7ZNuCZ6m9ZR7aVz8TjHNTWYSEjuLpXd5DXELLsIdxc=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr424101lfr.189.1587594026577;
 Wed, 22 Apr 2020 15:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-5-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-5-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 15:20:15 -0700
Message-ID: <CALvZod6mHQZ=fK4F2az+11q2t8mBU7EWU_FedGrZ--sjwFTo3w@mail.gmail.com>
Subject: Re: [PATCH 04/18] mm: memcontrol: move out cgroup swaprate throttling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The cgroup swaprate throttling is about matching new anon allocations
> to the rate of available IO when that is being throttled. It's the io
> controller hooking into the VM, rather than a memory controller thing.
>
> Rename mem_cgroup_throttle_swaprate() to cgroup_throttle_swaprate(),
> and drop the @memcg argument which is only used to check whether the
> preceding page charge has succeeded and the fault is proceeding.
>
> We could decouple the call from mem_cgroup_try_charge() here as well,
> but that would cause unnecessary churn: the following patches convert
> all callsites to a new charge API and we'll decouple as we go along.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
