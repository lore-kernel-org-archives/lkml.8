Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765BAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555722081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589906787;
	bh=sM5TWkuZbJDY4NlTw1WOM/771f8ZCEnuLZQAsc0iAdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ll2sqzVx2XAg+mCVMJmwpt4R3manCkGhAf8z7b7bvZY4e6Ex6DGZ+Tx9AgAqsvloz
	 lknv8qQhB1Kv9bt/XB3DNK28uNRxGorEW9Z6Gj20NjxV9VXviJ0p4l8WD3ZXgHlZte
	 9Gl3A70OnrgJu9CXBEjuerd66Ym1MbE0qrxTPDXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgESQqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgESQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:46:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA28C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:46:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q2so423372ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TC0qAtFd13O2JOLCB7SFLNnsJ0TrRRfShJMVEYLbwy0=;
        b=BM7rNRUOZPJu6CqIZoTyNHsH3OhfbJ7v4lyTa1sXCfThZdyIW2MAwpqUoVdCrwYJYJ
         M+8yUvqSB1mogas+2iJO8jLleH/wb+mxdAsp/6H+RxHZ44GfbLZBQMjsb0UkWlV6SNKA
         VToCUizM9QTTj9Opl/oBOtfqOQD3JZAH4FWEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TC0qAtFd13O2JOLCB7SFLNnsJ0TrRRfShJMVEYLbwy0=;
        b=Q2Vyrd/Vyzpc44ymemARrd3PcuqqdSZmPq60Stt6DcM7IQ0UYLc09hLjRr+wsEOU+E
         ZU/2D2vzMKlPtmkGVbKixtzfKHx3rMWwvJaquAYXxTRilbba4FcF94r3jOoJp9bTUSM7
         SUpxDBGk8hDjvhjAoGaEHDzgPgPxFfnDrEx3N498TURuG2zBmCHUfomU/v9FK2KoaEJ2
         WpWvje0CfQIy4YNg2bNRvk2EjgkgYNQOdq+cqv+Xgl4YaHzSaowwu8cUy7+VGKyg9ipZ
         gw5nZ3hUbkQ5pQMIgTpr2Hl+mukW3CQn8rud49tykcUh68BjYJbGHh1a6Uz6zsCAyySe
         xAag==
X-Gm-Message-State: AOAM530JEcdgntiLY61bPNOpfMlU0NCaYTh59zZf+SzMX1qz+yMAV0Mn
        ZfzrA38ysRPoeKCopeAHfFoy0BJQ+6w=
X-Google-Smtp-Source: ABdhPJyaU5tVF5FvBuqCGlhhIk9jop08TwPgOhiTfe34bgQ4i59NOAYSEtG/oYGKYCuJEOvL8TyplQ==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr201746ljj.130.1589906779983;
        Tue, 19 May 2020 09:46:19 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id s8sm9287666lfd.61.2020.05.19.09.46.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:46:19 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q2so423235ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:46:18 -0700 (PDT)
X-Received: by 2002:a2e:8956:: with SMTP id b22mr218841ljk.16.1589906778412;
 Tue, 19 May 2020 09:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-13-hch@lst.de>
 <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com> <20200519164146.GA28313@lst.de>
In-Reply-To: <20200519164146.GA28313@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:46:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVd4evLe-pi7VNrh4Htp1SjogWtEqgot6Ta+kavyqamg@mail.gmail.com>
Message-ID: <CAHk-=whVd4evLe-pi7VNrh4Htp1SjogWtEqgot6Ta+kavyqamg@mail.gmail.com>
Subject: Re: [PATCH 12/20] maccess: remove strncpy_from_unsafe
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I had a lot of folks complaining about things like:
>
> #ifdef CONFIG_FOO
>         if (foo)
>                 do_stuff();
>         else
> #endif
>                 do_something_else();
>
> which I personally don't mind at all, so I switched to this style.

Well, I don't particularly like that style either, it is _very_ easy
to get wrong when you edit it later (and various indentation checkers
tend to be very unhappy about it too).

But that's why I like trying to just make simple helper functions instead.

Yeah, it's often a few more lines of code (if only because of the
extra function definition etc), but with good naming and sane
arguments those few extra lines can also help make it much more
understandable in the process, and it gives you a nice place to add
commentary for the really odd cases (comments inside code that then
does other things often make things just harder to see).

             Linus
