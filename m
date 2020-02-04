Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F4C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2C320674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="SmjV2KcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDKde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:33:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39162 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgBDKdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:33:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so2896659wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dXZpcJNcrSChz8uMigrQ9vo5oCrVD78dOySEAXVtnIY=;
        b=SmjV2KcBEgVk7VQgpAwcbFjiZsKPTXGEHhLEBA31DKX3pNzqKmFTbxf+EuOu9u4wcA
         EB8ct83JJnw0StpoTdm2NLNt6rB08Zru4BEyHAa4jwkJlX07O5f3Vl4wawS0nkpn+nZz
         SMbOepVnMikF6rtXj9JddjqNMd91gbrBFPmJKKkLMvcYwigYRuYzdJ//isIWbQBRgSKG
         8sNNiwueOfzaL1SwD6QlO1A6NnM/LVvc8olvKzUJwlOjN+sHaOAzUHwiCm+xs+maon1h
         RBlmv2rnYIb7isDyApOAgLm5X987YsSeAV+LN+UhN0SdZjEoY4Ib+aH6RNtQHEBfScVE
         oOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dXZpcJNcrSChz8uMigrQ9vo5oCrVD78dOySEAXVtnIY=;
        b=imhPXXQpELLG2mJvKwepzLmYjSCvuyeUs99kcwRBThJlkykk/epWMjLok+uPNMyeS1
         O12hWHRIV2soorZJ8usxHXcpLCKQfxqRVAN7MOxj6Bx1OzX/XpG/dZsYubKODsTY6yc0
         x7XtrEyFwtqEy9qFE6OknRJ65GAgLXzBq00IVYl2dbLceYDj/98lL85ws03aSxBEJc1e
         gONdJZLs7dpe77kU1DxyKyRk4rnjH0TA/vw5zh7bcFF6v0N5Cdh6Wk/VhTgWS21IZ7Ca
         G3VhRwqO3GfSJ02ywZtS9zdB0lvbtXVfVXJ8p0byCdGAA/EZwupvJfAKmeGk/8WJot2u
         G5JQ==
X-Gm-Message-State: APjAAAWtyTobqU1TBqcDh0cW3O4C/RE82yNJgtss0sMHbPf75W+xYF3Z
        9vmq8/Wd5Gj4qgeIEg9Y3v8uP42HU1tNjHZHh0JZXBFx2dg=
X-Google-Smtp-Source: APXvYqyh5AEOBE9yUwQC10uFZt5d0deZ00spyHDvHIZcmpmlm2JeIuNd6tTMhf0+uCJvE5gajMzXnoayzKRjZwrAz08=
X-Received: by 2002:a1c:3204:: with SMTP id y4mr161605wmy.166.1580812411405;
 Tue, 04 Feb 2020 02:33:31 -0800 (PST)
MIME-Version: 1.0
References: <f9bbfa27026d0f596dbc0a9c2e1253575d6cc82e.1578576542.git.michal.simek@xilinx.com>
In-Reply-To: <f9bbfa27026d0f596dbc0a9c2e1253575d6cc82e.1578576542.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 4 Feb 2020 11:33:20 +0100
Message-ID: <CAHTX3dJwX==px4qyMBXt3w4jzSg=jc77SzKSKVBPsX4BaRqyKQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: defconfig: Disable EXT2 driver and Enable
 EXT3 & EXT4 drivers
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 9. 1. 2020 v 14:29 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> From: Manish Narani <manish.narani@xilinx.com>
>
> As EXT4 filesystem driver is used for handling EXT2 file systems as
> well. There is no need to enable EXT2 driver. This patch disables EXT2
> and enables EXT3/EXT4 drivers.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/configs/mmu_defconfig   | 2 +-
>  arch/microblaze/configs/nommu_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/conf=
igs/mmu_defconfig
> index b3b433db89d8..0e2f5e1fd1ef 100644
> --- a/arch/microblaze/configs/mmu_defconfig
> +++ b/arch/microblaze/configs/mmu_defconfig
> @@ -73,7 +73,7 @@ CONFIG_FB_XILINX=3Dy
>  CONFIG_UIO=3Dy
>  CONFIG_UIO_PDRV_GENIRQ=3Dy
>  CONFIG_UIO_DMEM_GENIRQ=3Dy
> -CONFIG_EXT2_FS=3Dy
> +CONFIG_EXT3_FS=3Dy
>  # CONFIG_DNOTIFY is not set
>  CONFIG_TMPFS=3Dy
>  CONFIG_CRAMFS=3Dy
> diff --git a/arch/microblaze/configs/nommu_defconfig b/arch/microblaze/co=
nfigs/nommu_defconfig
> index 377de39ccb8c..8c420782d6e4 100644
> --- a/arch/microblaze/configs/nommu_defconfig
> +++ b/arch/microblaze/configs/nommu_defconfig
> @@ -70,7 +70,7 @@ CONFIG_XILINX_WATCHDOG=3Dy
>  CONFIG_FB=3Dy
>  CONFIG_FB_XILINX=3Dy
>  # CONFIG_USB_SUPPORT is not set
> -CONFIG_EXT2_FS=3Dy
> +CONFIG_EXT3_FS=3Dy
>  # CONFIG_DNOTIFY is not set
>  CONFIG_CRAMFS=3Dy
>  CONFIG_ROMFS_FS=3Dy
> --
> 2.24.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
