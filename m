Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73144C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482F4208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="0BNBnlt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgCKHaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:30:20 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41530 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:30:19 -0400
Received: by mail-ua1-f68.google.com with SMTP id l7so354783uap.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPmOcXQ3X99zHwJqpB3nsuNuIevnyBfADR/rHEtNRP8=;
        b=0BNBnlt0yW57VD8zwOmvzW2sMziTU7mHMcMb/HOT0kuqJeFVpOc5fUJ6z9I4fFzjcB
         HtH1k4B+xEpqyI2Q0sX9RTaK11jmWJh18wZtJamFmwhIs2JBzlf25q9B1Zq3iAO7UQaN
         2oqkIsPspe2v/YbOo80/tyqJQDagTe6a+FkRZn0R73XKkTnZaF7793JlZ85CTjMpTdPf
         1jV2RqUXIZphPLvicgDxaYlIw6wTBz7k5E533El1oCe7Owad7QXcRN+jP0Qmva8sgdXG
         YDctySDeLCpZimi6n1fsxU+B19JswHyXUTI9Q6rO2WkfHChuS0TCwoAWt2Jmsax5ukXl
         HvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPmOcXQ3X99zHwJqpB3nsuNuIevnyBfADR/rHEtNRP8=;
        b=g6HpjVwKv1qZ+8Y+obmWxELNrEBaoV5l25jEBZraJiclNiE16JgKNGYOJ2ONotlets
         +MEDUrocwq8A8w06CFNM8CToyvJfMtN3M0TVM5mT3ugS8XyK1D7uXCiVXYqe47uqXbvQ
         zSvSYiZ0pJTsYIawium1dTTGVY6VjJGFSpPAnDHPf+iC1z1fyjpKgItSQH1K3YPAJgTL
         QbhtdkwMhmWvMMv6ycJXM3LRZOMT7lGCU0YaOMp7EL6D2qjvr8sKhjaDwveUb8PgqBdI
         mLb0REHYaF0oR0HEmv73FEdpV6NZeOSUrfdJ/ZLHZ/C82y0zvOXIAfO+5NgBFZHrIf6G
         49vQ==
X-Gm-Message-State: ANhLgQ3XGC0CCls2/fQUE2olvrvMMGhxkeNbdVq6Hyaldt6J5JbIG5bW
        agGTKfL4dBubUKmHhWY8KFPJv8sB8Hd4U7mO2zvYPg==
X-Google-Smtp-Source: ADFU+vs0Dvq9z7hlChVBga5EnnnCXMWgmos410ryGreZya3+Vz6NMZ91SWJ54I7K3Dhw1Fs8MAk1q3q7PPUo08uzlI4=
X-Received: by 2002:ab0:7518:: with SMTP id m24mr806098uap.60.1583911817488;
 Wed, 11 Mar 2020 00:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200310154358.39367-1-swboyd@chromium.org> <20200310154358.39367-2-swboyd@chromium.org>
In-Reply-To: <20200310154358.39367-2-swboyd@chromium.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 11 Mar 2020 13:00:00 +0530
Message-ID: <CAHLCerOx8-iUn0QHO4mDs2M9ncmpEvY7TyM9Tg-_wz9C0Thxug@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] i2c: qcom-geni: Let firmware specify irq trigger flags
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 9:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware. Also, remove specify dev_name() for the irq
> name so that we can get better information in /proc/interrupts about
> which device is generating interrupts.
>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Cc: Alok Chauhan <alokc@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 17abf60c94ae..4efca130035a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -549,8 +549,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>         init_completion(&gi2c->done);
>         spin_lock_init(&gi2c->lock);
>         platform_set_drvdata(pdev, gi2c);
> -       ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq,
> -                              IRQF_TRIGGER_HIGH, "i2c_geni", gi2c);
> +       ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq, 0,
> +                              dev_name(&pdev->dev), gi2c);
>         if (ret) {
>                 dev_err(&pdev->dev, "Request_irq failed:%d: err:%d\n",
>                         gi2c->irq, ret);
> --
> Sent by a computer, using git, on the internet
>
