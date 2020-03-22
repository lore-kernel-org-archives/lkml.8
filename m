Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A84C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62520775
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 19:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/rTj5IB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCVTId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:08:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgCVTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 15:08:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so5160135wrw.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHveMlauqRVMu8fl2+LENgr9/RI30rs1DmCAR9b9ZtA=;
        b=a/rTj5IBVyi1Esfi+59moPOqgxDRn0pnSpMeVKAHeWnJBWIOw215Tbj3bTQ3COnd/9
         1bwRyXqehZfqBx82HZcPTIlORHRcaoNpr3jgBFAwGPgq7lahDjd7PK9seS1gwJxDH/vC
         eHA6yiSjV+g4jd6RS0SlsKLzmgf9fEkeOqOOJNIBwmb3dp1PVXkvs42TGHmdvLXlwiRj
         OlZWsTBy68iWLEgHRlSHypMIJv4ZXIxwMNgi3YmIPamvb4hQASKofbo+mez9rwoGj8cX
         +2tUiA9iM7/0Kcc6VR2uuJmfU8Wk4aN5PMNvTDAcSQNBKKgiuYzy65Jf2/rIhBI30UPG
         x2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHveMlauqRVMu8fl2+LENgr9/RI30rs1DmCAR9b9ZtA=;
        b=rSshZ90VR+CczJTRCzvfL6VVeJAq4jBHE4VKQRbVOoJiXLTNWKoYSXdry9/vGp4G/s
         ZwaXxepZAWIbCun9Em7qTd7URIcjM0hDrcEVFvp/pANDAwfXqOrRZ1lTyxDvyDFDRm/5
         gK70cwHclMhFNrejXoHw1FOP1Lod5n5fhJZaH/4jFCYdCNFRmmj4UgnCW1GFDe4V/CRK
         ndmK2cWheR/NoQFzhCfFLp/+w7VaSfZ2HrCKqKBSUSjz05AQRxBMGAyiN0nwZ2+7Oi4L
         K+R/JZKkvXxtDlY4y8v3V1DFjVWSFhqJp1U/Nw8bdeDcPh12Omf9vCttm906amwBVRxT
         kKDw==
X-Gm-Message-State: ANhLgQ2pcYFvm6yH6iJne4QF3XhXhWb0a7TjklmKrLX6IuCt9xf7fi/d
        DfR4qkZG9syzZYBHfvDNmWWjBzF3RctPICg49SY=
X-Google-Smtp-Source: ADFU+vufzdDGsWfmALtU7fqgzxBUoCKg4jVeDJkFur2D1C18OFChZZtkuR+40P2N/qETqdOTsNxxvLSe/vyWu+3IkW8=
X-Received: by 2002:adf:a3db:: with SMTP id m27mr25765703wrb.350.1584904103034;
 Sun, 22 Mar 2020 12:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <1584421001-2647-1-git-send-email-Anson.Huang@nxp.com> <86mu89zqce.wl-maz@kernel.org>
In-Reply-To: <86mu89zqce.wl-maz@kernel.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 22 Mar 2020 21:08:11 +0200
Message-ID: <CAEnQRZCcmaU91Ep5kVesaGPsrvujq5mznk2SZccmZG9rbSCG0w@mail.gmail.com>
Subject: Re: [PATCH] irqchip: irq-imx-gpcv2: Remove unnecessary blank lines
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, tglx@linutronix.de,
        jason@lakedaemon.net, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 5:22 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 17 Mar 2020 04:56:41 +0000,
> Anson Huang <Anson.Huang@nxp.com> wrote:
> >
> > Remove unnecessary blank lines for cleanup.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/irqchip/irq-imx-gpcv2.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> > index 4f74c15..4f11b9b 100644
> > --- a/drivers/irqchip/irq-imx-gpcv2.c
> > +++ b/drivers/irqchip/irq-imx-gpcv2.c
> > @@ -17,7 +17,6 @@
> >  #define GPC_IMR1_CORE2               0x1c0
> >  #define GPC_IMR1_CORE3               0x1d0
> >
> > -
> >  struct gpcv2_irqchip_data {
> >       struct raw_spinlock     rlock;
> >       void __iomem            *gpc_base;
> > @@ -287,6 +286,5 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> >       of_node_clear_flag(node, OF_POPULATED);
> >       return 0;
> >  }
> > -
> >  IRQCHIP_DECLARE(imx_gpcv2_imx7d, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
> >  IRQCHIP_DECLARE(imx_gpcv2_imx8mq, "fsl,imx8mq-gpc", imx_gpcv2_irqchip_init);
>
> I honestly don't think this deserves a patch. Next time you work on
> this driver, add the cleanups to it. But on its own, it's only churn.

While you are technically right, it's only churn I think we need this
for code consistency and cleanup.

Even if we fix this when we work on the driver we still need
to make the cleanup in a separate patch.

My 2 cents,
Daniel.
