Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69684207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUIsyEnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgHUWl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHUWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:41:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B3C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 15:41:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so3534115ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCEF6wqc95cLrmB/oV3IZ67dACUQA3nyuwvULLWrblQ=;
        b=aUIsyEnWZLGtrHakZpo3Adlpynv8NvMuJ9J+SnnjASvqTaGNKNTC54dDARpOBO7EKK
         iggserf9ZQ3fDx/xDGLzPLlUuJDsjUg/IeDigqsrgXyoEQmPRRs/l7piUpHKO+4uwngm
         CkojfKcXW0cWdMnqL+2CAVH+L2M446/Ohai73Q699XWlOuX63VudwM8sly3sFUkEZMLG
         pusTDYlZcgX0u80JO32Cw1MnLSvQziEPS73Uv/OhqG9NqkPbMfmpiny5kb+kVNc0Hvjp
         0IQTS2wZQWpJZQkHVl/hCmaY+Yo/OPXEE4qsUAW/7AdiV49fW6NEQW7jgXJc+FyiK29I
         43Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCEF6wqc95cLrmB/oV3IZ67dACUQA3nyuwvULLWrblQ=;
        b=IqoI7p+9Ds51l9RBjov/y+16zT24pPGnpd83GuFOrpRz4WJbbVcA2Dmil6jhHpvTGj
         ArybZrFsBpkMbX/CRIvWYyHRTVqKvovl5ZJ429Xy7uWppLBQd5t9jdLDQR7abYkM0zv9
         SVKqrdIeHMQiKhxyiTtgW15YuBG2RyRW3ZIK+oPjTTVXsqhub0RF23saMjok2Ms9i/34
         V6ZEs/Z9e8tuzyn8pawmPHF0miTKin16LUrpmtextFj5VSEVhedivGjhlRlmBp4XYq+t
         B2J8qhkyxobQU7MWWkIIurbAUgfuLYiAEbxRYQOSQBZpKpkgiN28f8YUpDd78xpsYIEt
         7VhQ==
X-Gm-Message-State: AOAM5333DinLs6HyJlgN3AEn4huVmbAWhoemg4/IeROe3z0FoHhmnFqD
        w2UA1wGOjBNKXwLbdZls1GfxRWlRUZrZygMkJuV8tw==
X-Google-Smtp-Source: ABdhPJxAavBApZLnZJgIBEBEUhAPqDcRk1LqV3Ve1UUvn7RINl0zO9IW1qjmCcY+90sQgwoIJdCILpT6JoB2i1iB490=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr2526801ljj.270.1598049712869;
 Fri, 21 Aug 2020 15:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200821212056.3769116-1-guro@fb.com>
In-Reply-To: <20200821212056.3769116-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Aug 2020 15:41:41 -0700
Message-ID: <CALvZod79+g39SUbVA+=Z-e_6m7deE1QqA1p8ogKv+Qpn+SwuKg@mail.gmail.com>
Subject: Re: [PATCH] mm: rework remote memcg charging API to support nesting
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Schatzberg <dschatzberg@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 2:21 PM Roman Gushchin <guro@fb.com> wrote:
>
> Currently the remote memcg charging API consists of two functions:
> memalloc_use_memcg() and memalloc_unuse_memcg(), which set and clear
> the memcg value, which overwrites the memcg of the current task.
>
>   memalloc_use_memcg(target_memcg);
>   <...>
>   memalloc_unuse_memcg();
>
> It works perfectly for allocations performed from a normal context,
> however an attempt to call it from an interrupt context or just nest
> two remote charging blocks will lead to an incorrect accounting.
> On exit from the inner block the active memcg will be cleared
> instead of being restored.
>
>   memalloc_use_memcg(target_memcg);
>
>   memalloc_use_memcg(target_memcg_2);
>     <...>
>     memalloc_unuse_memcg();
>
>     Error: allocation here are charged to the memcg of the current
>     process instead of target_memcg.
>
>   memalloc_unuse_memcg();
>
> This patch extends the remote charging API by switching to a single
> function: struct mem_cgroup *set_active_memcg(struct mem_cgroup *memcg),
> which sets the new value and returns the old one. So a remote charging
> block will look like:
>
>   old_memcg = set_active_memcg(target_memcg);
>   <...>
>   set_active_memcg(old_memcg);
>
> This patch is heavily based on the patch by Johannes Weiner,
> which can be found here: https://lkml.org/lkml/2020/5/28/806 .
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Dan Schatzberg <dschatzberg@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
