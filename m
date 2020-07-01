Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0B92073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUKgl91b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgGADpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGADpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:45:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:45:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so21636951ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBz+jEb6wK1LlNw8ACgX4nWl1JiNlrUxCpaRcgOcNMY=;
        b=CUKgl91bW3eQwUurAPzfs3189MS6vi9b8vTqoTS3fXd07sQhCEmMwzCr+Mun7OIdaJ
         hyPV+AQqLOvnTivdudbjuZaJwvWk1QPr0sbmQI4vsLWn6rn6vQaaohxVeCHTTmcE6TUg
         kc90eCGJGecUtDkt636fORfD4ocOtlbEdRTicN3MlJGie8IGlHG44V2CqVIspQ9oluAB
         POosrx84TXrfN2FwCCZKFCGh8ViWlGC8mPfSYFOj6NNodpKqe2DBlvZhmQeVz7jHUT2K
         aBcZt2LalVWbMc23gHYAnq1+DI96OTXt+mXmhu29Go/xC9YNibQ547BEMpbGSkmpYUu5
         Zq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBz+jEb6wK1LlNw8ACgX4nWl1JiNlrUxCpaRcgOcNMY=;
        b=Ow5SlP/7+SngPuTlAlb3FIK+x2wcc66plvoiK08if5nBFEZYVtaB7bE/LpD7EVwCc1
         dE6i2GU2LpNuMtVjEJEbvAeQF+RlJwgYdNSK2ZmSz6V/PNxX7dKhSAAvJSXjCx2S50Xq
         CBctm9/Bpo+h+jvTnH+EFh5TwWfBBnlniLiIFkgmaRmpbao+MqzPTLv6DrK2LQ0Voi13
         kigufvREefcSOkAy2xo1ZS/QFG6mPpChbDVf1c/8FeSvO04ZeCtc+ff7fSTbOsxC8CCY
         EPoh8ojV77y7KAaRGXDSXonLCcTBlDy0P8BYwphB/3Kk2KaejXRnrE0pJNkZam11kH3D
         ZzKA==
X-Gm-Message-State: AOAM530BlaAWfxZhpYDydFfmNn7NS+3809ggi6nK5QrOZchjP7EOUnf1
        Mmvj9p4dFLIt32NER8rV02CmEEQNQ3Hts11OuE5FnqJK
X-Google-Smtp-Source: ABdhPJzZiy0/RrxJEYCgpY8YdrdDpvjCA/fSs2FUDRRZ1tcTC+bKJxBHbcusdhWcpiKRuQpJIczAKkx+F1SESXet0HI=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr2400378ljh.218.1593575112578;
 Tue, 30 Jun 2020 20:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
 <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com> <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 1 Jul 2020 00:45:01 -0300
Message-ID: <CAOMZO5CZMBeSY=0sa39wJsZpaCqWeCb4-HG4jjXO5pGeW64azg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 12:42 AM Andy Duan <fugang.duan@nxp.com> wrote:

> It doesn't break old dtbs, and doesn't break imx6q/dl/solo.

Well, it breaks imx6qp as I said multiple times.

It does not break in your case because you are using NXP U-Boot.

You cannot assume people are using NXP U-Boot.
