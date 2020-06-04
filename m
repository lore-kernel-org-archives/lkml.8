Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526B120870
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dZ+Mq7id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFDI5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgFDI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:57:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D7C03E96E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:57:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p18so4038194eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izvjeZntfmRt5pu1JX50kgxBnowsGSvfpbiC2Aiju08=;
        b=dZ+Mq7idopXp+hDzE7zFqBFyLUZ7EP9eaafDXK/AYtHuglQGqKnKfZcqf3skLKeuWi
         bt6Os/FC8ApoAMPYzZDQzJlNagYdue5brTxhUzcd8Co1CnwYoQm+m4WABrgSpcPnWIy8
         rHUdAg/mRcyHTGimvmyNjETWivcSuEfruD6iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izvjeZntfmRt5pu1JX50kgxBnowsGSvfpbiC2Aiju08=;
        b=jDVe9ppapYD1Vlj64N7JVwLA+yOqPM6xzTQBQWynPzJDzC8ltUJ3S4VbXqu4LLOinC
         ybp0Kjr4QjazcF0JIc7/75rcAZn3caCnPCgx3Pbydv50ioxO/EVvBA5glAAZbR5M026b
         jMfKmzhcasNFXl4IPhFsRx/29uSUOnFXjGjMnvXEE2dR3MsjZ5dCattQGQ9vVwYgTBcy
         WJ1hrc4Go/0HltXB4qm3C8etZVfxpoULT7U0oFK+N0HPpcAbt0UFlgHzymW599wXB0nO
         mUtqTLvwcRqN6FZRDufU+yqDMvOFjOAIprzfh09f/1uM+W6GL1m6q55eloT5HT+UHNxm
         Rsog==
X-Gm-Message-State: AOAM533JWiVIYtMcCyqtF+f0hyZAdXmAl5v71dqFNmLuE2mlF+d8aWpQ
        wHC1G/o+QJs46nibeZ60nxHarRtQGwT5pMagbp9MQAqluhkLLw==
X-Google-Smtp-Source: ABdhPJySAb3O8tj5h0rTeAJ2JH2o5Myx7L0hVgX6ooQ3uBIE934EdnxSaB6pv3CUHsAuoMpiBU/GkWyLhWf1oQlohl8=
X-Received: by 2002:a05:6402:17f9:: with SMTP id t25mr3364060edy.134.1591261055268;
 Thu, 04 Jun 2020 01:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200604084245.161480-1-glider@google.com>
In-Reply-To: <20200604084245.161480-1-glider@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Jun 2020 10:57:24 +0200
Message-ID: <CAJfpegv5W9BnCFGc2jWxCGS_RcqT0LFxw5ke2Z2XbCotokdUWw@mail.gmail.com>
Subject: Re: [PATCH] ovl: explicitly initialize error in ovl_copy_xattr()
To:     Alexander Potapenko <glider@google.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        royyang@google.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 10:43 AM <glider@google.com> wrote:
>
> Under certain circumstances (we found this out running Docker on a
> Clang-built kernel with CONFIG_INIT_STACK_ALL) ovl_copy_xattr() may
> return uninitialized value of |error| from ovl_copy_xattr().
> It is then returned by ovl_create() to lookup_open(), which casts it to
> an invalid dentry pointer, that can be further read or written by the
> lookup_open() callers.
>
> The uninitialized value is returned when all the xattr on the file
> are ovl_is_private_xattr(), which is actually a successful case,
> therefore we initialize |error| with 0.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Roy Yang <royyang@google.com>
> Cc: <stable@vger.kernel.org> # 4.1
>
> ---
>
> The bug seem to date back to at least v4.1 where the annotation has been
> introduced (i.e. the compilers started noticing error could be used
> before being initialized). I hovever didn't try to prove that the
> problem is actually reproducible on such ancient kernels. We've seen it
> on a real machine running v4.4 as well.
>
> v2:
>  -- Per Vivek Goyal's suggestion, changed |error| to be 0

Thanks, applied patch posted here (with your signed-off as well, since
the patch is the same...):

https://lore.kernel.org/linux-unionfs/874ks212uj.fsf@m5Zedd9JOGzJrf0/

Miklos
