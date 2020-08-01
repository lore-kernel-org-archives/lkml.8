Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D20C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 23:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A5520691
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596325861;
	bh=/RTX0rVm2iLBMlRdDM24nNOFTPRHcYFdhTxisdSjWDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qY2RGjyvIRH0ZhSS5NkEuNzeBTNnn7Rq+fgd7DgWlnRWho+wHNbRtn+VHjNBjHHHM
	 Jh+EmROt4HAb2kcNVhF/mrhfnlxgf0PP3Y5y8PPVvGgSlDJUvOMXgtoNMFw2oWnI/G
	 W6PLUQxYeLs2eLzz+ptjMIwST5TQsWOm06xsGFnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgHAXu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 19:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHAXuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 19:50:55 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47C420789;
        Sat,  1 Aug 2020 23:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596325855;
        bh=/RTX0rVm2iLBMlRdDM24nNOFTPRHcYFdhTxisdSjWDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GKa0b1n++JBbGlBkW2Q8zcKWc/8G5g2kRJ1hJfSjcl0x25nRnPleix94G6SZQBMQf
         CQBVbFMYm+Bwo6LXpkuUFdKiPhsXf5MRx+q682XvJ9JLGD6PVliYxMZVYv37rXZsGT
         SRG9c33TAZhWB2sOk3/rPYxvyyMkSdpNP5xIvKPQ=
Received: by mail-ed1-f52.google.com with SMTP id i26so21476911edv.4;
        Sat, 01 Aug 2020 16:50:54 -0700 (PDT)
X-Gm-Message-State: AOAM533cETGWa34GDD1RTJGvLLnrmUYg7KS0o7sn7TrFzvqkG20r7JTU
        bCsruVDPh0ln68A13AoUYmCv4f2K1qJYOsCskg==
X-Google-Smtp-Source: ABdhPJzQmcCCQwR67S6JChR4X8UlBaNrr/6FEYSwtL2uZyPlHYYi1Y8yC31MEt19hcsQnLvDj3qLleKurtzHXUqlyw8=
X-Received: by 2002:a50:d2c7:: with SMTP id q7mr5358828edg.61.1596325853405;
 Sat, 01 Aug 2020 16:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com> <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Aug 2020 07:50:41 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-RMT-1+-5aPxqhgLbk74j0MH8U78mibBZppt_OPPQrJA@mail.gmail.com>
Message-ID: <CAAOTY_-RMT-1+-5aPxqhgLbk74j0MH8U78mibBZppt_OPPQrJA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +
> +struct mtk_devapc_context {
> +       struct device *dev;
> +       u32 vio_idx_num;
> +       void __iomem *devapc_pd_base;

This is devapc context, so prefix 'devapc' is redundant.
And, what does 'pd' mean?

Regards,
Chun-Kuang.

> +       struct mtk_devapc_vio_info *vio_info;
> +       const struct mtk_devapc_pd_offset *offset;
> +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> +};
> +
