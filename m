Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F51C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C63A23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8BB26el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgHFRJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbgHFRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F073FC034625
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:33:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so42093795ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLJbE0lv1TbtATQ3egRbPPepTDXoKcJK7gbuEBUdECE=;
        b=s8BB26eldMXgB8UwQnXSHLvQsau0qyyEWmM/eVp+d7+MO6N2Z3PJZAU4ro5hgO8AxD
         tZfLtfChclrL9Iero4gGt4+eliDgV3iVi9TgTtX6t4CiG7ys9Bg7Xt8PlGGGDHwItByr
         pWo1RcsVmI5+eJisoHJMTYx37kRJghZDFmTAGrHYbtTscarDZkz+woLFxOc38wOniK8w
         CCOq85XUgVuQ4KozuxUIOo2cFEgSph2IN/dg67T1T7QCn8lwC50N+N3oaGbaU0GZzHGp
         5VDfHjrw0NASX1o66LwaEJ41mOjglv2RKJlAe4RNfv3ynfdQtNvLnhd1ZQZy24kATBXe
         FqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLJbE0lv1TbtATQ3egRbPPepTDXoKcJK7gbuEBUdECE=;
        b=FRJ+zXPrL4tm5i70aoVWzSVUj4YAVZ61fcKKiO26CLYZQ+m8BMWtzVrg5msm9gbmhy
         aFW7c+rv4nGdTLuyZkMLeMKsYGAx32QbYfOBl9qb0NMIihop7E2W6keCUJjlhOdNNcWl
         2lqmhX4Y+tfCWJ+arnRq+T8nFK0AjWynMIpQNc2sYijE9EPvREvrUBPxAjqcf8f/cQpS
         sE8QbzGNlDRA4s98VQA0x5z584+mjoDmnbe1wJhOnVoPO2bY7O+9KqTB6UUlFCHIvBQ0
         f0caxudzX1TkfY7C/1Z927K/+wUiiXaFc4Z7IVzGyn5UEmkUPZoS0mVmGcwyyhsRpPbN
         w+Kw==
X-Gm-Message-State: AOAM532zuNDX5cc78WI3psRqrCzn9P/za9ko1zy90sGZlBpbLIrbMZ8/
        XmAa2KcQNiJmaSgX5F2rlYPDTBZxmq+k+zHVogG0vEenvIUr9A==
X-Google-Smtp-Source: ABdhPJzJWxxWaGz7TueEicgJ6H5MpY1Qp+k57y2Cn4SnPYwI9LlHnYT7cRWVuhq5j9MiuRBB8Em61YOyUpQuzzRSoPA=
X-Received: by 2002:a2e:90e:: with SMTP id 14mr4006774ljj.293.1596720773151;
 Thu, 06 Aug 2020 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200804091603.541-1-a.fatoum@pengutronix.de> <20200805061753.5o63zu4ionhgjab4@pengutronix.de>
 <871rkkhy7v.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rkkhy7v.fsf@nanos.tec.linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Aug 2020 15:32:41 +0200
Message-ID: <CACRpkdaOysS1-Y=3ghQ+1qbMTR8yi3bHg=_+gUOPo_EcmGmJiw@mail.gmail.com>
Subject: Re: [PATCH] gpio: siox: indicate exclusive support of threaded IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 12:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> So the solution for this driver is either to make the dispatch handler
> threaded or use the hard interrupt variant of dispatching the
> demultiplexed GPIO interrupts.

The struct gpio_irq_chip .threaded bool that the patch
sets just instructs the gpio core to issue
irq_set_nested_thread(irq, 1) on the child IRQ.

This is a driver of type "struct siox_driver" handling the
IRQ through the special .get_data callback supplied in the
driver struct and it calls handle_nested_irq(irq) so with
this fix it percolated up to the parent as intended.

So far so good. So I think the patch should be applied.

But what is behind this .get_data() callback for siox drivers?

The siox driver framework in drivers/siox dispatches calls
to .get_data() from a polling thread which is just some ordinary
kthread. It looks like this because the SIOX (I think) needs
to do polled I/O. (drivers/siox/siox-core.c)

So this is a thread but it is not an irq thread from the irq core,
however it is treated like such by the driver, and in a way what
happens is events, just polled by a thread.

So when we call handle_nested_irq() ... we are not really
calling that from an irq handler.

I am just very confused :D

But Uwe must have designed this thread to mimic IRQs
specifically? (Uwe?)

I don't know if the IRQ core even sees a difference between which
thread it gets interfaced with. I suppose it does? :/

Yours,
Linus Walleij
