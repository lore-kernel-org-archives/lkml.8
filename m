Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1661C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAAC207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu5XSuYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFKKDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgFKKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:03:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29909C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 03:03:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c21so3188589lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHhqWIhIvM5lpxlrnRwzqP1uWQ2HNKwGR0MaTt6bLRw=;
        b=Pu5XSuYGVAYXzqsEG20GCkG4ViSLBeZGDbBew63ealygGV6Ux/1CRzmBv3fhs4Nc9o
         zs5jlgXV9PgL/z2gvGoUqBp/Qj0FBbEbCL59BIqnimSIkuri3Pd3MboSixkg6YN40295
         pfyIGn3WXdydSTkznscpUGpQOsTHpK5+uVxc9pRfjGVnQTx6ZdfkkMZVfhYXGNObETCA
         I0y9T0rrCyrrOtDnHt08gfitoCredOQ8it7QzspusD2+Tp3k9fGvlyt85dqdOX++S74P
         /pQzRT7QkmDINtk/Oyngu4smrM1kHzeR+jSfB1oLRInZqbXdAWDzGpnwfkR32SWS42+j
         Nczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHhqWIhIvM5lpxlrnRwzqP1uWQ2HNKwGR0MaTt6bLRw=;
        b=uIfpV7jHClQZuIkEZaYNdzLQrCPantgDX3c35czZlssSmeiio64SrUbL8ffevHFx3s
         dSBl9OB+YntJECt/BvXAvQ5pG0jX9quYyO/SVXHhlxQBEFySLyLLgeJQPiEqksTkPtja
         r0vkxVmiG8Y3usUTdMIpgft9OaJKR9aMpERsWkJMT9FQPsiQbt9K+9vu2p0ykYXZvWhx
         leK4ZJ/H6yKkBz2B3FGNAne1QkhMOCINyRfWS3Rmr68cXU9C8adzcGVjuEfpyaP6BKP2
         J3qbk5XvsQPQIOWh+xk6GyQXXojudEdkFGbBnqQxer1OTgCF2CkTsqzXBDECUyfUj9WP
         vRUw==
X-Gm-Message-State: AOAM531p4TaQNbzPjs9oWgL4xLAz4gJxHsRwzbaeoophAoj5H88xi1Zn
        jsWR6rGFO1I9AXsF1SzyszGNUAzAvlPytxyk1b9+eRvo
X-Google-Smtp-Source: ABdhPJzisXRGD18XWWGUY3aaoI7tpJKRP+dNnRDeIwG4exBGeGOataMJLxqOiWnOj34gDExPAy2nGc0d60pHuZEuFy0=
X-Received: by 2002:a19:641b:: with SMTP id y27mr3656360lfb.74.1591869828725;
 Thu, 11 Jun 2020 03:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com> <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
In-Reply-To: <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 11 Jun 2020 12:03:37 +0200
Message-ID: <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com>
Subject: Re: [PATCH] .clang-format: update column limit
To:     Joe Perches <joe@perches.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Jun 10, 2020 at 7:13 PM Joe Perches <joe@perches.com> wrote:
>
> Ii think this is a not a good change.
>
> If you read the commit log you provided, it ways
> "staying withing 80 columns is certainly still _preferred_"

Yes, but the related email discussions were not about establishing a
new hard limit, but about avoiding such hard limits for
historical/technical reasons.

> With this change, clang would _always_ wrap to 100 columns.

That is true, but it means clang-format will start splitting lines in
weird ways because it has to work with whatever the code is without
changes. If a programmer sees that the lines are too long after
applying the formatter, then it is a strong hint the code needs to be
rearranged somehow (e.g. creating intermediate results).

Hence keeping the limit at 80 means we will get strange arrangements
which could have fit in 100 just fine. In fact, I would argue a
*wider* limit is better for an automatic formatter, e.g. 120. Even
more so considering clang-format is not responsible for the final
formatting -- at least not yet :-) -- the developer is.

Cheers,
Miguel
