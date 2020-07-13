Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3CAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CF42064B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ds4Mxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgGMKfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgGMKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:35:45 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C19C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:35:45 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k23so12833748iom.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zkd7AusD5Iqi8emk4XGpAIzvYnOlGsGXoaeynxJlNps=;
        b=e+ds4Mxu02ZFxQAYVNOw7TqENK6NWoaPkZJ15GsOh6O8+qF/2/IJdeL+TkFXUDfabx
         MdmX8Y29Ljpzf7o42/z88a87iCOrAlwbwT9raV+Vk/b1FtIiFPvM75tVAQ5hRHxZC5Xs
         x+DcYR4yZzlNozDzLblRRiJ1/IBVLe8BJ1F25p/qHDgnfKOuWYMKAhwvPoaqRb/Uv8qy
         Aw7AHkdJaol8wmK2jCh+TCQ6AwqEMxK8PHvv4isbIpHrp0HJsV8o1jzpzwaY642WNrn6
         WGH6B2Hi1tlaV7nor1zz9hHmwAfQZp+NnQcR0AW0wYUaa2y8GdQXW/BsK3WbNoxCKoge
         aCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zkd7AusD5Iqi8emk4XGpAIzvYnOlGsGXoaeynxJlNps=;
        b=GZq+PQxaLZBFajfY4d0JgBjHde6wnYZPdh0Dzxnm8li+sjne0VmLI4c33/WMNLbvlw
         O/DWYTCEhCA4z0fXT/yTLRbeymzB8SZiQEZlrlNBSyavM2/47aCKCvnT026D3C5bvxAF
         R3m94V+X4H6zdQ/XxaA+54c+Op9otr68nyXiBWfHifQFFTE7gj8jZNf+TzUb+9re9PKl
         Aev5H2jl8xNu4hRTIrHmR27LaufJNefvIfnl3y4zXpojuQH1GzZLJd8BWcSDM7VReGnN
         9I53csXHHe7WpbqNih8FO7IydhyT9ZrHzbCAw2IJQIXKyVDD2p8FTgU+M/7HReoNb8jM
         9kYw==
X-Gm-Message-State: AOAM533O2TwqGLiHizlfM+0ftVJUyg6CGvkrxsEtnmEV/Q0aLs0jUNrs
        CLl4sZ027i1F7Xyl0iTrbvJyrGOKo4zyoqgu5AY=
X-Google-Smtp-Source: ABdhPJzCmPsUGSvqCwTgYsZRB+rx9MhwO4tdPSLLlrvlSMY+XJnd1AwtddubSmc8ksVG2gIZUma0ne8j5LMP6u/LfAk=
X-Received: by 2002:a5d:8f0b:: with SMTP id f11mr59878361iof.200.1594636544674;
 Mon, 13 Jul 2020 03:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
 <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com> <20200713065110.GB3500@dell>
In-Reply-To: <20200713065110.GB3500@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 13 Jul 2020 18:35:32 +0800
Message-ID: <CAE+NS36uRRqHetQE5QVJ94WX4g7CdQzvD-0VOnLfKAbqdHs3Sg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mfd: mt6360: Refactor and fix code style
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 10 Jul 2020, Matthias Brugger wrote:
>
> >
> >
> > On 07/07/2020 12:30, Gene Chen wrote:
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Rearrange include file.
> > > Remove brackets around raw numbers.
> > > Indicate sub-dev compatible name by using "-"
> > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> > > Rename mt6360_pmu_data by mt6360_data.
> > > Rename mt6360_pmu by mt6360.
> >
> > That seems like a lot of cosmetics. Why is this needed?
> > If you think that's needed it should be split up in different commits, =
each
> > explaining in the commit message why you do that.
>
> Agreed.  This set is still not broken up enough.
>
> Please place each logical change into its own patch for review.
>

1. Rearrange include file.
After check serveral file about coding style, include file seems sort
by architecture, not by alphabet
2. Remove brackets around raw numbers.
Due to redundant brackets, another reviewer recommended to delete them.
3. Indicate sub-dev compatible name by using "-"
Suggestion by Lees when review mfd binding document.
4. Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
Simplify the similar resources object.
5. Rename mt6360_pmu_data by mt6360_data.
Not only include pmu part, but also entire MT6360 IC.
6. Rename mt6360_pmu by mt6360.
Same reason as above.

We try to make code more simpler and easier to understand
We can also discard changes if patch 1,2,4,5,6 doesn't make any difference.

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
