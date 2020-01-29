Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A7DC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B7F2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tN0PTJcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgA2Jmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:42:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35693 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgA2Jmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:42:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so11401332lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgsPt5iLckDl4+reKUwpK1f/AMIxH90ObKmbxCdIZ14=;
        b=tN0PTJcTzUdOJaDREUJwwuN4Fwlv49F9pORwaFKbZS9kbFGwvBDWGHgZW6vbDhdWwA
         USD6BDOGBZrIk5H1bIPwx8B2kIQ59INlbcfn7nvWih3jjgkBEhJy9hy34ub4Zg9n+zPd
         VFQjJ7VywOVykhe+gb4ATY8EndDpqaiuo4oyI9rhvTQAkBaGiqxXAZMwdJyyOYTwclWg
         6Un8SC5o8GpqN1WsRU42/8cBSe01rNASa1cs5u+HgJaVQMD7Dweu3DSfzS/L6R68tGpn
         XPPnI+yikij40DB/e9DsEOw9xouejBjYL6OF2+QQEXqu4A4Aoqm2HKMIXc8Eq/T3B0XG
         objg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgsPt5iLckDl4+reKUwpK1f/AMIxH90ObKmbxCdIZ14=;
        b=I3ft7+3N71XyTJWFrUENwOZxKX6De9kAA97Lno2bNrXh1ptUQfDLcqVJL/4GOAY8i3
         PWMpRAOwpfsfn5Zps0wFDLnoW2hJGlMxfCL7kzIBBbBewaFZtSibLXtVfB1iwOyJyir0
         MvWiefzqEIVroAtp9/FdI7ufKvK04Q0JI+oFJUdsejLfC6WUg+l9UxZPIjP9p2zBFRFE
         EUZK3Rqy6aHjaq6swSge3yqJE/qHyZ0akKrNcyi2lvNu5kPNschgFKKO8qy6SjjEuCEq
         kUOAUf0q0uUZ5pmqakNNYCQxAap7RaJWhwVRtnczbX8hTLOsNqDFUrAyeyc55Fd+tvW2
         SO3Q==
X-Gm-Message-State: APjAAAUa6Cy6QN7Q3YKIrqWN5owRsBdhmTF+hg/BdTfv5KH01lc9qrZv
        jA/mLuJCdGkGQKcdw7Ssh4Vb1xFnPbVX/5EYcAcoRg==
X-Google-Smtp-Source: APXvYqzEcIiWTIZ9ytjZrmjpY6fIywNYTcRdFgjAz20YlNaSNq2K7nuUzaQ/5qIbfSRhs23wP8kcnro4GpNJkZSzX2U=
X-Received: by 2002:a19:40d8:: with SMTP id n207mr4819024lfa.4.1580290970448;
 Wed, 29 Jan 2020 01:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com> <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com> <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
In-Reply-To: <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Jan 2020 10:42:39 +0100
Message-ID: <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 9:30 PM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
> On 1/28/20 5:57 PM, Greg KH wrote:
> > On Tue, Jan 28, 2020 at 04:41:29PM +0000, Benjamin GAIGNARD wrote:
> >> On 1/28/20 4:52 PM, Greg KH wrote:

> >>> So put this in the bus-specific code that controls the bus that these
> >>> devices live on.  Why put it in the driver core when this is only on one
> >>> "bus" (i.e. the catch-all-and-a-bag-of-chips platform bus)?

> >> It is really similar to what pin controller does, configuring an
> >> hardware block given DT information.

> > Great, then use that instead :)

> I think that Linus W. will complain if I do that :)

So the similarity would be something like the way that pin control
states are configured in the device tree and the pin control
handles are taken before probe in drivers/base/pinctrl.c embedding
a hook into dd.c.

Not that it in any way controls any hardware even remotely
similar to pin control. Pin control is an electronic thing,
this firewalling is about bus access.

IIUC this framework wants to discover at kernel boot time
whether certain devices are accessible to it or not by inspecting
the state of the firewalling hardware and then avoid probing
those that are inaccessible.

It needs the same deep hooks into dd.c to achieve this
I believe.

Yours,
Linus Walleij
