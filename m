Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B6C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BFE206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAP5UuS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgA3MMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:12:37 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42144 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgA3MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:12:37 -0500
Received: by mail-vs1-f68.google.com with SMTP id b79so1886142vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 04:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oMFpwjVb7wHknI2AwAM6qt6edMX0VsMEB2cb5KoudE=;
        b=uAP5UuS4nIhlNl+uJgWtgeb+MNtWmxGmJMOxQsRCl4Q9yMSxy60q9sCVp/DRW8tQMa
         Y+2hLuAKNhZQnwTfrPNBSXYztdD/VLz9pvr8tN2OJsf2ru4JJ6m2Amolz5Kdovm7Uby5
         XlL7EAljqelhyzvHARieiDGh+zy7mQe95Fe1EjaUd02aoY3UztDQQt9IzZjMB71prQzc
         uKrpjECcLv/idYjwYFmKes1cNBP1EcpZxzrtRyV850R8AVN92NKMDWO/0YV8ipY3vfaX
         IWXSfPpq4y6bB8KjyYMuJMAwLnOnT+Rr/Sg2Wx4xc78rtJsGVABh0pe6WdnShctT2M8L
         FP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oMFpwjVb7wHknI2AwAM6qt6edMX0VsMEB2cb5KoudE=;
        b=XgBLCM5Q4yujk2txZbGT2u53Cr9Q5jrLgYG1mT9Qi+rHUm6N2tBKfkrDtU82qje5m5
         1GYExkLAf2wUowvA/WqCKF5JOjvHBJKAmifWGt4TGGejO29C01miEicpvpyH8y7qxeMm
         EYNg7JqF3ALAsAfF7z5wIySABEo2gufXi9bVAYKOXwMF4jzVfjhwKHBvGn37Bf1H/0kr
         5ez/Wy5/H1APT3jEwhqpKcY/7lRGmEqCxuJUxhce606vqvlYvY0bj6MDUQY/Dfs72hJ2
         OE58M9F5DYCZ7LZZ3Epbvx+uh48Bd4t2bVgV0zkpMRcNsz4dnMdddmAdrnWyOhOFiwMs
         mj/g==
X-Gm-Message-State: APjAAAXznOi43IxVBkY6DbPVZSEFnW10OdPXaJKYk/PVlLtAyYcAsnUq
        Twm0zguVQ6Xyq+lnsi+Q9vDz9k0p4e6nS12ZstyQDQ==
X-Google-Smtp-Source: APXvYqzIJN47kZl0erjghOvF7Xbi6btHuqe0G5exgzJNifWuD2wfvuXxX58uiGX8x9Y0uShbRP2pDgMMbmlbadc2sXo=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr2631714vsa.95.1580386356212;
 Thu, 30 Jan 2020 04:12:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <a63edff9a3c02a542d36fdd28fe774a5c3bf3b8d.1577976221.git.amit.kucheria@linaro.org>
 <20200102195537.GE988120@minitux>
In-Reply-To: <20200102195537.GE988120@minitux>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 30 Jan 2020 17:42:25 +0530
Message-ID: <CAHLCerMk=cHjOTkZo34oeoT-BA_YBz=uZS4MK3b9Z8KKzpnnkQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drivers: thermal: tsens: Add watchdog support
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

On Fri, Jan 3, 2020 at 1:25 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:
> [..]
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 4cf550766cf6..ecbc722eb348 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -377,6 +377,24 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> >       struct tsens_irq_data d;
> >       unsigned long flags;
> >       int temp, ret, i;
> > +     u32 wdog_status, wdog_count;
> > +
> > +     if (priv->feat->has_watchdog) {
> > +             /* Watchdog is present only on v2.3+ */
>
> Please omit this comment, you're carrying the motivation for this
> decision when you set has_watchdog already.

Will fix.

>
> > +             ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* Clear WDOG interrupt */
> > +             regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> > +             regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
>
> Are you sure you need to zero the clear register?

Yes, the corresponding downstream code is as follows:
                       /*
                         * Clear watchdog interrupt and
                         * increment global wd count
                         */
                        writel_relaxed(wd_mask | TSENS_TM_CRITICAL_WD_BARK,
                                (TSENS_TM_CRITICAL_INT_CLEAR
                                (tm->tsens_tm_addr)));
                        writel_relaxed(wd_mask & ~(TSENS_TM_CRITICAL_WD_BARK),
                                (TSENS_TM_CRITICAL_INT_CLEAR
                                (tm->tsens_tm_addr)));


> > +
> > +             ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
> > +             if (ret)
> > +                     return ret;
> > +             if (wdog_count)
> > +                     dev_dbg(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
> > +     }
> >
> [..]
> > @@ -793,6 +815,22 @@ int __init init_common(struct tsens_priv *priv)
> >               }
> >       }
> >
> > +     if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> > +             /* Watchdog is present only on v2.3+ */
> > +             priv->feat->has_watchdog = 1;
> > +             for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
> > +                     priv->rf[i] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                           priv->fields[i]);
> > +                     if (IS_ERR(priv->rf[i])) {
> > +                             ret = PTR_ERR(priv->rf[i]);
> > +                             goto err_put_device;
> > +                     }
> > +             }
> > +             /* Enable WDOG and disable cycle completion monitoring */
>
> Commit message says you're not enabling it. Should this say "WDOG is
> already configured, unmask the bark" or something along those lines?

Will reword

>
> > +             regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> > +             regmap_field_write(priv->rf[CC_MON_MASK], 1);
> > +     }
> > +
> >       spin_lock_init(&priv->ul_lock);
> >       tsens_enable_irq(priv);
> >       tsens_debug_init(op);
>
> Regards,
> Bjorn

Thanks for the review.
