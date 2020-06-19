Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7978C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56B520809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YoGoPScH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgFSAfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgFSAfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:35:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A11C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:35:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j13so4661371vsn.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sL5gZ4vOAKEirPKLzW02auBChHPmDUb8IY2xuO5IvUk=;
        b=YoGoPScH89CrVSf52d0551jmRTDhQPIuxmkDlYUfpuRR+FPM9Wu5+I79mM1TZNt6FB
         ok7O1Yy3TQ+J/i5f4mpkwV43SFeJZQ0adURF9ebgA7sIPuDXBRVdzT1Sf4TRXVgujQDj
         UrmCB+tHNuAI8lySYE/ZXe1IOjrSe7SOEU+Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sL5gZ4vOAKEirPKLzW02auBChHPmDUb8IY2xuO5IvUk=;
        b=qBHKD1RbeuoDAae9l7PqLK9yd7H51WUO/B7qFODToIeKEWjvkE3paUzdxEvRYmhKLW
         mnnYnKfnwc6C4QgPxeC0wn3VGuQdmn2qwNREQFKKGyt0ZKNEvO+7brn7FhPP4njxNO9L
         a7lWAXP60R0ff2gVnpkP6ZHO0kbc/6h8/yi0NNxSmza3Duc6dIC4TMZXw3GgyyF37Gbx
         FC5kPbxZh6jLD+9pQacvSwYdlK5Cl37xhrIZ3etPlB01lgjpjhLq/qof0xCtukN6XNP+
         MPrrBhgmOvfEcUAlbtGvhbimXrsvdyNeyUdAxBpmQC2Nfg+dBqTiAsYC+B7NCacAp1Ve
         XQdA==
X-Gm-Message-State: AOAM5324YWvaXI56s4p8Su/FVRA+QPzGVrHqX854c+hxk1VBqTvGx11T
        Z4f6nZzmGKRtlbJyMLo40pvZ7iBo6UU=
X-Google-Smtp-Source: ABdhPJxwkZVfO9VANv2HcmBimCoVJiGqrDE9dW+UEnvXNcnZoFqVAHOPrhOrux1Ec4Avr1xTB1cCmA==
X-Received: by 2002:a67:542:: with SMTP id 63mr6176318vsf.128.1592526908521;
        Thu, 18 Jun 2020 17:35:08 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id h190sm536277vka.53.2020.06.18.17.35.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 17:35:07 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id v25so2618341uau.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:35:07 -0700 (PDT)
X-Received: by 2002:a9f:3b1c:: with SMTP id i28mr773392uah.22.1592526906708;
 Thu, 18 Jun 2020 17:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200618150626.237027-1-dianders@chromium.org>
 <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
 <159250352382.62212.8085892973272354046@swboyd.mtv.corp.google.com>
 <CAD=FV=Xh3+cROZC8dCn99MLkngsyBcxq+Gv1CERayZXExwdygA@mail.gmail.com>
 <159251712230.62212.10744179843753723398@swboyd.mtv.corp.google.com>
 <CAD=FV=W1y4Z4T13i410zkb27mUxqn+rQE889=ckEEBhbPuci2w@mail.gmail.com> <159252347502.62212.15886549130634139267@swboyd.mtv.corp.google.com>
In-Reply-To: <159252347502.62212.15886549130634139267@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 17:34:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WC_EaktmUgev_13roVYyTsmHukYO0oJODhjVVryVPpzQ@mail.gmail.com>
Message-ID: <CAD=FV=WC_EaktmUgev_13roVYyTsmHukYO0oJODhjVVryVPpzQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 4:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-06-18 15:00:10)
> > On Thu, Jun 18, 2020 at 2:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > -----8<----
> > > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > > index d8f03ffb8594..670f83793aa4 100644
> > > --- a/drivers/spi/spi-geni-qcom.c
> > > +++ b/drivers/spi/spi-geni-qcom.c
> > > @@ -121,6 +121,10 @@ static void handle_fifo_timeout(struct spi_master *spi,
> > >         spin_lock_irq(&mas->lock);
> > >         reinit_completion(&mas->cancel_done);
> > >         writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> > > +       /*
> > > +        * Make sure we don't finalize a spi transfer that timed out but
> > > +        * came in while cancelling.
> > > +        */
> > >         mas->cur_xfer = NULL;
> > >         mas->tx_rem_bytes = mas->rx_rem_bytes = 0;
> > >         geni_se_cancel_m_cmd(se);
> >
> > Sure.  It gets the point across, though
> > spi_finalize_current_transfer() is actually pretty harmless if you
> > call it while cancelling.  It just calls a completion.  I'd rather say
> > something like "If we're here because the SPI controller was calling
> > handle_err() then the transfer is done and we shouldn't hold onto it
> > anymore".
> >
>
> Agreed it's mostly harmless. I thought the concern was that 'cur_xfer'
> may reference a freed piece of memory so it's best to remove ownership
> of the pointer from here so that the irq handler doesn't try to finalize
> a transfer that may no longer exist. "Shouldn't hold onto it anymore"
> doesn't tell us why it shouldn't be held onto, leaving it to the reader
> to figure out why, which isn't good.

Right.  The point is that 'cur_xfer' isn't valid anymore after
handle_err() finishes so we shouldn't hold the pointer.  I'm OK with
your wording and am happy if Mark squashes it when he applies or I can
send out a new version soon.

-Doug
