Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3708520870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCEHvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:51:13 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:60301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgCEHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:51:12 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mk178-1jcBCo3SLw-00kPug for <linux-kernel@vger.kernel.org>; Thu, 05 Mar
 2020 08:51:11 +0100
Received: by mail-qv1-f54.google.com with SMTP id r15so2029449qve.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:51:10 -0800 (PST)
X-Gm-Message-State: ANhLgQ2U+8pPT5kfyGfFXqzd6MriA8KgQoFaWBDnMBNbsBeLzpZD8JjN
        zxhE07MuCNtrq725d4vyOyeNKR2kU+YrfXuLmxc=
X-Google-Smtp-Source: ADFU+vstp1h0CG3pY8NKD3dLm/x1PP0tZEXhU2VaJcMhmxB0PpHKWPcO9B09FS7oilMTPjj9fe4r4108YlpY1i3Z7Sk=
X-Received: by 2002:a0c:f647:: with SMTP id s7mr5473438qvm.4.1583394669674;
 Wed, 04 Mar 2020 23:51:09 -0800 (PST)
MIME-Version: 1.0
References: <4e90d9af-c1ec-020f-b66b-a5a02e7fbe59@infradead.org>
In-Reply-To: <4e90d9af-c1ec-020f-b66b-a5a02e7fbe59@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Mar 2020 08:50:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0yfaZM6_jtbcgam7+ku2K3ZROnk2VGx+UAk0EODGs5WQ@mail.gmail.com>
Message-ID: <CAK8P3a0yfaZM6_jtbcgam7+ku2K3ZROnk2VGx+UAk0EODGs5WQ@mail.gmail.com>
Subject: Re: [PATCH] char: group some /dev configs together and un-split tty configs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oocrq4800gh6pLpqB35733BbJ3muCU01A0MOJSGXzY2Z2Qn4ML7
 2txQYJBW2U6eHSIanq/6I88cOb/mCkBRWY8zxgIYig5GPAa3RhTfOll4oaQqpc033xyOShN
 z18NfFcqyCcmQmElJlEHGcHcDgqhYdE/GHs1XO+TdlOV1u7p3U0Az2bzbzo+ZGWmw/duKAK
 M/g0tt8ioUxGf34NHG12Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H5vi0Qhmjfk=:TAQiCgTzDwnOb01NdSEckR
 DD5taXro6OT2UQ+I4kW0vKpf9xa66onSL7IswTaCF63coGTaeOD4UUaie1mNPJGwvNeXNlkjA
 3XDxzkYvxJ5Efw/y4NstsCoFEChTlMQhM90UVqERfUB9YvBnsqcDz+XIYpdrw44Ow1PiMuoyz
 uyh11+9VNtDVY17CRZygM7DXJKCVOELbm/q9xB82icW0p8vQSbhLyf96gEceVBNmFW8piU1hC
 LoOQ6l+bTVwKRh/zpItN3Wpt+9nC6dTt2tVEsFWheXzbYAaPWUeTtQU3dRlVXf1mW+/ZP+trS
 J7Gqd0jBS5/SnMZiJQjpgiEZCAUCrTbNKiADtea/AhNPQEzI5/MT1ZgIIv4p38YZj7Y5WiXtA
 ZQE2BQmcPndVOvSSAgWuTs5SjODPEDEViHf1yZIuZPLVyJWRQ7NjdfOev2Yk6zeDuhbBifxN5
 NwCims9ZdR4L+WtEwYJB4Oa2sxe8OqLl5txpsyiCIuGaCjIk2ttmo/u4w4ZKXViRKK58vyqUz
 eeOH5zvZMoKdMxDMbqRnk+W6A1ud1hYotlEI2McxqgC01UfvXGFTMhMvB9hP8EzR7JbVHkCdn
 qNHV12U3wM0Ri4gCbAXFeAKdPr60Q6QmtfuLNp9vIRZbZqldPF4wnHoxV4JrjsNck/MA6IA+5
 CxkVHX6R+MDUMM9ZemTiGTFLwoVGR1KxkpgyPeLjdUPqdrTbGmqe/mdsGZulN+oYX60m6rZTW
 nE09m+gYAqoihiL/UMeALmtTh6S1ar190RI+wY4fmiw/Z51R2XS6t92cwx9ZKM/3RfYp/T8qp
 BIkXc66ZPrxAWP2FNibr5p+6Bw64+PkjE6hqiUTKptLM4PGRHw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 7:45 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Group /dev/{mem,kmem,nvram,raw,port} driver configs together.
> This also means that tty configs are now grouped together instead
> of being split up.
>
> This just moves Kconfig lines around. There are no other changes.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/Kconfig |  100 ++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 50 deletions(-)
>
> --- linux-next-20200304.orig/drivers/char/Kconfig
> +++ linux-next-20200304/drivers/char/Kconfig
> @@ -7,25 +7,6 @@ menu "Character devices"
>
>  source "drivers/tty/Kconfig"
>
> -config DEVMEM
> -       bool "/dev/mem virtual device support"
> -       default y
> -       help
> -         Say Y here if you want to support the /dev/mem device.
> -         The /dev/mem device is used to access areas of physical
> -         memory.
> -         When in doubt, say "Y".
> -
> -config DEVKMEM
> -       bool "/dev/kmem virtual device support"
> -       # On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
> -       depends on !ARM64
> -       help
> -         Say Y here if you want to support the /dev/kmem device. The
> -         /dev/kmem device is rarely used, but can be used for certain
> -         kind of kernel debugging operations.
> -         When in doubt, say "N".
> -
>  source "drivers/tty/serial/Kconfig"
>  source "drivers/tty/serdev/Kconfig"

Good idea!

Looking at the result though, how about including drivers/tty/*/Kconfig
from drivers/tty/Kconfig after this? From the user point of view, it's
the same, but it seems to be grouped more logically then.

CONFIG_SYNCLINK_CS (in drivers/char/pcmcia/Kconfig) is also a
tty option that should probably get moved, but I guess that's an unrelated
change, and it would make sense to move the driver along with the
option.

      Arnd
