Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43CA206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5jljmQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHaS7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgHaS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:59:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:59:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so1104179pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3gvdeLLkLMj6sDEkcPB4/tK2fV8l3UXQaxnpiPHbxk=;
        b=f5jljmQ/Tzl+5/kQmFEzbbT1v88qGePnYEgl5N300ns0wx1IJw8gl5o8we5HmlsNUO
         9OrnCQ5fnN7H0lecCflIqYgo4ZUYtfwMqXbVvCJBuNQ1mJd81VwgdMaQcZbmrLK8giNW
         2Vo8kgN9OndT7YWtpzTDv+UrOpYqludP78QE72eW5t6EduVt1DYYwD4f9gxj96skYZgU
         2RuAvVCUUbVW/1OVhcepCZVYJkSeyH/GIwRjOjpPuppwNQvYBVoEcdmCoC7AymmQrk09
         DwGmrHquG9eF6ITSLT4smoZd7wD0MueAzRjsBbzuZu191A3lkHuWi7MG7JgGaoRMly6m
         D3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3gvdeLLkLMj6sDEkcPB4/tK2fV8l3UXQaxnpiPHbxk=;
        b=IVynn0S/iKEgwuy0YcTmBHHabtC38cFt/OnCdMCCp9V7uazhczs2l57t8kYYcXkTw0
         OaPIuw+xgNORz54N1H/Erm4x47seSrwjwuyEe5O099P7A7K60ZBt8uoc9V1udljTnJIQ
         2Pgv4Tr/MTKUQ+OWnVinWkFY21B+mtVOzoVqJ5/R52d04wUjgDBzc3jBbjcyYH49gmUw
         9nB5/WSCq/bOHf/ffg9EK5Hq4YV+ba8yIL9dAf/o7DKAX2nNA/5RmgM4vh2v1eB0HIEf
         O0BBTpwQvj4p51l4O0PrOFKEYUWvAlbWck4sI26H6xUpPJklvHUIaeouJKSz2aZ8Qiyy
         a3uQ==
X-Gm-Message-State: AOAM530iZ5O0XmTHJaJ8Iv5DgO4rp804jxi0Qeqn46YoIaxjJgdkNhNS
        AchbIv78/69jmCqxATRpGS7ykotwqkT5nvrfbYPa6A==
X-Google-Smtp-Source: ABdhPJxZdxUKTq0Gc3Lf2zRRjEfPyDXVNK6R9eATwLEDG7sxtcGbnWRGarQFHP/X/n7i91gf4i6j4xi1w7XQ868l7qg=
X-Received: by 2002:aa7:8e8f:: with SMTP id a15mr2350429pfr.135.1598900355921;
 Mon, 31 Aug 2020 11:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200831171733.955393-1-alinde@google.com> <20200831113238.b6b38076bb02076458592a3d@linux-foundation.org>
In-Reply-To: <20200831113238.b6b38076bb02076458592a3d@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 31 Aug 2020 20:59:04 +0200
Message-ID: <CAAeHK+z9xVfW_W1u=ZatPXQ+2UH9khuW2yM96BcgLmm8ENzymg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] add fault injection to user memory access
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     albert.linde@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>, akinobu.mita@gmail.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 8:32 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 31 Aug 2020 17:17:30 +0000 albert.linde@gmail.com wrote:
>
> > The goal of this series is to improve testing of fault-tolerance in
> > usages of user memory access functions, by adding support for fault
> > injection.
>
> Does anyone actually plan to use this feature, on an ongoing basis?
> It's the sort of thing which the various test robots could exploit, but
> I'm not sure that they are using fault injection?

Hi Andrew,

syzkaller/syzbot is using the existing fault injection modes and will
use this particular feature too.

Thanks!
