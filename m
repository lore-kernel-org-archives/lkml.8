Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B872C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5CD206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xc5YNUMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgEVPmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:42:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628EAC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:42:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so13224623ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOYVOHpaIS+oIho1dCUDLjlIT96AiPQqcbd2UVpV+2w=;
        b=xc5YNUMinAG4CGXABpBRi7fN1jT3RAq5g34Fsehb7FeGfXYItR+jv9zdzFUbWBZgED
         LmniBIdug9ZVwtsM86rfNB4Ym0c53ixm9EKzBW+98lrn+8iymUA1pl2rPFTIORF5gQ62
         S7DQ9GAYdIyD0+h/PDFxltIl+vny9nvjNZwtDFWooA9AaFqDP1f1M3b8WEMP5ciTcCjp
         W9NaNLJ0XScz6f3UhpDiAU5ZGmdgvxMde4+OxowuByFtU+aSTB2XW+29FZ21ruR/AtlZ
         X2z7XizfkhRaPFBSCM5YrIriiEQ/BuEbJkBwj+XeDUcSN1pBzeruIIxoHJrH2wvAAVgG
         WYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOYVOHpaIS+oIho1dCUDLjlIT96AiPQqcbd2UVpV+2w=;
        b=liPhdbl/A2wNlvvVdchUhSpA9zYM/jxl/x1s39GCGRZtYGp42KU+mTKhln/HR4DaT/
         xZclwvpRWbSosqEWy9G16VFHoiwwbE1vV83LgkjJ+PDN8/SZutUK1WjmNlI1FQ5FaWQe
         f3/92/OJcHAMuFN4/a+Z+2XfBpe2m2wEkciXiAM2+Ru51LscGnCOS7pbkIo/4Wn6L4Xm
         I4RCsp/BePO66jbkrMFRswzeaqC6p0kUNtTnr3x80hd0iS6blbzMJQQrk0dnl7hKUa7Z
         +z9rTcv5jDQ4JNMb6rXjQpCPqOzMOURnFAJZ+9KWFbNq+Ow4OVpWfDqIKGiAKR2aod9r
         t/dg==
X-Gm-Message-State: AOAM530l7skN7KhTqoh7x+Cp6VdxkrIRjSaBKcr4qV+AGHN+ogDBdWSv
        dDeOSJbWKxPpZfWTRXDTpXBAZwdh4RUYhmdawq39NQ==
X-Google-Smtp-Source: ABdhPJxRJSZJBv5r7tYd2u0AUqK3zkVLdXL1DZDbhQE8M+i8GAUoeEfr4zqO0vZ1A56dhmdh581qQsP3Tbtb1mlvNY0=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr7582617ljd.102.1590162124742;
 Fri, 22 May 2020 08:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084127.12923-1-laoar.shao@gmail.com> <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com> <20200522114544.GA1112005@chrisdown.name>
In-Reply-To: <20200522114544.GA1112005@chrisdown.name>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 May 2020 21:11:53 +0530
Message-ID: <CA+G9fYvw+oY-EK1+FYCUAD5-UGD4MhBGJHasjF+L5nLtzL2GLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
To:     Chris Down <chris@chrisdown.name>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 17:15, Chris Down <chris@chrisdown.name> wrote:
>
> Naresh Kamboju writes:
> >This patch is causing oom-killer while running mkfs -t ext4 on i386 kernel
> >running on x86_64 machine version linux-next 5.7.0-rc6-next-20200521.
>
> I think I see what's wrong here -- if we bail out early, memory.e{min,low}
> might be uninitialised.
>
> Does this patch fix it, by any chance?
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d3b23c57bed4..aa902b9cbb79 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5046,6 +5046,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>                         memory_cgrp_subsys.broken_hierarchy = true;
>         }
>
> +       memcg->memory.emin = 0;
> +       memcg->memory.elow = 0;
> +
>         /* The following stuff does not apply to the root */
>         if (!parent) {
>   #ifdef CONFIG_MEMCG_KMEM

This patch did not fix the problem.
The test log showing oom-killer link,
https://lkft.validation.linaro.org/scheduler/job/1445128#L1194

Build images:
https://builds.tuxbuild.com/YqW37GVsCHf8ndxOT2z1iQ/

- Naresh
