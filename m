Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86136C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AD6207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIv78Dpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHZVRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:17:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:17:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so4020918ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5CKUQlNHEbAiL+wb+a/1xleYsdvxRkErdEiQo/31Rc=;
        b=IIv78DpyHuknZxUDHIKLeWSoqevrFQKqYnX8M7pQr7QCTNMnAw1vcvQkupXWYALL6N
         NUce49qJVvhZ/k1Xx8ZEzeDH3K7xuHWqIRiv/64JzbqkWtWTzUtEmkhuPKs/IXVL9hmy
         IWBFDLgMI0NgodtRg4oeMiq97+Ehv6Zr5cyKDu7b2iMDrsVKvVBxdRm3tX6qOFwlQcjr
         YpHlx2IH38gpEXVk6mgBh5GWljGemx+USdYBqIWz2TtUvcZ5wko7KLzsCAWz4nhW7oF6
         dhLgsfMIlxdGeNJFnhtvfcEdnbD6e7eXDMoUid8HjG4eyx/9wBihXKY9iR9SQahx5J8d
         D0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5CKUQlNHEbAiL+wb+a/1xleYsdvxRkErdEiQo/31Rc=;
        b=EY++nkmGJeWppNTzJL9s63zv92/ooTswKQ5zxQ6D0lONy7pR+vQB9SlD2fuJ5SP9uu
         /AqoPoU8T38yDcCa+u2HZxiqWPS932p6XDowsAyYDoZpGILqMqLSVdmMMz6lW2agdxSk
         ANdq9DMjbQ4MPgQ2LmBoY6hgB6L5wm+3EVqu9YIShCT04yYn2AmBkGA/IABQyrWwZkvv
         kzYuwjoPivKtb4183zawY6fxixQREBB+hVgsftU3xYy2RfYuYAhxpUq+q2fTIiQfVOkK
         pyILWu1JD47bff/Vzast3pEmU1PUlJ/DvGFMKK2vlvoxpr2QFIj8cAyfhkxIk5HzXi/i
         OLPw==
X-Gm-Message-State: AOAM532Ma5R9LlzfrVgKjbgwq9xHFlN1XWJqnNLCF0lFu5UcXHDTCSxD
        lUC8lEbsCVT4XDLnqomlog/1cMIbsjJIE9aCSX4=
X-Google-Smtp-Source: ABdhPJxE/wKoot5GoHeHIK+4LIGDBJmVWtX9+lzB3qZ6GyAu/W8AWRlSxgs/uRM2LKVvsKojdpyqE5gt5UXYuDRlrT8=
X-Received: by 2002:a2e:b0da:: with SMTP id g26mr8617987ljl.264.1598476664853;
 Wed, 26 Aug 2020 14:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com>
In-Reply-To: <20200826201420.3414123-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Aug 2020 23:17:34 +0200
Message-ID: <CANiq72no2qO3BBTU3MhVCp4mDLqzMg7NhWGObHV3wtFCRjaziw@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:14 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> During Plumbers 2020, we voted to just support the latest release of
> Clang for now.  Add a compile time check for this.

Since this effectively enforces a minimum version for Clang, I'd
also update `Documentation/process/changes.rst` and
`Documentation/admin-guide/README.rst` to mention this, and perhaps
use that as a commit title ("implement minimum version for Clang")
since that is the important change, not the implementation so much!

[Actually, I'd remove the particular GCC version from the
`admin-guide/README.rst` to avoid having the version in 2 places (that
doc already links to the other one), but that should be another
patch.]

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
