Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA12C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56ED3221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywRwzmQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgDQKcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgDQKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:32:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F481C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:32:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h25so1474235lja.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqTZqGTsSmrCAsKabRRCDqcEbF//TC1XPh5bWqTeeJw=;
        b=ywRwzmQXj0N15QtED4mbKHHxNMxp+dKkqB02inJG6CliOcv/3OC2yaxGGjLQAjZp4o
         WnfZm8STb6DjwbMaTEQdFSGXkWWXZAtj+NzMJh7PpokgIRLzyZaqtGLhxYO1f/bJGA04
         T7ySiF2Q/AINsIukerlIXfdLOmY+p4+N5Z8HzL5tP2jDfG3J8emKgGWjWXct3zMFpwKb
         r9jrhH0xzGEZ5wje0oGTgCw/ilago7SPrxqfAblSyzrVSryjystpYW8/rKU2i8CRvgYd
         F5jvSYlWi0gbUVXIMfDFXOg8/gVjOm5RT0P7N39+0gG+vpJxNKYGYUKdZHsFF/x9HrcO
         D3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqTZqGTsSmrCAsKabRRCDqcEbF//TC1XPh5bWqTeeJw=;
        b=IlYN57ukJfFzZ08caGfuLIYM4MxS30n7k4VeFaagJe2QMIqRqi39UjIh0YGiaFH/Bh
         7yXpRldVS5dw3+YzsmNhWHKB72RPN90twDyT2JUwhFfXr/3qDBOs2maRkpENX/Sh5cut
         7uiH4H/5GOcPUHW3AND/hqOyZgnbgOFuKhKaxxKMei/0FoqA8ayQSUVtHpn5kmMMg3oG
         Fh+asZWY/6mKgyiIjVMefxr/YWvmFvcBxWoBGzK2WROOanEfUz+i++3+hz9S7qXcjo69
         0E8rZ554X2sLzvUaAUm8Er8ArbmJd7Sb6raU3fAyQLDUG8aXp2LgY20SvoZCRAZeqZg7
         QwSg==
X-Gm-Message-State: AGi0Pub9Zso0SFxpslv4nn1f3vGsMHVI/LRYD3fWaL7GMY05nS6kMSKH
        tRsIdtT2+7ZQ6Gd8NfX72jsWVXApXkLm0/4VGXBjfA==
X-Google-Smtp-Source: APiQypLAl4mqnWMVQC+ZN2inks+YZp11ZLS8VUKuXUOYfoUWZq/ZxzWXQvOW3gzuEVyBVbRMrGdjP4t68o56ttFlBNk=
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr1627862ljn.125.1587119542755;
 Fri, 17 Apr 2020 03:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200417082851.7d68e9ea@canb.auug.org.au>
In-Reply-To: <20200417082851.7d68e9ea@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Apr 2020 12:32:11 +0200
Message-ID: <CACRpkdY1UtTtRK7LaUxrBFRFooeT4s7h0GSKHNhsZrrMtJ5=3A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commits
>
>   fe5dfc6af3eb ("MAINTAINERS: Add Segey Semin to maintainers of DW APB GPIO driver")
>   49a369f94046 ("gpio: dwapb: Add debounce reference clock support")
>   cbabbfa160bd ("gpio: dwapb: Use optional-clocks interface for APB ref-clock")
>   fb7e1fc1b806 ("dt-bindings: gpio: Add Sergey Semin to DW APB GPIO driver maintainers")
>   7f51dbb7cab7 ("dt-bindings: gpio: Add DW GPIO debounce clock property")
>   179587eb757f ("dt-bindings: gpio: Convert snps,dw-apb-gpio to DT schema")
>
> are missing a Signed-off-by from their committer.

Ooops I hurt myself on the b4 tool, forgetting to pass --signoff to the
resulting git am foo.mbx... need to learn habits.

Sometimes I feel there should be some git am hook that just enforce
my --signoff on branches that go upstream so it can't go wrong.
Has anyone seen something like that?

Yours,
Linus Walleij
