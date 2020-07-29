Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6333D2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhaB3CWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2SNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2SNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:13:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD8C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:13:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 11so23176446qkn.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yy9mtIjdA8AtEwqn//sgva5a/m1w48DJN/R7rI1Pu+4=;
        b=DhaB3CWJuwOUWsKiZ0bWtUjW5xHK0iAqD4Cjzc7UAhDU4EcJQcIUdxj8gu2WB57Bz3
         6UEGKdA7j3qjFIatPNEE+CVjq4PTOZwGGMhK34gn4yby1irxP5Hp7Pgxk/sgcPxlY4Lj
         q21WMWfFdjjTWB7NZHYi6rK7Dz5pt1/T/85p7PvtUn0usmliZqK0FIt1JS5ll4r4eT3V
         HcRwYFpbXohH+um91PNrFcC6kSCFicriNeSEEO6Ob0Z9YEYLuZZCm+Ay8/Ilal6etcB4
         k1lPayuFZSWf+CXVU8dhNiQBe8o74z9vjDk5UbcbUmTX9KNnEwziQ3hP9ghpHWSnhgCP
         dEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yy9mtIjdA8AtEwqn//sgva5a/m1w48DJN/R7rI1Pu+4=;
        b=ss5J6xPUnPjDTtkZgsnZ/AhwUVa1pyhed5JtZENMgYADoD7XgMGVrIezumuJYlZZnV
         SKpIIAdfgSCjFvQpwlgXi5eHQxvNTYxj8gnqBiQ8qpYN/4HW8Qe66b30diIsZ79hDqYx
         NJ2T6vWvVx/fuvhTBUcIThZ5BXQpI1eRPnpIywU8KLEEVKjAxU1kqYE/yHg98M8sUg5u
         EY2EQ7rqAobkJkVrzVXDSF8jA7dd5XKq/wGuls+F+c0SOz7W9dQgSSU7mv3C9VtAEenX
         cVneAIjnRpqdRegEx72tdN+McsOtPMQRyLcSd1VnqU9GzPE5mgTeA15YOdDMtNGW38c5
         nTrg==
X-Gm-Message-State: AOAM532Vf3B/BXhUwGlgogtDGtKWp3Sj48ua7xWoaeH6YCZ0FbgcBaBQ
        qSxLe/nGNEBwfgABGN0yIsAyTUukszFYxi8I/aNAgw==
X-Google-Smtp-Source: ABdhPJx/a6zoUQJF008j02CLsUPE1M3WzyL4vwhssrFyCZpl7X7F9yTGiqyXLXCU1OAV/DI7RvYYCleCmEOtgp87kLw=
X-Received: by 2002:a05:620a:c88:: with SMTP id q8mr6004594qki.49.1596046401216;
 Wed, 29 Jul 2020 11:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200729212721.1ee4eef8@canb.auug.org.au>
In-Reply-To: <20200729212721.1ee4eef8@canb.auug.org.au>
From:   Brian Vazquez <brianvv@google.com>
Date:   Wed, 29 Jul 2020 11:13:10 -0700
Message-ID: <CAMzD94RRbuWKf0kYt9jzpTchjiwoWpKx8-xZNrVHggjNiCm5Vg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, thanks for reaching out and reporting the issue. I have
just sent the fix for review in net-next:
http://patchwork.ozlabs.org/project/netdev/patch/20200729181018.3221288-1-brianvv@google.com/

cheers,
Brian

On Wed, Jul 29, 2020 at 4:27 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> x86_64-linux-gnu-ld: net/core/fib_rules.o: in function `fib_rules_lookup':
> fib_rules.c:(.text+0x5c6): undefined reference to `fib6_rule_match'
> x86_64-linux-gnu-ld: fib_rules.c:(.text+0x5d8): undefined reference to `fib6_rule_match'
> x86_64-linux-gnu-ld: fib_rules.c:(.text+0x64d): undefined reference to `fib6_rule_action'
> x86_64-linux-gnu-ld: fib_rules.c:(.text+0x662): undefined reference to `fib6_rule_action'
> x86_64-linux-gnu-ld: fib_rules.c:(.text+0x67a): undefined reference to `fib6_rule_suppress'
> x86_64-linux-gnu-ld: fib_rules.c:(.text+0x68d): undefined reference to `fib6_rule_suppress'
>
> Caused by commit
>
>   b9aaec8f0be5 ("fib: use indirect call wrappers in the most common fib_rules_ops")
>
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
>
> I have reverted that commit for today.
>
> --
> Cheers,
> Stephen Rothwell
