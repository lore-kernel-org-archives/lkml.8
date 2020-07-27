Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC66E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="Rrme5m5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgG0JT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgG0JT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:19:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:19:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so1512963ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yLnBcJ7AAd3mxUPf3jGsnG6dsXBMorrtxynphcZ58Lo=;
        b=Rrme5m5VJcvJfeb/5BW8Hq518uIh95lif7kMwJNVad8/btgBS/K25HDnjgKvI8vtO7
         YI4LnrVFZ5bte7TgQnygpWDu4yyX00VmQ4d9DWQl0uJwumsl20t8YcFhULEuJmRmqLzH
         MBYYsHgJd1Ruyr2KL95cXQCZPmpRWwUJCoq21BZwg2oz1hFMO6KA6viDQW333yocDKgh
         m5QjZkGjhuIhDuMDV/FnhxfqO9sc39fLVqjoPlpSkVFTk0/HTd6fO51dYtA/3KqxVGq8
         Wi7aQuSR824kbXY6eaRf9EHGuOGoJ4D30m4hIF1qsykmde7LH484tEGOA9/K9zTR5oG0
         gYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yLnBcJ7AAd3mxUPf3jGsnG6dsXBMorrtxynphcZ58Lo=;
        b=U5HySB1EWWBs4SjYndJsDNSAg9ph/QW6ArgLsHbr1lnLP5w/YSrOj5ZInba+kH+nWx
         FEihLbkyw8Q2gCPVh1Wg8WHfjQIfJaXbxlV/NzMw1Q1/ug1xjwLbXkNVDIffhvh6mlag
         /ooWFcvyQlYLPvoxdgryVz+wA0xlgrEvQ3jOrRZBSAKL4Cghvc5s8iTIGmjkubxpS2Jw
         ciLZKBg3tx81Mypvdb9xNgTtth44mZaU12WLk10gn7rNjqBbySizDaVX59dibGiXDE8W
         4R/NcpsaVe9YJaPdPPeXmKN1DGTwCo/4OKpWgdaATlNxzI/eztXWAe+uEUb0FxobLbIE
         SI5g==
X-Gm-Message-State: AOAM533tU/IoRgmjd2y7bF5peXpiU6+f135aDOzvBAejdOCVg+QEP6cr
        7H89fv2bLzzZMXf+cZgwiwbJQ7nJKqUwyqGKMqZpKjbi
X-Google-Smtp-Source: ABdhPJyuwhYdkGGy++YHy8bXte3CGx1WkQqv2s1Zp2sQFaoV4RP9ZY9GnwaCnPl/RDaoqjmbMCr7jWPWPAn3ppjayGo=
X-Received: by 2002:a17:906:2451:: with SMTP id a17mr17227540ejb.274.1595841597754;
 Mon, 27 Jul 2020 02:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com> <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus> <20200723195755.GV3428@piout.net> <CAC4G8N7Agb6pVVv6x9_pMMxkB9HnCFiaaC6EJb4-MNzEPd0Uhw@mail.gmail.com>
In-Reply-To: <CAC4G8N7Agb6pVVv6x9_pMMxkB9HnCFiaaC6EJb4-MNzEPd0Uhw@mail.gmail.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 27 Jul 2020 11:19:21 +0200
Message-ID: <CABdtJHvA9YL76pf+ip--OuX1WOxLPm3f=WB_-BAdA2QguSu3tA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
To:     Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>, a.zummo@towertech.it,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:41 PM Miguel Borges de Freitas
<miguelborgesdefreitas@gmail.com> wrote:
>
> Hi Alexandre,
>
> Having a way to dynamically change the configuration would definitely
> be helpful in most cases. I decided to go with a DT property because
> in the case this patch tries to solve (the cubox-i) there isn't simply
> any other option - the default mode won't work due to the missing hw
> components. So, I thought that by defining it as a DT property it
> could somehow be locked to the hardware definition.
> Keep me posted
>
> Regards
>
> PS: Sorry for the second message, forgot to disable html and the
> message couldn't be delivered to all recipients.
>
> Alexandre Belloni <alexandre.belloni@bootlin.com> escreveu no dia
> quinta, 23/07/2020 =C3=A0(s) 20:57:
> >
>
> > >
> > > I'm all for common properties, but is this common across vendors?
> > >
> >
> > This is but this shouldn't be a DT property as it has to be changed
> > dynamically. I'm working on an ioctl interface to change this
> > configuration.
> >
> >

Thanks for sending this patch.  I think there are two paths forward if
an ioctl interface is being added.

1)  Change the property to reflect that this is the default state the
RTC should be initialized to.
2)  Just move this configuration into the bootloader and then verify
that the bootloader doesn't reset this value.

-Jon
