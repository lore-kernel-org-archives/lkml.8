Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5FC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322D92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uybE7F3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgBZDZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:25:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39191 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:25:00 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so1733619ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOzAwCx4zkKExWVM/1JeparZOmVnpclobVkhjd9ROHU=;
        b=uybE7F3iZRKuDdGsl6AyNPinESePbWi00KedWrOiIi33XC+9m8T4hszY/5M8ZqDunR
         c9cmuFEToTMIUntwmJSVt7qJ7n6vT0NsDJbG4RGdP0gv6zADb9cZek3wTGJGGX4vG2h6
         Ba12yAInTSh6EGdarC7pCOlFji5RczzdfgF7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOzAwCx4zkKExWVM/1JeparZOmVnpclobVkhjd9ROHU=;
        b=M9ld1Dfty+W7gk0XlTD8mWlBhbZpWsBr8tW3UShWxwCQiOdCbbHT4yCfpW6/kfjMnV
         F7nEcQn6y1ca+zsF/elB47Ad+9B1X/je21qXEHSrZOqWZIcEQPvmVJL+kwtwUgLomWxb
         GR0c9fYmBzk97RAUoUN2v5diZ5Sc5DlNILgAsOVdQHWHbRwq4TwGIM7BERRvpmvPlJj1
         hw8VvfjNkaiLIt/rd/TWThT7i59ivorCbEcoZOsO6xBzvmd4qGX65gCuVU7ESHi1h0Ra
         hs0x0JXw+cwEjpJqttLpq7fJmx1Fu5pK+fo0MZMpVl5zAZbBLBAXprhFNXBM+F7xrX6c
         JiiA==
X-Gm-Message-State: APjAAAUUEh1yHYyJoEjEQvE1GUHlIrpDHswyWDodB4kIxRe0rTRaCICs
        mf5FyO50Q1LF8XSqOBTjI8B1h3QytsdqPVLylrEYgQ==
X-Google-Smtp-Source: APXvYqzHGFbOXP4crruGf1D013vhSDqRLdH6MZOdcklPvGslpTyDp+PnQANCeKZTWskBq50NizwHS+1Rd5rHwBdROCE=
X-Received: by 2002:a05:6638:6ba:: with SMTP id d26mr1761220jad.23.1582687499763;
 Tue, 25 Feb 2020 19:24:59 -0800 (PST)
MIME-Version: 1.0
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
 <20200221154923.GC194360@google.com> <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
In-Reply-To: <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Feb 2020 22:24:48 -0500
Message-ID: <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:13 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Feb 21, 2020, at 10:49 AM, Joel Fernandes, Google joel@joelfernandes.org wrote:
>
> [...]
> >>
> >> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
> >> registered.
> >>
> >> - Current protocol in the most recent glibc integration patch set.
> >> - Not supported yet by Linux kernel rseq selftests,
> >> - Not supported yet by tcmalloc,
> >>
> >> Use the per-thread state to figure out whether each thread need to register
> >> Rseq individually.
> >>
> >> Works for integration between a library which exists for the entire lifetime
> >> of the executable (e.g. glibc) and other libraries. However, it does not
> >> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
> >> having a library like glibc handling the registration present.
> >
> > Mathieu, could you share more details about why during dlopen/close
> > libraries we cannot use the same __rseq_abi TLS to detect that rseq was
> > registered?
>
> Sure,
>
> A library which is only loaded and never closed during the execution of the
> program can let the kernel implicitly unregister rseq at thread exit. For
> the dlopen/dlclose use-case, we need to be able to explicitly unregister
> each thread's __rseq_abi which sit in a library which is going to be
> dlclose'd.

Mathieu, Thanks a lot for the explanation, it makes complete sense. It
sounds from Chris's reply that tcmalloc already checks
__rseq_abi.cpu_id and is not dlopened/closed. Considering these, it
seems to already handle things properly - CMIIW.

Chris, Brian, is there any other concern to upgrading of tcmalloc
version in ChromeOS? I believe there was some concern about detection
of rseq kernel support. A quick look at tcmalloc shows it does not do
such detection, but I can stand corrected. One more thing, currently
tcmalloc does not use rseq on ARM. If I recall, ARM does have rseq
support as well. So we ought to enable it for that arch as well if
possible. Why not enable it on all arches and then dynamically detect
at runtime if needed support is available?

Thanks,
Joel
