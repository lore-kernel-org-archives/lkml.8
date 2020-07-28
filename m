Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758BBC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531E82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fw2kRNbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgG1UHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1UHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:07:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f14so6052123ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnz0jOHGhQ7071N749Two4h1HroTIuj/RiP18x35OOI=;
        b=Fw2kRNbpJHyRS+1no8N05uMus3XPhZET++7DGlfe6jJSIZSAzilD13sbJKzlBvIKZU
         VZxNwziJ0lu/iYgED5pnjaYig4DCwmb0+QuLlzBik3D/tlKW9LuxoTkPxVRciQOOKID1
         A3x28H2/8Eksk7/cKrMVrDL+p/piLtAk8Szms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnz0jOHGhQ7071N749Two4h1HroTIuj/RiP18x35OOI=;
        b=pzStBK/YduhiNd5PfFjMCnNlPYtIEkHypAfDp3iWMmF0PljDI/DwFsPajnHHcLmNnY
         Xeb0N5gmlrTYbV4I1bohUE/K4LPw30mOQ7kX/j0uaAI/8yPZ+u96qX7mzYStBPbRKmZM
         rHvFRAMorl1at9+WQvHlJCVHolHQJW246T4m5dAXnmK5FWn2bVfR1o9Q6f1O/8Tzgbvl
         r+7ZyLjQtKAC4I9DIN+Z2n0RengMDCSOka/xcUWIa1PE5cd/jfFh6SfeUKwdnh60Q1A8
         Fv04un8cz0w70VITHZqdvIcMPRUQPuZh5A9V5pfbdLwmQAJpws7SzfEmbpjV4/EV0uMk
         STRA==
X-Gm-Message-State: AOAM530ZNaMEZsOxisv7yq5HHNt0HtXl9IoA0++BXx5yEao4rVIRm2Cl
        GfvQOE9l2HTuEQB/HGSI2dmD9L0ps14=
X-Google-Smtp-Source: ABdhPJwXbB9bNarPMpyzrSDGvws/F23P4xuPAnG+aj0VDp8/i7O/Q+s6elMsnmCfzg4hzPr1FRiSuA==
X-Received: by 2002:a17:906:430a:: with SMTP id j10mr26385830ejm.163.1595966859040;
        Tue, 28 Jul 2020 13:07:39 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id g25sm3985826edp.22.2020.07.28.13.07.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:07:37 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id f18so708908wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:07:37 -0700 (PDT)
X-Received: by 2002:a7b:c953:: with SMTP id i19mr5308631wml.103.1595966856934;
 Tue, 28 Jul 2020 13:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.3.I2a1314232ace4323af96f9981c1e1a4f31f78049@changeid>
 <CAHp75VfOhoJrHEnC_Wh2qnOMX0pT1Jx92B0TFQ5=cfZsTSNSOg@mail.gmail.com>
In-Reply-To: <CAHp75VfOhoJrHEnC_Wh2qnOMX0pT1Jx92B0TFQ5=cfZsTSNSOg@mail.gmail.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:07:00 -0600
X-Gmail-Original-Message-ID: <CAHcu+VaDBj87stJ9JJkuerJkr8=-g68FhUUnKvfpN8uYaMBUhQ@mail.gmail.com>
Message-ID: <CAHcu+VaDBj87stJ9JJkuerJkr8=-g68FhUUnKvfpN8uYaMBUhQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: sx9310: Fix irq handling
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Fixes enable/disable irq handling at various points. The driver needs to
> > only enable/disable irqs if there is an actual irq handler installed.
>
> > -       enable_irq(data->client->irq);
> > +       if (!ret)
> > +               enable_irq(data->client->irq);
> >
> >         return ret;
> >  }
>
> Can it be a usual pattern?
>
>   if (ret)
>     return ret;
>   ...
>   return 0;

I think this way is more readable. The alternative would have to be
something like this:

....
if (ret)
  goto out;
mutex_unlock(&data->mutex);
enable_irq(data->client->irq);
return 0;

out:
mutex_unlock(&data->mutex);
return ret;

>
> --
> With Best Regards,
> Andy Shevchenko

Regards,
Daniel Campello
