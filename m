Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797A92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Sf/3co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgG0LMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgG0LMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:12:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C0C061794;
        Mon, 27 Jul 2020 04:12:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so8869068pfn.12;
        Mon, 27 Jul 2020 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpiOzoaiyx99ynR2WykS5OLOkmTVVgbbrLc0IXpWnR8=;
        b=A7Sf/3coa+fxUWtaNpz7yyIgCasw1IqgduuJzPXaOtbss/krO+INI3+vdjSItItDls
         oHfR/G8SMHJY6U/3nsURjcNTR+Sy6VixxEXkSGgQ9kJ08Hbg1rGyo+DxOIgwy8llD9dA
         qZwNFk8MnRTfvYELpLeyxhGTAIU2Ipdzik0QYGH4+Qj9+dhFlPKtk9xbCLkyQhfLtxcU
         eLxCX2jsCSwqDj4AkMc0S27aaBarvBSKGkNeAIUdXttVJyiz7DeBFMDfy5RzKtgc1n7y
         6cTaL2DtTX4QM7tekW/6ie7ZUVOCkgUIWUSsrr/bfl4UfNMqe0AMTM6ecFGiH67sBPQD
         tM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpiOzoaiyx99ynR2WykS5OLOkmTVVgbbrLc0IXpWnR8=;
        b=oqmwjOutLFZhn48kFgNFBsP+PzY0Iasq0eOnzYa9/7i4F7pNSBYbpPpqZomnnnu02h
         OU9D9uU0pxY7LRhDzYsYHEAF1CKXPDhkST29kswkJEjdBkEEYdY8wd4BXjB667kHsmfD
         bZQmEX4YC8kMSqqSbDfAWmkzIkLlhbROfDeXYBDApBHytJYKFLw3+a3S9yP9fdguH6rP
         fX1G6lZ4Qa2fK8TIl93DcA+/csmg+EPaZ5cXEoKjXr0ZV/XCI+eJcoZoXrLX9sYANpm+
         XYm70EjYl28hV4NQIje7Xp2WQbfrwjw5weWdRggrlN1/Lbxo+td1avxj3fM64/uoY1hr
         32sQ==
X-Gm-Message-State: AOAM532U/7x4ul8R1EV2a8B3y4O3ptC5Af0EQizmgnIZHs0XyPMnqwqT
        QHBfHvU/ipdMD0gfSVstppzbsrnUaLpyZWiUv5w=
X-Google-Smtp-Source: ABdhPJyvf3lIpJpA/1EcG6vZkAsQqoAQLwhd16BxxYu2pcosuttYaTohVJdM6B1u4sl6qyovpGHqAgrkyoqCPCO1NOc=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr19797993pgi.203.1595848351479;
 Mon, 27 Jul 2020 04:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200724223746.GA1538991@bjorn-Precision-5520> <CAHp75VdSr1rguc9HJVh_rA1nBh1uyCdr18eyPosWPzCH1K2=zg@mail.gmail.com>
 <CAHp75VfKeTCBOne3tDSM46q6m_FE+7hS3H9Hx5C3RRPvueqZAQ@mail.gmail.com> <20200727070652.GA5400@gmail.com>
In-Reply-To: <20200727070652.GA5400@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 14:12:16 +0300
Message-ID: <CAHp75VdzAk6U_mKn32+dmw1aNyREtaXMB6sHubE8G9imtv5=3g@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:08 AM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> On Sat, Jul 25, 2020 at 01:44:44PM +0300, Andy Shevchenko wrote:
> > On Sat, Jul 25, 2020 at 1:42 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:

...

> > The only problem here, is that the 2nd is already in the Mark's tree
> > and he doesn't do rebases.
> > So, it will be the other way around.
> >
> Concluding from yours and Bjorn's suggestion, I will drop the
> device_wakeup_disable() call form .resume() and send the fix. I will also track
> the drivers who got similar upgrades and went un-noticed.

Thanks for doing this!

> As Bjorn mentioned, the problem is that I don't have hardware to test, so I just
> replicated the legacy behaviour in generic by replacing
> pci_enable_wake(....,false) with device_wakeup_disable().
>
> So, from now, while upgrading drivers with generic PM, should I completely drop
> the pci_enable_wake(....,false) calls if both .suspend() and .resume() try to
> wakeup-disable the device?

I guess the best approach is to rely on the PCI core to do the right thing.
But mention this change in the commit message that we will have a
track of the changes properly.

-- 
With Best Regards,
Andy Shevchenko
