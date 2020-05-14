Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0332C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2CC206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDvaNrZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgENL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:27:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF5C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:27:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c3so2005586otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxAs+mvRFMkQC0sck5MS5WhqTOyvJuovj78EsreUtvE=;
        b=FDvaNrZJJwmbPiapmx88pMKzanvUHC7BTHIvMPe6B5SRaYMqaQWdQVHWUzKT+CHWUO
         IPI6jehEtsu0MvskmpriRki1/VVhuWa2lsxgeLpPE7ZS8EWWrQif51SMiqmU1yHqtGJM
         6bRy5vuz/HsIlMA7dBfSMddHzP681WpZ3lOPsOAzBtSVfjWxRh+ijCUQwrlwc4KkTRYX
         jD2GmDreLZ9kOPcjPIeoO58EFtYAxQQcULnBjInpLJv/yor8X2t278Rdl8YDRBz5nLdX
         S2xUG1+EBMvAZsS/mbUm6DSjxNvARM92lDxzTsBdL2WqA5oI2dzXTWMEpCHuE6qJYR1r
         9BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxAs+mvRFMkQC0sck5MS5WhqTOyvJuovj78EsreUtvE=;
        b=UnlZWITwcvNmKamnlyimsrkFt1GidsCigVgcyypCBPJTmsgRvbRdi3er6h9t2CaEcn
         uzpGoo88I49qTghxmI66pqR7JvFhUi8Iti2mxZocDgIfJCZ0WkDFiK2wHML3EpjLQDAW
         WkxiEbe2nLvy2m8N2pQ6l1n3Ei032SFEP6tJKpjmA6AbkbXp5sHa992wBiIIQ/+xgruE
         qILPYUAgmwKowaJgv+2WPSs37iPrCSEBTw8kZYNHp/MdI4CZI+9iTmeXKxuQyUGBI1/2
         U8W5GDI9+6EVTCvqIM7zSLpVoT/ic62qdXiUrhrcbvnJ9YWkqBC7xYiUaw5KWfRcKuez
         kaEw==
X-Gm-Message-State: AOAM531vfeU/7R3mCffpD1QKpQS7ZKIsDn0R43EZjFi1C7zp8JRHgQQo
        xYaq0upNdnFrOOntwnRIFdbY9kKxOshdGSQIHujGv6gq0ci1MQ==
X-Google-Smtp-Source: ABdhPJwpNNt1Jw4j4qQX1GS4dly/n8TtoBFGmz3on2XvNgxroZ43lfjyKd0ko9cuFU1Ms4pbt3IhJepoCBIn1LeudGU=
X-Received: by 2002:a9d:e93:: with SMTP id 19mr3159324otj.371.1589455675094;
 Thu, 14 May 2020 04:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
 <20200508204200.13481-4-sumit.semwal@linaro.org> <20200511103937.GC8216@sirena.org.uk>
In-Reply-To: <20200511103937.GC8216@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 14 May 2020 16:57:43 +0530
Message-ID: <CAO_48GFGpHeu_xb9XT9CFMOSUOJgRrb-z_KZ3-r3X78s-2ddjw@mail.gmail.com>
Subject: Re: [v2 3/4] regulator: qcom: Add labibb driver
To:     Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        Nisha Kumari <nishakumari@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thank you for your review comments!
On Mon, 11 May 2020 at 16:09, Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, May 09, 2020 at 02:11:59AM +0530, Sumit Semwal wrote:
>
> > +     ret = regmap_bulk_read(reg->regmap, reg->base +
> > +                            REG_LABIBB_STATUS1, &val, 1);
> > +     if (ret < 0) {
> > +             dev_err(reg->dev, "Read register failed ret = %d\n", ret);
> > +             return ret;
> > +     }
>
> Why a bulk read of a single register?
Right, will change.
>
> > +static int _check_enabled_with_retries(struct regulator_dev *rdev,
> > +                     int retries, int enabled)
> > +{
>
> This is not retrying, this is polling to see if the regulator actually
> enabled.
Yes, will update accordingly.

>
> > +static int qcom_labibb_regulator_enable(struct regulator_dev *rdev)
> > +{
>
> > +     ret = _check_enabled_with_retries(rdev, retries, 1);
> > +     if (ret < 0) {
> > +             dev_err(reg->dev, "retries exhausted: enable %s regulator\n",
> > +                     reg->desc.name);
> > +             return ret;
> > +     }
>
> If this is useful factor it out into a helper or the core, other devices
> also have status bits saying if the regulator is enabled.  It looks like
> this may be mainly trying to open code something like enable_time, with
> possibly some issues where the time taken to enable varies a lot.
>
Makes sense; I am not terribly familiar with the regulator core and
helpers, so let me look and refactor accordingly.

> > +     if (ret)
> > +             return 0;
> > +
> > +
> > +     dev_err(reg->dev, "Can't enable %s\n", reg->desc.name);
> > +     return -EINVAL;
>
> Return the actual error code (the logic here is quite convoluted).
Will try to simplify.
>
> > +     ret = regulator_disable_regmap(rdev);
> > +
> > +     if (ret < 0) {
>
> You have lots of blank lines between operations and checking their
> return codes?
>
will correct that.
> > +     ret = _check_enabled_with_retries(rdev, retries, 0);
> > +     if (ret < 0) {
> > +             dev_err(reg->dev, "retries exhausted: disable %s regulator\n",
> > +                     reg->desc.name);
> > +             return ret;
> > +     }
>
> Similarly to the enable path, but is this one about off_on_delay rather
> than enable_time?
Got it. Let me look deeper.
>
> > +     if (reg_data->type == QCOM_LAB_TYPE) {
> > +             reg = &labibb->lab;
> > +             reg->desc.enable_mask = LAB_ENABLE_CTL_MASK;
> > +     } else {
> > +             reg = &labibb->ibb;
> > +             reg->desc.enable_mask = IBB_ENABLE_CTL_MASK;
> > +     }
>
> Write a switch statement so this is extensible.
I can change over to switch, though in the current set of downstream
code I've seen, it doesn't look that it would get extended. But I
guess there isn't any harm in moving over to switch. Will do.

Best,
Sumit.
