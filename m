Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4364C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A00C20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQL2Dzu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgGWRhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgGWRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:37:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152EC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:37:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so3364020pfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnuIrZu2OWZ5kvibJg3aLSShYvtv8J4Cmi01ZuM4HUc=;
        b=PQL2Dzu+NyxvneZO+9riZM5BPQljQd5y0QHCqDonnE9YhEMxSIxU1BxGHIgflOvBgs
         aVM1ujTMLTpWe2xuZaJF0T90dTxI4S4fTu+fomJ9guXal5MCiQwuzFh+a9venPA8cruV
         I5+/M8kERmuifFpR2Y+CLeFkHpLbevIG8qmQu1qa0rxljQ8fiJYr6fisZklFa0WAjrWo
         ZSPFB3DurMQ1rcxRADLINxxFeRWWMIT1q6O6IIPbVD1KmIUzniZj1j4QtlKzWeS+f5M6
         NSWJEXusM+uVG0MzzQkqW4aBmpuhAyXMZWUcCOvREVIDcp500g0r42e2W9hfW5XmiToQ
         K41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnuIrZu2OWZ5kvibJg3aLSShYvtv8J4Cmi01ZuM4HUc=;
        b=ZLr6Kcsv5+q70DK7zZKxDRNHIr/ZFm/JvGKm7yVm/I20cD2YXSrSIAvjSDogXBg/YG
         xbz9NJG2g1ItWiPvhnx26kzt8YcWuacFmXAkOIbZ3diLYM1oDJHtTRB9rkP/hzCQ+JXR
         4F6L9vVUAEo7pngVVYwqMWESm2fPLKvatd0+jaSuj3Q0mUqy2X+p5wE7BVv/NFU9/Zb6
         FThTCKeMePEarSCQTPesjI66H7fqMIVtP6qeA4kcbiWc+rRfiSYZqHzk2wV6hUEBLPAB
         XwOU9CafUCmZOWaMTXt7O3vPegLgdNYcLxv9gwBDZOoUh4H3bNPg1XKCaZbLafvsJuPR
         fG4w==
X-Gm-Message-State: AOAM533oVCheUWuoM9XJyoaM37QW7Noqq8VsCbk2Z3IZsAXzceu8a56e
        YoFaimwOhDOJnnER8b8Qmax80cljYTEJEnGetOT1FA==
X-Google-Smtp-Source: ABdhPJzFd1N2krZxRMK3NLvXZSLLCFIMX7xBovURQlHaZx+irb05W06lmdHRV6Pg81rYWDbD3PvqpSO/m7aTpaGtEeM=
X-Received: by 2002:a63:fc01:: with SMTP id j1mr5228706pgi.0.1595525864945;
 Thu, 23 Jul 2020 10:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-5-saravanak@google.com> <1595504763.31289.5.camel@mtkswgap22>
In-Reply-To: <1595504763.31289.5.camel@mtkswgap22>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 23 Jul 2020 10:37:09 -0700
Message-ID: <CAGETcx-BWm9TPZix7WvVfe+BwHi=9-Bq2xJBLEK-dWH+xzpYxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] irqchip/mtk-cirq: Convert to a platform driver
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 4:46 AM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> On Fri, 2020-07-17 at 17:06 -0700, Saravana Kannan wrote:
> > This driver can work as a platform driver. So covert it to a platform
> > driver.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/irqchip/irq-mtk-cirq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
> > index 69ba8ce3c178..62a61275aaa3 100644
> > --- a/drivers/irqchip/irq-mtk-cirq.c
> > +++ b/drivers/irqchip/irq-mtk-cirq.c
> > @@ -295,4 +295,6 @@ static int __init mtk_cirq_of_init(struct device_node *node,
> >       return ret;
> >  }
> >
> > -IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_cirq)
> > +IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
> > +IRQCHIP_PLATFORM_DRIVER_END(mtk_cirq)
>
> Hi Saravana,
>
> Looks good for me to convert cirq to a platform.
> Thank you for your patch.
>
> Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>

Hi Hanks,

Thanks for the Reviewed-by on both patches.

-Saravana
