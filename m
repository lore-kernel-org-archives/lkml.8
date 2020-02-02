Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BEAC3524A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 11:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F322067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 11:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="UGxus0Uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgBBLsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 06:48:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39288 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBBLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 06:48:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so13781488wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 03:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Op0zfe58XdVsuLFDv+kV1nCs9niSTB0gzCPSk7DxSPs=;
        b=UGxus0UvDEEJ26RDo6DrWOA2vo37glkXXFSFf+GTlBeShN0snPnY61EzyFpFflbcP6
         1AgXPK07wWXJXS9BGhu9nzE6uaoHggg4jwSLJczzAxLPO33lbgqV07O3Z0jvovl7o3aG
         wfZukZU1s67yckW3jLJ8T1HiFu9IWrptgcPvcztYI2DIypbNNs7/Khp19P0WrNiaFJ+i
         NaK3kdgK6HEBrD0SPfcD98NTFP75FyC/Y2O6ctpqZmqsJZQmYs+BA4mBDxns/msWKpmy
         CqIsb3Ge7I9O09tHPaJpE6Xy7g4dD7HbrfcfSP+nT7X6J9aOXVcCcyVxatvywF3/UN6N
         vpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Op0zfe58XdVsuLFDv+kV1nCs9niSTB0gzCPSk7DxSPs=;
        b=j8qseUjQxcfeaow3OcMPezxS7xjMtkA5NrjOFwBsEJ3dZSKzmM6VtNDUFWV/e453zQ
         9yl5W/oEFMdHJ5zVLKHsq0hmr5fmzk9g/4IEslaMFx6Fzqth9VYYHhwxk+/I0mjfCA7a
         4pfPVimuV4XRcysGzI8s5v+C8qHtHWB6nf7xVsn2E4BVY4ePXduic1VvWeKzBnVHle4M
         zHaJa5NXQwRWUSXJVQo/ux9+SI27GsZ2ZfJyzmqo328V8anY95W/TPczZOR1UHTEyZTd
         fWvacqK3fbRJucfgU4GFZFNnPqi4tojY77CLfOkPR+VEFTe3BYhkkkviqQPXrR3MYKHk
         9dFw==
X-Gm-Message-State: APjAAAXbEC3gTJIQGkWNBNyBr4mlBQ4YsJfp+28ICEtFxQlmIjXnV7TN
        WlVzkLRWM60/A6z9tA71kHOU1E8rpcxfgZXaWmIcCXaQ0g2y
X-Google-Smtp-Source: APXvYqxq7L4O+L8Zw+nM1sKEx/N3GRXkz3TOVixpfJQrX2G1q0+48Y2iIlYhn2cIHDmMG2e+GnhI1z0A0QWYcaZav2w=
X-Received: by 2002:a05:600c:2113:: with SMTP id u19mr22862304wml.78.1580644110192;
 Sun, 02 Feb 2020 03:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20200202110202.124048-1-anup.patel@wdc.com>
In-Reply-To: <20200202110202.124048-1-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 2 Feb 2020 03:48:18 -0800
Message-ID: <CAOnJCU+_CnH6XcXbVrf4LCg3s830n6x6OyWckzoBC-kG2yFpwQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Don't enable all interrupts in trap_init()
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 3:06 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> Historically, we have been enabling all interrupts for each
> HART in trap_init(). Ideally, we should only enable M-mode
> interrupts for M-mode kernel and S-mode interrupts for S-mode
> kernel in trap_init().
>
> Currently, we get suprious S-mode interrupts on Kendryte K210
> board running M-mode NO-MMU kernel because we are enabling all
> interrupts in trap_init(). To fix this, we only enable software
> and external interrupt in trap_init(). In future, trap_init()
> will only enable software interrupt and PLIC driver will enable
> external interrupt using CPU notifiers.
>
> Cc: stable@vger.kernel.org
> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code)
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f4cad5163bf2..ffb3d94bf0cc 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -156,6 +156,6 @@ void __init trap_init(void)
>         csr_write(CSR_SCRATCH, 0);
>         /* Set the exception vector address */
>         csr_write(CSR_TVEC, &handle_exception);
> -       /* Enable all interrupts */
> -       csr_write(CSR_IE, -1);
> +       /* Enable interrupts */
> +       csr_write(CSR_IE, IE_SIE | IE_EIE);
>  }
> --
> 2.17.1
>
>

Looks good.
Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
