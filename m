Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F308FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB26520675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO+BX/Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCJNgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:36:31 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35323 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCJMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:42:46 -0400
Received: by mail-yw1-f67.google.com with SMTP id d79so12386287ywd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6+AR1Sm0huTiOmTHUHeBU28UDpRzfwyHTrCE/9H+0k=;
        b=TO+BX/Pc83sjyH/1clGRsJ3evPMnbZNEMBak/+efgmCETo89CvQ/ilyaBphkZIjtCB
         S75kPK6p+VkNIviTIMy1jqmoDgb59I+I0/3bYBkXP/jR8Ifu0C9AyiD6TaNVMJ7PM5Mx
         gnV91kUlK593CUGAymHMd2eSkryNRhaAHD2F5iOc7VBqwDmA7mYAQKD1eU8mP6CgAk9I
         tPW899+q2Lzhs97UGdAyHuyZzR3UHWTc/espqU0/UnURqJpPrV7NS66ipaKCIp9wCwQn
         gN1BE8OK7vCi9Pv796lbWKjELx75rWPJRX0gKTmKtPeKC5lHLmHS6cBLjuqv7OUAMdVP
         ZaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6+AR1Sm0huTiOmTHUHeBU28UDpRzfwyHTrCE/9H+0k=;
        b=dPlwgo8OJtH1sUd3IxL2/rmT8KCsTcjNh/yJwgPq2B040kG/lam9BWIQgnA3+ZhCqd
         HTywzqoej+P7cc4EFE7gCBzzJ5uy2geAsrjl3LIieUhW7mIusBUqV+5U+mIhJgHzZaUi
         EJQC06s0ItK+HN07WxD+MJuqKmVawlc+4TgdSEWvd5qIgX3GDviBu0B/yGcP4BjU31M7
         i1hGPbrirvjUUHLuBYIj0Qfjs5ZifN8Spk7/K7TtD/St+gjVjWS3kXeeesRUaRJkqzOd
         JCvJHjKycr8bunRTjfM0XQeuDLmQHfqhwKlF+jG3zR07FtoEcHWXmjrPY/JshgAZmAjJ
         FUoA==
X-Gm-Message-State: ANhLgQ2zl2FJ/XXxupjY9lHnQv6Viz9i4JsDg4n6zhXtrm4pAmKGmtAy
        n4UIfAXUojToSzDWpc7HcVS2keqM9tLGzANU6dI=
X-Google-Smtp-Source: ADFU+vv54Eb1eXMbNSVCbnLsO+PdRq5jfWrkb5E+TbuBdAGiawFXL5MWgwS36A0l/5qWvvMzujWM1RWYpl1dS4Q/Toc=
X-Received: by 2002:a25:614b:: with SMTP id v72mr21345190ybb.154.1583844165317;
 Tue, 10 Mar 2020 05:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200310115925.126174-1-anup.patel@wdc.com>
In-Reply-To: <20200310115925.126174-1-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 10 Mar 2020 20:42:35 +0800
Message-ID: <CAEUhbmVqrgVF+FFsaO47nOBOZUWzA-LfAfubACNg8yJcx152gw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Only select essential drivers for SOC_VIRT config
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 8:00 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The kconfig select causes build failues for SOC_VIRT config becaus
> we are selecting lot of VIRTIO drivers without selecting all required
> dependencies.
>

Isn't this a sign of some VIRTIO Kconfig options are not correctly
expressing dependencies?

> Better approach is to only select essential drivers from SOC_VIRT
> config option and enable required VIRTIO drivers using defconfigs.
>
> Fixes: 759bdc168181 ("RISC-V: Add kconfig option for QEMU virt machine")
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig.socs           | 14 --------------
>  arch/riscv/configs/defconfig      | 16 +++++++++++++++-
>  arch/riscv/configs/rv32_defconfig | 16 +++++++++++++++-
>  3 files changed, 30 insertions(+), 16 deletions(-)
>

Regards,
Bin
