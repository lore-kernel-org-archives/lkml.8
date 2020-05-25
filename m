Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D0CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED56A20776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mODj/zYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbgEYBnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 21:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgEYBnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 21:43:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC59C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 18:43:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so15855998iow.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqz94/+7e1RiM5o+h+HIR5TE0upbQHfvoZz9aXKyiXs=;
        b=mODj/zYaEfVJeQKqnlvU8U0thUA054KETDD+0ZJLi/WUHfuJCiUK+YSmFFrpzDEb2T
         qfvn1pEwu7ZiV5+l6WMtrkMTLo5vrGse/ywkJHZgM302nWAn3p3P89mZ7AdaS5okO5z+
         B0zQERPodLWyTeyc3I30uPgJtEMgR1Nk3d+XD3yOBFmh+1B9cEOpKQZlRARDCHFn0mO7
         MWXJX34skcUgAi+UliZvPi6mvfe5Id4PHa7lQEJR9F2Ml57zrSYcjgO1bxTqd+lqQCpz
         vLdpgx9e++1DVTlk0l0QsBLh1xR07qXZH/cJFC69qYM58i7uTFqSHjreyKCnhqwwsKrt
         V5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqz94/+7e1RiM5o+h+HIR5TE0upbQHfvoZz9aXKyiXs=;
        b=grVk9i8GhKfsUh5Qgi/aPUsD3vDGFx3Es9tIPCcLi+KiYBlAf/TLgkczP02yulvGJ6
         wlzXpdxIjVxspxcguUIohQoQSX60/y410cFkhxxdSLvMZajq9LetJFtf+izV7CH94wrd
         BELMGkuSVEcCQ8vSUIaKSw1Nh6DBp8W3Lb2rETX2N+1LDdj+fN5/7eg6xVB38qK+M88n
         CXcpSb6a2Cmdruq2znj1ERMHm7D2NF4B9AW09EUODs2WrS2eXEEAUdXRttDLaTGZ28wA
         3chJt0tQ1raah42t+XAXYMRQsdFVBheo/urqmSJefKnuomJFHdw5kxeT27lB/ee0rZNv
         yFPg==
X-Gm-Message-State: AOAM531gV6Yi3SOLsC/HWtCi9b4WSkzt/gQxtVg0UtiaCPlgBPTLlQQ+
        ygYrsNZuZnbmLfz6spX3Rxzc78OaJR/cn9TvGsfe7w==
X-Google-Smtp-Source: ABdhPJxf+6uLG/Y2ljHcsChPE+oY3J+gk3Kl1nNxYTtxiBfoP4oERbrxXXoZVsfQmFgE4AI8sPfu7fwDiECsZIJ+Pkw=
X-Received: by 2002:a02:942a:: with SMTP id a39mr17381196jai.50.1590370991729;
 Sun, 24 May 2020 18:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid> <87a71y93lr.fsf@linux.intel.com>
In-Reply-To: <87a71y93lr.fsf@linux.intel.com>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Mon, 25 May 2020 11:43:00 +1000
Message-ID: <CAATStaOY+JJ7mXWRwfXWuR_imhwsv=PecKSWiuZUetHTcz3EXg@mail.gmail.com>
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 May 2020 at 23:35, Andi Kleen <ak@linux.intel.com> wrote:
>
> Anand K Mistry <amistry@google.com> writes:
> >       }
> >
> > +     done_fd = eventfd(0, EFD_NONBLOCK);
>
> This will make perf depend on a recent glibc or other library
> that implements eventfd. Wouldn't surprise me if some kind
> of build time check is needed for this to pass all of Arnaldo's
> built tests.

Looks like Arnaldo made that change when merging:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=e9db221d37f91409040cf7f3fbed08b44e055ae9

This makes me curious. How old a kernel should modern tools support?
From the man page, eventfd was added in 2.6.22 (and eventfd2 in
2.6.27), which was 2007 (or 2008 for eventfd2) and glibc-2.8 which was
2008. I understand the kernel's policy of never breaking userspace,
but what about userspace tools?

>
>
> -Andi



-- 
Anand K. Mistry
Software Engineer
Google Australia
