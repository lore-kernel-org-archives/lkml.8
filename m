Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8260204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aB8ub7BN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgFRPGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgFRPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:06:08 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233FFC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:06:08 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n22so1509826vkm.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uhyo0sKph8oAx2mIyvhHF5US4adK0E3GfKdnIj29E9Y=;
        b=aB8ub7BN1xbigSK9olQdwudzkwJ1S2Yyrfdib2JJjs9mSUrmcIBMO2frrAcBiZHX7l
         4L9kXEoi3EWaFw233GFFuBhCKCauoatr3Dh0Zel+L6LuxU0GkTw8Fz5FrXpPncLbU1ap
         Wjgam1IaQoIbFXWShumV1iaHOZseVhcJ8qLaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uhyo0sKph8oAx2mIyvhHF5US4adK0E3GfKdnIj29E9Y=;
        b=UjIWj9r7KO2rMJkVHDXS5PSvJ4P34SjLGHmaPVUNOUPwDDZ0d/xysmGnwmQ84IrHlG
         VOoVF7Dz3pvrAkXzDwyl2h151T21qbwid5NyapaCdodTyI91wTeBzGzdENGxoIqQEpw9
         nCCw6DtpI4ruhWu2q7fuOm8NNVD3VfpYRQI4azjeRV1n+QMSmzjcTqAhNFklA5LNCm1z
         rjD5jl+Dtxko81rDIWGtqeWwPLoho2ygdxruEMIYCmNDmfCgH7rm4HT8Ef3oJ/0CBNIm
         aLMHzcvZ6iLb0CShmCdsCJ1SYZZ+y4K8USNHbc8ej8E/lyfY+Wcu8hCZtLzRz+b5mqo8
         y1Xg==
X-Gm-Message-State: AOAM530zTqU0v+U0sQoYoGng6UGBV3+9nQnOwbuSqz1NCvcnkJNNVl0z
        e4l+50fWMRk0VLZN4fDMkwdChKvpjoU=
X-Google-Smtp-Source: ABdhPJwQotPmEPLNgCD12BohWZyNgp7TQAeoq2Mwj5j7N82gkg1cKH8Za43OMXFuU9sDT7F9rRpAeQ==
X-Received: by 2002:a1f:ea82:: with SMTP id i124mr3600394vkh.62.1592492766914;
        Thu, 18 Jun 2020 08:06:06 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id r139sm356296vkr.20.2020.06.18.08.06.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:06:06 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id e1so1513631vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:06:06 -0700 (PDT)
X-Received: by 2002:ac5:ce86:: with SMTP id 6mr3726475vke.75.1592492765249;
 Thu, 18 Jun 2020 08:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
 <159242860191.62212.18088243128415903480@swboyd.mtv.corp.google.com>
In-Reply-To: <159242860191.62212.18088243128415903480@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 08:05:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfYnkw2EFFHZNMRffmO3XJE9Qm8YtMzjK8OWLgL39XKQ@mail.gmail.com>
Message-ID: <CAD=FV=XfYnkw2EFFHZNMRffmO3XJE9Qm8YtMzjK8OWLgL39XKQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] spi: spi-geni-qcom: Don't keep a local state variable
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

On Wed, Jun 17, 2020 at 2:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-06-16 03:40:50)
> > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > index 63a62548b078..6feea88d63ac 100644
> > --- a/drivers/spi/spi-geni-qcom.c
> > +++ b/drivers/spi/spi-geni-qcom.c
> > @@ -63,13 +63,6 @@
> >  #define TIMESTAMP_AFTER                BIT(3)
> >  #define POST_CMD_DELAY         BIT(4)
> >
> > -enum spi_m_cmd_opcode {
> > -       CMD_NONE,
> > -       CMD_XFER,
> > -       CMD_CS,
> > -       CMD_CANCEL,
> > -};
> > -
> >  struct spi_geni_master {
> >         struct geni_se se;
> >         struct device *dev;
> > @@ -81,10 +74,11 @@ struct spi_geni_master {
> >         unsigned int tx_rem_bytes;
> >         unsigned int rx_rem_bytes;
> >         const struct spi_transfer *cur_xfer;
> > -       struct completion xfer_done;
> > +       struct completion cs_done;
> > +       struct completion cancel_done;
> > +       struct completion abort_done;
>
> I wonder if it would be better to use the wait_bit() APIs. That would
> let us have one word for various bits like CS_DONE, CANCEL_DONE,
> ABORT_DONE and then wake up the waiters when the particular bit happens
> to come in through the isr. It is probably over-engineering though
> because it saves a handful of bytes while increasing complexity.
>
> Otherwise I like this patch.

I'm going to leave it as-is for v4.  We can always make it a future
improvement if we want.

-Doug
