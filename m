Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5076120756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HSC9jimH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHKUNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:13:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5998AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:13:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so112701otc.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMKY1Jw9WxsNwHBaKFMxM1LYgIpjkj5V6Wxr1s+O2Ac=;
        b=HSC9jimHDqj2Rr/YX/+SxiUOCVVW88ynLYyl/lDM7MG18I3Awgye833RnYVBR2kVdS
         gVA9vwie+VlyFLkCq5Nj6iBdlaxk8IblV2OB+2iwJswifSkVCRLUex4q+tLLxNj500tH
         OkAPdLCgDWW08vBQY+uE/41F+6UcAg020bK0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMKY1Jw9WxsNwHBaKFMxM1LYgIpjkj5V6Wxr1s+O2Ac=;
        b=jHyqL7zINBZ0ldVQN2/7uz7C4QScdkXLXFMRW9ip9Y4VYwW4uqgA2Pmhfii1lX0m4u
         4hRwQG+OQ0TgUiqwwEu5VNSSsqn1rd/qhbBouQ1E7WtpbWoPcO3qc/brEGsUQ+3+pPo9
         aHpL7fQzWtu28BE5e4V0GlG03ZKE3p9pn7jR/lj9pZWbnQFccD4iDhO/Typotc5xjrRR
         FgdY0U/4UnKPT0iZpieQ2kC7o4xZcBrUCv2UxJ2Ln7AznqamxQRkAsJTKTnTWufJpRDF
         LrS/rZ8ho2GZvKH8j3ZDyF9p1WMDer/6SObobTm+/xVWS/okyv2HOug9P6ncYtqomGU9
         riHw==
X-Gm-Message-State: AOAM5339AVX1dr3MB9RFBuNHoFB9WViMQXKNdjEWAPt9c4cxKCfsEE9J
        E1kEmIWwTk/B5tS+OC941z/vvXzGv3g=
X-Google-Smtp-Source: ABdhPJyDy9pPSqjcZllnx3g24UTlmL8XV5PDqHAgWTOPG86qBDPW0MWX8QYWvqvil9SkYH5ct/Jybw==
X-Received: by 2002:a05:6830:1e71:: with SMTP id m17mr6883090otr.188.1597176783318;
        Tue, 11 Aug 2020 13:13:03 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 14sm430341otg.45.2020.08.11.13.13.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:13:03 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id z18so121734otk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:13:03 -0700 (PDT)
X-Received: by 2002:ab0:623:: with SMTP id f32mr9988390uaf.121.1597176383647;
 Tue, 11 Aug 2020 13:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
 <1597058460-16211-3-git-send-email-mkshah@codeaurora.org> <159717444178.1360974.6520145243224264090@swboyd.mtv.corp.google.com>
In-Reply-To: <159717444178.1360974.6520145243224264090@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 13:06:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W8kG-ffngoSp-aEViRHas0rOVHDo5WH-OcmkEER0itMw@mail.gmail.com>
Message-ID: <CAD=FV=W8kG-ffngoSp-aEViRHas0rOVHDo5WH-OcmkEER0itMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] pinctrl: qcom: Use return value from irq_set_wake call
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        LinusW <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 12:34 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Maulik Shah (2020-08-10 04:20:55)
> > msmgpio irqchip is not using return value of irq_set_wake call.
> > Start using it.
>
> Does this work when the irq parent isn't setup in a hierarchy? I seem to
> recall that this was written this way because sometimes
> irq_set_irq_wake() would fail for the summary irq so it was a best
> effort setting of wake on the summary line.
>
> >
> > Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 90edf61..c264561 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -1077,12 +1077,10 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
> >          * when TLMM is powered on. To allow that, enable the GPIO
> >          * summary line to be wakeup capable at GIC.
> >          */
> > -       if (d->parent_data)
> > -               irq_chip_set_wake_parent(d, on);
> > -
> > -       irq_set_irq_wake(pctrl->irq, on);
> > +       if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
> > +               return irq_chip_set_wake_parent(d, on);
>
> So this bit is probably fine.
>
> >
> > -       return 0;
> > +       return irq_set_irq_wake(pctrl->irq, on);
>
> But this one is probably not fine.

Interesting.  I wasn't aware of the history and thus assumed this was
a bug.  If Stephen is remembering correctly, please add a comment
saying that we are purposely ignoring the return value in this case.

-Doug
