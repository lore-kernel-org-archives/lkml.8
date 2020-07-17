Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996BA20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594995312;
	bh=scjhaPmYBYlkHTCMPkS4HuQeVN/II4OmnYBJOma1450=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sg8WzFiARCnw96zVezAZngiEQfr3cvmh+MGxAdvd2OviYxaS2hMu2LK+EkHKX6Rtv
	 tBKgWxXFJmk7bPmEWWG8ZI71qIGnhjObefnLIecjB95RRF2SEaYdLBuys2LUjXzGYQ
	 u6Twn1bfSkAzVys+MhCnfFaH24WqNM+S1TKugraU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGQOPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgGQOPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:15:11 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D462820717;
        Fri, 17 Jul 2020 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594995310;
        bh=scjhaPmYBYlkHTCMPkS4HuQeVN/II4OmnYBJOma1450=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1k3rR5Vle/vTBP94Fxt2qQ3nj99Cg7bMK7U561DSmGEYVAQKGdK4JjFB5+p/dIqL
         Fu1ezV1st0OIgRrz3n5ysTa1PiCXYaTJEfAOd4mFNC4vWIVCu+GVJRzqmZEA6RoUkc
         bfe6lgfxz3IP33q9GVN5aUTZW8qEUt1VyFpSNzh8=
Received: by mail-oi1-f175.google.com with SMTP id t4so8094603oij.9;
        Fri, 17 Jul 2020 07:15:10 -0700 (PDT)
X-Gm-Message-State: AOAM532YoqbptQ41G5+7uIOzxlcNh7LrUoUzwC6UpjAqMLEq7euPOGca
        THEu9ZOWR9C7fY9YPIn0Vz98Ol7cvt5GwW7/GA==
X-Google-Smtp-Source: ABdhPJzOkH/bGKW5lbTgJGLSIvdskhs13FPE8k2K6kft/+EkrgJ/rkNQpYnz5vnrmDpON5xD8RwrzShzXmccZD+Q6nk=
X-Received: by 2002:aca:4844:: with SMTP id v65mr7988751oia.152.1594995310214;
 Fri, 17 Jul 2020 07:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
 <20200716192452.GA2699629@bogus> <20200717023108.GA17070@b29397-desktop>
In-Reply-To: <20200717023108.GA17070@b29397-desktop>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Jul 2020 08:14:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+A+Gj5Ry=eUakkD6bTVh73nmCt4=vyT62yjoh14QyU8w@mail.gmail.com>
Message-ID: <CAL_Jsq+A+Gj5Ry=eUakkD6bTVh73nmCt4=vyT62yjoh14QyU8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: ci-hdrc-usb2: add property disable-runtime-pm
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 8:31 PM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 20-07-16 13:24:52, Rob Herring wrote:
> > On Tue, Jul 14, 2020 at 05:18:20PM +0200, Philippe Schenker wrote:
> > > Chipidea depends on some hardware signals to be there in order
> > > for runtime-pm to work well. Add the possibility to disable runtime
> > > power management that is necessary for certain boards.
> >
> > This is why we have SoC specific compatible strings. Use that.
>
> It is a board design limitation, not SoC's. To support USB low power
> mode for device mode, either VBUS connects to SoC, or VBUS connect to
> GPIO, or VBUS connect to Type-C IC, but none of the design is used
> at that board. So the USB can't enter low power mode for that board,
> otherwise, the USB controller can't be woken up since no any interrupts
> will occur if USB cable (host at other side) connects to the connector.

That's certainly a better explanation than the original.

Don't you need to describe the Vbus connection in the above cases?
Then you could handle this case based on the lack of a Vbus
description?

Rob
