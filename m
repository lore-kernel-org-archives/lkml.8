Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67384207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUQziiOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHVJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:23:34 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC5C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:23:34 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l84so3664089oig.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HXml0ksMnzvv0PRQAiLA54DGPaMuEoNWDNqurufgFqc=;
        b=AUQziiOpLs7N4SZ+gDZAYjJxm3LXmSdWYH7qbJJUJ6dRrBh2p7H6ceokvgdCT6iR1Y
         RzRW7aOOgRZl2uwtIQz1CXHY3i5Sn4eTL2rciBvcpYhEgZoElwzhfpicxRjnZKvwxWBN
         Rr7yGJi8Ndgcjh/RRcf6sDS+chSmNNd86C22BjZXiWPQfRcYLC0j1NWtavYcS2AoyCPn
         ICG5vWq8fLfDKLtDrdq/MLfYMFa5nD2tyiWlvfoi+F/HqxUBBWO4LxjFprlw8VeRkT+3
         fIshfOzQzGy4UVv5S4ShHx9c0Ps20+WVGywxZgoBwBPss3+4zpq8c6lRhP9W0nEEOud8
         CXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=HXml0ksMnzvv0PRQAiLA54DGPaMuEoNWDNqurufgFqc=;
        b=E2Abf//Rkje+HU8d3bOI3BktKHyrccOC9tY3q1dSSuDLltvMf+fRVh/WoBqB8kDRwb
         juJeBp3nXbZW840T4iVlG+TXRwLgZwYJmxUs9vxkNFf6PEnyBzNVRyeX6ol2BNjED56o
         0J6JyBlPMHZ3MM9UjLk/Cq9P+Fq5DzDVOJKYchiWklMoWQXOfkZECYixQ/x3eNDbeJ9k
         iuKGTorCZmiVJw2fnUdjrv8g5lLyGFd2vNHyHfQvH3HirGiLcXk++OtnybuSfhOmnjMG
         jo/tEmQKaGReFuzGIZFmpSTaGk7fo3dNq19lCcIhpNIDFnYbGuYfXC2wDvK9A7DyoHMd
         DfeA==
X-Gm-Message-State: AOAM5335r3HKbZ1M1shf7V/XYgVxdkbczUJStMGqyzmidQWWPHIGEyej
        kBz+iMEZHpyDzzAyIv5itycJ9Jz2MgCFLVfZ/54=
X-Google-Smtp-Source: ABdhPJyYzMqqJ5iIG3OiSuDBhMH+/5T4EJSfWsASkkoSZDm+wjfZ+0Xn4EX4uMvhQ1laDl0gYUVxOJBry4Dsb9d/XSs=
X-Received: by 2002:aca:acd5:: with SMTP id v204mr523966oie.35.1598088213901;
 Sat, 22 Aug 2020 02:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan> <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org>
In-Reply-To: <20200822084133.GL28786@gate.crashing.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 22 Aug 2020 11:23:21 +0200
Message-ID: <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 10:42 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi Arvind,
>
> On Fri, Aug 21, 2020 at 11:55:52PM -0400, Arvind Sankar wrote:
> > Cc Segher.
> >
> > Segher, we were looking at gcc PR82602, where IRA could reorder volatile
> > asm's (reported on ARM). The fix was backported to gcc-6.
>
> I know ;-)
>
> > Do you know if
> > there is any reason the problem couldn't occur on x86 on older gcc
> > without the fix?
>
> No, I see no particular reason, at least GCC 5 seems vulnerable.  (The
> GCC 5 release branch was closed at the time this bug report was made,
> already).  There is no reason I see why it would work on x86 but fail
> elsewhere, either.
>

[1] says:

Current Minimal Requirements
...
====================== ===============  ========================================
        Program        Minimal version       Command to check the version
====================== ===============  ========================================
GNU C                  4.9              gcc --version

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst#n32
