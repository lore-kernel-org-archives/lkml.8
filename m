Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25CDC54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81ED120673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL400oUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgELOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgELOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:24:21 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363AC061A0C;
        Tue, 12 May 2020 07:24:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j2so1632928ilr.5;
        Tue, 12 May 2020 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHPCRyECAcM8k/cCdpKgX/ZG7bOYLJtrdapfMB8yHTY=;
        b=pL400oUOmAbd00DWGg45pkmL9RaYHaSg0EMnVTCe13VpTIwWykhkyVyy+4r+WyoLVz
         7FsIjn4CGjupx/7voxxuK4RFDbUEAxeFVMgyArXMO9PCj8M/a1980V33qwl8Ig6Sml99
         ABgVQ7DUfri85Qk9eWeVWYWVEgDpHKjK6KzsceQqWZUK63ExHiy5Xu3KIdt0kI8rz55N
         xnTzuNSd80B4X5LY7GXe4cpaHlCHfDe7iduvh0Qxff7utifkz+yfh4SnEfdKZispRiW2
         3vSi6u8ZzySDWb3nq85Msah09Q8zntlB0W6pdgPvoFLvJTZvi8QUT2OyJR+QPRSRztw/
         eELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHPCRyECAcM8k/cCdpKgX/ZG7bOYLJtrdapfMB8yHTY=;
        b=Qdx/abfKtvMQPhrzLCaKvPFzrS+Sis3Uj56rLGQLWwhHb7Zjw9zt0+SjUmOwoa4mTO
         9jByLdz2t6T7eu1IftXIXCo99Dd6YSlIrIX9jaWisv+r0e9deJG0Pi/xOX9TcieKKQ9C
         A+F85JX0hpMToBoCSxvHb2ednjhfRA4cOfflWY367WM3XyLSs2T4zTZbwb3reiOSZQjG
         rP4aPO9mD2lGt9uC7pT9088ldrp0W+Mky7fg9u7lWmm6nHoinpBX9xUJuMq9PMlWVJe/
         uiRvOD3oNRVjhsCewZab/Y6G+bVDCL7lMpB4BEEDw10TAK7kKi7ABoxNTbUYN3rY+54O
         0Ahg==
X-Gm-Message-State: AGi0PuYwH6zKMK4oVej52KBCvCpd6l4BwiN+SPNR9R2P1+oi6rlK6WDJ
        LCPjlSAaQfE+/0OU6TNE5IjRhVMYAXpJVKkPMDE=
X-Google-Smtp-Source: APiQypIFGaWFT/sin8nzW7GPMz/bf3+8hyeBW5SceLin9d02vPh/G5jzdUF5gSilruEh5HwTVCfzhHp34i+OXseVuQg=
X-Received: by 2002:a92:2904:: with SMTP id l4mr13035243ilg.159.1589293460473;
 Tue, 12 May 2020 07:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200511193643.30926-5-alcooperx@gmail.com> <Pine.LNX.4.44L0.2005111542310.11417-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2005111542310.11417-100000@netrider.rowland.org>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 12 May 2020 10:24:09 -0400
Message-ID: <CAOGqxeXSZY6-NNCvrYmurVb1q9e5_fJVdpU3EwO4vFV+hpxwvg@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 3:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 11 May 2020, Al Cooper wrote:
>
> > Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> > was created instead of adding support to the existing ehci platform
> > driver because of the code required to work around bugs in the EHCI
> > controller. The primary workaround is for a bug where the Core
> > violates the SOF interval between the first two SOFs transmitted after
> > resume. This only happens if the resume occurs near the end of a
> > microframe. The fix is to intercept the ehci-hcd request to complete
> > RESUME and align it to the start of the next microframe.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
>
> I hate to point this out...
>
> > +static int ehci_brcm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct resource *res_mem;
> > +     struct brcm_priv *priv;
> > +     struct usb_hcd *hcd;
> > +     int irq;
> > +     int err;
> > +
> > +     err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +     if (err)
> > +             return err;
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq <= 0)
> > +             return irq ? irq : EINVAL;
>
> That should be -EINVAL.
>
> To tell the truth, I'm not sure it's worthwhile checking for irq == 0.
> That's up to Greg to decide.

Darn, I've been looking at this code for too long :(
Since Greg originally requested <=, I'll fix this and send v10.

Thanks
Al

>
> Anyway, as far as I'm concerned you can either change EINVAL to -EINVAL
> or change the whole thing back to "if (irq < 0) return irq;".  Either
> way, you may add:
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> Alan Stern
>
