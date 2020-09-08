Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48382C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0524820738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfZeBpwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgIHPQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbgIHPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:14:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75FBC004597
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:03:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so8467626lfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35ffxxsxZE/p6QPZ+y6QCPHa8SJQuBpKbrJ3nN8f7Do=;
        b=SfZeBpwGk5EdXuctT8Rfu5FaUAR8dmQYobfsnrAQ0U51z5DyNExlZifizNW/Z+KpE6
         Y5xfsLpgTAbhABsXDfSIw+0PUmYj4zBbosX2YpIguoq23vV+/t8rVH8zf8QhZwwBB4fZ
         ykv4ddJ9jzXCMoA+119I7ywtCr4Wc5U16/6e44YOhqIcmQYaiHIvPZHd6ILKLyyCOj0+
         5e8GJdKA+qeEBL1qIbYiz+Kt8DvQcDvpS653F35kl/ec94nvVv6BONeQGYiZhMcozk3y
         NiPDI+XUgag9CcRj2z6ntZVpum8MWu5cfG37rKhQN0T/FQ7RYinWD2pGlsMnw709qSoG
         3RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35ffxxsxZE/p6QPZ+y6QCPHa8SJQuBpKbrJ3nN8f7Do=;
        b=BPw0RetnmwjjnXs97VeFGkvvcycGoOiyqfnvG4mB+Iwn7rXwsXX0x3RURuYWyhrpJL
         ymlhoF71DUvQBc8c6LB+7hlqABIig0PHwJZ8sI3sNpfJJtWyV6FeiuwvdJ5KhH8OI3SF
         h9HYCesw+L2gP1a821coQ3u6SknrXYiHtfK3BFMvl2LiM2XK9yLG/nRAAJvFC6F39ubL
         /AokCzCr1mZDuVkOWTfRKdkLSaY/yEe2qfkCZtFwKxuNPBSIA3hKoCJVZIIF1SmVi+m2
         umw73JCwS2oF6pwqfPc+IM0Tif7BvRjfp9oCBZLp5IhkOHjtAH7d/65ktz6JACUCh8mU
         Ty1g==
X-Gm-Message-State: AOAM5316GCD/0YRNEzYvG8rFlwn2AoQaz+PwI+LR6yyPK+g4ShfaoJyg
        pox/mmuJ1CMnZl5udvQJVMMtJ0RTcL0yt9H34/ZIcQ==
X-Google-Smtp-Source: ABdhPJyloY+0ffwnRt4valQxwgqq+18FVfS+W8CEn6xuoIUFjrD4ZGBo6n6WZ3bGrhD9AIi2w/koBpPRBihOXvRliFk=
X-Received: by 2002:a19:6b17:: with SMTP id d23mr1392055lfa.190.1599577429182;
 Tue, 08 Sep 2020 08:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200908205659.361b0a1b@canb.auug.org.au> <ddc76403-4b00-66ba-43ea-7889b9a32bb5@infradead.org>
In-Reply-To: <ddc76403-4b00-66ba-43ea-7889b9a32bb5@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Sep 2020 17:03:37 +0200
Message-ID: <CAKfTPtB-br6iKAMnofbPEmPVF-fpQpjkbXtfTcNkNzbc1Kdtug@mail.gmail.com>
Subject: Re: linux-next: Tree for Sep 8 (sched/topology.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Valentin as this seems related to the patch "sched/topology:
Move sd_flag_debug out of linux/sched/topology.h"


On Tue, 8 Sep 2020 at 16:48, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/8/20 3:56 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200903:
> >
>
> on i386:
>
> ld: kernel/sched/topology.o: in function `cpu_attach_domain':
> topology.c:(.text+0xf03): undefined reference to `sd_flag_debug'
> ld: topology.c:(.text+0xf4f): undefined reference to `sd_flag_debug'
> ld: topology.c:(.text+0xfc2): undefined reference to `sd_flag_debug'
>
>
> Full randconfig file is attached.
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
