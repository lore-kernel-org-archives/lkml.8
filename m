Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B9EC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865DC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6azBBvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbgDMVSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388824AbgDMVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:18:22 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6330C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:18:21 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id f195so2646751vka.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMStv6/H6fKdh3eOej5IbI92bnMSzwFQyeN+60omz28=;
        b=E6azBBvnm4EbB/a9ZuKz2TSlug3KWPAiix5Rw5gOLRMxggeZR1Vyib7CqdzmSOZspF
         8Fpa8rKNOZR17A9UtkUQhZN6tPJCgwsCKCy/oZrkwX1OCq8nPE/G/dpst0z3O1svY9Mc
         KjwK947vOsj47uLZch2bcTR0/UPEH28HsxFK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMStv6/H6fKdh3eOej5IbI92bnMSzwFQyeN+60omz28=;
        b=j0HBh0Nmec4vefrgJ2Ukdkd5vU74PQH0QVlhNQfOymUUSYAuXDsN80JNxV+dC5Ze5L
         zkHLLV5uG2tU2c9xtFpIDKY0/LQCIALgI4FvJKNFvUqdK5dAcEs1845aW0YO1+TW5h12
         JJiBLq2xz4npsR4SXpcK93lDzZb1Eus4weq1g6B69v9hu8O23RbuWLS3rX5kkPGSDdq9
         ng3eLxFkXvl6MFfQVRaXUPkwx36M4HqICJJgPWFoBqykgFG1GRLXf2LgqpM3FJOz8ymW
         ElDjgkSe+xgcus3aAVX+VmZcoU3w7ed3PE9NNdzeYcEymdvQRv2mn9OSelG3dObrkVw4
         wB0w==
X-Gm-Message-State: AGi0Pua/ZE6a6Br5x6Of9ryNr0UJ6dT85PANs6aSHQzD/G5698cEARd0
        E5UfkxdU7AykspnX4yINJdQCiqXiKIY=
X-Google-Smtp-Source: APiQypIE7avTwb/jb/oq6eqZQRx94mRn+HNf59w7N5kcvVwaF6uZjd89h/iKAhOQdH6AWr8vyZ+6qw==
X-Received: by 2002:ac5:cbcf:: with SMTP id h15mr2896779vkn.8.1586812699468;
        Mon, 13 Apr 2020 14:18:19 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 45sm3184075uaq.19.2020.04.13.14.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 14:18:18 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id 184so6404580vsu.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:18:18 -0700 (PDT)
X-Received: by 2002:a67:7141:: with SMTP id m62mr13509743vsc.73.1586812698026;
 Mon, 13 Apr 2020 14:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.1.I1b754137e8089e46cf33fc2ea270734ec3847ec4@changeid>
 <6566837cdb0e8db522c53daba8baf49c2ca79376.camel@perches.com>
In-Reply-To: <6566837cdb0e8db522c53daba8baf49c2ca79376.camel@perches.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Apr 2020 14:18:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UOzVmwpoxd4QTSPiG9nt=YjUYZdgmK=SKU6vTFWcf=bw@mail.gmail.com>
Message-ID: <CAD=FV=UOzVmwpoxd4QTSPiG9nt=YjUYZdgmK=SKU6vTFWcf=bw@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] drivers: qcom: rpmh-rsc: Clean code
 reading/writing TCS regs/cmds
To:     Joe Perches <joe@perches.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 13, 2020 at 11:21 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-04-13 at 10:04 -0700, Douglas Anderson wrote:
> > This patch makes two changes, both of which should be no-ops:
> >
> > 1. Make read_tcs_reg() / read_tcs_cmd() symmetric to write_tcs_reg() /
> >    write_tcs_cmd().
> >
> > 2. Change the order of operations in the above functions to make it
> >    more obvious to me what the math is doing.  Specifically first you
> >    want to find the right TCS, then the right register, and then
> >    multiply by the command ID if necessary.
>
> Though these operations are only used a couple times, perhaps
> it'd be useful to have static inlines for the calcs.
>
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> []
> > @@ -67,28 +67,33 @@
> >  #define CMD_STATUS_ISSUED            BIT(8)
> >  #define CMD_STATUS_COMPL             BIT(16)
>
> Maybe something like:
>
> static inline void __iomem *
> tcs_reg_addr(struct rsc_drv drv, int reg, int tcs_id)
> {
>         return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
> }
>
> static inline void __iomem *
> tcs_cmd_addr(struct rsc_drv drv, int reg, int tcs_id, int cmd_id)
> {
>         return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_id;
> }
>
> > -static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> > +static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> >  {
> > -     return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
> > +     return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
> >                            RSC_DRV_CMD_OFFSET * cmd_id);
>
>         return readl_relaxed(tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
>
> etc...

I won't object if you really feel passionately about making that
change but at this point it doesn't add tons of extra readability for
me personally.  I was kinda hoping that Maulik and my series could
land in the next few days since having 16 patches outstanding gets a
bit unwieldy.  I'd rather not send out another spin of my series at
this point since it's just a bunch more churn in everyone's inboxes.
Maybe after they land you can post that as a follow-up cleanup?

-Doug
