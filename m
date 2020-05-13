Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF4120659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UHr3BmqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbgEMXlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732456AbgEMXlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:41:23 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84138C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:41:21 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l25so898554vso.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlGt6Oy3r+BmfkpKnoIDqe3ZUdwniAx9kteZIcI2SXs=;
        b=UHr3BmqVuaNOTVxKkDgUigv2I6cDB3yY+X1ORivDUjUdYlkwuvCUX/udO5encsZXMO
         WzjqaT6kOYLT7bjFIkAqPNXKGNzFSaf3+f3bf+rpCr6LlCaaNzLRV1k46VsU7j1lSLRt
         DDJupzdmugvcfBflTh7YorajO7wWp9umAxN8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlGt6Oy3r+BmfkpKnoIDqe3ZUdwniAx9kteZIcI2SXs=;
        b=CioTLfAI25bdbijfC1pzX42TDgtsF7nlQHjHufyL6pgXnEdc3wq8yQeWfwC9kSDmx0
         22m2Vr2jprJkwM4qdOwDmUFr0WZ+bUw6cudT/KNtu7++kH/TzvLUZSDd4Et9aXIEkXQB
         McIEyVkSQVoZRgIcomxPTUYBJEXopgYcWC+bTu8M/7M/7/G+FZoVhq9WmSGqO/ClCsu9
         czLNi4vKyO44bttx0qNUlBqQI8v54wHT2mg98JB76kh0z0XhQlv4loFix449P5vM90mc
         vVhulKiMNtlthaqEOcfiGSgaVyUUXzvs+BLcWhBnEISdpRVofTUB05tqWhZgZtKJctSg
         +0NA==
X-Gm-Message-State: AOAM533kMg+8swLs9RG9Q2Pln2gI45Web40Bsq4b8CxUmbses4kc5ZtY
        au31GA5nLe7rPaC0TcAKmCmLjStHCDE=
X-Google-Smtp-Source: ABdhPJxX6mpNeR2W7Dtt8/YHI9N3IQsRQbIa0KEjIKE6rh4yym+2efMf5UEFriyvQQoZDKXwsghVtQ==
X-Received: by 2002:a05:6102:2d3:: with SMTP id h19mr1308099vsh.58.1589413280355;
        Wed, 13 May 2020 16:41:20 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id n17sm284548vkn.29.2020.05.13.16.41.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:41:19 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id v23so299287vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:41:19 -0700 (PDT)
X-Received: by 2002:a1f:2c41:: with SMTP id s62mr1494343vks.40.1589413279155;
 Wed, 13 May 2020 16:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200511021637.37029-1-liwei391@huawei.com>
In-Reply-To: <20200511021637.37029-1-liwei391@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 16:41:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNTkRW9LbNjY_0Ljj57m19gFUEHAuYKd-i6jpu_QpMgg@mail.gmail.com>
Message-ID: <CAD=FV=VNTkRW9LbNjY_0Ljj57m19gFUEHAuYKd-i6jpu_QpMgg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Make the internal env 'KDBFLAGS' undefinable
To:     Wei Li <liwei391@huawei.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 10, 2020 at 7:18 PM Wei Li <liwei391@huawei.com> wrote:
>
> 'KDBFLAGS' is an internal variable of kdb, it is combined by 'KDBDEBUG'
> and state flags. But the user can define an environment variable named
> 'KDBFLAGS' too, so let's make it undefinable to avoid confusion.
>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  kernel/debug/kdb/kdb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 4fc43fb17127..d3d060136821 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -423,7 +423,8 @@ int kdb_set(int argc, const char **argv)
>                         | (debugflags << KDB_DEBUG_FLAG_SHIFT);
>
>                 return 0;
> -       }
> +       } else if (strcmp(argv[1], "KDBFLAGS") == 0)
> +               return KDB_NOPERM;

One slight nit is that my personal preference is that if one half of
an "if/else" needs braces then both halves should have braces.  I
don't know what Daniel and Jason's policies are, though.  In any case,
not that I've ever used the KDBDEBUG functionality, but your change
seems sane.  Without it if I set "KDBDEBUG" and "KDBFLAGS" and then
type "env" I see the flags listed twice, but one is real and one is
fake.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
