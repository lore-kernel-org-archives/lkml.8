Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AC42080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cK5PuTL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGULqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGULqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:46:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A99C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:46:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so8698229qka.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9dKJjAdiDcopuGHfo3T3egP3BswnlQGtJN/1BQ5lnA=;
        b=cK5PuTL++eq4nIne5xa49rSP8UltaCqZFyqQHZpj8PEve2wW9Q2T9IXf6Z9KRt9hib
         zvCBcoGmnVH6krboPzGCK5fw8NDrNBgz/UfvmV6RQi8HmpSp11HLBUgWathJzuYPg1DN
         UsDuZFXbzHqNOU0loLHgMxTIf1Lyp620f1QJVAY2zA/DdswmWA0WRIU5+1hkki2ix1IO
         CL61g4fceQAPhpy3AXrDW+J/p+Tt0U4UqqKgD4tnPIABGcJcirY9elglb5MtvYhZ6dT3
         QL+buHGXkFWJYFPPn6pHPURDVC4P6g28/JsBvp7YCPMWWhtFQ729xeVzyYwuX2BqRjkO
         xqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9dKJjAdiDcopuGHfo3T3egP3BswnlQGtJN/1BQ5lnA=;
        b=uDhpZBINpuGKrRfl7aHQuSymMXY55fazvlCEdvEVfHyUsZP10S19WGlg8+qsytMo9q
         7o/WGdToY6XBokym8RRnqvP0VGaESdOSnqGOW0VazaytCqMYK3kvaVjqu0SyadWUedYE
         QLLf5X57sxtBuLyhsZFTsaowmcNzUVDRONlNxZBtM5WWzfZ/H6d5vwtey/gIGgSBcQmW
         QFrQ1gZNNr+yUn8247s6FaRJ3OFGsFm1rAq878I6kr5JSh38VzFgnjeUB8KL7Yp4913R
         23P6xdkmsNuJp0wRgHWYqK/fAZs0Te97dJVIZ9IqpWynMaamMgGLWPU2MuFDGwuClmjk
         BYmQ==
X-Gm-Message-State: AOAM533nQ3dJwqmtqYg3z0/knkm/FLg+60Z3FwO6VhVlWRD0M8Tj6pFI
        B53xOUxr1xKqecobMmjqqyBvwEAe9V52iENO660tpw==
X-Google-Smtp-Source: ABdhPJzxqkXqxF/hDERKPQHmbSEeq9mWaaFaSXFpCIOaoILcry7AVotPWKvzFRrk64/HtXjv6CpYJ6mXZXD7bxVe0a0=
X-Received: by 2002:a37:b48:: with SMTP id 69mr10175282qkl.407.1595331972130;
 Tue, 21 Jul 2020 04:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <5fa344db7ac4af2213049e5656c0f43d6ecaa379.1595331682.git.andreyknvl@google.com>
In-Reply-To: <5fa344db7ac4af2213049e5656c0f43d6ecaa379.1595331682.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Jul 2020 13:46:00 +0200
Message-ID: <CACT4Y+ZZU3RUKNcwK9doRzSbFNEb4779w2JTQ4m_pNSw3w1brg@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: add KCOV section
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 1:41 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> To link KCOV to the kasan-dev@ mailing list.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d53db30d1365..fbe59955646d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9305,6 +9305,17 @@ F:       Documentation/kbuild/kconfig*
>  F:     scripts/Kconfig.include
>  F:     scripts/kconfig/
>
> +KCOV
> +R:     Dmitry Vyukov <dvyukov@google.com>
> +R:     Andrey Konovalov <andreyknvl@google.com>
> +L:     kasan-dev@googlegroups.com
> +S:     Maintained
> +F:     Documentation/dev-tools/kcov.rst
> +F:     include/linux/kcov.h
> +F:     include/uapi/linux/kcov.h
> +F:     kernel/kcov.c
> +F:     scripts/Makefile.kcov
> +
>  KCSAN
>  M:     Marco Elver <elver@google.com>
>  R:     Dmitry Vyukov <dvyukov@google.com>
> --
> 2.28.0.rc0.105.gf9edc3c819-goog


Acked-by: Dmitry Vyukov <dvyukov@google.com>
