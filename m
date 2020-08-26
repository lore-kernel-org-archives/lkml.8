Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E008C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0844D20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxWnP/Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHZV0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:26:52 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8669C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:26:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t20so2903371qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vNwGXGQOTygwuMBKfjEu6u4Lq92Mu8LGDRvMGtfK34o=;
        b=ZxWnP/OrQvg1qob1Tm05zHvxBPrIXB5evMokOLRllRlGbQKDLv6HLAgopTJG2UhpHd
         EHVp+18AKmk/opBhZGfUkmZcu+2pIYMzzbgB4gB7/0LVJPkU7pQnzRs9uo/X1xnEuONz
         OJnhM3Q4y6okIM7vNz5mnzu1ZOD26KNTXi06Wrkto5I1p5CaZn8SWjwL1AMU/uxbs41m
         XDrwsnGFTkUaC+4jSU5NcW1nUhUIq25U1rgfeOhWiiKsGG9Lxt90oTwrhaTyWmfG3l6Q
         MkwOsULlMrePp8Gvw8SeVVNWx8ZzkvH9IMxw116at9yZ2LO6nSE/+JCYGZEAKELg94zy
         J88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vNwGXGQOTygwuMBKfjEu6u4Lq92Mu8LGDRvMGtfK34o=;
        b=qLLT/4uBeZgSpkjIaGsJeo/RF4Zs5ar2C4TDW9sW8kHDzhYZ12S/rQE2DHeugQnZAk
         Zc9oxNHnbv8NoRelUcb7a9LXmy8dhJz6jZwb0OT1CD13w4KvBIYeUOp19Pj0H4OPB9Hu
         HTgCCOGsny0iCN2pm18Y+owdcjm2aolSg8B+qF4BJCVb12SnkMj5gLbvBYeeiKa+QVyY
         mLahqXq6GDqS2n5ggjFyHqBAuZg84Y8i6DHV6PqifOd6qrGC/t6BV8Jo4bAofINVSe2G
         SVlKmhmo52t9MMR3w/Q5dYrnaxbUerBh7Iv84U7vTQz3qTJ4q1uA8Sw2tdiJke0cHQqP
         3I/g==
X-Gm-Message-State: AOAM530sAjUAlDwd19b25wF3L4sJwT0twwXyT0lmvJT6E/cPn6yq/v15
        DfSOHOVd6aSSjX2IpH+Y9m0=
X-Google-Smtp-Source: ABdhPJwDqsGYnFEtvfFnrZtZ2AUpF8DakLLIvYfA9GILERLAjv2oghsd4xhLrP5ug3VKZi5aoE6pMw==
X-Received: by 2002:aed:38c7:: with SMTP id k65mr16710881qte.133.1598477210710;
        Wed, 26 Aug 2020 14:26:50 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 95sm187866qtc.29.2020.08.26.14.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:26:50 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:26:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
Message-ID: <20200826212648.GA1005132@ubuntu-n2-xlarge-x86>
References: <20200826201420.3414123-1-ndesaulniers@google.com>
 <CANiq72no2qO3BBTU3MhVCp4mDLqzMg7NhWGObHV3wtFCRjaziw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72no2qO3BBTU3MhVCp4mDLqzMg7NhWGObHV3wtFCRjaziw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 11:17:34PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 26, 2020 at 10:14 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > During Plumbers 2020, we voted to just support the latest release of
> > Clang for now.  Add a compile time check for this.
> 
> Since this effectively enforces a minimum version for Clang, I'd
> also update `Documentation/process/changes.rst` and
> `Documentation/admin-guide/README.rst` to mention this, and perhaps
> use that as a commit title ("implement minimum version for Clang")
> since that is the important change, not the implementation so much!

I was actually going to comment on this separately but you beat me to it
:) this patch probably should have been sent as a series with the
Documentation update to avoid confusion for the reviewers:

https://lore.kernel.org/lkml/20200826191555.3350406-1-ndesaulniers@google.com/

Cheers,
Nathan

> [Actually, I'd remove the particular GCC version from the
> `admin-guide/README.rst` to avoid having the version in 2 places (that
> doc already links to the other one), but that should be another
> patch.]
> 
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> Cheers,
> Miguel
