Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648E5C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C662063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwLZV5Pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgDGL3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:29:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37186 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:29:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id g23so2712848otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ks+RAtref+Aa1LsW+qIjyIm12wRKmiZeJoTmqqOQJAc=;
        b=WwLZV5PqTcKdjYS0x26/v/152x7q2BE84BJKWv5T0fkwlP232BkXXojRJGU3wqXEMB
         eTJ35MYTpY5QgZ+YnFShYrtna/idnsWil9QCzqNUnMc03XPLNojGeZfwcRbIDjcZMkZC
         46p+Z6IXaKLfS4gJEZMtdVhS2lu5VoVT0vrr/k5Y8C7wH/nYomuIHrE3RFRycbRLhWqB
         F0mylWILg6s6/G5U/q64JbpqV1ZexEdkOhq1LzmjSGPnpxBbWU4FRoh6AQp+8rVWs+W0
         5zxR5JcOWhdxqupUCQTENA4KCynXCuZzWw+QmtXOcmWCSafkb3cfokad4WMcSVpr2yxv
         qpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ks+RAtref+Aa1LsW+qIjyIm12wRKmiZeJoTmqqOQJAc=;
        b=kfUyA86fiUMr1bvLW+N18QG1aaWOvmcOquD8SV3BGvUYq8nSeUuJm615V4zls/n6dq
         9LcrVMzAboCwIcF/eV0fo26ljWDYTNzEdso/S7tWZohSoq9c+KQL4Wv+rWV0wUBpfhla
         jZz5tEMasvb0k9Ctw4DvVX1vJyhq9dpe2QPKmjffpb17jQNW08CfvdJ8HBBRN9K8B3kW
         XwOzxRjvwbvWb9OAsbcnqxNF7Bb6bdKskGu8AzZQwg0grpXf2sBye9owSU8NEBCesAAT
         P+8URP7+bjGz2azqNJRTsFlqeeDZDcp0KRYCVjeceI6WIT/8tBuJEniVx3Yl2ymtiEo/
         9H7Q==
X-Gm-Message-State: AGi0PuZoz2uLh6/HG0c192El6qy02INzCFncKR7ZR/w/V19NaAADv16k
        N95F5MC9j+120egpyDDp00bsN4nivKuYEeWXOQ5NiA==
X-Google-Smtp-Source: APiQypIbfbWm+UAuN2LQYpOJrjxSOeEswzyxBe4SbCKqH3dehDKampxrwTbrEfg8it7NBjEQyLOXANbFoJ8NHgeJKvk=
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr1082037otr.272.1586258957489;
 Tue, 07 Apr 2020 04:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133346.372517-1-robert.foss@linaro.org>
 <20200331133346.372517-2-robert.foss@linaro.org> <20200401080705.j4goeqcqhoswhx4u@gilmour.lan>
 <CAG3jFyvUd08U9yNVPUD9Y=nd5Xpcx34GcHJRhtvAAycoq3qimg@mail.gmail.com>
 <20200403232736.GA6127@valkosipuli.retiisi.org.uk> <20200404093446.vuvwrhn5436h4d3s@gilmour.lan>
 <20200406083506.GE6127@valkosipuli.retiisi.org.uk> <20200407083647.4mocdl7aqa3x737q@gilmour.lan>
In-Reply-To: <20200407083647.4mocdl7aqa3x737q@gilmour.lan>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 7 Apr 2020 13:29:05 +0200
Message-ID: <CAG3jFyvd32pWppubMoOoyH9eO2XLjwUXMC7p4xtv8m+JkPv6vw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] media: dt-bindings: ov8856: Document YAML bindings
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Maixme & Sakari,

On Tue, 7 Apr 2020 at 10:36, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Sakari,
>
> On Mon, Apr 06, 2020 at 11:35:07AM +0300, Sakari Ailus wrote:
> > > But that 19.2MHz is not a limitation of the device itself, it's a
> > > limitation of our implementation, so we can instead implement
> > > something equivalent in Linux using a clk_set_rate to 19.2MHz (to make
> > > sure that our parent clock is configured at the right rate) and the
> > > clk_get_rate and compare that to 19.2MHz (to make sure that it's not
> > > been rounded too far apart from the frequency we expect).
> > >
> > > This is doing exactly the same thing, except that we don't encode our
> > > implementation limitations in the DT, but in the driver instead.
> >
> > What I really wanted to say that a driver that doesn't get the clock
> > frequency from DT but still sets that frequency is broken.
> >
> > This frequency is highly system specific, and in many cases only a certain
> > frequency is usable, for a few reasons: On many SoCs, not all common
> > frequencies can be used (e.g. 9,6 MHz, 19,2 MHz and 24 MHz; while others
> > are being used as well), and then that frequency affects the usable CSI-2
> > bus frequencies directly --- and of those, only safe, known-good ones
> > should be used. IOW, getting the external clock frequency wrong typically
> > has an effect that that none of the known-good CSI-2 bus clock frequencies
> > are available.
>
> So clock-frequency is not about the "Frequency of the xvclk clock in
> Hertz", but the frequency at which that clock must run on this
> particular SoC / board to be functional?
>
> If so, then yeah, we should definitely keep it, but the documentation
> of the binding should be made clearer as well.
>

Alright so, let me summarise the desired approach then.

ACPI:
  - Fetch the "clock-frequency" property
  - Verify it to be 19.2Mhz

DT:
  - Fetch the "clock-frequency" property
  - Verify it to be 19.2Mhz
  - Get xvclk clock
  - Get xvclk clock rate
  - Verify xvclk clock rate to be 19.2Mhz

Since the xvclk clock isn't available under ACPI, this is how the two
cases would be distinguished between.
Does this sound about right?

> assigned-clock-rates should still go away though.

Ack.

>
> Maxime
