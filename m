Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75F4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B419620DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYAUeoba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFQMG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:06:57 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B71AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:06:56 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id k7so336275ooo.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oK1miWNWYOKPjuspWCCpSQeFxt/H9WWh4wjWuUE9BvY=;
        b=zYAUeobaou6XLm+qcgcX4FwIIvQpXwj8kympi0GOHqzllYblgQdAJTbWQ+SSpNrkNi
         Xvvq+vhSq7PnW44GFx0iH0+sWZmJVhaORYR8tCJjLuCrEE69i0VeY8Nwf4Gtd+7jAZ43
         wazBVn+5m9HsDfxtBQPErV3v1v71e7gS8WGPKcPLkwzyo5QwMyZPWT1v/aHnvCsWKxaY
         P+sWRMDCSJBZ6Kqt073gt+eU1KBW4qYkaFsUylmV81qBLsNIcePl9hpOSWi2MqmrRd7i
         K6lMefpLFhqgOKi3wMp/i2DAVs8nZbFT48Le4dqqYHprvOqxAFvbMN48IkZIq9adh8OT
         uALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oK1miWNWYOKPjuspWCCpSQeFxt/H9WWh4wjWuUE9BvY=;
        b=kLaL2pknR46ZGETTTrqUP+9UgLh+BmG+NrrgfEvfAaKB5vsefr+tyvrcKKwLQmfiL8
         mtcSD2BQUQ1hrJlBa8gnhtwsd3ISBlB8I8Afshho6zOWltrspqfJwnd2D2Ziqt/Qjl8+
         A6y+laCeBIhF9tjDBmeQxfbmKVCkp0PwKH8mXX6+oN/Bi8sZb0S6xj6ULiq4uH0tIZWW
         ngr7yCrsRdjfvfDX+wJ5OA03adbF0cS5Z/8lablTlYlmxLhO5t8LXIrxr8TLyWtOZVCs
         fJAhYErR8eZ1eMcS1hSNRZWDV/WEM4ydI5VrKVwPYVmoi2Y9mrShLFcd3hsDLxCZMUPL
         h2AA==
X-Gm-Message-State: AOAM531j7Tp62f6xcuUxOrfJGyfHkjujkw+MO2TKU3Qo2C6VRl3aA7IJ
        iVSnuGZiMDzRFA+wE3k4dWpVlP6vNfl//yRsrxt6fQ==
X-Google-Smtp-Source: ABdhPJzT2qK4SOqmuUO247dYpxBYGjX9ICe5z/gR9ccoHplJOlL+3174gwJwUJxiEzawX/v40xjg86InPPkv9sR6j0Y=
X-Received: by 2002:a4a:abcb:: with SMTP id o11mr6538059oon.58.1592395615229;
 Wed, 17 Jun 2020 05:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-6-sumit.semwal@linaro.org> <20200602122205.GF5684@sirena.org.uk>
In-Reply-To: <20200602122205.GF5684@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 17 Jun 2020 17:36:43 +0530
Message-ID: <CAO_48GGY2TRVPXFVCvo9fEoknw65sz9BrL-mp+SZ=_EAo88t-A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] regulator: qcom: labibb: Add SC interrupt handling
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

Hi Mark,

On Tue, 2 Jun 2020 at 17:52, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 02, 2020 at 03:39:24PM +0530, Sumit Semwal wrote:
>
> >  static int qcom_labibb_regulator_enable(struct regulator_dev *rdev)
> >  {
> > -     return regulator_enable_regmap(rdev);
> > +     int ret;
> > +     struct labibb_regulator *reg = rdev_get_drvdata(rdev);
> > +
> > +     ret = regulator_enable_regmap(rdev);
> > +     if (ret >= 0)
> > +             reg->enabled = true;
>
> Can we not read the register we just wrote to here?
As I mentioned in the other patch, it seems there is a (noticeable)
delay in getting the value to reflect in this register for IBB.

Also, from the notes from the downstream driver (also copied below),
it seems like during short circuit there is another protection system
that can cause the registers to be cleared, hence the need to track
the current state in software.

>
> > +     /*
> > +      * The SC(short circuit) fault would trigger PBS(Portable Batch
> > +      * System) to disable regulators for protection. This would
> > +      * cause the SC_DETECT status being cleared so that it's not
> > +      * able to get the SC fault status.
> > +      * Check if the regulator is enabled in the driver but
> > +      * disabled in hardware, this means a SC fault had happened
> > +      * and SCP handling is completed by PBS.
> > +      */
> > +     if (!in_sc_err) {
> > +
> > +             reg = labibb_reg->base + REG_LABIBB_ENABLE_CTL;
> > +
> > +             ret = regmap_read_poll_timeout(labibb_reg->regmap,
> > +                                     reg, val,
> > +                                     !(val & LABIBB_CONTROL_ENABLE),
> > +                                     POLLING_SCP_DONE_INTERVAL_US,
> > +                                     POLLING_SCP_TIMEOUT);
>
> Why do we need a timeout here?
IMHO, This seems to be the time required by the PBS to actually
disable the regulator? If the PBS is not able to disable the
regulator, then it points to a more serious problem?
I'm sorry, that's just my understanding based on the downstream driver
:/ - not much input is available from the QC teams about it.

>
> > +                                             NULL);
> > +             regulator_unlock(labibb_reg->rdev);
> > +     }
> > +     return IRQ_HANDLED;
>
> This returns IRQ_HANDLED even if we didn't detect an interrupt source...
> Especially given the need to check to see if the regulator was turned
> off by the hardware it seems like there must be some false positives.
Right - I'm not sure what else can I do here.
>
> > +     } else {
> > +             ret = devm_request_threaded_irq(reg->dev,
> > +                                             sc_irq,
> > +                                             NULL, labibb_sc_err_handler,
> > +                                             IRQF_ONESHOT,
> > +                                             "sc-err", reg);
>
> This looks like we're requesting the interrupt before we register the
> regulator which means the interrupt might fire without the regulator
> being there.  The order of registration should be reversed.

Agreed, and will update in the next version.

Best,
Sumit.
