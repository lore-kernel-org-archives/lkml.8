Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7958C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B303320738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6qMNMd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHYNxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHYNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:53:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:53:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u18so2509587wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m5K7q4ntfOvCuWo9VcwV3Y8K7PEmWf/RHpOYApWqYOo=;
        b=p6qMNMd5VglEdqFcIL1iv1XVKPRZ+sI70S8iThAOM+4AcOZuWdjDKeIKcuVwOrv97l
         mlzPdyztvYgnW6wJDVCB3Zwj5L/YbWx44evE1cefrB4fkVlzOUNZGIK1bwBRlX34j8Vx
         rop3HtmimD+WJ70KqcQt4D6PQzT1TvsMJ/x9dio43yiqkEcoej/f4of2ZQlmhTfC4p+n
         WIxtyaIr6IzvFHkq73aPJzB8sua9bocWmlXJIpI7t5WUNXF+apZlgt3q1ncLtpusFoWn
         NSctCbUnOTq51icB0I75NTaV26VnEpI1kjT4ICWIZXkbN4xEi1Hp16oDmEPe/fetgm3z
         M2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m5K7q4ntfOvCuWo9VcwV3Y8K7PEmWf/RHpOYApWqYOo=;
        b=Ve9y91Lvv3FfYBJm82oM4ucVHiSpJd+GQPnX6sHx+J8XgwEYeFN5uAMWaKPpWYG2uH
         RKt/aG0snARR7u8Y1iyiSPg+IqUDMOuXyqN5/YVyD+FgAH7msIINBqmpLcRNU7WlvEhe
         FPEt8MEwUopaMYENu2Q2NE9H6GSYBPgLiyAautC5DgW0eWRw3uhY5oyX5RgNZQU+KUKU
         7N2fwoVFxLnLJKNUyzWGf71MlL4/fOlAIy9OLsgDS4doomZftCJV8+27OSeUvJawwm8X
         nAJoymv3lM9SI2kBrc165K5ZfHI0J5TyKOnKYNdbfmA/lfZ2SHuNLqmBG+z54T87k0ik
         WnHA==
X-Gm-Message-State: AOAM532ua5fd8jkI26w6ysS8Cxy5guEc4gp26N7YNQxJ2/8EL0mQAmxg
        4sCSFy/PQmbi3GdGcnsWqejOtg==
X-Google-Smtp-Source: ABdhPJy8k9/Nb4tlj+y4Bq+1w/ACN3QGov3SCl+s4GMHcCRvFUwVSFwb3GgE8g5wKq+pB2bBXE/pBA==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr2243927wmb.25.1598363603543;
        Tue, 25 Aug 2020 06:53:23 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id h10sm30075699wro.57.2020.08.25.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 06:53:22 -0700 (PDT)
Date:   Tue, 25 Aug 2020 14:53:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, gregory.clement@bootlin.com,
        Thomas Gleixner <tglx@linutronix.de>, jason@lakedaemon.net,
        Marc Zyngier <maz@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "p.zabel" <p.zabel@pengutronix.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        clabbe@baylibre.com, bage@linutronix.de,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 00/16] Allwinner A100 Initial support
Message-ID: <20200825135320.GM3248864@dell>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <CAEExFWsvScMgi_Dftfq06HZiF8CFAmym8Z_tgQoHHAfiGxWt0g@mail.gmail.com>
 <CAEExFWuwjmqAh0c3kMLS3Gs6UC2A8TtY-9nJeWxFPRDugtR4pA@mail.gmail.com>
 <20200824080327.GH3248864@dell>
 <20200825085532.vv4dpuzmjnshm5qn@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825085532.vv4dpuzmjnshm5qn@gilmour.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020, Maxime Ripard wrote:

> On Mon, Aug 24, 2020 at 09:03:27AM +0100, Lee Jones wrote:
> > On Mon, 24 Aug 2020, Frank Lee wrote:
> > 
> > > ping......
> > 
> > "Please don't send content free pings and please allow a reasonable
> >  time for review.  People get busy, go on holiday, attend conferences
> >  and so on so unless there is some reason for urgency (like critical
> >  bug fixes) please allow at least a couple of weeks for review.  If
> >  there have been review comments then people may be waiting for those
> >  to be addressed.  Sending content free pings just adds to the mail
> >  volume (if they are seen at all) and if something has gone wrong
> >  you'll have to resend the patches anyway so [RESEND]ing with any
> >  comments addressed is generally a much better approach."
> 
> This is true to some extent, but pinging after a month doesn't seem
> unreasonable either.

Pinging is mostly a fruitless exercise.

After a month, many Maintainers would have purged any un-serviced
mails anyway.  If a patch-set is left hanging, still requiring
attention before the next version, submitting a [RESEND] is generally
a better option.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
