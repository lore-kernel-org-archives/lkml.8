Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5878620657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFs5UOpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgGOIoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgGOIo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:44:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:44:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so2645111pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQZ+5fRESyEi63NIelgd90G0TtLUIL0LzSPgqMyfTyM=;
        b=qFs5UOpAaOm+WGRKa8yt+h+sNKKx5DXUBETYTeROWmGtZlF9E60iYM66u9BQMEar+G
         vEzjCPPA0S2CDZUi4v1y6DoA5siI+TCH9TrIT49WLvIURisB7cph3iO4eJuie53/iUQ5
         /Jz9gC52PAEeOkBQYAUPSkoetziXdG2pHrKTKFhgBqFo9fZ3PKtlga4stHf6138143rF
         Y3SKawrS4W+ltNKuleWcVeD73hFu9VXunP7qU1hrMOYh1QqoKp9z+XxAewEYjNb9qpkb
         JWhfW9uduotjkNcZXm/6JDfDsPnv43oRMD8GS81+LcsGs1t0pWeKY02eTHS5Lv2Z4LEy
         MXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQZ+5fRESyEi63NIelgd90G0TtLUIL0LzSPgqMyfTyM=;
        b=RXno7w1cvyU6Gc/Elfez0rARkdibwFHXGk1Ue7MoxIJSKcbUAyPQibXoI8SY3dBwC9
         h2NFuJ8PlidCdIbNIoFTtoRvhp/Ol66955qqKiRKyGvD3VP+eqrB1AftmEmDRdPhu5sH
         W3zAU5flfjbxpcje2vB9P3vTKr/Yk/rVLMOew/l3d1UxHM1vDz+YWo5imBHFXnFk8SaH
         075r32hgV6Mdu45XHoh1zmpzyLqaiXMTAVFwRuPoUOPjWEL+FVeiwPlyODz3CO3AsJIB
         a7RxIxZ+6X/JpIBZKZDDzvrRlHpphDXyJ3NaY1j9xCdCw8rOmti1tc4fGUKaMROjXOSn
         KwPA==
X-Gm-Message-State: AOAM531kndkNKqy3KBsRf3UwlHAn8nisyHwJjkcztuKnba/SFhA0WoZX
        tsW5DgpRWQb/On7A+8hzAI50JEgxGhQbz1sbBeMX8g==
X-Google-Smtp-Source: ABdhPJxKV2Qih0pRErB5HR7H8Cpzgcn1iUkcpTb3z47Perx/PI1mWPDqewFDOixtcRSv86ABrAacAvT5BYgqgubgI9w=
X-Received: by 2002:a17:90a:4bc7:: with SMTP id u7mr9250189pjl.217.1594802668714;
 Wed, 15 Jul 2020 01:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com> <20200704085213.444645-4-ignat@cloudflare.com>
In-Reply-To: <20200704085213.444645-4-ignat@cloudflare.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 15 Jul 2020 01:44:17 -0700
Message-ID: <CAFd5g44Hxhxjqb6WkfaMtaTDKVhs0onnkRaQ0Aq55z6oYTbJbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] um: allow static linking for non-glibc implementations
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 1:52 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> implementations, which do not rely on NSS, such as musl.
>
> Allow static linking in this case.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

One minor issue below. Other than that:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  arch/um/Kconfig         | 2 +-
>  arch/um/drivers/Kconfig | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9318dc6d1a0c..af7ed63f9c74 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -67,7 +67,7 @@ config FORBID_STATIC_LINK

Doesn't look like FORBID_STATIC_LINK is used anymore, so you should
probably drop it as well.

With the preceding changes, in this patchset, you can revert my patch
like you did in the RFC - or not, your choice. I am not offended by
people reverting my commits. I just don't like it when people break
allyesconfig. :-)

>  config STATIC_LINK
>         bool "Force a static link"
> -       depends on !FORBID_STATIC_LINK
> +       depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
>         help
>           This option gives you the ability to force a static link of UML.
>           Normally, UML is linked as a shared binary.  This is inconvenient for
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 9160ead56e33..72d417055782 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -234,7 +234,6 @@ config UML_NET_DAEMON
>  config UML_NET_VECTOR
>         bool "Vector I/O high performance network devices"
>         depends on UML_NET
> -       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network driver uses multi-message send
>         and receive functions. The host running the UML guest must have
> @@ -246,7 +245,6 @@ config UML_NET_VECTOR
>  config UML_NET_VDE
>         bool "VDE transport (obsolete)"
>         depends on UML_NET
> -       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network transport allows one or more running
>         UMLs on a single host to communicate with each other and also
> @@ -294,7 +292,6 @@ config UML_NET_MCAST
>  config UML_NET_PCAP
>         bool "pcap transport (obsolete)"
>         depends on UML_NET
> -       select FORBID_STATIC_LINK
>         help
>         The pcap transport makes a pcap packet stream on the host look
>         like an ethernet device inside UML.  This is useful for making
> --
> 2.20.1
>
