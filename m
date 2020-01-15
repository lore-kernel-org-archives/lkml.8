Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80820C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525DD2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeMscKv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgAOTvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:51:38 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46313 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgAOTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:51:38 -0500
Received: by mail-oi1-f170.google.com with SMTP id 13so16583545oij.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrYAie2eRW6IOTWX2EXtM4jme3AXHDgWbVMHcdt6qOk=;
        b=QeMscKv82Bnz8PPS+/me8QibPYuHHbtAGQHXr1iESgQRS5z9UegSgqBc7oHWy/l5N8
         kScbRsGy4BFu6acDpF4e+5OqfHO0Yg+pLjevq5crkOWgeZuTFH+or+Q3q6LILoDWguFW
         SF7N0HHqaAByj5cyV6lvQfeiPmJMT01gDalkmMHeQroUmKtjmo5dq3dxFibsh/XEKpVO
         Cpfb5+m2w3y8eXA0XhmBM+The7CO09fmdOE7l15/M++VLmfveN0fRQX+yNNMwUmUehmp
         gP7PUCdjw5EB/qALIkf5Li0x+0aQbOOBmQST5RqHHEUv0NRU7Q4NOpWwuMKyaDqzOS1F
         iRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrYAie2eRW6IOTWX2EXtM4jme3AXHDgWbVMHcdt6qOk=;
        b=IqzLeewTCwLNmJPHAe5xATg83CqBiKrC38B39AcSSmTroS38QN5F3KksO5Ll+Xg2Vy
         2ReYmWnvkYiCyMpdj9mkiZ5ZP8vvA9TIHrtskhHDy8e3+GS+TyeEQ2E0OkWia72dsn1i
         2m583vvN1Weif9pkQgqlQ/A/CxBoyng/s9LjW0sychHzaL5DW7UEJ2fpw3qyUoZ3wjN4
         PGFMnJ7b+AlEvpJrYNUb6lD8wUsw9cqxsrRbCfYlui5pQ9sA2U5ivVN7gGpPvZ2RTn+/
         Hu/+sJBS10YN5pYm9me8rD5b6Gl0A0YBFfglsKGvqqjf07KZRLTQ4TACcDY9B1y/Kmyz
         LsEQ==
X-Gm-Message-State: APjAAAXQ+tMegutiJ0L0mnKGjVAuEqDoRjAXEz4MBQV3Bvj9EovTVaMQ
        hVUb/tARcCuZLCLra/wCf7RBKtZa7XBFx2NnZvQJbQ==
X-Google-Smtp-Source: APXvYqznmXUDHrqkq6pOGZvvIxaj76OPkZQJUmHzZZ2yM6qp0VMnMMzFY7hgzrG9YmzcMX3Zmb9cUg2ozkWQegK2zxA=
X-Received: by 2002:aca:2112:: with SMTP id 18mr1133436oiz.155.1579117897045;
 Wed, 15 Jan 2020 11:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Jan 2020 20:51:26 +0100
Message-ID: <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
> >   * set_bit - Atomically set a bit in memory
> > @@ -26,6 +27,7 @@
> >  static inline void set_bit(long nr, volatile unsigned long *addr)
> >  {
> >         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> > +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> >         arch_set_bit(nr, addr);
> >  }
>
> It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
> next to almost any instance of kasan_check_write().
>
> Are there any cases where we actually just need one of the two but not the
> other? If not, maybe it's better to rename the macro and have it do both things
> as needed?

Do you mean adding an inline helper at the top of each bitops header
here, similar to what we did for atomic-instrumented?  Happy to do
that if it improves readability.

Thanks,
-- Marco
