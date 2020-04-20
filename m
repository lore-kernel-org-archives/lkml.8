Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE44DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEDB20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgDTOfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:35:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgDTOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:35:13 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N45th-1jHMUx43rV-0105HW for <linux-kernel@vger.kernel.org>; Mon, 20 Apr
 2020 16:35:11 +0200
Received: by mail-qt1-f169.google.com with SMTP id z90so8546168qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:35:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuahG27kNBpjdzcO8xGat2cRhoSuipOu9DeBfwE9kl1pmWQdFXNQ
        haSFqGcfe8HUzkjtGcwnl8uhXEH871fVyKBULNc=
X-Google-Smtp-Source: APiQypJ8+eSyM92GKz+tgktc3MN8Tu0mYjJI8QaeKzhQGr6nLHXQdvHnLZbXBCSy5i2jRKmsTpsr3bDsRZBUFnm0wII=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr16212594qtp.304.1587393309871;
 Mon, 20 Apr 2020 07:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200420030538.101696-1-wenhu.wang@vivo.com>
In-Reply-To: <20200420030538.101696-1-wenhu.wang@vivo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 16:34:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ErZh6teKEC8srU5E1WmXxtTgQppt1yDoYmO7huw4gqA@mail.gmail.com>
Message-ID: <CAK8P3a1ErZh6teKEC8srU5E1WmXxtTgQppt1yDoYmO7huw4gqA@mail.gmail.com>
Subject: Re: [PATCH v2,RESEND] misc: new driver sram_uapi for user level SRAM access
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kernel@vivo.com,
        Rob Herring <robh@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f2KcBoQYKMkDgGCqtwpUxjQ4BrGLgCXosMUHdU42ZMlCwfboEx8
 o/UC7mLD3M1uD0ncxhJGmDjhNLwiSu78TGgPbleNfkhx21n1gOXYeZUzRyTvugdC2q1gGQM
 FkTekJondpUYpvFiQxXMKGCX6cXF1jF3EN/LSXIxh1c8fkj7SUKL8KR33wQLlgDgTTK5s3t
 UaG8sQunweBBFU5PG13FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t2mjBYshxc4=:Zm43rhuYlnsdUeOB8eHDHk
 hIgV2c+XbsOAyna+DhZFIKrk/2ujUMs7rAfT0VHZCPnFdhWxyR5A2LXUXFJY0dMeDWzmJokAK
 qPyOwgT5kA9nUBqB793UeZf4R2cSx1dbQ74pA8LERnVbqjCFNXPPSKwU7ZmmcTIQUXgBCXJA/
 +FdOZlalnLoByUi+KAQ4JC3tFQD64cjRnRVJT2uDJEZwOf2Tm8PbVhgnZ9fVv3AO/wRN+MunM
 3hBQ5tb9jHutdTd9PULZ6ieJGvSrPzT1/IHivuUI5jx3f9IwjWMoMD1GPqPJgM23KI4OjIiIh
 BZjv4gsQGgWZFwE3iuCX3aTlZGa16suvAKEtq3z8LX8+861FMPsqV1UroclTtRPY8PYnfCcQ+
 DolqCOb1hykFRkHpnBPn2vb9GQMjSYnQILVMI350IYy4gmtb2uby2wLJTL+8mLg3gdN8lJvk0
 j8ayH7ZwFuS33B0VSNFxD4L7aBSeSe2OAI/9DDAYdE3rsmhTvLFO0A2MWMnR/QTp6a7D1M4pJ
 +ArrZ+p7toPRAB0aMLVPv8/j+6Z+9FsGaTY/CK4SmwA4mpzP0qGqrFOyBCMATEDNYO0s4pTUx
 UVPUPNmHAbz0xYJwVrIQsqzG3z7NshtVq5jO4N+4z5Y0ynkstGTr9GpQ4tNbhzJ61xulnwbsG
 NeXtuABeqz0oGTTy/K5fATECbZo/6t2ge5NOdZAwNw0zc1WHWzPl+i27aGEE/GK37CB9ES4jo
 1tTZvQabQCDzYKD0dVFc4ZUrDbnBEA0SGi9oKEtPGbyHtQFTfUYm8FHJWZ7bE2vVZQaTLggR9
 sMtbGuj9ON8Vcoy6/XQ20Um4nU48wXEnbbIKNMaEw+Ms/bo/4s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 5:06 AM Wang Wenhu <wenhu.wang@vivo.com> wrote:
>
> A generic User-Kernel interface that allows a misc device created
> by it to support file-operations of ioctl and mmap to access SRAM
> memory from user level. Different kinds of SRAM alloction and free
> APIs could be registered by specific SRAM hardware level driver to
> the available list and then be chosen by users to allocate and map
> SRAM memory from user level.
>
> It is extremely helpful for the user space applications that require
> high performance memory accesses, such as embedded networking devices
> that would process data in user space, and PowerPC e500 is a case.
>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> Changes since v1: addressed comments from Arnd
>  * Changed the ioctl cmd definitions using _IO micros
>  * Export interfaces for HW-SRAM drivers to register apis to available list
>  * Modified allocation alignment to PAGE_SIZE
>  * Use phys_addr_t as type of SRAM resource size and offset
>  * Support compat_ioctl
>  * Misc device name:sram

Looks much better already.

> Note: From this on, the SRAM_UAPI driver is independent to any hardware
> drivers, so I would only commit the patch itself as v2, while the v1 of
> it was wrapped together with patches for Freescale L2-Cache-SRAM device.
> Then after, I'd create patches for Freescale L2-Cache-SRAM device as
> another series.

What I meant to suggest was actually to tie it more closely to
the code we already have in drivers/misc/sram.c, which already
has some form of abstraction.

> +static int __init sram_uapi_init(void)
> +{
> +       int ret;
> +
> +       INIT_LIST_HEAD(&sram_api_list);
> +       mutex_init(&sram_api_list_lock);
> +
> +       ret = misc_register(&sram_uapi_miscdev);
> +       if (ret)
> +               pr_err("failed to register sram uapi misc device\n");

The mutex and listhead are already initialized, so this can
be a one-line function

    return misc_register(&sram_uapi_miscdev);

> --- /dev/null
> +++ b/include/linux/sram_uapi.h

The ioctl definitions need to be in include/uapi/linux/

> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SRAM_UAPI_H
> +#define __SRAM_UAPI_H
> +
> +/* Set SRAM type to be accessed */
> +#define SRAM_UAPI_IOC_SET_SRAM_TYPE    _IOW('S', 0, __u32)
> +
> +/* Allocate resource from SRAM */
> +#define SRAM_UAPI_IOC_ALLOC            _IOWR('S', 1, struct res_info)
> +
> +/* Free allocated resource of SRAM */
> +#define SRAM_UAPI_IOC_FREE             _IOW('S', 2, struct res_info)

struct res_info needs to also be defined here, so user applications can
see the definition, and it has to use __u64, not phys_addr_t, to ensure
the API does not depend on kernel configuraiton.

        Arnd
