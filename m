Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C675C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2C5208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VStnWt6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbgE0Oqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbgE0Oqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:46:51 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2CFC03E96E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:46:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id d1so1739410ila.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AU7716CyemDmasYys+I/AcpiH3oj4x9jWwzzxX5tgKU=;
        b=VStnWt6jTjFgaMVpk3oAYnsncjATXU/wAutYtmJZxldXplcS0pQN70hvvNDVsOPkH4
         vnpNBR2ZdymxIB23xtSA8Lf6Q+U1apKa27CyqmEcDbIor/6l6or9W2gJF5nwV4rqyhy5
         zn5mI5nrRB5YSUzlGDB5NcEQTR9RL2pEiZTE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AU7716CyemDmasYys+I/AcpiH3oj4x9jWwzzxX5tgKU=;
        b=r6Hzs1x0EVCV6xdKs3x5QaeV2T9ZvkWz9auId9VUUXI+yfqtMOxQhmNltZl1amsRy3
         7vG7asT5I9V/QmJSB0/w7xU3FRz2gmTrDEui0uUZLadafcjAtyP/OUlU/Qu0ENy/SNTH
         Vz8jQvdHG2yUu4Y/zscGm1jEIHJg1PbQZHtR5L+7i2jUeNY9PivfBorfX1IDGX57pVpB
         yRq386hqaLkf530tFnnQf1kmGgvRKWjXxct3BPFt+4i/QNlCWgzDy8ugJmJcyHqBByk6
         A/XR9awNxh9lCCNL1Ns1XN6etGxMdAkm/DsVKup16LH8eh7ADCOjnkhZnSp6E/bFmDTd
         ASyA==
X-Gm-Message-State: AOAM531rX0MJwE6jNVfzUCZEuWLYaRjURN9yi6Qyh4IhcjPuuS2zVM30
        cUvxMy48cPKQ3uS8fe/r7gtVbvdl+XdYW0nTO0ARPA==
X-Google-Smtp-Source: ABdhPJzUVd1aHH7lzmeRjgv7wJnpzxeLVtfR5lAOrmZRujWuS3ksAZB8tphWnFf4uD7EhaGC6PT22n7EI0O6IBqmsk8=
X-Received: by 2002:a92:d182:: with SMTP id z2mr6049581ilz.47.1590590811109;
 Wed, 27 May 2020 07:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200403094033.8288-1-xia.jiang@mediatek.com> <20200403094033.8288-7-xia.jiang@mediatek.com>
 <20200521153257.GF209565@chromium.org> <1590544320.12671.10.camel@mhfsdcap03>
In-Reply-To: <1590544320.12671.10.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 27 May 2020 16:46:39 +0200
Message-ID: <CAHD77HkUrO4em_=7aJqHLU0WnkdsiGJYHMgEyv23fbztQfupCA@mail.gmail.com>
Subject: Re: [PATCH v8 06/14] media: platform: Improve the implementation of
 the system PM ops
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hsu Wei-Cheng <mojahsu@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        maoguang.meng@mediatek.com, Sj Huang <sj.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:58 AM Xia Jiang <xia.jiang@mediatek.com> wrote:
>
> On Thu, 2020-05-21 at 15:32 +0000, Tomasz Figa wrote:
> > Hi Xia,
> >
> > On Fri, Apr 03, 2020 at 05:40:25PM +0800, Xia Jiang wrote:
> > > Cancel reset hw operation in suspend and resume function because this
> > > will be done in device_run().
> >
> > This and...
> >
> > > Add spin_lock and unlock operation in irq and resume function to make
> > > sure that the current frame is processed completely before suspend.
> >
> > ...this are two separate changes. Please split.
> >
> > >
> > > Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> > > ---
> > >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > > index dd5cadd101ef..2fa3711fdc9b 100644
> > > --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > > +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > > @@ -911,6 +911,8 @@ static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
> > >     u32 dec_ret;
> > >     int i;
> > >
> > > +   spin_lock(&jpeg->hw_lock);
> > > +
> >
> > nit: For consistency, it is recommended to always use the same, i.e. the
> > strongest, spin_(un)lock_ primitives when operating on the same spinlock.
> > In this case it would be the irqsave(restore) variants.
> >
> > >     dec_ret = mtk_jpeg_dec_get_int_status(jpeg->dec_reg_base);
> > >     dec_irq_ret = mtk_jpeg_dec_enum_result(dec_ret);
> > >     ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
> > > @@ -941,6 +943,7 @@ static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
> > >     v4l2_m2m_buf_done(src_buf, buf_state);
> > >     v4l2_m2m_buf_done(dst_buf, buf_state);
> > >     v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> > > +   spin_unlock(&jpeg->hw_lock);
> > >     pm_runtime_put_sync(ctx->jpeg->dev);
> > >     return IRQ_HANDLED;
> > >  }
> > > @@ -1191,7 +1194,6 @@ static __maybe_unused int mtk_jpeg_pm_suspend(struct device *dev)
> > >  {
> > >     struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
> > >
> > > -   mtk_jpeg_dec_reset(jpeg->dec_reg_base);
> > >     mtk_jpeg_clk_off(jpeg);
> > >
> > >     return 0;
> > > @@ -1202,19 +1204,24 @@ static __maybe_unused int mtk_jpeg_pm_resume(struct device *dev)
> > >     struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
> > >
> > >     mtk_jpeg_clk_on(jpeg);
> > > -   mtk_jpeg_dec_reset(jpeg->dec_reg_base);
> > >
> > >     return 0;
> > >  }
> > >
> > >  static __maybe_unused int mtk_jpeg_suspend(struct device *dev)
> > >  {
> > > +   struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
> > > +   unsigned long flags;
> > >     int ret;
> > >
> > >     if (pm_runtime_suspended(dev))
> > >             return 0;
> > >
> > > +   spin_lock_irqsave(&jpeg->hw_lock, flags);
> >
> > What does this spinlock protect us from? I can see that it would prevent
> > the interrupt handler from being called, but is it okay to suspend the
> > system without handling the interrupt?
> Dear Tomasz,
> I mean that if current image is processed in irq handler,suspend
> function can not get the lock(it was locked in irq handler).Should I
> move the spin_lock_irqsave(&jpeg->hw_lock, flags) to the start location
> of suspend function or

Do we have any guarantee that the interrupt handler would be executed
and acquire the spinlock before mtk_jpeg_suspend() is called?

> use wait_event_timeout() to handle the interrupt
> before suspend?

Yes, that would indeed work better. :)

However, please refer to the v4l2_m2m suspend/resume helpers [1] and
the MTK FD driver [2] for how to implement this nicely.

[1] https://patchwork.kernel.org/patch/11272917/
[2] https://patchwork.kernel.org/patch/11272903/

Best regards,
Tomasz
