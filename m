Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406172225F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJsS8hBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgF2SiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgF2SiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:38:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA47C02F032
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:00:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so13780100oty.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=64cs0TbTbP8oXkjqFwlVyOK6sTxRyWaYSp+tM0bVADY=;
        b=iJsS8hBM9QxkxafcTMtycbQCdy9iovLnZQNdm8sCMuUW7wM0vJYf5QfWXoLeJioLI9
         zuvRpVpeKmZt7ZodsyhJFd7sMFqdMhqfJaDmmNRU088OIknBDX2Qfw3w74wbyBichTco
         0AoN+RjPb0ODn5sXj655D7NhIWazi7BLmbQ5QZkVjOjHcgRp8JDNfrBkm/Z/pmvtz5lW
         sqfT4dwvk9uyfa+TPJc7Rb1sANktKemkQv0y3XrC/ZHh+CvhL6rHiv5IcqUlLuRyNU9o
         ZN6zW0cF4acVTqClrpTBc3bdnzXC3B6KxGjzrkaZ7ViJ+uGfpZ8ARYYSTDPcvO0sKb5n
         5RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64cs0TbTbP8oXkjqFwlVyOK6sTxRyWaYSp+tM0bVADY=;
        b=NuIo1VlcZv49m6B1n4c/lzUFZiUpCZG11pyYTVCnviiD1ppRJ/TXyVgpMqv0D4zrkp
         dDKbFLhUc7fhj/qNWM49I+KdDddFcvUOaHAyQfLrjIn5LeG1t4Xpo13yxo70F8m8PXZ4
         LtYu59wWjWLUH1614ELGr05qUbCivAh9jK4RDAMvJKCC19Bcjr8JJw/M8lS7nB/020wv
         OVLKMBXwGm29xGJ0VrUJS4lII+6QuMasudTvWIw0GwvpAYMKMDRYp2JR+Q6qKiD6E2pf
         cRH+RVj/HSmUX+zMWVVu3sSrFl2zcXK6ViXcq1cx55bHxZFezJwhIelkLXt/Tb+XO/ei
         Jwgg==
X-Gm-Message-State: AOAM532doZIboY7Xgwhr4+YsKfOpUWMS4PTKsM5WET7COFhGAevWSaSN
        cJxfJMkXO+MqmmYHd8C/joXBHrA3QB9X2ow9FRs=
X-Google-Smtp-Source: ABdhPJzhdHJhL6wz1HDjdvznHpIGmS/1e0gDDMgS5NOP2fYaMZB7eIyrlZjLdTrGaY2+0NhG+ZKaNsBIJm4MAxyRH3Y=
X-Received: by 2002:a9d:904:: with SMTP id 4mr14130648otp.339.1593442851032;
 Mon, 29 Jun 2020 08:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-7-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-7-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 18:00:21 +0300
Message-ID: <CAFCwf12UOrL3R4TKuE6Zwrgyfz0NHRRqyqdSwJQZ78yYvRVrDg@mail.gmail.com>
Subject: Re: [PATCH 06/20] misc: habanalabs: goya: Omit pointless check
 ensuring addr is >=0
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:04 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Seeing as 'addr' is unsigned, it would be impossible for the assigned
> value to be anything other than zero or positive.
>
> Squashes the following W=3D1 warnings:
>
>  drivers/misc/habanalabs/goya/goya.c: In function =E2=80=98goya_debugfs_r=
ead32=E2=80=99:
>  drivers/misc/habanalabs/goya/goya.c:3945:19: warning: comparison of unsi=
gned expression >=3D 0 is always true [-Wtype-limits]
>  3945 | } else if ((addr >=3D DRAM_PHYS_BASE) &&
>  | ^~
>  drivers/misc/habanalabs/goya/goya.c: In function =E2=80=98goya_debugfs_w=
rite32=E2=80=99:
>  drivers/misc/habanalabs/goya/goya.c:4002:19: warning: comparison of unsi=
gned expression >=3D 0 is always true [-Wtype-limits]
>  4002 | } else if ((addr >=3D DRAM_PHYS_BASE) &&
>  | ^~
>  drivers/misc/habanalabs/goya/goya.c: In function =E2=80=98goya_debugfs_r=
ead64=E2=80=99:
>  drivers/misc/habanalabs/goya/goya.c:4047:19: warning: comparison of unsi=
gned expression >=3D 0 is always true [-Wtype-limits]
>  4047 | } else if ((addr >=3D DRAM_PHYS_BASE) &&
>  | ^~
>  drivers/misc/habanalabs/goya/goya.c: In function =E2=80=98goya_debugfs_w=
rite64=E2=80=99:
>  drivers/misc/habanalabs/goya/goya.c:4091:19: warning: comparison of unsi=
gned expression >=3D 0 is always true [-Wtype-limits]
>  4091 | } else if ((addr >=3D DRAM_PHYS_BASE) &&
>  | ^~
>  drivers/misc/habanalabs/pci.c:328: warning: Excess function parameter 'd=
ma_mask' description in 'hl_pci_set_dma_mask'
>  drivers/misc/habanalabs/goya/goya_coresight.c: In function =E2=80=98goya=
_debug_coresight=E2=80=99:
>  drivers/misc/habanalabs/goya/goya_coresight.c:643:6: warning: variable =
=E2=80=98val=E2=80=99 set but not used [-Wunused-but-set-variable]
>  643 | u32 val;
>  | ^~~
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalab=
s/goya/goya.c
> index 0d2952bb58dfb..a4a20e27ed3b4 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -3942,8 +3942,7 @@ static int goya_debugfs_read32(struct hl_device *hd=
ev, u64 addr, u32 *val)
>                 *val =3D readl(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
>                                 (addr - SRAM_BASE_ADDR));
>
> -       } else if ((addr >=3D DRAM_PHYS_BASE) &&
> -                       (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_siz=
e)) {
> +       } else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
>
>                 u64 bar_base_addr =3D DRAM_PHYS_BASE +
>                                 (addr & ~(prop->dram_pci_bar_size - 0x1ul=
l));
> @@ -3999,8 +3998,7 @@ static int goya_debugfs_write32(struct hl_device *h=
dev, u64 addr, u32 val)
>                 writel(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
>                                         (addr - SRAM_BASE_ADDR));
>
> -       } else if ((addr >=3D DRAM_PHYS_BASE) &&
> -                       (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_siz=
e)) {
> +       } else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
>
>                 u64 bar_base_addr =3D DRAM_PHYS_BASE +
>                                 (addr & ~(prop->dram_pci_bar_size - 0x1ul=
l));
> @@ -4044,9 +4042,8 @@ static int goya_debugfs_read64(struct hl_device *hd=
ev, u64 addr, u64 *val)
>                 *val =3D readq(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
>                                 (addr - SRAM_BASE_ADDR));
>
> -       } else if ((addr >=3D DRAM_PHYS_BASE) &&
> -                  (addr <=3D
> -                   DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u=
64))) {
> +       } else if (addr <=3D
> +                  DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u6=
4)) {
>
>                 u64 bar_base_addr =3D DRAM_PHYS_BASE +
>                                 (addr & ~(prop->dram_pci_bar_size - 0x1ul=
l));
> @@ -4088,9 +4085,8 @@ static int goya_debugfs_write64(struct hl_device *h=
dev, u64 addr, u64 val)
>                 writeq(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
>                                         (addr - SRAM_BASE_ADDR));
>
> -       } else if ((addr >=3D DRAM_PHYS_BASE) &&
> -                  (addr <=3D
> -                   DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u=
64))) {
> +       } else if (addr <=3D
> +                  DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u6=
4)) {
>
>                 u64 bar_base_addr =3D DRAM_PHYS_BASE +
>                                 (addr & ~(prop->dram_pci_bar_size - 0x1ul=
l));
> --
> 2.25.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
