Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602C020759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFRv66x+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG1CQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgG1CQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:16:30 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:16:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i138so8972834ild.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+qhhZcvnd3RwCE+F+SIU+6bIz1sPCtUPTyz82YandFo=;
        b=qFRv66x+Edw1E+2euA44W6pSi/QdRSgRAuqJr5j87nkElpfIJYd0Ulo2oMb7qvFS2A
         1YaugNbwMsygktYgyYSotHWs4z+QeIc4BhbLPLluw85gbbpJuGg27/hfsTBCSOTN0c2Z
         KnxSpb8uZRn6vzvEns12aizFTS7X0H+TBuwNMbRq4TlHww/GMpfSlMIibX8M90RvvCDp
         EDzsLb2qVJsm6OzyV7+I3s7OWTKed8CL5ua+kpiVkdWF7wwShVUtGYBpMn4pSdXYA/Pm
         kYNgKfMX5KIi1KMlmP+h0paxQXYe6dVD28DGHha+CjQ+G8vdC25H2tmEkd17vauWmGg5
         rcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+qhhZcvnd3RwCE+F+SIU+6bIz1sPCtUPTyz82YandFo=;
        b=h2TH3IBDNKHIjEwCwkvAUSky/4psWM1CSyq6bRdVVQ6TlRByKkN0ySF+ADEgxSHBRS
         sP4hzRV+1p1MgJXDJiXgIGTrVWMNEONm/pg1741OqMbWBF9hYHbf231OmY7TKfYzMYV8
         0hZLSfAc79YJO0lYxQSEbEQUDyEkBtZNpNaBdoD9ZGPD3Yt6MpKHN6yi/BULtY/e1Uba
         ylCjnDXYQYz+nGb4iBIGINJ7FP+oDMifEbrDj+izj1M10zrqdE5ikFW9CB7+bj9E6t2m
         tCW/hdGh8uE2Ati/C4ewDXCT1lmz1WrsfD3jyDkshYPgPYs/LfDW7D0ZdctPItTDHIaE
         XXig==
X-Gm-Message-State: AOAM5315nTcjpvmNXZx0EiJa8j1Ep2vXEp3dFet2mKNaPI7zW8qELpJd
        bovaig0MgzJ3uAfFHj0NxHP6wXfEuuAxitvHheppGQAR
X-Google-Smtp-Source: ABdhPJyRGZ6wDA+UhVMRrrMpC3VXX10f0UdEKy2RU3tRJYFS731AYHP3Mobcvf9npHHHyQCtFPwo1Fi6FOVbF+R/H0c=
X-Received: by 2002:a92:9f96:: with SMTP id z22mr27481140ilk.266.1595902589613;
 Mon, 27 Jul 2020 19:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-2-git-send-email-gene.chen.richtek@gmail.com> <20200727110821.GH1850026@dell>
In-Reply-To: <20200727110821.GH1850026@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 28 Jul 2020 02:16:15 +0800
Message-ID: <CAE+NS34FexE-LwbzkOLepKytKCbKm3RowPQKqROR_a6wCrVLLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mfd: mt6360: Rearrange include file
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 17 Jul 2020, Gene Chen wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Rearrange include file without sorting by alphabet.
>
> Why are you making this change?
>

Personal coding style references from upstream code.
I can discard this change if it doesn't make sense.

> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/mfd/mt6360-core.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index e9cacc2..df4506f 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -5,15 +5,14 @@
> >   * Author: Gene Chen <gene_chen@richtek.com>
> >   */
> >
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/i2c.h>
> > -#include <linux/init.h>
> > +#include <linux/crc8.h>
> > +#include <linux/slab.h>
> > +#include <linux/regmap.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/kernel.h>
> >  #include <linux/mfd/core.h>
> > -#include <linux/module.h>
> > -#include <linux/of_irq.h>
> > -#include <linux/of_platform.h>
> > -#include <linux/version.h>
> >
> >  #include <linux/mfd/mt6360.h>
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
