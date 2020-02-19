Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CBC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E40924670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4HyybsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBSSYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:24:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35840 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgBSSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:24:42 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so1653815iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smlfcUywMEBA2Gw1eHAbjNVoQlh2LXz5jWIz6aJcmfw=;
        b=O4HyybsNXczsbhrrLu4qddjfAQuXg+JBoGLqWPg/hSHL/MiwlPJ7VLi677GK7dYdgU
         skT/NGbNoll9J1+NV9EDP9BSSEsuS9UhB/4e8Xbm8I1uk7W24JlO9YyyAxjr2sbl/gak
         ZQ62NhEncAgdLWVw67qx6fj8lVkDiZCr9Mpe9mhjtgjt973WgmcKyYzTA3oQFZwVKzld
         9qoGBoiuZUVZGrO3A2UOAbHajl4eDCpwHoZUjn3ba25pB6pn2WlvVKRMBvDnSSi5nfkW
         F8DzPx2Lb982yWUeGj1AVKPqKjRXBsi6COFkUBsyGQ2fcFByhCgjArwp88THYs/L0fSM
         xCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smlfcUywMEBA2Gw1eHAbjNVoQlh2LXz5jWIz6aJcmfw=;
        b=M4bJGpK7Yp74++Q+gv1Z47JIqarfSrW6nsyEYhOiJpkcBelMw8M4OxIGrWs1jyDdfF
         JlGzR852YkS6goH6rhu6SJPwhg38F2HToKMavaTdnyd9SYHWVxAXoCud0FbDaZitjYF+
         yYBEs9Dsua9jVUhgin4AgVZsfK2Sxmn7OxKHhsNIllqyh5fBac9M09LnkvCMqVZwDmHo
         4a5Zv9NlQLA9P/9rB1wJ8t4Pr7jyCm/gzYamzhKX4eoW1z5oAccJ1D4UqdXN74jiCAzm
         4mdCEXE/phCfbXECloHMK84Y7JoFuupbwkJk3Lq5QF8KKqjzUjErzgUGxxJ3v4DNKnTS
         aeFQ==
X-Gm-Message-State: APjAAAXIHwPvQOYavmlqWXJ79x8/49J8Wo66MwXXVQ5EOuxVp1bnTHLj
        rQ/YHP3a9ZcBmu4qlpxUseaWoYHKgFD9fUAwbRA+rA==
X-Google-Smtp-Source: APXvYqxWEN30KM/Wzmg23n8n06SyNxQpEVoQeFFH1fNl9ZzFQKgO61ZWof893ZVTmjk1+rAp7WzAPQ2G/0k3qCSAPCE=
X-Received: by 2002:a6b:4e13:: with SMTP id c19mr19787179iob.58.1582136681309;
 Wed, 19 Feb 2020 10:24:41 -0800 (PST)
MIME-Version: 1.0
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 19 Feb 2020 11:24:30 -0700
Message-ID: <CANLsYkzeAyGhYqewGaHfd-myW5EzE83WUOwAbKwTP-34pbUR-w@mail.gmail.com>
Subject: Re: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
To:     peng.fan@nxp.com
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, 19 Feb 2020 at 00:33, <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> This patchset aim to replace NXP vendor imx_rpmsg.c driver.

You mean remoteproc/imx_rproc.c ?  Upstream rpmsg/imx_rpmsg.c doesn't exist.

>
> This patchset is tested with Loic PALLARDY's patch
> "remoteproc: add support for co-processor loaded and booted before kernel"
> https://patchwork.kernel.org/patch/11265869/,
> and inspried from st's remoteproc early boot support.
> Since Loic's patch is still under review, just expect your comments :)

Did you base your work on top of Loic's because your MCU firmware is
always loaded by the bootloader?  If not please send another revision
of your work without early boot support.  When we have a clear view on
how to proceed with the early boot support you can send another set to
enable that.

Thanks,
Mathieu

>
> Patch [1,2]/9: dt-bindings convert to json and new SoC support
> Patch 3/9: skip firmware load when recovery. To i.MX8, firmware is not
>            handled by Linux.
>
> Patch [4-9]/9: i.MX specific part to support rpmsg/virtio with mbox.
>       because NXP release image not have resoure table, so add resource
>       table in dts
>
> My test dts diff for i.MX8QXP MEK, but I have tested this patchset
> for i.MX8QXP MEK, i.MX8MM EVK, i.MX7ULP EVK:
>
> +
> +       imx8x-cm4 {
> +               compatible = "fsl,imx8qxp-cm4";
> +               rsrc-table = <
> +                       0x1 0x2 0x0 0x0 0x18 0x5c
> +                       3
> +                       /*fw_rsc_vdev*/
> +                       7 0 1 0 0 0x200
> +                       /*fw_rsc_vdev_vring*/
> +                       0x90000000 4096 256 1 0
> +                       0x90008000 4096 256 2 0
> +                       3
> +                       /*fw_rsc_vdev*/
> +                       7 1 1 0 0 0x200
> +                       /*fw_rsc_vdev_vring*/
> +                       0x90010000 4096 256 1 0
> +                       0x90018000 4096 256 2 0
> +               >;
> +               early-booted;
> +               mbox-names = "tx", "rx", "rxdb";
> +               mboxes = <&lsio_mu5 0 1
> +                         &lsio_mu5 1 1
> +                         &lsio_mu5 3 1>;
> +               mub-partition = <3>;
> +               memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>,
> +                               <&vdev1vring0>, <&vdev1vring1>, <&vdev0buffer>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               vdev0vring0: vdev0vring0@90000000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x90000000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev0vring1: vdev0vring1@90008000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x90008000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev1vring0: vdev1vring0@90010000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x90010000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev1vring1: vdev1vring1@90018000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x90018000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev0buffer: vdev0buffer {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x90400000 0 0x100000>;
> +                       no-map;
> +               };
> +       };
> +
>
> Peng Fan (9):
>   dt-bindings: remoteproc: Convert imx-rproc to json-schema
>   dt-bindings: remoteproc: imx-rproc: support i.MX[8,8M,7ULP]
>   remoteproc: add support to skip firmware load when recovery
>   remoteproc: imx_rproc: surport early booted remote processor
>   remoteproc: imx_rproc: parse early-booted property
>   remoteproc: imx_proc: enable virtio/mailbox
>   remoteproc: imx_rproc: add i.MX8QM/QXP
>   remoteproc: imx_rproc: support i.MX7ULP
>   remoteproc: imx_rproc: add i.MX8MM support
>
>  .../devicetree/bindings/remoteproc/imx-rproc.txt   |  33 --
>  .../devicetree/bindings/remoteproc/imx-rproc.yaml  |  95 +++++
>  drivers/remoteproc/imx_rproc.c                     | 455 +++++++++++++++++++--
>  drivers/remoteproc/remoteproc_core.c               |  19 +-
>  include/linux/remoteproc.h                         |   1 +
>  5 files changed, 531 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
>
> --
> 2.16.4
>
