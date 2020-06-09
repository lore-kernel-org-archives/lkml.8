Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C772076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJfv/PGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgFITcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFITcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:32:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7617AC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:32:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so1847449pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rS0PjS0rxiYFFA6NkJOsLiVgpILALWXqX0+c6m8rUY=;
        b=OJfv/PGGjziwHlWGLl+f5814ZzqprpOKgo0vPYSNCO/nX2sijtaq5FNv2gvbWNkhmp
         ukFbQ40AvJEaCjIAoONUN7rBXUFQtFBC59T6RYgZf6/g+ZOE30WUE3PG/CzZUVuCMG2F
         xYPtOViIgO4UXi78VEBAlZF2PZmzgpXAibdXz32MwoE5ZnUNKhuYdjOdPa3tRcIPJuPD
         NI8Zjw7xlv97Ssky633X8+kf83KMTUNzd2Lvt3fH2AJwCNE2X+GxhWoqijUCJyQYRMZy
         PvSNcDANXeakfxifbFaKVQtiKdwY6rLQetiJl79W0EhnNinpGxBPO9DxW5/K8v3jyoxD
         VEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rS0PjS0rxiYFFA6NkJOsLiVgpILALWXqX0+c6m8rUY=;
        b=PL72TPNaTAc1isbO7FzZX4al9fv9Gwa2T/6wruAgc2n+aldp0Q624cp6LQdhkN6waH
         wR7s+DBDJ2khXbFhQ9Ytgmr6SR1S3h4enyGV2lS5tfDRQ/Psw7sMB08AX0rtxPGKD5MC
         hTd63yTirbNlYBQ0gCbbDTFwT2L5oq+KEM6/LzmBEGrmoVfWeN6mYK3gB4y70pj1IeET
         KnsNZgngp0SwN6452pQK2YBt9u/QDCS1CCaX4vc0xqGZfmVo57wkrmrqCdN+PjCav2o+
         2LoRzaTSQtYVQKJuH3pxo+MH9M5OUhRtg2TvDloikI2KqcplQiUuP4PtfYDrWyyZ14IV
         KwYA==
X-Gm-Message-State: AOAM531CPSpf8ft5cfWxGIHxfP1Le+ljokSrLxbbVUPp5JDQCFseKoTk
        Pe2lyq8lFVDRhqWphp0TOGRJKGJhxsByKQ3YJbZm+Q==
X-Google-Smtp-Source: ABdhPJzT/ray+2iwWCZt/bmbUFyJRHb3+cB2WcthZLy3Trleot/HATDwSXKrTU7Vy+g0WzyotOm2sfBvvFzmrrJfW+E=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr6575703pjv.217.1591731151274;
 Tue, 09 Jun 2020 12:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com> <20200606040349.246780-6-davidgow@google.com>
In-Reply-To: <20200606040349.246780-6-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:32:20 -0700
Message-ID: <CAFd5g44KHLV3EV+At3tsnbcagbW5Yc-fRXoTBae8no=peCJsmQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        andreyknvl@google.com, shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 9:04 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> KASAN errors will currently trigger a panic when panic_on_warn is set.
> This renders kasan_multishot useless, as further KASAN errors won't be
> reported if the kernel has already paniced. By making kasan_multishot
> disable this behaviour for KASAN errors, we can still have the benefits
> of panic_on_warn for non-KASAN warnings, yet be able to use
> kasan_multishot.
>
> This is particularly important when running KASAN tests, which need to
> trigger multiple KASAN errors: previously these would panic the system
> if panic_on_warn was set, now they can run (and will panic the system
> should non-KASAN warnings show up).
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
