Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D05320674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRSdQDBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgGMFoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMFoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:44:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B5C08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:44:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so14658118ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rp7+bh2mU6TpEEtWpOr+87rCm6MPnrvLOWdtUzMHKQ8=;
        b=CRSdQDBtxmD9eFlVT0K5jcruX9Eb95imbaOtpnYb7gl8aEBpXbsxoBVC4abKx/J+Ld
         DFDhaOOfCqUgceSh2DeJvNwSBdWGz4Enfbn7+tsEQatlol7t82YFPryAObOhHvlVQ1A+
         fkQzDtU1fT+c4rqwAN9nfZyl6z1t9Vi91nFGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rp7+bh2mU6TpEEtWpOr+87rCm6MPnrvLOWdtUzMHKQ8=;
        b=Svo9Bopofbk+wVN+F/gS7ZaKRr+cFQpu17fF2jjwf4uHvW855XTZjojPxobbFyJ0Ms
         bAaPXF+BtmFlW14YZC48LzJ77a3L37BC9qJTipapWB5MCdF3Yzhx+4FNhGSOwVpqJS6c
         tfnWRXlMMKkbngr+SY6+oBnbzojdXgvqx6ad4GHCkVtWL4p+BIjg6mqRSGqrMhviD5sC
         jWKjOub9871GHuQUF7vIjoi36kW3uDlaXXEXoSKAF2rovEkasQTf2tQ+niCS/FdcljqB
         2CP9afjf5Nx1fPEJRrT+ne2mUzOVBuT7duGRTxc1LuG5qL0EMODR3udqQ4SQV6Me8gU0
         vo4g==
X-Gm-Message-State: AOAM533L+LKNMYzw85geY5LauuofSAfqxQYoO5no/ugwxw8NnEmHQbtR
        2fin3lfRrSZs2Me7vTsWWO31WNPA6kRzPU7gEWdPUQ==
X-Google-Smtp-Source: ABdhPJxKhhkxwRWVmaaKVxOyh3qvejCjDIr3yNQRWD870hkkTeHHZbJtXmbbx2iPuNB7nZjoO1GN3ll0CJpetV9WDDo=
X-Received: by 2002:a17:906:b45:: with SMTP id v5mr69591620ejg.464.1594619058124;
 Sun, 12 Jul 2020 22:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com> <20200711064846.16007-2-yong.wu@mediatek.com>
 <9e21288c-07da-88b0-2dbb-bd9a2a4d529b@gmail.com>
In-Reply-To: <9e21288c-07da-88b0-2dbb-bd9a2a4d529b@gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 13 Jul 2020 13:43:42 +0800
Message-ID: <CANdKZ0dwsaP=s8AgRbDx2_0y4JmPnF-X0Rb=4vor2MWCYWfGKw@mail.gmail.com>
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 2:06 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 11/07/2020 08:48, Yong Wu wrote:
> > Put all the macros about smi larb/port togethers, this is a preparing
> > patch for extending LARB_NR and adding new dom-id support.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
> >   include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
> >   include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
> >   include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
> >   include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
> >   5 files changed, 19 insertions(+), 4 deletions(-)
> >   create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> >
> > ...
> > diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > new file mode 100644
> > index 000000000000..2ec7fe5ce4e9
> > --- /dev/null
> > +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2020 MediaTek Inc.
> > + * Author: Yong Wu <yong.wu@mediatek.com>
> > + */
> > +#ifndef __DTS_MTK_IOMMU_PORT_H_
> > +#define __DTS_MTK_IOMMU_PORT_H_
> > +
> > +#define MTK_LARB_NR_MAX                      16
>
> include/soc/mediatek/smi.h has the very same define.
> Should smi.h include this file?
>
> Regards,
> Matthias
>

Looks like this is being addressed in patch 5 in this series ([05/21]
iommu/mediatek: Use the common mtk-smi-larb-port.h)
That said, should that patch be merged into this one?



> > +
> > +#define MTK_M4U_ID(larb, port)               (((larb) << 5) | (port))
> > +#define MTK_M4U_TO_LARB(id)          (((id) >> 5) & 0xf)
> > +#define MTK_M4U_TO_PORT(id)          ((id) & 0x1f)
> > +
> > +#endif
> >
