Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2496CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D3F206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNUGojQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIAIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:12:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E071CC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:12:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 12so245708lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbTfqn3dImHPoURfH7UKW3vOdKiFrwL6dfSxV5kclZo=;
        b=oNUGojQpvZOEPWI2xpiwDnkwVfNbMxDrJzno2TdXnD3nlEmK36gs2Kt4zQUUpe7ky+
         zUX5TQ0YfB1aG1KwAXhDiw/AfSVOXwG8tE+mufH+sE5G88v/kJl292r5W0x3irkyuauy
         w6mJXNMUd0G8O/+sNWuEaERc2ZNrtSbS4fZlid7Lccc6qwBxwcx7S98v3urWVnxAbBQl
         kRz/kCIk9yw0H86/mjQg8M5ZTzyv1m0aaDQViSrGva8ZmHlZVv2jd+1o3bym8rMSBv0Q
         e6gOO3jRm7k16lWIEwwqA1J4WaDjEDMXkcnnTYjgzdRzNqk1r1Bu16Q4+mz1qycIlp+1
         r/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbTfqn3dImHPoURfH7UKW3vOdKiFrwL6dfSxV5kclZo=;
        b=tuVWzzUCoAZmB5MbPP3OR69ScQFLQRZMxdyGuuDTlZT8ko0Hk4do6INuz1F6mmYGc9
         OH6KUlIjypQ6LQXfy/cl8viMwqEOCw4Ws3Vf1n1solFTbKynhSCdGpq7Zcli/tubeUyP
         YWiOy1C8HvZDs0K0V0QYeTcQZ8Y+E9tYVX3UtoyApIvzXuakom/5l4ObjJ90ZQtrEJ4B
         OxABzVOj3njkaI6Ug4x1VVQRu9Asgh0ytPoaR1m1y7sWtuir3GNunxwnbxdlQP9lX5iw
         OuVFjYGS0AQBQ2JoLHvD5hIlI30sjd5PzZDotRF7axBq9l2XeFyyLTZe/6RYpDFooqZ4
         XcJg==
X-Gm-Message-State: AOAM532qX9EAQ/oE5T2wuBt2zszfMMH4rvt7Ezl7k2blJwt5gYuQkE+4
        BY0BZ2V5NeMtQwKPS62K/jsBTme1v4F161WYlAw=
X-Google-Smtp-Source: ABdhPJwqIlAldn/nfKWkqME+9tUsn7AFUgQruxqSUTEO0w05IrXUcckchMZjG6Fayrj/hkYyEyD1gUe0VLjcB9w58kY=
X-Received: by 2002:a19:447:: with SMTP id 68mr611827lfe.26.1598947971337;
 Tue, 01 Sep 2020 01:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com> <20200901002326.1137289-8-ndesaulniers@google.com>
In-Reply-To: <20200901002326.1137289-8-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Sep 2020 10:12:40 +0200
Message-ID: <CANiq72kouA9jNPb3ySBfNhSfsKCiELM8G785D4feTZzqFx509Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] compiler-gcc: improve version error
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 2:23 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> do so provides developers

"doing so"? "to do so"?

>  include/linux/compiler-gcc.h | 2 +-

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
