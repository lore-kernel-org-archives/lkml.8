Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E7E2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1GgAEfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFJEcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgFJEcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:32:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FCC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 21:32:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m32so394326ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNZY3kvPUajnugJBZAgYscKFfGeLDHC37yBStZ/Zzc0=;
        b=F1GgAEfksMlFWf+LbjWv2+RWQ2Me1uHwZ/PexVY3WpC9e4coq6wekkYYP/tKnOKxyl
         GceH0uSy6sm+w/1UrCLci37W1+yyg5n9/tunLQPkIMtQw5mNpmw6Kc+NsDmS9KNG31vZ
         PV5kT5rPvRWY3y+PaOLzFQaeOdBuVs8HZLSyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNZY3kvPUajnugJBZAgYscKFfGeLDHC37yBStZ/Zzc0=;
        b=SRoqsmBnM4YdzscffwKoExaXFZyGrDTmx/8Y+8h59xXMaX7qUKCWQDW6KWcxHQ5ajh
         yf/oc8EbjayiXY/TWOkROYsNlfNJ65kTzBCQhOCzYGXMa/lnIMGcBE10yk4gcPo0aOyO
         tYxtflwVy0VwMDTYSexess4qPzg2KVQhdMbhABtBC2LO3Eau42mn4AmQbniQq/cICSeo
         KU3Yy/IXIlW9KIK7G+8U7RWn6f8cTRVgltHuHBQRmCqGyZ9/Wyz4teNdVDF+3MEydrPF
         16xfLm2n/YsLYdKy+J5DLrCVdmRheBbtxgqk/ZQFb+CPS9Kt0VDupoMWg1Ac2mGM4tS6
         UUxw==
X-Gm-Message-State: AOAM533g0Qk5fhFsdWr7qv0CmgUyCH2wptIYaTeeYPzUSHAcA+XKG/Hl
        xcXd4LgqJx0lJJWteVZbdzemW1LckFWOwg8+q5OTwg==
X-Google-Smtp-Source: ABdhPJzLUhwaJxqqIwYO4BFy1bhZoClxjAaefMR6FwhdM6Yrj/un5QGigK1T0K5DzZlJG5H0bfidmewINUg0Fu4jxFc=
X-Received: by 2002:a05:6402:17ce:: with SMTP id s14mr880290edy.53.1591763548970;
 Tue, 09 Jun 2020 21:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200609080001.121499-1-pihsun@chromium.org> <20200609080001.121499-3-pihsun@chromium.org>
 <20200609111919.GB4583@sirena.org.uk>
In-Reply-To: <20200609111919.GB4583@sirena.org.uk>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 10 Jun 2020 12:31:53 +0800
Message-ID: <CANdKZ0dDHo-bjX2AT0GiTPoDmY2jNNSGkTcGb-f9j1mPoecNkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: Add driver for cros-ec-regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, some inline reply:

On Tue, Jun 9, 2020 at 7:19 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 09, 2020 at 03:59:55PM +0800, Pi-Hsun Shih wrote:
>
> > +static int cros_ec_regulator_set_state(struct regulator_dev *dev, bool enable)
> > +{
> > +     struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> > +     struct ec_params_regulator_enable cmd = {
> > +             .index = data->index,
> > +             .enable = enable ? 1 : 0,
>
> The ternery operator is totally redundant here.
Ack, would fix in v2.

>
> > +static int cros_ec_regulator_enable(struct regulator_dev *dev)
> > +{
> > +     return cros_ec_regulator_set_state(dev, true);
> > +}
>
> > +static int cros_ec_regulator_disable(struct regulator_dev *dev)
> > +{
> > +     return cros_ec_regulator_set_state(dev, false);
> > +}
>
> I'm not sure that the shared function is really worthwhile though,
> there's not really enough in it and certainly not anything complicated.
Ack, would fix in v2.

>
> > +static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
> > +                                      int max_uV, unsigned int *selector)
> > +{
> > +     struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> > +     int min_mV = DIV_ROUND_UP(min_uV, 1000);
> > +     int max_mV = max_uV / 1000;
> > +     struct ec_params_regulator_set_voltage cmd = {
> > +             .index = data->index,
> > +             .min_mv = min_mV,
> > +             .max_mv = max_mV,
> > +     };
> > +
> > +     if (min_mV > max_mV)
> > +             return -EINVAL;
>
> The core will do this for you.
Since I'm doing DIV_ROUND_UP for the min_mV, so this may happen if the
min_uV~max_uV range given by the core doesn't contain any value that
can be represented exactly in mV.

>
> > +     ret = of_property_read_u32(np, "google,remote-regulator",
> > +                                &drvdata->index);
> > +     if (ret < 0)
> > +             return ret;
>
> This remote-regulator property is a bit weird, it feels like it should
> be a reg property on a bus.
Ok I'll change this to reg property in v2.

>
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id regulator_cros_ec_of_match[] = {
> > +     { .compatible = "regulator-cros-ec", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, regulator_cros_ec_of_match);
> > +#endif
>
> Your compatible is google,regulator-cros-ec.
Ack, would fix in v2.
