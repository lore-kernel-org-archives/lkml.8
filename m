Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2BC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455132064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rI7NENBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgDQMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727897AbgDQMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:41:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C35EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:41:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so840505wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5d/+Mz/K41+l5nHe9+HnUq2CLogiiEQD3UQf60PXu/k=;
        b=rI7NENBDqfn/fQ7qMbOy7mITJfkQZEgaC2hsDwXL+0KFHV3dDjMAv2g3Jg61nEmyy6
         8ANMlYPUB/U1teG3lMdroPrkMNaHEAcZuqQlz64TkXMTB23LkwaBwjJgSomws8ogA52Z
         XO0/dACcTP0sFZuFnhLB94gL5IKx/+KKdwRGWoQ41L43VgH1XL0sk7TJnEyVHMgQX4l5
         CmweALmDi9EHLblVMek5HkyTylDkLdtzDp4iDrvtL1t7/rmTD3clnDBLUD80BVmdOQre
         cCI2lzKvXTlC7kQHsFC/qUAtpETJqhlMaMkes8BMTqNdcFQUjXfz11aWAldnMRu9F/dG
         6Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5d/+Mz/K41+l5nHe9+HnUq2CLogiiEQD3UQf60PXu/k=;
        b=YzyqfL7IHlnppIY0LxPGkEWaCS0INSJTkfPATTBwkX/69XYI38o+haXRSTsDff+8b+
         7TlyXEpLHoRdjcVNxomNMKPBTpFZEf2a1y3LurwMJ0ZkBgQUB5l5JBI42X5t6x/RD5Op
         4quJ5QGQE5SWyacKDz+S5FdVovnZPG4/WOE+YyNa/HMjMglUej5mxX1diZ+jl9+gERtq
         +FK03tT+XZt73M6D1VJtRjzvU9IZPGJtgLyxwGY8xWWni+Jb/SvvJ8lYIKFwFzo6O3w3
         p4dKHZWsXjzVO9T0nwfbpu3lD2BGa1WOHJlKv3lxtXWM/mBO1O3QgUoPuxMVuVvf+GQk
         cDRA==
X-Gm-Message-State: AGi0PubadctFaqGXSmo4WAbI5N4JG1+R5lJQXVdbLrOLAJKaV9yU+JmP
        3rE34AaiqbqR5uw/xz/fYgoLHHFJneXGKQXJMNnkfw==
X-Google-Smtp-Source: APiQypINgiS8TdVKf+DZcpqWM6CnJsqHx/bwUe303I5G+wpdbKEuPCqn6K1HfP0lC0KGhWUgUZW/5cGLYE2KWBl1U5E=
X-Received: by 2002:adf:c601:: with SMTP id n1mr3534017wrg.381.1587127264046;
 Fri, 17 Apr 2020 05:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200417121222.156422-1-wangkefeng.wang@huawei.com> <20200417121222.156422-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20200417121222.156422-2-wangkefeng.wang@huawei.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Apr 2020 18:10:51 +0530
Message-ID: <CAAhSdy3_0-rLZQUv_u-Drdxy_nw4xzM85gN_Qo_WcXC8aGDhzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tty: riscv: Using RISCV_SBI_V01 instead of RISCV_SBI
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 5:40 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As shown in SBI v0.2, the legacy console SBI functions (sbi_console_getchar()
> and sbi_console_putchar()) are expected to be deprecated; they have no replacement.
>
> Let's HVC_RISCV_SBI and SERIAL_EARLYCON_RISCV_SBI depends on RISCV_SBI_V01.
>
> Fixes: efca13989250 ("RISC-V: Introduce a new config for SBI v0.1")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/tty/hvc/Kconfig    | 2 +-
>  drivers/tty/serial/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 31b7e1b03749..d1b27b0522a3 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -88,7 +88,7 @@ config HVC_DCC
>
>  config HVC_RISCV_SBI
>         bool "RISC-V SBI console support"
> -       depends on RISCV_SBI
> +       depends on RISCV_SBI_V01
>         select HVC_DRIVER
>         help
>           This enables support for console output via RISC-V SBI calls, which
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0aea76cd67ff..adf9e80e7dc9 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -86,7 +86,7 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
>
>  config SERIAL_EARLYCON_RISCV_SBI
>         bool "Early console using RISC-V SBI"
> -       depends on RISCV_SBI
> +       depends on RISCV_SBI_V01
>         select SERIAL_CORE
>         select SERIAL_CORE_CONSOLE
>         select SERIAL_EARLYCON
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
