Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EBCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8251B2098B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="iAtnVt11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgICTVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbgICTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:21:45 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D97C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 12:21:45 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cr8so1856009qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dowifujsygdwiQ9jbyQZJ4foEh8zBJ4ZLzABLofs6M=;
        b=iAtnVt112D3hVzzS1Doyn59zhroPYPe9VaxBwdqwvcIj+i/BoY0Ro3WQ+6IeVB+fM8
         tIy6YmpwWFTvtbDC0yR+kKmhFzz2gN5Wi5JMTolFKHbaLWqIetb1Vti+jHJ0TVwW/PFY
         cAnzSjsBnPGCDsfwOkSWQxu28lEMTOzq/Dk4pgxWo76nQEf7XVzwMSE/li86ZLbqZSCT
         jOFiOfmqabsuqewmzSDNxvYvaKgMSruquavPw6AHD/ERXIP/eIE0GaXAra7ftenEPOIJ
         1l99eYc3F0Jg1PARncVIkEfm7pTeDxn6ipOkRkQtO+9qB1kGq5sHwfKewiP1lyXrHz9g
         C3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dowifujsygdwiQ9jbyQZJ4foEh8zBJ4ZLzABLofs6M=;
        b=QDDrVkAOPrGOYd2CWB74msAk4IWF2g6IrqckI+0Ur8U9Vx6xsts/vzPAmIPnXdTO7u
         ZmugtZ6JmCtpqJ8ifpHH4IIwmLBUC7ZJVRgoyPgbjPr5QG+wX+nYYvBWLcjfKUTqF0W+
         TdXaHtFykmJ+9dvdkEYKDfYM85Fbeo24+i2a2JbiMZXI7UTgrplbVC8CG4FQPj7hjCwu
         bm3ZdKbGYdVMYv5YvYcJIlmUFHOpzPutUOEs31CuVSbAzvPdMkmfR2fcpgO1CxmaGXOL
         qw4JIMQdHQUoZK9CDYZp6eClfaT9i2nA4Uf0vPPGypMXCpMMlFDTOAF3IyDgX9fE8TSq
         gipA==
X-Gm-Message-State: AOAM530+/XKNbZZPuMz/40YTBWkCC/CX6z+GU8Ap2V4fQWmiogxamGyV
        rmRaST5KAfqKTwFJ1pgwZh2ByA==
X-Google-Smtp-Source: ABdhPJxKWJUplPVzCpYvg5dXOArUCgpCGn4DNLInI64IfUnz+jy+KeXip8s3NaC3K1WR1kDRm6v5Aw==
X-Received: by 2002:a0c:e981:: with SMTP id z1mr4313130qvn.15.1599160904468;
        Thu, 03 Sep 2020 12:21:44 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id y7sm2822665qtn.11.2020.09.03.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 12:21:44 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:21:40 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200903152140.7b6e9c7f@DUFFMAN>
In-Reply-To: <9be6848cfdbb92865417292feff03cae@kernel.org>
References: <20200829164920.7d28e01a@DUFFMAN>
        <65d88bdd0888a69849327501a2aad186@kernel.org>
        <20200831031838.2d6d76d9@DUFFMAN>
        <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
        <20200831234542.295b1275@DUFFMAN>
        <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
        <20200901164249.GA15045@e121166-lin.cambridge.arm.com>
        <20200901143356.0425d9ba@DUFFMAN>
        <20200902160110.GA30014@e121166-lin.cambridge.arm.com>
        <20200902234756.60e4c4f6@DUFFMAN>
        <20200903091901.GA9386@e121166-lin.cambridge.arm.com>
        <CAL_JsqJwH3ZKWKYeSJYKZhaU7x59H0t=AM4nWDSmRZuSY0-DGA@mail.gmail.com>
        <9be6848cfdbb92865417292feff03cae@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 16:59:30 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On 2020-09-03 15:35, Rob Herring wrote:
> > On Thu, Sep 3, 2020 at 3:19 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:  
> >> 
> >> Ok I think I understand what the problem is.
> >> 
> >> Can you give this patch a shot please ? I think we are
> >> dereferencing a NULL pointer if bus is the root bus and dev == 0,
> >> we can rewrite the check if this patch fixes the issue.  
> > 
> > Indeed. I checked all the other cases of
> > pci_is_root_bus(bus->parent) and they should be fine because they
> > are only reached if !root_bus.
> > 
> > I would restructure the check like this instead:
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c
> > b/drivers/pci/controller/pcie-rockchip-host.c
> > index 0bb2fb3e8a0b..9b485bea8b92 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -72,14 +72,14 @@ static int rockchip_pcie_valid_device(struct
> > rockchip_pcie *rockchip,
> >                                       struct pci_bus *bus, int dev)
> >  {
> >         /* access only one slot on each root port */
> > -       if (pci_is_root_bus(bus) && dev > 0)
> > -               return 0;
> > -
> > -       /*
> > -        * do not read more than one device on the bus directly 
> > attached
> > -        * to RC's downstream side.
> > -        */
> > -       if (pci_is_root_bus(bus->parent) && dev > 0)
> > +       if (pci_is_root_bus(bus))
> > +               if (dev > 0)
> > +                       return 0;
> > +       else if (pci_is_root_bus(bus->parent) && dev > 0)  
> 
> Careful here, this else is relative to the *closest* if,
> and not what the indentation suggests...
> 
> > +               /*
> > +                * do not read more than one device on the bus
> > directly attached
> > +                * to RC's downstream side.
> > +                */
> >                 return 0;
> > 
> >         return 1;  
> 
> 
>          M.

Both patches work fine. They both allow the device to boot and Wi-Fi to
work as expected.

I will echo Marc's concerns over the indentation. I am only casually
acquainted with C and this indentation would bring to wrong conclusions
if it hadn't been pointed out to me.

Cc me on an eventual patch, FWIW I can give it a final test just in
case.

Thanks again,

-- 
Samuel Dionne-Riel
