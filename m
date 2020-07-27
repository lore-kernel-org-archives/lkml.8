Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41CEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4935208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="Nt6Fwzha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgG0OJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgG0OJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A0C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:09:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so2423208ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pg/Nnv0D1WsGinkKtElYg3qznMo9ABDAS8PwWWLLEvA=;
        b=Nt6Fwzha9lu3obIVmM3nlY7KTH1efUxxtkgXw73WT80mRpGh21NnB1S+MiIGzdwIGM
         9zapQp5FeATTB9cfb6xHAQVd7DJhuxuufGZI+u8GdrHd4jpi3/Mwpb7cAG6I0QzGb1Bx
         qsDyS16YuzYnfrp3GMXrvFQzcR+FDbreKu/jT0huq6A3jgoL/lsoNsIVICpUb02JS3Ik
         zjfE2/A9VnMrAqvSssJZKsafv7vUqBbHUxfqmM+Cv5A8+0ZbdGmo9qvaL9/8WBgT+dG8
         +r4FU88CKEycAH3gSEdSqa626u6tnrMpFp/QQyD9vhiaOZnKOdqd2Gua36+qT83cdhJZ
         qRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pg/Nnv0D1WsGinkKtElYg3qznMo9ABDAS8PwWWLLEvA=;
        b=L1h2DMmf9jkeiy3tL1mh1STteksfpVSxqFXLmnwsjEuPdAXI9OkiwwRA+4iGonsODK
         ruO9rUmf+m4NdOTfP8t8Vp5ryTEDGIGGuRFbTvqbGNoyoV2a6aC2SYzMz/Bm13OD5lJT
         UMVrWkdejQEb8pMExdZ9jxiEprcFC67W2/AejiAYl5O/DvLVGg2RMUb8S+fX3t49hzyt
         rTpaw2rRi356cIf3h0c3i9DYIuixuvnIfz2j521mYWo/D6JJKd0mxZc5oKSn4dUOIkFw
         2/026bajSBEDyZ139do1JFtZmh0unEdIZ3OHPKCSqUchXK0xjnV819TgvygVrCkgClfL
         2Fvg==
X-Gm-Message-State: AOAM533jQApZdqQfbX4GKPiYit3/9C6e6W5OSJxdwBFU8hIBuGDT2JZp
        jpSVTdSWexCo/wNWGXz9yWUsuaoCr3t8vQH6fQMuvA==
X-Google-Smtp-Source: ABdhPJyyLsHgFogO9i0Mb36ziEUhhi4kBqtpaCxtBQS0uG3xl8Bb0Tz2MBbIOTL3+4xhJZJM1svkfXLsgzCGnPX6QVM=
X-Received: by 2002:a17:906:1e43:: with SMTP id i3mr20393886ejj.92.1595858977126;
 Mon, 27 Jul 2020 07:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200713060842.471356-1-acourbot@chromium.org>
 <20200713060842.471356-4-acourbot@chromium.org> <CAAEAJfBO1Sih3r_RqxYCLRxtx6SoDq674zrvqhJiEBJeiDAtvw@mail.gmail.com>
 <CAPBb6MV=oo-a9POY_qedcJYU_qSJ695FwJthBrp3SQUK+g0JvA@mail.gmail.com>
In-Reply-To: <CAPBb6MV=oo-a9POY_qedcJYU_qSJ695FwJthBrp3SQUK+g0JvA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 27 Jul 2020 11:09:25 -0300
Message-ID: <CAAEAJfD6tiJKLNoSJbvJkafLrU8s5Y8mZOg038SuH1QNCO-+_g@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] media: mtk-vcodec: add SCP firmware ops
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 at 06:06, Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Thu, Jul 23, 2020 at 6:40 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > On Mon, 13 Jul 2020 at 03:09, Alexandre Courbot <acourbot@chromium.org> wrote:
> > >
> > > From: Yunfei Dong <yunfei.dong@mediatek.com>
> > >
> > > Add support for communicating with the SCP firmware, which will be used
> > > by MT8183.
> > >
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > [acourbot: refactor, cleanup and split]
> > > Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> > > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > > Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > > ---
> > >  drivers/media/platform/Kconfig                |  1 +
> > >  .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  3 +
> > >  .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  3 +
> > >  .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 56 +++++++++++++++++++
> > >  .../media/platform/mtk-vcodec/mtk_vcodec_fw.h |  2 +
> > >  5 files changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > > index c57ee78fa99d..f0dbe048efea 100644
> > > --- a/drivers/media/platform/Kconfig
> > > +++ b/drivers/media/platform/Kconfig
> > > @@ -256,6 +256,7 @@ config VIDEO_MEDIATEK_VCODEC
> > >         select VIDEOBUF2_DMA_CONTIG
> > >         select V4L2_MEM2MEM_DEV
> > >         select VIDEO_MEDIATEK_VPU
> > > +       select MTK_SCP
> > >         help
> > >             Mediatek video codec driver provides HW capability to
> > >             encode and decode in a range of video formats
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > index 4f07a5fcce7f..5b5765b98e57 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > @@ -225,6 +225,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
> > >         if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
> > >                                   &rproc_phandle)) {
> > >                 fw_type = VPU;
> > > +       } else if (!of_property_read_u32(pdev->dev.of_node, "mediatek,scp",
> > > +                                        &rproc_phandle)) {
> > > +               fw_type = SCP;
> > >         } else {
> > >                 mtk_v4l2_err("Could not get vdec IPI device");
> > >                 return -ENODEV;
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> > > index 4340ea10afd0..42530cd01a30 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> > > @@ -233,6 +233,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
> > >         if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
> > >                                   &rproc_phandle)) {
> > >                 fw_type = VPU;
> > > +       } else if (!of_property_read_u32(pdev->dev.of_node, "mediatek,scp",
> > > +                                        &rproc_phandle)) {
> > > +               fw_type = SCP;
> > >         } else {
> > >                 mtk_v4l2_err("Could not get venc IPI device");
> > >                 return -ENODEV;
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
> > > index 967bb100a990..f2a62ea62fc6 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
> > > @@ -19,6 +19,7 @@ struct mtk_vcodec_fw {
> > >         enum mtk_vcodec_fw_type type;
> > >         const struct mtk_vcodec_fw_ops *ops;
> > >         struct platform_device *pdev;
> > > +       struct mtk_scp *scp;
> > >  };
> > >
> > >  static int mtk_vcodec_vpu_load_firmware(struct mtk_vcodec_fw *fw)
> > > @@ -71,6 +72,48 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
> > >         .ipi_send = mtk_vcodec_vpu_ipi_send,
> > >  };
> > >
> > > +static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
> > > +{
> > > +       return rproc_boot(scp_get_rproc(fw->scp));
> > > +}
> > > +
> > > +static unsigned int mtk_vcodec_scp_get_vdec_capa(struct mtk_vcodec_fw *fw)
> > > +{
> > > +       return scp_get_vdec_hw_capa(fw->scp);
> > > +}
> > > +
> > > +static unsigned int mtk_vcodec_scp_get_venc_capa(struct mtk_vcodec_fw *fw)
> > > +{
> > > +       return scp_get_venc_hw_capa(fw->scp);
> > > +}
> > > +
> > > +static void *mtk_vcodec_vpu_scp_dm_addr(struct mtk_vcodec_fw *fw,
> > > +                                       u32 dtcm_dmem_addr)
> > > +{
> > > +       return scp_mapping_dm_addr(fw->scp, dtcm_dmem_addr);
> > > +}
> > > +
> > > +static int mtk_vcodec_scp_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
> > > +               mtk_vcodec_ipi_handler handler, const char *name, void *priv)
> > > +{
> > > +       return scp_ipi_register(fw->scp, id, handler, priv);
> > > +}
> > > +
> > > +static int mtk_vcodec_scp_ipi_send(struct mtk_vcodec_fw *fw, int id, void *buf,
> > > +               unsigned int len, unsigned int wait)
> > > +{
> > > +       return scp_ipi_send(fw->scp, id, buf, len, wait);
> > > +}
> > > +
> > > +static const struct mtk_vcodec_fw_ops mtk_vcodec_rproc_msg = {
> > > +       .load_firmware = mtk_vcodec_scp_load_firmware,
> > > +       .get_vdec_capa = mtk_vcodec_scp_get_vdec_capa,
> > > +       .get_venc_capa = mtk_vcodec_scp_get_venc_capa,
> > > +       .map_dm_addr = mtk_vcodec_vpu_scp_dm_addr,
> > > +       .ipi_register = mtk_vcodec_scp_set_ipi_register,
> > > +       .ipi_send = mtk_vcodec_scp_ipi_send,
> > > +};
> > > +
> > >  static void mtk_vcodec_reset_handler(void *priv)
> > >  {
> > >         struct mtk_vcodec_dev *dev = priv;
> > > @@ -94,6 +137,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
> > >         const struct mtk_vcodec_fw_ops *ops;
> > >         struct mtk_vcodec_fw *fw;
> > >         struct platform_device *fw_pdev = NULL;
> > > +       struct mtk_scp *scp = NULL;
> > >
> > >         switch (type) {
> > >         case VPU:
> > > @@ -106,6 +150,14 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
> > >                 vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_reset_handler,
> > >                                     dev, rst_id);
> > >                 break;
> > > +       case SCP:
> > > +               ops = &mtk_vcodec_rproc_msg;
> > > +               scp = scp_get(dev->plat_dev);
> > > +               if (!scp) {
> > > +                       mtk_v4l2_err("could not get vdec scp handle");
> > > +                       return ERR_PTR(-EPROBE_DEFER);
> >
> > I suspect the EPROBE_DEFER should be returned by scp_get
> > itself instead.
>
> scp_get() is a function of of mtk_scp remoteproc driver, so even if we
> decide this is desirable (which I am not convinced, as the current
> code leaves the freedom to decide how the absence of SCP should be
> interpreted to the driver) this is beyond the scope of this series.
>

How can the consumer decide if it should defer probing or not?

> >
> > > +               }
> > > +               break;
> > >         default:
> > >                 mtk_v4l2_err("invalid vcodec fw type");
> > >                 return ERR_PTR(-EINVAL);
> > > @@ -118,6 +170,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
> > >         fw->type = type;
> > >         fw->ops = ops;
> > >         fw->pdev = fw_pdev;
> > > +       fw->scp = scp;
> > >
> > >         return fw;
> > >  }
> > > @@ -129,6 +182,9 @@ void mtk_vcodec_fw_release(struct mtk_vcodec_fw *fw)
> > >         case VPU:
> > >                 put_device(&fw->pdev->dev);
> > >                 break;
> > > +       case SCP:
> > > +               scp_put(fw->scp);
> >
> > Interestingly scp_put is a wrapper around put_device :-)
> > Perhaps not a reason to violate the layering.
>
> I don't see what is wrong with the current code? If SCP is in use, we
> use SCP functions to manage it. If in the future SCP involves in such
> a way that we need to do more than a put_device(), we are covered. Or
> am I missing something?

Oh, nothing wrong. I just found it interesting that scp_put was
just wrapping put_device. Nothing to fix really.

Thanks!
Ezequiel
