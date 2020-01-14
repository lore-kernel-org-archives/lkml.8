Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702BC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA362084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nz5Aooyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgANCNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:13:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33613 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgANCNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:13:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so427301pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 18:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+z8kiB27wPGXn90Jifmc7GvqCcTTfQFQ09TVSilQ62U=;
        b=nz5AooyyO8UV4W2raMKoiKBMXtT/bo9PatBrL5aEBihU5Bu8dzhJ8lIyBnJQ+7UN76
         P+8/m5ClVTYTjII38MEWxWvX3IgSd4aJJ5WHnTZBjPegsX3qCbvmzuugoTbHeCGxKb4D
         x4Tz6JqgNPET3RWsCkuix5TjP3xnI2zk1U5FIhqepS7I66Q5kXX0uOyeIxJgvG80qeSF
         xxacbzLRmtPQRQNpVGry/ia8R+OdKCBfLrFLnw5bvA0fTBwrEhvK38+x3T07HMggXDyN
         L3ZMnfshrU53TdeSuwwYqAH4t9yzn8peHp4uA1EZQ7oD09Aj36dwrTV0bi7V3NhYvo8o
         1BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+z8kiB27wPGXn90Jifmc7GvqCcTTfQFQ09TVSilQ62U=;
        b=h+nZsiJ8T1x3QMjFYhHClRWDI9C9TuXm7LX5NJvzJuaHxEd+3+p0aaKJogl1YvTRUd
         TJYOaKDgdlDPZ/HNgajo8Px0TTUWIM3VnSM0E4TKBNrgZgzs5diR05HcI8XNW42nWYVc
         iOIrtqaJU5XfIg8rAV1H/n8sRZsHdnzPDjKSXCRX+yY+m8AtfqixUX/Xlc3w42bWj9zs
         frYMl/+WGYkTIGb9lYWqTlGoovp45Xd/wfogRYY2Y6rvBZmDuk1f+ytv+Murb2Cnxx5a
         2ffd3+QZ14lhh9N2M8ay386qitI1jhO2h9GYlsdbsTKM3SBDY4QSrmRe6AEyhYuNhtq6
         cFFA==
X-Gm-Message-State: APjAAAVLBzI39bJ4sMz3kclPJwZWUjwsVuv8u7RUSuZMDMFbSTUrCNIG
        XHpZFE1E0/+lmHhv0kEU/Bqv86+ilS7Qs3TwnmhqKw==
X-Google-Smtp-Source: APXvYqw6inDyeiXLNEF5jBW5S399bu/qD+aslWeemGXOynwxYjD/Q4CHQwEuQJmIYgaJouVkAD9Go4Az+fNFNcXaWa0=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr17781759plm.232.1578968030398;
 Mon, 13 Jan 2020 18:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20200110134337.1752000-1-arnd@arndb.de> <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
In-Reply-To: <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 18:13:39 -0800
Message-ID: <CAFd5g45bsH1781stRRWR45AN92=o9MeafHDjt7qZQveJSVMOJQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kunit: move binary assertion out of line
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 6:12 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 5:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > In combination with the structleak gcc plugin, kunit can lead to excessive
> > stack usage when each assertion adds another structure to the stack from
> > of the calling function:
> >
> > base/test/property-entry-test.c:99:1: error: the frame size of 3032 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >
> > As most assertions are binary, change those over to a direct function
> > call that does not have this problem.  This can probably be improved
> > further, I just went for a straightforward conversion, but a function
> > call with 12 fixed arguments plus varargs it not great either.
>
> Yeah, I am not exactly excited by maintaining such a set of functions.
>
> I don't think anyone wants to go with the heap allocation route.
>
> Along the lines of the union/single copy idea[1]. What if we just put
> a union of all the assertion types in the kunit struct? One is already
> allocated for every test case and we only need one assertion object
> for each test case at a time, so I imagine that sould work.
>
> I will start messing around with the idea. Still, it sounds like we
> are down to either reducing the number of instances of this struct
> that get created per test case, or we need to remove it entirely (as
> you have done here).
>
> Cheers

Woops forgot to link the original discussion.

[1] https://lkml.org/lkml/2020/1/13/1166
