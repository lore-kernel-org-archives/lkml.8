Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB9C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92CF20829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WH2gIvD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIJUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgIJUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:39:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B5C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:39:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n22so7734033edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYmngQGxhwrP1IO10+U44hIuDR+Bh29FacWTWPCzifs=;
        b=WH2gIvD2kocNW47TzoJUq8vy8koxj0ikTiqTurIt6Osqva8P4NIsbGtJVGwywUIjkq
         xe3qkruoqIuEPaS3xmqhN2h7V3FGdVjN/fZNXtAtjbUs+ii6wOWOxYBwlihrbKA6Dsi2
         ZcxxkAAiqBfwAJnSmslWIncB3hpPqqLBsQnucMZPZcNa3susHR1gFRdjKlEQ6Zwl4evT
         Ngj6/THEyDfAL+bxEhBtLcLnD1Efcq5a03Byz8i2VKTt0P9PSzdVa+iwn8BOcmkqFZjj
         WKCR+bEgC/b8wFZGdDbKxyU2GcFt1zleojRTJ6mzpqrmZfP30xuKihxrC7oSbqE+O1e4
         z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYmngQGxhwrP1IO10+U44hIuDR+Bh29FacWTWPCzifs=;
        b=lJtCu1sJpEtCNwfD0as1pPC9kFoODCTuZW01uG/r5GYHl269hcwobpriDxJShWulhX
         MszPjMaomfVY3/ISOu2AjzeihrNhPn0CKPB9EmupCIJC0qGyfh1bjvfOJyPjNWF5xWR4
         b9LAxEXvWZfF0As1GO/rC/b+iBt++3PHVjFIa1G1rKiEsvrpiBIfI8G6uWD2zUggfQoS
         DP7M9L3iLIjLvIQAqJCDveF0xS3nosJ6oaOABpjRVf3ZZsrGaBflPb/u12adsj8iv2JA
         2ivBcbv46AaMIqndw4hekKcuSzWov4rzuWouVsUwjWuXmbXvnKRvSqoeAvZzGOtrAUMp
         WJRA==
X-Gm-Message-State: AOAM533SdfQ3vwTeretcn6n5ltAE1AkQObkRu8ALeQVwIXmqvT5XApIk
        Da7nxTO/Pli9REqI241hZ2vlf+BqaJQZVLUvbJeFWA==
X-Google-Smtp-Source: ABdhPJzQ6i+tHlAxsWiND/QkNM3WvkTC+Ju6Mk1rDHZmgMyEa8UX1fZqVV5xbVt8ItiYrZl+V7nr/bCNAXGD3jgXwtk=
X-Received: by 2002:a05:6402:7d2:: with SMTP id u18mr11556708edy.69.1599770370678;
 Thu, 10 Sep 2020 13:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org>
In-Reply-To: <20200910202107.3799376-1-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 22:39:04 +0200
Message-ID: <CAG48ez0WzMpTqaTgtZwQ9MenCoWuyFn1yRhL9R0+s+=pbonTQA@mail.gmail.com>
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation (fbfam)
To:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:21 PM Kees Cook <keescook@chromium.org> wrote:
> [kees: re-sending this series on behalf of John Wood <john.wood@gmx.com>
> also visible at https://github.com/johwood/linux fbfam]
[...]
> The goal of this patch serie is to detect and mitigate a fork brute force
> attack.
>
> Attacks with the purpose to break ASLR or bypass canaries traditionaly use
> some level of brute force with the help of the fork system call. This is
> possible since when creating a new process using fork its memory contents
> are the same as those of the parent process (the process that called the
> fork system call). So, the attacker can test the memory infinite times to
> find the correct memory values or the correct memory addresses without
> worrying about crashing the application.

For the next version of this patchset, you may want to clarify that
this is intended to stop brute force attacks *against vulnerable
userspace processes* that fork off worker processes. I was halfway
through the patch series before I realized that.
