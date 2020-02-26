Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8872C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723FE21744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nl+fis2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBZDiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:38:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37317 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBZDiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:38:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so1187723wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUhme0us7XCJPh4wc0WtPdoMxGC3Hr7PgG+Bm4j+hk0=;
        b=Nl+fis2gOaoRx3SrTeUUI8sONp5Gdnq27Eg2dVwY/dTetlfPvUy434M2LBm9eRA8K3
         vcshKxtpCxmJzId+GiDLWBG8skdcwoK8I6TLRDcTXAnqHIsH48tqooV9HxLglGu/6OxE
         peayvXv5V0qpu2GZHAB5CLyYfuV5OQ1P7uOE7PpTC6nlIMj1V3vtmqXpQG9iZzUlPPgz
         iwIoyMUcdZRljpIfSfp/JG/eUBZTQPetkwlWv0qVBsgD3zBFUCgneDl24XzI6elAhBva
         DqeTdJx7ozOW3ODjFz8JX1VIUTnNq+CgQI0bWQvPdOCWCJthOAs9s/UZ53AH2s3mEXLS
         iSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUhme0us7XCJPh4wc0WtPdoMxGC3Hr7PgG+Bm4j+hk0=;
        b=iZq1BNdTBWpIbSABUsBYDItF0Qxw1DXzEZUa6nJpIfPvLxhxVN4yyVF8KFOCa2NMkE
         T00XjnsTS/9212jbGDB8KN7P3fo3kDZOtMw6QaMkeDiFP7sFaQ0KMrYyvMoa895bLZVl
         9ZWazI23zQLq/0eL5quxb7FK9R/8e6m6aiuqgGPK/vt16GB8B8TKwVKoUKbHqD+spcc/
         BAuZpyU/xwmv+9VonAKBaHDt6rZg6flxrzTwqPDWIQW5jIRyYl2EI6gXqP8vaSJXaO9v
         dsxUOcaA1NSaNS00JGaUHO/R7sOLidM2UMHC2yVlHrYmH81MlB7x7DC/d3bts6snXaM8
         zB2Q==
X-Gm-Message-State: APjAAAVIGmwUm0x+x9VlZx1hPqYCK/BzhoeJFJT+hW4aLjbnt5FY4iAn
        VbW5vqUqlJ3Y8XaoFrKU/UZxrkZ6QxLXnIlqKtUeDw==
X-Google-Smtp-Source: APXvYqwTZtcMOk0jMNlMfjETTWKxTwPOeL0qN0nSzMjuy9IgiYoPzojXH3flYzobHAaMUZH45Ih+DM3cmj7AE9GDuI0=
X-Received: by 2002:adf:e40f:: with SMTP id g15mr2574118wrm.223.1582688328104;
 Tue, 25 Feb 2020 19:38:48 -0800 (PST)
MIME-Version: 1.0
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
 <20200221154923.GC194360@google.com> <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
 <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
In-Reply-To: <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
From:   Chris Kennelly <ckennelly@google.com>
Date:   Tue, 25 Feb 2020 22:38:37 -0500
Message-ID: <CAEE+ybmQb02u-=c1sHozkJ+RXOi2Hno6qYJ0Vx9rOpKjSQ4fPQ@mail.gmail.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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

On Tue, Feb 25, 2020 at 10:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:13 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > ----- On Feb 21, 2020, at 10:49 AM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> >
> > [...]
> > >>
> > >> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
> > >> registered.
> > >>
> > >> - Current protocol in the most recent glibc integration patch set.
> > >> - Not supported yet by Linux kernel rseq selftests,
> > >> - Not supported yet by tcmalloc,
> > >>
> > >> Use the per-thread state to figure out whether each thread need to register
> > >> Rseq individually.
> > >>
> > >> Works for integration between a library which exists for the entire lifetime
> > >> of the executable (e.g. glibc) and other libraries. However, it does not
> > >> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
> > >> having a library like glibc handling the registration present.
> > >
> > > Mathieu, could you share more details about why during dlopen/close
> > > libraries we cannot use the same __rseq_abi TLS to detect that rseq was
> > > registered?
> >
> > Sure,
> >
> > A library which is only loaded and never closed during the execution of the
> > program can let the kernel implicitly unregister rseq at thread exit. For
> > the dlopen/dlclose use-case, we need to be able to explicitly unregister
> > each thread's __rseq_abi which sit in a library which is going to be
> > dlclose'd.
>
> Mathieu, Thanks a lot for the explanation, it makes complete sense. It
> sounds from Chris's reply that tcmalloc already checks
> __rseq_abi.cpu_id and is not dlopened/closed. Considering these, it
> seems to already handle things properly - CMIIW.

I'll make a note about this, since we can probably benefit from some
more comments about the assumptions/invariants the fastpath uses.

> Chris, Brian, is there any other concern to upgrading of tcmalloc
> version in ChromeOS? I believe there was some concern about detection
> of rseq kernel support. A quick look at tcmalloc shows it does not do
> such detection, but I can stand corrected.

The build time configuration is because we need to have an assembly
implementation of the restartable sequence (example: x86_64
[https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/percpu_rseq_x86_64.S]),
although I've been moving these to inline assembly recently.

If we have build time support for the code path, we'll try to invoke
the rseq() call and see if registration succeeds:
https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/percpu.cc#L85-L107

> One more thing, currently
> tcmalloc does not use rseq on ARM. If I recall, ARM does have rseq
> support as well. So we ought to enable it for that arch as well if
> possible. Why not enable it on all arches and then dynamically detect
> at runtime if needed support is available?

As far as ARM support goes for TCMalloc's per-CPU/rseq path, I haven't
had the bandwidth to write an assembly implementation (although I'd
welcome one).

Thanks,
Chris Kennelly
