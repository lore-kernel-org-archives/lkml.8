Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFE721D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToaFsl9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAWSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:45:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44328 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:45:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so1794636pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvsi3+mVRugxOCmIL81uU90/b28J/511mNG/ZrCHXHA=;
        b=ToaFsl9G1rGPH6lAtDVZr8Oaf9j7/1qd9QX6XKweW63AEwNAI3TZBjgIWkg78QTkoQ
         5NmMT4+6HP8VbbljIG7r9SHWggAETrPh9wqEYEHzoaNjGip0j6I9C9ha46HGXtcNioxJ
         YlUaEbzH2m3KjCIN7z0mcVzW/J/Xi1JN7jkawQxCcRDfdoBpDGhbRZGdUvXyeiCyKo1f
         wV8YWAXwj4KEUSWtkq7Gq3dqjX2YfORkOX67a07l4ZYeUpAZxEtQIRj3SKlhU/RR9L3w
         UNCked2iDLQ+0Hn2IuxGfTvvQEDcKJNLyG+VEK2wi9Htl/hEnLhsH9I4kgJaEr9joRJp
         r2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvsi3+mVRugxOCmIL81uU90/b28J/511mNG/ZrCHXHA=;
        b=DtP9K1kn2zYspjqdRx7HuN8xJLTjOJt14FE45RX7JBRMq1f5gOKayLOtLh5X5BzTX5
         FPKA+Jap5GCewg64wk7y2mWBN2UITlaamEBgasfKyRkqjGhXIeN86xcgsKneBG67TPp3
         eiZY2NCiv1vDy1H4Vh4rBjY1BRiEVQpq6NK2g7GVIu8vCG7QCwn7QP9RzH61JHegojFL
         oeFMEokRnzKhTVRqtO8mELFhkRPrf2hMXTOTChrcqPbebURTRxOz7m08gyUwOxrWAK+4
         ZUT+haKwDmmkxUX+4vC22JuinuWkYeDgcZAJZ8CFRQQxR29KqxCuNa/K/QNmvz/Yywru
         vh7w==
X-Gm-Message-State: APjAAAWT83oEhTurFEMIKksVAoOIwIMnhpbH87kOqVSfWSFP4zcTtjQq
        BYedFWj2KCyNw92PqBvJCJYXvUF9jjbtlVa8Gvql+A==
X-Google-Smtp-Source: APXvYqyMHe8Nhew2tJBHBmTJOvyY2uoTq78E8EWJb0A/uv7w1kn1M4Th80XISCR7i0gIfcuuv6uzV9EEjHNjJkWphzo=
X-Received: by 2002:a63:590e:: with SMTP id n14mr210602pgb.10.1579805119253;
 Thu, 23 Jan 2020 10:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck> <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
In-Reply-To: <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Jan 2020 10:45:08 -0800
Message-ID: <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
To:     David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Will Deacon
> > Sent: 23 January 2020 17:17
> >
> > I think it depends how much we care about those older compilers. My series
> > first moves it to "Good luck mate, you're on your own" and then follows up

I wish the actual warning was worded that way. :P

> > with a "Let me take that off you it's sharp".

> Oh - and I need to find a newer compiler :-(

What distro are you using? Does it have a package for a newer
compiler?  I'm honestly curious about what policies if any the kernel
has for supporting developer's toolchains from their distributions.
(ie. Arnd usually has pretty good stats what distro's use which
version of GCC and are still supported; Do we strive to not break
them? Is asking kernel devs to compile their own toolchain too much to
ask?  Is it still if they're using really old distro's/toolchains that
we don't want to support?  Do we survey kernel devs about what they're
using?).  Apologies if this is already documented somewhere, but if
not I'd eventually like to brainstorm and write it down somewhere in
the tree.  Documentation/process/changes.rst doesn't really answer the
above questions, I think.

-- 
Thanks,
~Nick Desaulniers
