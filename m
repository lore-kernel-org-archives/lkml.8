Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D852076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQmXWerI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgE3Und (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgE3Unb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 16:43:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51BC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:43:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so3010862iow.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4AsZGoHkWeKZl23U2BgKUaE05/budRARyGFisUFMAg=;
        b=OQmXWerIg8QIvwAPvdBRaSBVezUo5IXv/JrET0Ok0KHl9WRT5scWvK8IQNIWc0KtMn
         Lkvgxho9ysVNpAmheK8lMRh+f/RTpT1iR1OUu8fKh3+Mm8bVJc7ycrmuXuY5ixrA9l2C
         u+ROczlA8vOOgr4hXs0YzFBOOoTea9C8kKE3ZzTrFT4vjw8DfhxYJb5XxvOqEIaZPV69
         +1Z3UFEDChNboaZGgHvjtF+0DbDU1zlODSZLNLwoiI3FRNkNbOiV/fnl9YoLatz91vlM
         27sZKOL0n4svv6djq4nMOvMXkLFAmII8H4tO99dsK8k5k8nHOdMrUVL/Cn83cidaQhb7
         ArhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4AsZGoHkWeKZl23U2BgKUaE05/budRARyGFisUFMAg=;
        b=ByUrhNmuo0mKJFtzc9F/UxOmxwC7wJU9Qnjz63Vfl8sIxducA+b5j2AK5SHJ4VhdjX
         YVxd0FwXC3j6KGwJgiyaFswDjwtUtSIRSG4GQdc6OtqPmUFKDWQ7tXJrleK3B+ouDJDK
         I+gNEosAIduUUaIMsXht0HLNuoSooP9bS7R0cjdbdBbTWJ8MhUJlY1tzSPPrrkBJgLAV
         lGnz6OWqrx+e6qocw8IXlQKkbhKVwBAAgsyUQUAkoiwfx4tuvQSfqLkCHuLTlQcpf9fx
         hPBCG//hkonKFUZ1+gZaqjAuTvChvPTMTYFvBk40znkcEc0m7Qab5+kcUySUi8lV1LRl
         c1+Q==
X-Gm-Message-State: AOAM532QWfuy5WqLaZmMbWiWSh9MFrTmjCl/usPFc3D3vChhYpNso+Da
        a/pb5BGRE5cQnLSm0WXXiJwLORdZtXOfjA1ziPI=
X-Google-Smtp-Source: ABdhPJzu7g1KysQKCksCZKnwLqPTctR/FKten80v+eHNGAZ22seueovNdiNBUYMuUDcn6usaq72w9TPTlEK/Ff5Hlc4=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr12011542iov.80.1590871410827;
 Sat, 30 May 2020 13:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916D588A9432A9F1D1F99BAF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496671BFF3496FD1C4C51E7E80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39164CB0791AB259CE62EC4EF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916BD0FCF482C124E21D3B1F58E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916BD0FCF482C124E21D3B1F58E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 30 May 2020 15:43:20 -0500
Message-ID: <CABb+yY2J5Q6uvXNk0KE3QL32C_J3RFHJJX_tq4R9arAcvJ262g@mail.gmail.com>
Subject: Re: [PATCH] mailbox: imx: Add context save/restore for suspend/resume
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:55 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Gentle ping...
>
>
> > Subject: RE: [PATCH] mailbox: imx: Add context save/restore for
> > suspend/resume
> >
> >
> >
> > > Subject: RE: [PATCH] mailbox: imx: Add context save/restore for
> > > suspend/resume
> > >
> > > > From: Anson Huang <anson.huang@nxp.com>
> > > > Sent: Friday, April 24, 2020 10:33 AM
> > > >
> > > > > Subject: RE: [PATCH] mailbox: imx: Add context save/restore for
> > > > > suspend/resume
> > > > >
> > > > > > From: Anson Huang <Anson.Huang@nxp.com>
> > > > > > Sent: Friday, April 24, 2020 7:01 AM
> > > > > >
> > > > > > For "mem" mode suspend on i.MX8 SoCs, MU settings could be lost
> > > > > > because its power is off, so save/restore is needed for MU
> > > > > > settings during
> > > > > suspend/resume.
> > > > > > However, the restore can ONLY be done when MU settings are
> > > > > > actually lost, for the scenario of settings NOT lost in "freeze"
> > > > > > mode suspend, since there could be still IPC going on multiple
> > > > > > CPUs, restoring the MU settings could overwrite the TIE by
> > > > > > mistake and cause system freeze, so need to make sure ONLY
> > > > > > restore the MU settings when it is
> > > > > powered off.
> > > > > >
> > > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > >
> > > > > As mentioned before, we'd better keep the original author.
> > > > >
> > > > > > ---
> > > > > >  drivers/mailbox/imx-mailbox.c | 35
> > > > > > +++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 35 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mailbox/imx-mailbox.c
> > > > > > b/drivers/mailbox/imx-mailbox.c index 97bf0ac..b53cf63 100644
> > > > > > --- a/drivers/mailbox/imx-mailbox.c
> > > > > > +++ b/drivers/mailbox/imx-mailbox.c
> > > > > > @@ -67,6 +67,8 @@ struct imx_mu_priv {
> > > > > >       struct clk              *clk;
> > > > > >       int                     irq;
> > > > > >
> > > > > > +     u32 xcr;
> > > > > > +
> > > > > >       bool                    side_b;
> > > > > >  };
> > > > > >
> > > > > > @@ -583,12 +585,45 @@ static const struct of_device_id
> > > > > > imx_mu_dt_ids[] = {  };  MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> > > > > >
> > > > > > +static int imx_mu_suspend_noirq(struct device *dev) {
> > > > > > +     struct imx_mu_priv *priv = dev_get_drvdata(dev);
> > > > > > +
> > > > > > +     priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int imx_mu_resume_noirq(struct device *dev) {
> > > > > > +     struct imx_mu_priv *priv = dev_get_drvdata(dev);
> > > > > > +
> > > > > > +     /*
> > > > > > +      * ONLY restore MU when context lost, the TIE could
> > > > > > +      * be set during noirq resume as there is MU data
> > > > > > +      * communication going on, and restore the saved
> > > > > > +      * value will overwrite the TIE and cause MU data
> > > > > > +      * send failed, may lead to system freeze. This issue
> > > > > > +      * is observed by testing freeze mode suspend.
> > > > > > +      */
> > > > > > +     if (!imx_mu_read(priv, priv->dcfg->xCR))
> > > > > > +             imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
> > > > >
> > > > > This could be separate patch if it aims to fix a specific corner case.
> > > >
> > > > This is NOT corner case, it can be reproduced with our imx_5.4.y
> > > > very easily, and this issue cause me many days to debug...Also cause
> > > > Clark's effort to help test it a lot for many days...
> > > >
> > >
> > > Is this issue only happen for non-state lost case (eg. Freeze mode)?
> > > If yes, it's a specific case and worth a separate patch to highlight it IMHO.
> > >
> > > BTW, it seems most drivers have this issue in current kernel because
> > > they don't know whether the state are really lost, it seems like
> > > kernel still doesn't support this well.
> > >
> > > > I do NOT think it makes sense to first send out your patch with bug
> > > > for review, And then add another patch to fix it. 1 patch is enough
> > > > for this
> > > feature.
> > > >
> > >
> > > Anyway, if you really want to go with one patch, for this case, we
> > > usually could keep original author and add a small fix note in commit
> > message.
> > > (You could see many community guys do like this if you search kernel
> > > commit
> > > log)
> > >
> > > Basically we try our best to keep origin author in order to respect
> > > others' work for community work.
> >
> > I am fine with whoever is the author, my focus is the issue fix and easy rebase.
> > If maintainer agrees that introduce a patch with bug and add another patch to
> > fix is OK, then I can rework the patch into 2 patches.
> >
Not two patches, just add to the original patch and add a fix note in
commit as Anson suggested ... though I don't know what the original
patch was. But I am definitely in support of giving credit to the
original author.

thanks.
