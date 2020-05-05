Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C9C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBA920659
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588722962;
	bh=3sOFBfJ7/Y7pRswTyrfyPYAxQMpF/nDHfoDgbjG7YMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yuzbBWphUeNcD8pzR6eiSBqPTSBx9jf0NgDinZbpdeP0/qvTq/ZOIcZs9KusSTsLg
	 bIojIIx9yN3VRF6/6osPxcot+X1cZPYF4jDI3UaZa8Q3MHCb1i56uDS2Ae+LuR/aoF
	 EKaOeDw/9GUD6wV2O8L99TusYJO49e6VCez1kylg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgEEX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:56:01 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:63600 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgEEX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:56:01 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 045NtZnN006317
        for <linux-kernel@vger.kernel.org>; Wed, 6 May 2020 08:55:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 045NtZnN006317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588722936;
        bh=Y9RWxiRgOZwnVwD83VxXe/juAd1avld7+FovXshP7OI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Btemxv12bE2TFIaNRp2UDHOS+O3LYyBMJGNElW4v+e2RRb9kLax99VIJr88qnnKCk
         vtNOxapLTEh9uMnvC1aa3cAJXu/iMLSCz9+DzSHxCAkqtH4WgzA3l2vNthRTjCbrj8
         i9i/O8D2nXJG3vJYPdcjjBhHEDX1vs+0He0eyGsGE9AiHzdDJa5WIv3tTNnOojIxhx
         csgoJRpVVGdYGc7yAYJlQMN5moc1lyAxh2wNuZcXJZuzdWAmv4uB8UR7nNpn6MPLdm
         1i+ZrioO3PVKf48AEPFd2HRbpFaArrHtYn1fsWbe4igMHEFKMGpBtidbwm53an9WA1
         UectidQhDHQug==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id w68so54837vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 16:55:36 -0700 (PDT)
X-Gm-Message-State: AGi0Puaq//sSBa7ybQqI+AXeBU4qXftfHYy6z4fGHuY7NF98Rry/o9I7
        t22olPIqo/MWs1RquPbdW1CUr/QXuHL1FTKiIkM=
X-Google-Smtp-Source: APiQypI+/RbUwYA5RFpvV4RyRz1fC3Ok15Mm/8/k0F/GZ2w3vpKCGOdJSdoDo/J+o9eBlCt2hs0jYbW5su9myiejCGo=
X-Received: by 2002:a1f:1ed1:: with SMTP id e200mr4979912vke.96.1588722934713;
 Tue, 05 May 2020 16:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200428212555.2806258-1-arnd@arndb.de>
In-Reply-To: <20200428212555.2806258-1-arnd@arndb.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 May 2020 08:54:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6-F2qB5=gxZjxwNuArcbiTzsmhHApMUipxy+=QAu6ag@mail.gmail.com>
Message-ID: <CAK7LNAT6-F2qB5=gxZjxwNuArcbiTzsmhHApMUipxy+=QAu6ag@mail.gmail.com>
Subject: Re: [PATCH] samples: fix binderfs sample
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Brauner <christian@brauner.io>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,


On Wed, Apr 29, 2020 at 6:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A routine check for misspelled Kconfig symbols showed on instance
> from last year, the correct symbol name is CONFIG_ANDROID_BINDERFS,
> not CONFIG_CONFIG_ANDROID_BINDERFS, so the extra prefix must
> be removed in the Kconfig file to allow enabling the sample.
>
> As the actual sample fails to build as a kernel module, change the
> Makefile enough to get to build as a hostprog instead.
>
> Fixes: 9762dc1432e1 ("samples: add binderfs sample program")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  samples/Kconfig           | 2 +-
>  samples/binderfs/Makefile | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 5c31971a5745..e0b747cc90c9 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -171,7 +171,7 @@ config SAMPLE_VFIO_MDEV_MBOCHS
>
>  config SAMPLE_ANDROID_BINDERFS
>         bool "Build Android binderfs example"
> -       depends on CONFIG_ANDROID_BINDERFS
> +       depends on ANDROID_BINDERFS
>         help
>           Builds a sample program to illustrate the use of the Android binderfs
>           filesystem.
> diff --git a/samples/binderfs/Makefile b/samples/binderfs/Makefile
> index ea4c93d36256..a3ac5476338a 100644
> --- a/samples/binderfs/Makefile
> +++ b/samples/binderfs/Makefile
> @@ -1,2 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs_example.o
> +ifndef CROSS_COMPILE
> +ifdef CONFIG_SAMPLE_ANDROID_BINDERFS
> +hostprogs := binderfs_example
> +endif
> +endif
> --
> 2.26.0
>


binderfs_example.c includes <linux/android/binderfs.h>.

This uapi header is very new.

include/uapi/linux/android/binderfs.h was added by
commit c13295ad219d8bb0e47942d4cfc8251de449a67e
i.e. Linux  5.0


If this sample is compiled by a compiler with kernel headers
older than Linux 5.0, it will fail to build.


Documentation/process/changes.rst defines the minumal
GCC version, but the minimal kernel header version
is undefined.

Is there any criteria when to add
'-I usr/include' ?


At least, this is this case, I think.

--
Best Regards
Masahiro Yamada
