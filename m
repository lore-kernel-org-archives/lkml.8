Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D33CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903F2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk4Nropd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJMQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:16:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbgCJMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583842609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBJ5h02t1XBacqVRLa8/tjxigZnxj6mvBCIXpcgjcyM=;
        b=Xk4Nropd6SrIORZlGe1xwsYrG3lBkGODNsyrk4/9dc2C6TuGZ/DTjbNusfgvyhRb1H2gAd
        rQkk5YZ/cyH1hMY6XNK69oP+5hLZ/1Y1p3Kyu0OikoSQuv1t3PCNXJmjQl9yBA7uYxXvv0
        vozSAqc2/xPKU8g0NiyfIDnriMDZeFg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-u-hHExN9Mw2NSW2A7qvvbw-1; Tue, 10 Mar 2020 08:16:48 -0400
X-MC-Unique: u-hHExN9Mw2NSW2A7qvvbw-1
Received: by mail-qt1-f198.google.com with SMTP id f25so8955074qtp.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 05:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBJ5h02t1XBacqVRLa8/tjxigZnxj6mvBCIXpcgjcyM=;
        b=TaGr3yW1NyDD0ZqSB6JaiWOo+Fyp7oUPojuxq2HSQKM96ygjnDAbMK9NQctK/yppz2
         jcU1q42MuWN+2nZLhZohrntxIq51A8e5YgRPG84tTo/R3vibPeWr+gMbvtu4Z0TIxjYX
         adTxP5+8HJD3kRMR4tlh/7NVQSQ0M/qSjeAryzKB5bux3B9CC0oNztDKNGYn6tx4jyZP
         zNow9rzgnYpZTk34+rr8FkPJT+OF9PMskWIFpqAllkCHhhE8UnlaBk2BWXoNXDisWXjV
         O23zs72Hiidw4PsQuOvOIQ1Vs+6RH5LgH7kbpEQgfGNgG0qKq5E3eTKB7sADLmyY0mnj
         c1HA==
X-Gm-Message-State: ANhLgQ3TixtCYio/1rWe/THNwq3D3gKDJi8MDVE9mVt0WP4f224EDAnK
        g5HtdLZFQH/KdpwILh+HMGQrKmBdcXQPFsYT+0lfqg6YQqFxLIv26CteXjP1KqcRBy/qIa4QcJx
        YA2LFlmHLdhfgL6R/ujoKwv0k
X-Received: by 2002:ac8:4e91:: with SMTP id 17mr19204533qtp.133.1583842605220;
        Tue, 10 Mar 2020 05:16:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsTFMO2DVmVDOKBX1ZKtKCIPsKMKeNIFpQSDDWYB39XUebWYbZ7eXcfC4GZXS3KFds1h10ZRw==
X-Received: by 2002:ac8:4e91:: with SMTP id 17mr19204480qtp.133.1583842604637;
        Tue, 10 Mar 2020 05:16:44 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id d22sm4226347qte.93.2020.03.10.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:16:43 -0700 (PDT)
Date:   Tue, 10 Mar 2020 08:16:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Only select essential drivers for SOC_VIRT config
Message-ID: <20200310081558-mutt-send-email-mst@kernel.org>
References: <20200310115925.126174-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310115925.126174-1-anup.patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 05:29:25PM +0530, Anup Patel wrote:
> The kconfig select causes build failues for SOC_VIRT config becaus
> we are selecting lot of VIRTIO drivers without selecting all required
> dependencies.
> 
> Better approach is to only select essential drivers from SOC_VIRT
> config option and enable required VIRTIO drivers using defconfigs.
> 
> Fixes: 759bdc168181 ("RISC-V: Add kconfig option for QEMU virt machine")
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Yea makes sense.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  arch/riscv/Kconfig.socs           | 14 --------------
>  arch/riscv/configs/defconfig      | 16 +++++++++++++++-
>  arch/riscv/configs/rv32_defconfig | 16 +++++++++++++++-
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 3078b2de0b2d..a131174a0a77 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -12,20 +12,6 @@ config SOC_SIFIVE
>  
>  config SOC_VIRT
>         bool "QEMU Virt Machine"
> -       select VIRTIO_PCI
> -       select VIRTIO_BALLOON
> -       select VIRTIO_MMIO
> -       select VIRTIO_CONSOLE
> -       select VIRTIO_NET
> -       select NET_9P_VIRTIO
> -       select VIRTIO_BLK
> -       select SCSI_VIRTIO
> -       select DRM_VIRTIO_GPU
> -       select HW_RANDOM_VIRTIO
> -       select RPMSG_CHAR
> -       select RPMSG_VIRTIO
> -       select CRYPTO_DEV_VIRTIO
> -       select VIRTIO_INPUT
>         select POWER_RESET_SYSCON
>         select POWER_RESET_SYSCON_POWEROFF
>         select GOLDFISH
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index c8f084203067..2557c5372a25 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
>  CONFIG_NETLINK_DIAG=y
>  CONFIG_NET_9P=y
> +CONFIG_NET_9P_VIRTIO=y
>  CONFIG_PCI=y
>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_HOST_GENERIC=y
> @@ -38,12 +39,15 @@ CONFIG_PCIE_XILINX=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_BLK_DEV_LOOP=y
> +CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
> +CONFIG_SCSI_VIRTIO=y
>  CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_NETDEVICES=y
> +CONFIG_VIRTIO_NET=y
>  CONFIG_MACB=y
>  CONFIG_E1000E=y
>  CONFIG_R8169=y
> @@ -54,13 +58,16 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_HVC_RISCV_SBI=y
> +CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
> +CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
> +CONFIG_DRM_VIRTIO_GPU=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
> @@ -74,6 +81,12 @@ CONFIG_USB_UAS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_BALLOON=y
> +CONFIG_VIRTIO_INPUT=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
> @@ -88,16 +101,17 @@ CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_9P_FS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_SCHED_STACK_END_CHECK=y
>  CONFIG_DEBUG_VM=y
>  CONFIG_DEBUG_VM_PGFLAGS=y
>  CONFIG_DEBUG_MEMORY_INIT=y
>  CONFIG_DEBUG_PER_CPU_MAPS=y
>  CONFIG_SOFTLOCKUP_DETECTOR=y
>  CONFIG_WQ_WATCHDOG=y
> -CONFIG_SCHED_STACK_END_CHECK=y
>  CONFIG_DEBUG_TIMEKEEPING=y
>  CONFIG_DEBUG_RT_MUTEXES=y
>  CONFIG_DEBUG_SPINLOCK=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index a844920a261f..0292879a9690 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
>  CONFIG_NETLINK_DIAG=y
>  CONFIG_NET_9P=y
> +CONFIG_NET_9P_VIRTIO=y
>  CONFIG_PCI=y
>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_HOST_GENERIC=y
> @@ -38,12 +39,15 @@ CONFIG_PCIE_XILINX=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_BLK_DEV_LOOP=y
> +CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
> +CONFIG_SCSI_VIRTIO=y
>  CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_NETDEVICES=y
> +CONFIG_VIRTIO_NET=y
>  CONFIG_MACB=y
>  CONFIG_E1000E=y
>  CONFIG_R8169=y
> @@ -54,11 +58,14 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_HVC_RISCV_SBI=y
> +CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
> +CONFIG_HW_RANDOM_VIRTIO=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
> +CONFIG_DRM_VIRTIO_GPU=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
> @@ -70,6 +77,12 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_BALLOON=y
> +CONFIG_VIRTIO_INPUT=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
> @@ -84,16 +97,17 @@ CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_9P_FS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_SCHED_STACK_END_CHECK=y
>  CONFIG_DEBUG_VM=y
>  CONFIG_DEBUG_VM_PGFLAGS=y
>  CONFIG_DEBUG_MEMORY_INIT=y
>  CONFIG_DEBUG_PER_CPU_MAPS=y
>  CONFIG_SOFTLOCKUP_DETECTOR=y
>  CONFIG_WQ_WATCHDOG=y
> -CONFIG_SCHED_STACK_END_CHECK=y
>  CONFIG_DEBUG_TIMEKEEPING=y
>  CONFIG_DEBUG_RT_MUTEXES=y
>  CONFIG_DEBUG_SPINLOCK=y
> -- 
> 2.17.1
> 
> 

