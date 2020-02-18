Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C84C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D04208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SH/AM7by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBRSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:08:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35056 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBRSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:08:57 -0500
Received: by mail-ua1-f67.google.com with SMTP id y23so7816053ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/hUNGk4SRM6kiHXV6o5gYzyAFxdFqq5txQCPei9mDM=;
        b=SH/AM7byq+GGZQOujD7y/pc9Z/jCNs8xRbvT3Xe26n4ObiDBca0/M1TL3iIp78G/R+
         KTx5VvRBK5p3StKKpsfLEm7H9wE343y6/5WBtpFIGos4DhvLfuVWpvX4GedZjL1+HaEc
         iJvH2r5Ftd+73Z/Pgaxa5yIH+MbzUINwlk1QetcQ2LojEZk8ZRig72UJrtiPm3RwCyO3
         sG7Bw8J0HX5+wDbWGKnHBCLC7AyVJAFKy5RAyYxDGpHixEcvDasdB20bLWeK3RlfFvXG
         19TGixZqnpV+mbILDmiWJHexNORo89AoO5/5humbXk7aszT1lJuRUya08rorJChwDm7k
         qKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/hUNGk4SRM6kiHXV6o5gYzyAFxdFqq5txQCPei9mDM=;
        b=oG+fh46i+kpUYy0JrKFLEocW40b5P4Ct0ZFDwKLr+v/NBRQ6MEMUhv8aVc6ljXo3T+
         P+FTllFE1h8QnKsrAXy4YA6pp5Fs4pBJibKKtt5yPElVuuZ0cCQKr1yoQ5R/EQ7nubWq
         sF4K/uuAKy+5t7kdF37zm/vxsbPlh1T8lwH/NXurT/vG9XuwZxdvIqqAPqKsmVpeg3+5
         k972y1hJsB1CkkQ80fb3NpNFPd7PRVFd9PnnGMZiAbIdKjXlReBx5nuDUpzUJHsgPqcC
         rnlpyrAvPRjeS+Ds5XX8Av0y/xUkJRwIGv5oqhnXVOgvTRY4U6WuH4vbHxd+EF3SdZ1O
         EFLg==
X-Gm-Message-State: APjAAAVzpWhjt9amLVrX1Ddc5M4/eFcSaZ3UfVYTNCsQtRSwaxAZDfo3
        cJyJI5V1IYiX/6bv4nKvxXDmLFaQpFYbWcbEZzaqFg==
X-Google-Smtp-Source: APXvYqyeUDwAdKkMhuDh2cUfhU3voe/Oj/lYB2U1rDCoNqf1S55cF1bQIpKWl5ZDtNg+HnjLQr+xWwKzvmFiPW+Dk2U=
X-Received: by 2002:ab0:7653:: with SMTP id s19mr11019733uaq.94.1582049334828;
 Tue, 18 Feb 2020 10:08:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <932e07a83fed192678b8f718bbae37d0dc83590d.1580390127.git.amit.kucheria@linaro.org>
 <20200203181413.GF3948@builder>
In-Reply-To: <20200203181413.GF3948@builder>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 18 Feb 2020 23:38:43 +0530
Message-ID: <CAHLCerNi2kb-bU_xsmB4aGLtUKPXfUrqDMLJLU=XXTnk-Kk=+A@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] drivers: thermal: tsens: Add critical interrupt support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 11:44 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:
>
> > TSENS IP v2.x adds critical threshold interrupt support for each sensor
> > in addition to the upper/lower threshold interrupt. Add support in the
> > driver.
> >
> > While the critical interrupts themselves aren't currently used by Linux,
> > the HW line is also used by the TSENS watchdog. So this patch acts as
> > infrastructure to enable watchdog functionality for the TSENS IP.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
>
> Please do provide a changelog when respinning your patches.
>
> >  drivers/thermal/qcom/tsens-common.c | 120 ++++++++++++++++++++++++++--
> >  drivers/thermal/qcom/tsens-v2.c     |   8 +-
> >  drivers/thermal/qcom/tsens.c        |  24 +++++-
> >  drivers/thermal/qcom/tsens.h        |  71 ++++++++++++++++
> >  4 files changed, 212 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> [..]
> > +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> > +{
> > +     struct tsens_priv *priv = data;
> > +     struct tsens_irq_data d;
> > +     unsigned long flags;
> > +     int temp, ret, i;
> > +
> > +     for (i = 0; i < priv->num_sensors; i++) {
> > +             const struct tsens_sensor *s = &priv->sensor[i];
> > +             u32 hw_id = s->hw_id;
> > +
> > +             if (IS_ERR(s->tzd))
> > +                     continue;
> > +             if (!tsens_threshold_violated(priv, hw_id, &d))
> > +                     continue;
> > +             ret = get_temp_tsens_valid(s, &temp);
> > +             if (ret) {
> > +                     dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> > +                     continue;
> > +             }
> > +
> > +             spin_lock_irqsave(&priv->crit_lock, flags);
> > +
>
> I see that I failed to follow up on the discussion on the previous
> revision. The handler is called from a single thread, so you don't need
> a lock to protect the irq handler from itself.

Makes sense now. Will fix.

Thanks for the review.

Regards,
Amit
