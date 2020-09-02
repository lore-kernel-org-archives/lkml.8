Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5046C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E79620767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="apW9O2U7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgIBPc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgIBPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:32:41 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98477C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:32:41 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id c25so20002vkm.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaZwArJVDsGm3BuqCJoaQAv1/h87JxXOYIV/nwkJsOI=;
        b=apW9O2U7VXpHx2cVUs09CAp1uF3w9aOpWk4Vb8yGApJGh1qjt3XA6PXXFw13jrgzgR
         tI4O/e8yuhAbTWTBy6q9Jl+S7v3R9/w5G9705tGiktUvp3rpntBNYZwBkxXKqpXfoU6x
         lULIGWY9qLRpCNLvcGgymqDpj+A/tHo4j3Ca4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaZwArJVDsGm3BuqCJoaQAv1/h87JxXOYIV/nwkJsOI=;
        b=LwnU6NafraDwahL091SQYoYTghFYnZMKXyZ7WGnyKbddElnQ9EI5tJtYAwO8TSIBoV
         BvzRCOxlj0vUawuZynSZeG06shY44PfKvBzkQY/+PL3+LPMmTzw7qgeDY1ceRkf9XgXv
         2UW1ldHhc0JEzSK7C1D0D0FHcFwETTIUThU2vLRGZIAPmrBTwx0s0x4M7IIxb5tQfPK8
         yOPFh+RsQy2qfY2dojsOeHUK7CYwiGqcazy2EGqXRURu8IkkiacU6XufKF7ha2RdP7kS
         SJFfQuYXYn/dzr3Qb7dDh3D5skm2uWOqhpi52sEaDm7/veUXbNnYid6zbiu04+Jt267w
         0rTw==
X-Gm-Message-State: AOAM532HG4LziM0b6oL0TpQhO5CwurWkrMGcEToFQRnLA7kCTLFNq1DM
        2J3CPZtd1wPVKrxOy1HTrrGGsdrVIraFzw==
X-Google-Smtp-Source: ABdhPJwtV4tnDIHO3VjKT5zn6XCAE4kUgidJR96x8eXzrqVfFPPwuD8xfR3193kRIboh3Sg655PvLw==
X-Received: by 2002:a1f:1f0d:: with SMTP id f13mr3226644vkf.1.1599060760613;
        Wed, 02 Sep 2020 08:32:40 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id k12sm8700vke.4.2020.09.02.08.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 08:32:40 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id s29so1708852uae.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:32:38 -0700 (PDT)
X-Received: by 2002:ab0:623:: with SMTP id f32mr5391415uaf.121.1599060757775;
 Wed, 02 Sep 2020 08:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200813113030.1.I89c33c4119eaffb986b1e8c1bc6f0e30267089cd@changeid>
 <20200901170745.GA3419728@google.com> <CAD=FV=Xv0FLtWWcQcRy7p2LPNdDtSjdarsvNHRHaLkWwABnwJw@mail.gmail.com>
 <8ad0589e-102d-7523-899f-0ebe85b7d2b8@codeaurora.org>
In-Reply-To: <8ad0589e-102d-7523-899f-0ebe85b7d2b8@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Sep 2020 08:32:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XKUEQP3gyE8E2UOE12qKYwzgMp0eNeYjCp0DxPDACSMQ@mail.gmail.com>
Message-ID: <CAD=FV=XKUEQP3gyE8E2UOE12qKYwzgMp0eNeYjCp0DxPDACSMQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add 'sustainable_power' for CPU
 thermal zones
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 1, 2020 at 10:36 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> > * In terms of the numbers here, I believe that you're claiming that we
> > can dissipate 768 mW * 6 + 1202 mW * 2 = ~7 Watts of power.  My memory
> > of how much power we could dissipate in previous laptops I worked on
> > is a little fuzzy, but that doesn't seem insane for a passively-cooled
> > laptop.  However, I think someone could conceivably put this chip in a
> > smaller form factor.  In such a case, it seems like we'd want these
> > things to sum up to ~2000 (if it would ever make sense for someone to
> > put this chip in a phone) or ~4000 (if it would ever make sense for
> > someone to put this chip in a small tablet).  It seems possible that,
> > to achieve this, we might have to tweak the
> > "dynamic-power-coefficient".
>
> DPC values are calculated (at a SoC) by actually measuring max power at various
> frequency/voltage combinations by running things like dhrystone.
> How would the max power a SoC can generate depend on form factors?
> How much it can dissipate sure is, but then I am not super familiar how
> thermal frameworks end up using DPC for calculating power dissipated,
> I am guessing they don't.
>
> > I don't know how much thought was put
> > into those numbers, but the fact that the little cores have a super
> > round 100 for their dynamic-power-coefficient makes me feel like they
> > might have been more schwags than anything.  Rajendra maybe knows?
>
> FWIK, the values are always scaled and normalized to 100 for silver and
> then used to derive the relative DPC number for gold. If you see the DPC
> for silver cores even on sdm845 is a 100.
> Again these are not estimations but based on actual power measurements.

The scaling to 100 doesn't seem to match how the thermal framework is
using them.  Take a look at of_cpufreq_cooling_register().  It takes
the "dynamic-power-coefficient" and passes it as "capacitance" into
__cpufreq_cooling_register().  That's eventually used to compute
power, which is documented in the code to be in mW.

power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
do_div(power, 1000000000);

/* power is stored in mW */
freq_table[i].power = power;

That's used together with "sustainable-power", which is the attribute
that Matthias is trying to set.  That value is documented to be in mW
as well.

...so if the silver cores are always scaled to 100 regardless of how
much power they actually draw then it'll be impossible to actually
think about "sustainable-power" as a mW value.  Presumably we either
need to accept that fact (and ideally document it) or we need to
change the values for silver / gold cores (we could still keep the
relative values the same and just scale them).

-Doug
