Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D164C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA59206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLkUYzU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHILCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHILCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:02:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC0CC061756;
        Sun,  9 Aug 2020 04:02:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o21so6292402oie.12;
        Sun, 09 Aug 2020 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WprT/dfsik7SE7E1bU7qAKAxCXB7Ve5h5LFVPNakpU0=;
        b=LLkUYzU9m3dfZaLVUUZDVuiJiCAVi68LHp6S16MH76XNn7ONANrmokq8af6inqMzTO
         X/8NMWLFGCaSdbT3f75Se19ukcjw3vFJZVtVpnBjuZZHKtsdBjVE1Sfbcht53I9+bDQ+
         x1NAhzMjoyGVJQBgzAQr5EfHrp/azboQEVUQox2/Tw3zQMmD1htRtzpkGPhnwK2JNidA
         0YA3b7ZFgyHAf5QhhUKsKS5lR2kdGrjHCRN/ClJi4Ndcu37r8GbBaswK2fLYWQP4WJya
         0igjEzyS0MCxygh5dG9dhEEUpHn1dpUS2qSU93hLWFnCp+Ug9pk9LbrvTN5vHvdZRryl
         S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WprT/dfsik7SE7E1bU7qAKAxCXB7Ve5h5LFVPNakpU0=;
        b=P1uMnciyOKyDRPTGgK/S1fcO531Way8X4O+xpyj5TmvKKvHnU+GmBlrHPB8h9FMsVa
         nV/kwTISrWRrStSpnuJstXNyezGFmCZEecBV6Xu5Wi2j51Fp8dUHx2hwv+iaii11zmCw
         rYFZywWieycYpXLPjI8dOUhyOu7nqg+NsbrinBzGHcPGMD20vyywT8yH6as1B7m/PGBg
         hdtkc+WdBJ7XTeXmdrhjKQ/+cD3Ss1OtTjjprQah/hD8SpCO6tOw7zF4AKDK+eoG9FIx
         nQXfUzPPeCViSuDFeQXYHudu36mHoobCW0p+NKuIv6X8abP6+CmmpcjtIaOVLT4+5DD1
         dKyQ==
X-Gm-Message-State: AOAM532gUFNZ8X0MQdkETRsi81Bq2xwVgnCGvJ8rbLlY0QUTZKTS8Lgy
        tGIWPtRPnIZc1LUrqO9h1685HJ4WprhoI37dbbDunk9p
X-Google-Smtp-Source: ABdhPJyuPFTiwJSL5v5H1oVTK9zSQbmLqMXjHJ14YN+M4iwKa/t127k0u89DKj1VngpHpKU+2rYa+XJB1o6Y5JxCfq0=
X-Received: by 2002:aca:5bc6:: with SMTP id p189mr17572478oib.130.1596970965656;
 Sun, 09 Aug 2020 04:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200730082022.5557-1-colin.king@canonical.com>
 <CAFCwf101gsf3GK6f_ggNgPeKTFXEDdCYz-LugNq5mY342zc2Hw@mail.gmail.com> <20200731062057.GC1508201@kroah.com>
In-Reply-To: <20200731062057.GC1508201@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 9 Aug 2020 14:02:18 +0300
Message-ID: <CAFCwf11oAg=mhsqwnSh7vHuUeJEpEtBFKggFaRcbOFY8PhPsPA@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: fix incorrect check on failed workqueue create
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 9:21 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 30, 2020 at 01:51:48PM +0300, Oded Gabbay wrote:
> > On Thu, Jul 30, 2020 at 11:20 AM Colin King <colin.king@canonical.com> wrote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > The null check on a failed workqueue create is currently null checking
> > > hdev->cq_wq rather than the pointer hdev->cq_wq[i] and so the test
> > > will never be true on a failed workqueue create. Fix this by checking
> > > hdev->cq_wq[i].
> > >
> > > Addresses-Coverity: ("Dereference before null check")
> > > Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/misc/habanalabs/common/device.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> > > index be16b75bdfdb..35214a186913 100644
> > > --- a/drivers/misc/habanalabs/common/device.c
> > > +++ b/drivers/misc/habanalabs/common/device.c
> > > @@ -288,7 +288,7 @@ static int device_early_init(struct hl_device *hdev)
> > >         for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
> > >                 snprintf(workq_name, 32, "hl-free-jobs-%u", i);
> > >                 hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
> > > -               if (hdev->cq_wq == NULL) {
> > > +               if (hdev->cq_wq[i] == NULL) {
> > >                         dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
> > >                         rc = -ENOMEM;
> > >                         goto free_cq_wq;
> > > --
> > > 2.27.0
> > >
> >
> > This patch is:
> > Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> >
> > Greg, can you please apply it directly to the char-misc-next branch ?
> > I don't want to send a pull request for 1 patch.
>
> Already merged :)

Hi Greg,
I can't find this patch in char-misc-next.
Can you please check if you applied it ?
If not, I'll apply it to my fixes tree and send it to you for -rc2

Thanks,
Oded
