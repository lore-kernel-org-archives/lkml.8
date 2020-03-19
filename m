Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E9C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219062071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YXAM1GQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCSEaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 00:30:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgCSEaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 00:30:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id r7so3825073wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNG/4gsDlzID/iu3w+7gBGtdDaCICA3ZSeGXD3zpCk4=;
        b=YXAM1GQ1QpTkAV165dYe5R2hLUQ7NtlOJaPdIEHv4eQutWDukXGoQWco8p0IFSXu7x
         WTXdbLZFfC+6+MxJE1nkJEldIgRV/i/jYYEq8mD6ch/keXX8TyluN7g4fTrddvuX31wi
         pXWcbqNc4kEFZ6vMaF86+ybbobPrWmBn7aPm5WK4oRZZ7j88SZ3zQNcs1SQQqiy8Q7XU
         09lDLm56TmcwsJIUdrAGY8GDjmQssR16AdbliMTA4vi2OiFJmqaeu3NDwIFDxth/Cbtr
         USrVqSkQng8XOo48I+QO604ysAX3eUtd/76DaBLY15WpsZKSF+87pDhBsnRvAmSmB6Ec
         gRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNG/4gsDlzID/iu3w+7gBGtdDaCICA3ZSeGXD3zpCk4=;
        b=PQ1UHyw1vfkxUjvLROrgCiB7Hs9s8rA6m0+AodiVtxdduE5hPkr99hyxq73FqxAp1n
         5cHtgrVMuPUItn8MdQgPvdvzVFhfepNQcbNauh5uLkkOdbTUXF4pqTn+a7loLkdN9BXk
         tK1B7OE7UY4sypkcYs+HyWBny9NjLAPx7TEyRmL79ByZomwLrAS+towlG9SJsIl2WsZR
         lVDTzlrDgum6wMMur18Wx2mUIaatzKfPkt/xwJqN686joaaLNuCqEbvwD73MsFRnZoDZ
         9idk3caUkFkSOEcPRcpQm2Hqt5Zxb6LbAQZzQPknX4VlsGW4CcisUyKMlP9v7EWZlCeh
         GQFQ==
X-Gm-Message-State: ANhLgQ28zXcJ6Q9ZNLConyciyPDe2ug1NMHX7N7mSLSr10GgfS0IfRQa
        C5DJuOvq4SXdwGP2aeVTWt97uyixcDGdbo3niYt9y39U
X-Google-Smtp-Source: ADFU+vuEQwg54UfRnVUivvi2XAvw1kpPkO+wKIeQOvogrYA6XaZZDcGKFwx/sipK4ZcE3k+HyqO+TMExufbbQHxzTm0=
X-Received: by 2002:a7b:c458:: with SMTP id l24mr1229147wmi.120.1584592208974;
 Wed, 18 Mar 2020 21:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200310115925.126174-1-anup.patel@wdc.com> <20200310081558-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200310081558-mutt-send-email-mst@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 19 Mar 2020 09:59:56 +0530
Message-ID: <CAAhSdy2ALTEAYO==KR3kobrmrf8ct0Zzf2aJSSU_qGJHt8SMgw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Only select essential drivers for SOC_VIRT config
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Mar 10, 2020 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Mar 10, 2020 at 05:29:25PM +0530, Anup Patel wrote:
> > The kconfig select causes build failues for SOC_VIRT config becaus
> > we are selecting lot of VIRTIO drivers without selecting all required
> > dependencies.
> >
> > Better approach is to only select essential drivers from SOC_VIRT
> > config option and enable required VIRTIO drivers using defconfigs.
> >
> > Fixes: 759bdc168181 ("RISC-V: Add kconfig option for QEMU virt machine")
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> Yea makes sense.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Can you take this fix for Linux-5.6-rc7 ?

Regards,
Anup

>
> > ---
> >  arch/riscv/Kconfig.socs           | 14 --------------
> >  arch/riscv/configs/defconfig      | 16 +++++++++++++++-
> >  arch/riscv/configs/rv32_defconfig | 16 +++++++++++++++-
> >  3 files changed, 30 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 3078b2de0b2d..a131174a0a77 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -12,20 +12,6 @@ config SOC_SIFIVE
> >
> >  config SOC_VIRT
> >         bool "QEMU Virt Machine"
> > -       select VIRTIO_PCI
> > -       select VIRTIO_BALLOON
> > -       select VIRTIO_MMIO
> > -       select VIRTIO_CONSOLE
> > -       select VIRTIO_NET
> > -       select NET_9P_VIRTIO
> > -       select VIRTIO_BLK
> > -       select SCSI_VIRTIO
> > -       select DRM_VIRTIO_GPU
> > -       select HW_RANDOM_VIRTIO
> > -       select RPMSG_CHAR
> > -       select RPMSG_VIRTIO
> > -       select CRYPTO_DEV_VIRTIO
> > -       select VIRTIO_INPUT
> >         select POWER_RESET_SYSCON
> >         select POWER_RESET_SYSCON_POWEROFF
> >         select GOLDFISH
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index c8f084203067..2557c5372a25 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
> >  CONFIG_IP_PNP_RARP=y
> >  CONFIG_NETLINK_DIAG=y
> >  CONFIG_NET_9P=y
> > +CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_PCI=y
> >  CONFIG_PCIEPORTBUS=y
> >  CONFIG_PCI_HOST_GENERIC=y
> > @@ -38,12 +39,15 @@ CONFIG_PCIE_XILINX=y
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_BLK_DEV_LOOP=y
> > +CONFIG_VIRTIO_BLK=y
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_BLK_DEV_SR=y
> > +CONFIG_SCSI_VIRTIO=y
> >  CONFIG_ATA=y
> >  CONFIG_SATA_AHCI=y
> >  CONFIG_SATA_AHCI_PLATFORM=y
> >  CONFIG_NETDEVICES=y
> > +CONFIG_VIRTIO_NET=y
> >  CONFIG_MACB=y
> >  CONFIG_E1000E=y
> >  CONFIG_R8169=y
> > @@ -54,13 +58,16 @@ CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> >  CONFIG_HVC_RISCV_SBI=y
> > +CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> > +CONFIG_HW_RANDOM_VIRTIO=y
> >  CONFIG_SPI=y
> >  CONFIG_SPI_SIFIVE=y
> >  # CONFIG_PTP_1588_CLOCK is not set
> >  CONFIG_POWER_RESET=y
> >  CONFIG_DRM=y
> >  CONFIG_DRM_RADEON=y
> > +CONFIG_DRM_VIRTIO_GPU=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> >  CONFIG_USB=y
> >  CONFIG_USB_XHCI_HCD=y
> > @@ -74,6 +81,12 @@ CONFIG_USB_UAS=y
> >  CONFIG_MMC=y
> >  CONFIG_MMC_SPI=y
> >  CONFIG_RTC_CLASS=y
> > +CONFIG_VIRTIO_PCI=y
> > +CONFIG_VIRTIO_BALLOON=y
> > +CONFIG_VIRTIO_INPUT=y
> > +CONFIG_VIRTIO_MMIO=y
> > +CONFIG_RPMSG_CHAR=y
> > +CONFIG_RPMSG_VIRTIO=y
> >  CONFIG_EXT4_FS=y
> >  CONFIG_EXT4_FS_POSIX_ACL=y
> >  CONFIG_AUTOFS4_FS=y
> > @@ -88,16 +101,17 @@ CONFIG_NFS_V4_2=y
> >  CONFIG_ROOT_NFS=y
> >  CONFIG_9P_FS=y
> >  CONFIG_CRYPTO_USER_API_HASH=y
> > +CONFIG_CRYPTO_DEV_VIRTIO=y
> >  CONFIG_PRINTK_TIME=y
> >  CONFIG_DEBUG_FS=y
> >  CONFIG_DEBUG_PAGEALLOC=y
> > +CONFIG_SCHED_STACK_END_CHECK=y
> >  CONFIG_DEBUG_VM=y
> >  CONFIG_DEBUG_VM_PGFLAGS=y
> >  CONFIG_DEBUG_MEMORY_INIT=y
> >  CONFIG_DEBUG_PER_CPU_MAPS=y
> >  CONFIG_SOFTLOCKUP_DETECTOR=y
> >  CONFIG_WQ_WATCHDOG=y
> > -CONFIG_SCHED_STACK_END_CHECK=y
> >  CONFIG_DEBUG_TIMEKEEPING=y
> >  CONFIG_DEBUG_RT_MUTEXES=y
> >  CONFIG_DEBUG_SPINLOCK=y
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> > index a844920a261f..0292879a9690 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
> >  CONFIG_IP_PNP_RARP=y
> >  CONFIG_NETLINK_DIAG=y
> >  CONFIG_NET_9P=y
> > +CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_PCI=y
> >  CONFIG_PCIEPORTBUS=y
> >  CONFIG_PCI_HOST_GENERIC=y
> > @@ -38,12 +39,15 @@ CONFIG_PCIE_XILINX=y
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_BLK_DEV_LOOP=y
> > +CONFIG_VIRTIO_BLK=y
> >  CONFIG_BLK_DEV_SD=y
> >  CONFIG_BLK_DEV_SR=y
> > +CONFIG_SCSI_VIRTIO=y
> >  CONFIG_ATA=y
> >  CONFIG_SATA_AHCI=y
> >  CONFIG_SATA_AHCI_PLATFORM=y
> >  CONFIG_NETDEVICES=y
> > +CONFIG_VIRTIO_NET=y
> >  CONFIG_MACB=y
> >  CONFIG_E1000E=y
> >  CONFIG_R8169=y
> > @@ -54,11 +58,14 @@ CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> >  CONFIG_HVC_RISCV_SBI=y
> > +CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> > +CONFIG_HW_RANDOM_VIRTIO=y
> >  # CONFIG_PTP_1588_CLOCK is not set
> >  CONFIG_POWER_RESET=y
> >  CONFIG_DRM=y
> >  CONFIG_DRM_RADEON=y
> > +CONFIG_DRM_VIRTIO_GPU=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> >  CONFIG_USB=y
> >  CONFIG_USB_XHCI_HCD=y
> > @@ -70,6 +77,12 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
> >  CONFIG_USB_STORAGE=y
> >  CONFIG_USB_UAS=y
> >  CONFIG_RTC_CLASS=y
> > +CONFIG_VIRTIO_PCI=y
> > +CONFIG_VIRTIO_BALLOON=y
> > +CONFIG_VIRTIO_INPUT=y
> > +CONFIG_VIRTIO_MMIO=y
> > +CONFIG_RPMSG_CHAR=y
> > +CONFIG_RPMSG_VIRTIO=y
> >  CONFIG_EXT4_FS=y
> >  CONFIG_EXT4_FS_POSIX_ACL=y
> >  CONFIG_AUTOFS4_FS=y
> > @@ -84,16 +97,17 @@ CONFIG_NFS_V4_2=y
> >  CONFIG_ROOT_NFS=y
> >  CONFIG_9P_FS=y
> >  CONFIG_CRYPTO_USER_API_HASH=y
> > +CONFIG_CRYPTO_DEV_VIRTIO=y
> >  CONFIG_PRINTK_TIME=y
> >  CONFIG_DEBUG_FS=y
> >  CONFIG_DEBUG_PAGEALLOC=y
> > +CONFIG_SCHED_STACK_END_CHECK=y
> >  CONFIG_DEBUG_VM=y
> >  CONFIG_DEBUG_VM_PGFLAGS=y
> >  CONFIG_DEBUG_MEMORY_INIT=y
> >  CONFIG_DEBUG_PER_CPU_MAPS=y
> >  CONFIG_SOFTLOCKUP_DETECTOR=y
> >  CONFIG_WQ_WATCHDOG=y
> > -CONFIG_SCHED_STACK_END_CHECK=y
> >  CONFIG_DEBUG_TIMEKEEPING=y
> >  CONFIG_DEBUG_RT_MUTEXES=y
> >  CONFIG_DEBUG_SPINLOCK=y
> > --
> > 2.17.1
> >
> >
>
