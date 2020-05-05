Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64680C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428B9206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsSNLS2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgEEPgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729250AbgEEPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:36:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90193C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:36:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1325259pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwxCkRHW3LLt11CwSWNDSa8Gob3WyF2l16Zu0juPB1E=;
        b=qsSNLS2nAOF69rRydRSFpGTgir/jRB4Zxox9XTBqky6kpZyY1Qi/c5poTt/ioS2Wc9
         OCCi7qRkUBaQQkV0XhJzHDwZkpfXmHVyW7ahUeIvKmVLuBK3L9fyjgcrT9a3PEGRQ6Ao
         yvudtC4wo0ft0Z5cRiDCJpN1fbXmoW/iUOwknqTMg7VjpzT0wi9uR+sDNP21Rjon/iqR
         ZBzD05KS0bLIaaY0dfWVmuOVmADaZHNYD+HemT1VguJV1+s7EBfL0bZJ2fIRPt87xNpS
         jRUDc1X3an6C/lBOOUs7gLnkpOdJk9Z8Z880I1KT5WCze4sNYkf3ak85WURtk0HjnzOI
         CF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwxCkRHW3LLt11CwSWNDSa8Gob3WyF2l16Zu0juPB1E=;
        b=eNA2hVkLHVAG+Twb9o0OrGETekITk55WLP95Xg2Ihv5KZGjS+SKbFht53kzUVpoIaW
         306SftSBlP3hFvlabO8/Qr/nHstTcxt6siWlAuSEA8Yxyut2MTXs8GSuqWWZiHT1Ce3D
         f/kgRn6vlItbDBMVCN7vQRa0coaOCA9RxgJ4ZPmkxXswBiH/7BbSJBcIadBerMG4JT4H
         k/3ZUvAqBxSKc5x39rXba7GV51PKA0z3GIBs8JDZ9e4mCVdfRKU5aoI+07B5HLL1MHk1
         R29xAr689rytoHz6rp2yyR0ScHYARHa4zWjm67jcpk2djA1ghpcCbmF27ESvlKlgtsjd
         Y05g==
X-Gm-Message-State: AGi0PuYFFAjarX2jNii23yL/5z5JRK5SFPBGud01nxGt+7wqv6pqZvNC
        sg8IjLqUd2S+phJV+nO0COTbB724SfMCAUDu7UyWnw==
X-Google-Smtp-Source: APiQypJvP6wSu1cPxVKVqCewcZTF7AkEv6Px3jZaq/9uQ4S08BiRypUqyPv1V+E6apS+vGLgDIdU6r4tIUnFAzo1wDM=
X-Received: by 2002:a17:902:eb54:: with SMTP id i20mr1537334pli.179.1588693000713;
 Tue, 05 May 2020 08:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135513.65265-1-arnd@arndb.de> <CAHp75VfmvXotH+NRt_YnNQW8O38Gas+ZfLH00jfhytM8w7ka3w@mail.gmail.com>
 <CAK8P3a2pXZGbFvXpD5D4trGjxaie_NYi4hhUyYmKmv9A_HfRdA@mail.gmail.com>
In-Reply-To: <CAK8P3a2pXZGbFvXpD5D4trGjxaie_NYi4hhUyYmKmv9A_HfRdA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 08:36:27 -0700
Message-ID: <CAKwvOd=6jdRedjhcuQ0Bsr5hJ9djp8xLpLmT-bC9Wd-1GYK1fw@mail.gmail.com>
Subject: Re: [PATCH] bitops: avoid clang shift-count-overflow warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 8:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 5, 2020 at 4:08 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, May 5, 2020 at 4:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > Clang normally does not warn about certain issues in inline functions when
> > > it only happens in an eliminated code path. However if something else
> > > goes wrong, it does tend to complain about the definition of hweight_long()
> > > on 32-bit targets:
> >
> > Shouldn't it be fixed in CLang?
> >
> > > include/linux/bitops.h:75:41: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> > >         return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
> > >                                                ^~~~~~~~~~~~
> >
> > sizeof(w) is compile-time constant. It can easily drop the second part
> > without even looking at it.
> >
> > > Adding an explicit cast to __u64 avoids that warning and makes it easier
> > > to read other output.
> >
> > Looks like papering over the real issue.
>
> I'm not sure if there is anything to be done about it in clang, since it
> always does syntactic analysis before dead-code elimination by design.

That's pretty much it.  We had a patch to Clang to use delayed
diagnostics to delay emitting the warning in case the AST node was
dropped, but it wasn't accepted in code review.

>
> It is a bit odd though that it only prints the warning sometimes, but

Sometimes?

> I suspect this is also something that works as designed. Maybe someone
> on the clang-built-linux list knows more about the background.


-- 
Thanks,
~Nick Desaulniers
