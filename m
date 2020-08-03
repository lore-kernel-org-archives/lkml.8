Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52912206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjvwRpvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHCGu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgHCGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:50:28 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1896C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 23:50:28 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x24so3053836otp.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KSdlAYLfq6oYXP5DVeyrt3CYvkgO3dsvD8hzUOr0Pg=;
        b=HjvwRpvoC8uQQvmnUQwqQqSclfNQZDlVWpLOEJGi2uT/0rm+sxjw5UwQInrCDi/Fmf
         /LVxI1DWQ7rl/9KBmKp9FcrV6NjSP2cPpoO5pjNNFIlbMCNMMTExTXno43BxJlq8wovk
         BzxlQ6ri8YdxEcnnD8IMfIElj9B42cd6ukcMLT+3seGSgpOrhMK3XVNI26SwqSDzZoGW
         jAq5v6EixU9NK15WkhDThVF3H99G2yrinNGq5MV4B2y91jQie13jzyMevZqt6GtUs6nJ
         aTno6gjP0cYJeW9IHr1Vi9OaB/sHYwta6ypWUW5c/xYW7Khbs6oRu+t7Hk9r53f/wk5b
         kRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KSdlAYLfq6oYXP5DVeyrt3CYvkgO3dsvD8hzUOr0Pg=;
        b=NZNJ7pq8QKoErBSuGz15BjUBBgAZXwDSlAO1Z4IAHKlhukfkL5uTr+MMWoDe7+uL2F
         NJoT1NHRU9PvzR94P9jvxjMP84EbqfQXRwEIHc22WH/rXOoQyD49iciRAn9ZVhA+Zej5
         TRqLU30EHmkLKNJJ21RG7+geyMONgMPolluNjlr+pYfXPZhzp9v05Hu6x6KvLz/cTi4l
         tt/FFg6flOiwogrjXoDNgOJXZbfQpZoX4S9VeAZ2aqPM6mPIyU+W7a9aXFHVNa/vVV1t
         SA/NoBSYwkXMEgZrNtTuMHNeu8FlP9zp2Pyg/4SIrcLwBPG87/+J1p16j2yPe1nciL2N
         9GpQ==
X-Gm-Message-State: AOAM533hD6QTRq/eh9arD8zqZ76RLFWa1fo/k3jzgWKRr+nKDB94UKk/
        YxHpeg1J3TM4RAw6LWADatkL9rB0PGRdWqN/sE5sWg==
X-Google-Smtp-Source: ABdhPJx3CdTlScwAxzpstIdr9TgdXDYCZxvjyWYAbsdBRhTTM+iKMgS9ngCxfmOprZVCdGrTx7LXqkXwxAKn1dDRFJ4=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr11624412otr.251.1596437427272;
 Sun, 02 Aug 2020 23:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200803064512.85589-1-wenhu.wang@vivo.com>
In-Reply-To: <20200803064512.85589-1-wenhu.wang@vivo.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 3 Aug 2020 08:50:15 +0200
Message-ID: <CANpmjNNH7Szgnbg+7Q_TGCma6z4OXcSELtvgvndx=6zvok=sAA@mail.gmail.com>
Subject: Re: [PATCH] doc: kcsan: add support info of gcc for kcsan
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 at 08:45, Wang Wenhu <wenhu.wang@vivo.com> wrote:
>
> KCSAN is also supported in GCC version 7.3.0 or later.
> For Clang, the supported versions are 7.0.0 and later.
>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---

Nack.

Did you mean K-A-SAN?

In which case this is the wrong file (kasan.rst also has the right
information FWIW).

>  Documentation/dev-tools/kcsan.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index b38379f06194..05a4578839cf 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -8,7 +8,8 @@ approach to detect races. KCSAN's primary purpose is to detect `data races`_.
>  Usage
>  -----
>
> -KCSAN requires Clang version 11 or later.
> +KCSAN is supported in both GCC and Clang. With GCC it requires version 7.3.0
> +or later. With Clang it requires version 7.0.0 or later.
>
>  To enable KCSAN configure the kernel with::
>
> --
> 2.17.1
>
