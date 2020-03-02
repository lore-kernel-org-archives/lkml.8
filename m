Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35859C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8D521739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaGbZGjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCBWUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:20:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39138 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBWUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:20:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id o5so395619pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiRXpYLqa4ejnGphOY97gu7ECpDZYBemFYjwQAOSIN8=;
        b=aaGbZGjtJ97tAFGUqz1YUpCvWUuKvLCOUoq7GqERz+rB0v9aKkWW1Vu0eodTPN9RqX
         872hdjf3v+n810DIGbWsb1YA3ylC25C8v7EbWQNdSnyn6CmqUl7EYIv2FFTiNddxIOh7
         lGAwzdPNbyd6Btislx/JrjefO+I8oHSBuVzcuGPCQJBgfUM96yWecj+MmA8ndhCrt1qV
         wsqBoVrTHQprLkdeFc8bBH4cBTEiANYeLNTg2xN2rJdvvRvKUTfzQ4otrxw9aIwvUrKk
         aglUxIPKqfFRNTr5MBy60063UjLYzQNw6+c5p0GejmWLVief8dOlfKcEFSvRknw4chxX
         3HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiRXpYLqa4ejnGphOY97gu7ECpDZYBemFYjwQAOSIN8=;
        b=jQz6dh+PORaTJevJ2JBXgShiJZzQTdXz+88LaKOeV69q9AyFvbc/1wxQYDT2d3D/k+
         FFpOpA4fKshfUdXHfoEntrC+dsSz19NLT7x9LVIuQAB0BGGw5AsmfpoPuE+zkQHJOhNk
         hVO6VXPsFeSsqhwf5F9nqmSUsploS5oBN+97wszCs3mSytB39+F6ilK4LVQoVanNGnab
         wRT8NfRKYjh5gXgyCEPohJ47Pfodtg2u+rykk8K90b8wHbySZgCOHbuSSso7nmECGKaQ
         YWy1gA6OxdV/ix7eV0SUvs9nNCvbDMkbQW2tLhhPByQkY+VNdhtQnCc6RX12qWdxGV/u
         Zwzw==
X-Gm-Message-State: ANhLgQ0ACBhwE6wv/bn3FuQLRwqT5qlDWonXUkwuIJBUUvrwHOkEp8ga
        z+QDboV7vQ2EsIinGqih3P79HHj1WCh7B23sCM6nrQ==
X-Google-Smtp-Source: ADFU+vuOaeld9UBVLAooUJ2zjVQ14iAl+j/4kAj7yT6yN5YktIvgDo9o5Nd/iazOvMtSLESD5sgw76KV2VeNpaXLVLU=
X-Received: by 2002:a17:90a:3a90:: with SMTP id b16mr120232pjc.29.1583187608902;
 Mon, 02 Mar 2020 14:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com> <20200302211640.GA8364@roeck-us.net>
In-Reply-To: <20200302211640.GA8364@roeck-us.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Mar 2020 14:19:57 -0800
Message-ID: <CAFd5g452oaKojBZfvTYw-L14wTFqsjDeX4mtYDM=kv6xhcTnig@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Guenter Roeck <linux@roeck-us.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 1:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> > Guenter,
> >
> > are you still running your cross-architecture tests? If so any chance
>
> Yes
>
> > you can try this for your build tests?
> >
>
> I didn't have KUNIT_TEST enabled to start with. I did that now, and
> started a test run on mainline a minute ago. We'll see how that goes.

FYI, kbuild already found some architectures for which this change doesn't work.

So far, I need to fix:
- arm64 (32 bit seems to work fine)
- i386 in some cases.

> Afterwards, sure, I can run the series in a test branch. It would be great
> if I can pick it up from a repository somewhere.

Cool, I will post my next revision to a branch somewhere.

Thanks!
