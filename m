Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0125C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA72078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvjSqQzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHaXcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHaXcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:32:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2CCC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:32:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c15so4007779plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQyI5jnqhxLR4xdjLE0c/+hNgZMrXCOgjD35+oUtjqU=;
        b=ZvjSqQzDPGWg2Eqva6xKVRgz+hFJP78RaHD2sJVVnrL+vrXsgQ+uwQVj9E1wMWRDzO
         ssbgb3NsUL3bNnRdsOWJHlkmMxgL3we0QvYL9aECahkRL/l6o32ongZDC7wwUGG8IDPH
         dReR8bv4wUcJbtihxUsjdSZqS+71cvYi5QqBPre1+v5wXO+7rXFx7xO779hreiDc5A/Y
         7C0E8snSyR2mpdz1rlzI+ogR9nZ2Mb650LxwxprNK9e+brS7YW4UA3nUnZgW8reSPYYg
         T18SH4AhejN96LZpvw+Jjybpr/WqhwMhDJN/yEL2X+Vn4W0+DP8nKgPpAwSv3tJPggfM
         wcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQyI5jnqhxLR4xdjLE0c/+hNgZMrXCOgjD35+oUtjqU=;
        b=h1Cdz0+qamdaQ5Q6tWhLt38fOJydjkI2DIuBrxkVQmT19dFrQolgPhCVFAqeC9hfOm
         dlb0gOUf0W1lHE/CGu4rAUdDng1LBcIr2oJTTBhDpspOVzYmN9SH/eanu3vhmU5xDiNs
         OFZ+sGemKai2s1AbLJwLyQWqqyKhngBjzNl+vThpDbJOoPtekMkmMTLfJTzsrDyILfJy
         JlmeZtto2xwfHTnFSRhIoxzoQeBrPx3paVyxz2BRuR6qIUOKvgfpbzKEW+zbI9Qs63eR
         jph9vOFal+3eecP/gfraIqQW6ucBNFf7vyWDQwKh9OogcNzVRqkQNiMBl+loWlbKac4z
         iA5A==
X-Gm-Message-State: AOAM533YHRRaAbaX753xDJGu6n3nbktPgwskC3w0aZakJZVTs70dimcT
        bk+nxjDUu43BIvJkPcd1ZRjBQEfvC30AcpzQOBnhBQ==
X-Google-Smtp-Source: ABdhPJw+gaafisXpINYI34TQxTsth0ssWy/oLCFcgg41FYo58UoPTkKWjnATp12WnDc7coC5lj01OggEx9UB8dc3th4=
X-Received: by 2002:a17:902:8f8f:: with SMTP id z15mr2890617plo.221.1598916733887;
 Mon, 31 Aug 2020 16:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com> <20200826214228.GB1005132@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200826214228.GB1005132@ubuntu-n2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Aug 2020 16:32:02 -0700
Message-ID: <CAKwvOdkTN4BbVvwh8MPrVXERdHjQusmp9yAo09uW=698_fi0Fg@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> > During Plumbers 2020, we voted to just support the latest release of
> > Clang for now.  Add a compile time check for this.
> >
> > Older clang's may work, but we will likely drop workarounds for older
> > versions.
>
> I think this part of the commit message is a little wishy-washy. If we

Yep, you're right. I'm still in denial. Let me rip that bandaid off
and send a v2, with your and Kees' suggestions.

Sorry, the docs patch already got picked up. Let's follow up with
additional patches to docs separately.

> are breaking the build for clang < 10.0.1, we are not saying "may work",
> we are saying "won't work". Because of this, we should take the
> opportunity to clean up behind us and revert/remove parts of:
>
> 87e0d4f0f37f ("kbuild: disable clang's default use of -fmerge-all-constants")
> b0fe66cf0950 ("ARM: 8905/1: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer")
> b9249cba25a5 ("arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support")
> 3acf4be23528 ("arm64: vdso: Fix compilation with clang older than 8")

I'd prefer to see this land in mainline first; otherwise, I'm worried
about this patch "racing" to mainline with those patches if they go
via separate trees.  Thoughts?
-- 
Thanks,
~Nick Desaulniers
