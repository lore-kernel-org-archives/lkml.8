Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8A620578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586872074;
	bh=zPGc63UmWLc/+H/vjVjMmsftRUnohKoZ25/OzLAX5q0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=RLzi5oDAIe7IUi4572prYPErtLUW6VlCuCmQgTRqWwzUK8OZrhLt7r1DjxyGmQnAv
	 w1MUw2gmqoi7xqz9HOTgT65RhglIunWX9y5KaDgDPMtZJIOsrFu5pgp9RCyHIhMrMK
	 k1MZ2Tjasnj3kuRBPRqKqyEhZ8Wi1Idv1il4WeSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgDNNrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732790AbgDNNrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:47:42 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553C72078B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586872061;
        bh=zPGc63UmWLc/+H/vjVjMmsftRUnohKoZ25/OzLAX5q0=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=HRMb8JjdVUWax/yRhGpGbsXJtWA0MwsXbW5hdYtmysQU0jyHCuyXJUqnSyIuwOjhh
         saVHqWredVkvYW0WSYQHrXBHg+oS/u8bANzIjtXP42QCBKNS7BMMYtH2MnBm9y+iFX
         Dr9wWT0Ih9G62vdBgNLHljzN1U4Cil7VH86QZa/I=
Received: by mail-lf1-f52.google.com with SMTP id l11so9423854lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:47:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuYlgS+G3o9T1PfeJff+l6IFMnf4YBYapyTmxwxPyjx77WcJZ3ij
        bxUoarGF6Fu7TtZwf2PgH3O7gdsRnxFOPGRZ11U=
X-Google-Smtp-Source: APiQypJxCiAhNBPjhKsW1uO1167hs2/TAd8oRp4Z+eS/oD8l54yts/N11sRuWc97KVigMWLNcyMCQcj61mfyJqS+FqM=
X-Received: by 2002:ac2:551e:: with SMTP id j30mr14307830lfk.179.1586872059357;
 Tue, 14 Apr 2020 06:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200401100240.445447-1-ribalda@kernel.org> <20200402065953.9974-1-ribalda@kernel.org>
In-Reply-To: <20200402065953.9974-1-ribalda@kernel.org>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Tue, 14 Apr 2020 15:47:23 +0200
X-Gmail-Original-Message-ID: <CAPybu_34nSmbu4JMK-uA3SWrj_eMUftZ8S6zf1Vpg3Etkz3SPw@mail.gmail.com>
Message-ID: <CAPybu_34nSmbu4JMK-uA3SWrj_eMUftZ8S6zf1Vpg3Etkz3SPw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: Fix mtd not the same name not registered if nvmem
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Thu, Apr 2, 2020 at 8:59 AM Ricardo Ribalda Delgado
<ribalda@kernel.org> wrote:
>
> When the nvmem framework is enabled, a nvmem device is created per mtd
> device/partition.
>
> It is not uncommon that a device can have multiple mtd devices with
> partitions that have the same name. Eg, when there DT overlay is allowed
> and the same device with mtd is attached twice.
>
> Under that circumstances, the mtd fails to register due to a name
> duplication on the nvmem framework.
>
> With this patch we add a _1, _2, _X to the subsequent names if there is
> a collition, and throw a warning, instead of not starting the mtd
> device.
>
> [    8.948991] sysfs: cannot create duplicate filename '/bus/nvmem/devices/Production Data'
> [    8.948992] CPU: 7 PID: 246 Comm: systemd-udevd Not tainted 5.5.0-qtec-standard #13
> [    8.948993] Hardware name: AMD Dibbler/Dibbler, BIOS 05.22.04.0019 10/26/2019
> [    8.948994] Call Trace:
> [    8.948996]  dump_stack+0x50/0x70
> [    8.948998]  sysfs_warn_dup.cold+0x17/0x2d
> [    8.949000]  sysfs_do_create_link_sd.isra.0+0xc2/0xd0
> [    8.949002]  bus_add_device+0x74/0x140
> [    8.949004]  device_add+0x34b/0x850
> [    8.949006]  nvmem_register.part.0+0x1bf/0x640
> ...
> [    8.948926] mtd mtd8: Failed to register NVMEM device
>
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> ---
> v2: I left behind on my patch a
>
> mtd->nvmem = NULL;
>
> from my tests. Sorry.
>
>  drivers/mtd/mtdcore.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5fac4355b9c2..7a4b520ef3b0 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -28,6 +28,7 @@
>  #include <linux/leds.h>
>  #include <linux/debugfs.h>
>  #include <linux/nvmem-provider.h>
> +#include <linux/nvmem-consumer.h>
>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -545,13 +546,34 @@ static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
>         return retlen == bytes ? 0 : -EIO;
>  }
>
> +static int nvmem_next_name(const char *init_name, char *name, size_t len)
> +{
> +       unsigned int i = 0;
> +       int ret = 0;
> +       struct nvmem_device *dev = NULL;
> +
> +       strlcpy(name, init_name, len);
> +
> +       while ((ret < len) &&
> +              !IS_ERR(dev = nvmem_device_find(name, device_match_name))) {
> +               nvmem_device_put(dev);
> +               ret = snprintf(name, len, "%s_%u", init_name, ++i);
> +       }
> +
> +       if (ret >= len)
> +               return -ENOMEM;
> +
> +       return i;
> +}
> +
>  static int mtd_nvmem_add(struct mtd_info *mtd)
>  {
>         struct nvmem_config config = {};
> +       char name[128];
> +       int ret = 0;
>
>         config.id = -1;
>         config.dev = &mtd->dev;
> -       config.name = mtd->name;
>         config.owner = THIS_MODULE;
>         config.reg_read = mtd_nvmem_reg_read;
>         config.size = mtd->size;
> @@ -562,6 +584,13 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>         config.no_of_node = true;
>         config.priv = mtd;
>
> +       if (mtd->name) {
> +               ret = nvmem_next_name(mtd->name, name, sizeof(name));
> +               if (ret < 0)
> +                       return ret;
> +               config.name = name;
> +       }
> +
>         mtd->nvmem = nvmem_register(&config);
>         if (IS_ERR(mtd->nvmem)) {
>                 /* Just ignore if there is no NVMEM support in the kernel */
> @@ -573,6 +602,10 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>                 }
>         }
>
> +       if (ret)
> +               dev_warn(&mtd->dev, "mtdev %s renamed to %s due to name collision",
> +                               mtd->name, nvmem_dev_name(mtd->nvmem));
> +
>         return 0;
>  }
>
> --
> 2.25.1
>
