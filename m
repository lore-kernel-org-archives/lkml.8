Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD843C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 22:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D36520727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 22:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAjVbcAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgEPWgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 18:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgEPWgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 18:36:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95AC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 15:35:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so5940064ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojEx/IuaCeSKl9dRzHTqbsmjCdnPX9Gd1n5eUMrsf6M=;
        b=JAjVbcADzxZkX/Q9hYkJyomMRdTOJf00a9W3t+vXoqLmEMBqDEC7mhW36NzNVaCP1b
         fOClknEqOrOMON9fxP6KqFVN6LaC0xmFLhaA/jkcXyZtggHuF3gQDyHCuOzZrkP5OHw/
         Zf07d/YRPfmnlMdTYBcFLj1AreaT2nGSG90e942XyELtlrm57Wy1geeB+JYwT+LSi4AF
         ktCg9U466UEeAGkcu++Yo+YcrlViEBVBRSZkoa4pplU8dag4LG3Br2IeZjDVz7Y/3Pr+
         RauQC0Sq1+9MypuJ0ayG38Gt0/+xjXawcGnpc1PYS2tklbxy1NWEQvCE92pCofiWJDgR
         SF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojEx/IuaCeSKl9dRzHTqbsmjCdnPX9Gd1n5eUMrsf6M=;
        b=shxC7E9OADV4exiyYGnJBda4GaSnMmsoUBEf9S18+Lu4/53XQ6rsoG8UTiQqDmJagM
         JcV1lqkf4HsBlyp3ihvQF8WudpU8RmJ0SSihrv64NnYJo34ZDdBFs118gDlfdVcQRpUd
         if3hKNFvkn3w8NHKFF6hiJgqpuj9LMxhoLH+2XjQWhs6q6II3z7vPTE7by+8ycUDQQUV
         RdHOflJXTuNGJdgF7cZsoTGgUzmxa6e6JEs4txmZbSUp+xA8poq0acrWU6jjEu0pmi5d
         37Yj7Xi7cAG3pZmGK5lN9oW2eS1zGGNek5wbJjODhGzuKI3Z27jGUrUNfuKkLx03ikWY
         VT3A==
X-Gm-Message-State: AOAM531rwvXHcJfzkm7cV0IJIFGwMK87MqS95ePWYcRyUNbFkl9HHx73
        OyxBwcs42XV8o/WPObCCTcYv+OngrgnqMfKP5rU2TzM7
X-Google-Smtp-Source: ABdhPJyww2Ss10TFjQnw3rjcwTRh+N7rxxkevxyjMZ55BpomUMXpG4iVUjePGN7YpviRN2j8Ji6HIOVBA8z0RrSBLvE=
X-Received: by 2002:a2e:9795:: with SMTP id y21mr6097660lji.115.1589668557959;
 Sat, 16 May 2020 15:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200516021736.226222-1-shakeelb@google.com> <20200516.134018.1760282800329273820.davem@davemloft.net>
In-Reply-To: <20200516.134018.1760282800329273820.davem@davemloft.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 16 May 2020 15:35:46 -0700
Message-ID: <CALvZod7euq10j6k9Z_dej4BvGXDjqbND05oM-u6tQrLjosX31A@mail.gmail.com>
Subject: Re: [PATCH] net/packet: simply allocations in alloc_one_pg_vec_page
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 1:40 PM David Miller <davem@davemloft.net> wrote:
>
> From: Shakeel Butt <shakeelb@google.com>
> Date: Fri, 15 May 2020 19:17:36 -0700
>
> > and thus there is no need to have any fallback after vzalloc.
>
> This statement is false.
>
> The virtual mapping allocation or the page table allocations can fail.
>
> A fallback is therefore indeed necessary.

I am assuming that you at least agree that vzalloc should only be
called for non-zero order allocations. So, my argument is if non-zero
order vzalloc has failed (allocations internal to vzalloc, including
virtual mapping allocation and page table allocations, are order 0 and
use GFP_KERNEL i.e. triggering reclaim and oom-killer) then the next
non-zero order page allocation has very low chance of succeeding.
