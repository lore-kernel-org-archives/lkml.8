Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A60C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491FB20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqLvow7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGOCex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:34:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB77C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so3192668wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6LjRRrOVLGwVCH+E/vyiV5aYGtBQNbXUznocfAb3SM=;
        b=VqLvow7SaFWzu6jDNNTg/b7EHiPxeh+07ePJpCnkINLTRLnBsPXLN/jem/POkOU2gL
         Gr9jYNphMaj/vFSifxXuYaM/jC96ugVhM9gJlpCKEBy3lA6X1S/y8ZxI74ZSSzZcwqg4
         ZxvBJOvLFMcOXkEOCSCpECuvyJ90PbxqrCwIGwcwgfw41C9sa+VTV0gWxiE9O5esrg2o
         Fx3KWfmjdHd/aMdcylVCG6aT+FcI2imzVqUVwuJsPVZK9ERFpS2z/Ih49SWHUDpVKaB7
         Qwh4cxCWKsczYrcvb4pBTb09JpTGkWcvu1VkVUyou396rpeyLyv1FxGAUkn7Y01V62jW
         MsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6LjRRrOVLGwVCH+E/vyiV5aYGtBQNbXUznocfAb3SM=;
        b=eD0mAkD4qa/vGPCSal6IFuLncZdg3eDJ21y9+fGf3zITBNaaNFOvfRdwbKc63KYoks
         +yj0pSMsNcD3OqrnrzvDOQhuMEMtfpn75OWOlZFqcohS9tgDXim15wUDR5qVtr5B+jjy
         fN/kwKpKAC3HeXuPwGK4+pR28ykzVE4bhEe6MuTvP6TTkqg+h2Dtm9S+S0bAXKThA6Iz
         PIH10NTgu8hJBhgYtFD1jEkFNdvFmzj/CG9lNjngeIEKiAy9C72O9bhNf7uIqI8SpTry
         xe/q/0ur7ZwR8C/lCCnAAdt2e8HrM+324M9jOx9cT4FxyBaLJJK9v7LRlLkr4L/zIILV
         qyHg==
X-Gm-Message-State: AOAM530NL2gYGrUzaiJaWlW3OPAzc8v0BO+GLEWpvzyJrjrmd5nlyrLC
        ti1U5JK4wQy4GwaZ7XiCKp7lc4tq/P5UG3Vkxegf0w==
X-Google-Smtp-Source: ABdhPJz1Z6RHfokkDk1nsGqHkzY0Eso/NAYD3JoNvRiQCC7JJzY2omDv4F4SJBQsn7SH4y16tveNnvG9KLVTTrGsTbE=
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr6743574wme.177.1594780490700;
 Tue, 14 Jul 2020 19:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
 <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com> <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com>
In-Reply-To: <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com>
From:   Chris Kennelly <ckennelly@google.com>
Date:   Tue, 14 Jul 2020 22:34:38 -0400
Message-ID: <CAEE+ybmt4BredezuTPdh-vf=FkKtu0yAhWuf+0daUe89AnbmPg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:33 PM Peter Oskolkov <posk@google.com> wrote:
>
> On Tue, Jul 14, 2020 at 10:43 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > ----- On Jul 14, 2020, at 1:24 PM, Peter Oskolkov posk@posk.io wrote:
> >
> > > At Google, we actually extended struct rseq (I will post the patches
> > > here once they are fully deployed and we have specific
> > > benefits/improvements to report). We did this by adding several fields
> > > below __u32 flags (the last field currently), and correspondingly
> > > increasing rseq_len in rseq() syscall. If the kernel does not know of
> > > this extension, it will return -EINVAL due to an unexpected rseq_len;
> > > then the application can either fall-back to the standard/upstream
> > > rseq, or bail. If the kernel does know of this extension, it accepts
> > > it. If the application passes the old rseq_len (32), the kernel knows
> > > that this is an old application and treats it as such.
> > >
> > > I looked through the archives, but I did not find specifically why the
> > > pretty standard approach described above is considered inferior to the
> > > one taken in this patch (freeze rseq_len at 32, add additional length
> > > fields to struct rseq). Can these be summarized?
> >
> > I think you don't face the issues I'm facing with libc rseq integration
> > because you control the entire user-space software ecosystem at Google.
> >
> > The main issue we face is that the library responsible for registering
> > rseq (either glibc 2.32+, an early-adopter librseq library, or the
> > application) may very well not be the same library defining the __rseq_abi
> > symbol used in the global symbol table. Interposition with ld preload or
> > by defining the __rseq_abi in the program's executable are good examples
> > of this kind of scenario, and those use-cases are supported.

Does this work if/when we run out of bytes in the current sizeof(__rseq_abi)?

Which library provides the TLS symbol (and N bytes of storage) seems
sensitive to the choices the linker makes for us, once the symbol
sizes diverge.

> > So the size of the __rseq_abi structure may be larger than the struct
> > rseq known by glibc (and eventually smaller, if future glibc versions
> > extend their __rseq_abi size but is loaded with an older program/library
> > doing __rseq_abi interposition).

When glibc provides registration, is the anticipated use case that a
library would unregister and reregister each thread to "upgrade" it to
the most modern version of interface it knows about provided by the
kernel?

> > So we need some way to allow code defining the __rseq_abi to let the kernel
> > know how much room is available, without necessarily requiring the code
> > responsible for rseq registration to be aware of that extended layout.
> > This is the purpose of the __rseq_abi.flags RSEQ_FLAG_TLS_SIZE and field
> > __rseq_abi.user_size.
> >
> > And we need some way to allow the kernel to let user-space rseq critical
> > sections (user code) know how much of those fields are actually populated
> > by the kernel. This is the purpose of __rseq_abi.flags RSEQ_FLAG_TLS_SIZE
> > with __rseq_abi.kernel_size.

I authored the userspace component
(https://github.com/google/tcmalloc/commit/ad136d45f75a273b934446699cef8b278c34ec6e)
that consumes the extensions Peter mentions and found that minimizing
the performance impact of their potential absence was a bit of a
challenge.

There, I could assume an all-or-nothing registration of the new
feature--limited only by kernel availability for thread
homogeneity--but inconsistencies across early adopter libraries would
mean each thread would have to examine its own TLS to determine if a
feature were available.

Chris
