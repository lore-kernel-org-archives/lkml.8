Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35004C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1620760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lUDpaAUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGPNNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:13:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D69C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:13:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so7048018wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9u0OaI73oXhhsb+oeV3fiveuxa7GdvhC13FjWGvhnU=;
        b=lUDpaAUiBGrLCQlRiX+SgWv6HzFUpZjxg8IbVIxQAjEem/sOgyzudjH1Ew2udNkvnz
         CZQSIxD0QpP+GxU65RWUZKiEl0ZDuVnwaLPZPBDrX5kZkpcmDn8l/GDC7vsLr1ZCUryT
         4vJH83uX+Essxes/0nPXT4VXyiKkziIPkQLw6/kBXq/75Z8wp1rTV9Uryv4E2RCddiz8
         UQwqwUHWPADle7ZRaPjCIafb33zMWegcMSWgTAtWGaMuLFtJNkrInhBMHuM7UYV/8zJo
         +x9vGTpqvugEAC74jtG6zR8B3/mqj8+TiAyjE3pwPzLa5VMPohnn2OePR443sucX3oBx
         KihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9u0OaI73oXhhsb+oeV3fiveuxa7GdvhC13FjWGvhnU=;
        b=fe7ueV6QssadOfbg6m3xuSFxGVH1PxvWoA63w5ltRAmL0nk1CZCI7hpDxXmEVDjHUF
         vTheYNdRc24i6yFIVwgqnVg6T1ZBMVAlFr1zGoR/NTUmq4eQey79C57dAvyW/8j0N/Z1
         ElUDYntJ2j3nZegZp8PkGhLolv4w61OaLk+GETr4T1kBnxyDERsvVg/aox0w+666b0RX
         1cWqXEFiq2xOGfYgTUenZZwzQu6rCIw8jhJWQZaGUV9hhzE7R1FGDjQV3caLq90AkyOy
         ECrC2TcIdmZmyjHtG+GxksrAE8MZ0hIgYqvxi5cjijL/8bbswJkfGwF1jliRUlts9Zf8
         zCSw==
X-Gm-Message-State: AOAM5316ENDpBTgD0BU47+id34IDsdVltaEnpcBElAuNhydJ7d4ckMkp
        wxvU1u4dUOClSNjqKrBB07NOIcFlparo2aK3Acn3cA==
X-Google-Smtp-Source: ABdhPJyNrDd++3iRKErtZgLSEvCnoA9VLxRwm6VVLX4CuD9FS6IlrIlhxCvro2daVx57TMR+P//3sqVgv/nFdgNLLZg=
X-Received: by 2002:adf:ff87:: with SMTP id j7mr5358437wrr.128.1594905197215;
 Thu, 16 Jul 2020 06:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <1594874393-23620-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594874393-23620-1-git-send-email-bmeng.cn@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Jul 2020 18:43:03 +0530
Message-ID: <CAAhSdy0==OEUUs6-+0g=kogqm2J=64XFiacNL7HdgZwyS-3hWA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add SiFive drivers to rv32_defconfig
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:10 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This adds SiFive drivers to rv32_defconfig, to keep in sync with the
> 64-bit config. This is useful when testing 32-bit kernel with QEMU
> 'sifive_u' 32-bit machine.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  arch/riscv/configs/rv32_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 05bbf52..8759501 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -14,6 +14,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
> +CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
> @@ -61,6 +62,8 @@ CONFIG_HVC_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_SPI=y
> +CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
> @@ -76,6 +79,8 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_MMC=y
> +CONFIG_MMC_SPI=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
