Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138D6221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="BCsdMv/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgIKMDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:02:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:02:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so13451326ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=MB8KR/cuoizxWcYxBx51GB3knSYT3+P7WpQmn9XtoNc=;
        b=BCsdMv/qZu57CnDlGgysC+BzA1p1EgCDicm8DWRwDUMUhQpDR2Rg9NqQWbXGN6WLZd
         8O48ycLGqIlQA/c1IXwmaUSIkPV/4xU2qzadkGdTrQ8RzNavt3YE2CeSY2gUGk9+SPvL
         qGVGVM3x4UBWPSanOTKXqlsOTB3kiwRL5ItGdyIsHHAN0Aips5EhoJohuqZic/kKGbhL
         bEuOfCuQFUH2Pf0k5u2jmgBM18O5G0BGEBIYAB81moyikw1L9GJ1BNWvcl75mibJR+Cj
         MXrp0kepHyZVXjzQK9uzr6VFb/iQ1tt4PrXhDOscYK4ONpbe/SQvsyxbGHIIiW4kj2eE
         kSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=MB8KR/cuoizxWcYxBx51GB3knSYT3+P7WpQmn9XtoNc=;
        b=YN7OEFSgcX0nPEKrZpRk6SrgB9R4X7nD2skJt+6IrfNBWePDemEHiwJENKJEOyNg5g
         +NyAzkQPXjstk4LLtWAVudzelXuSjQzEf+Mp2kIer9v8DbyHd5x2CeNnJtrIlE6Izxcl
         awNtjGSbyjmOrdxqJWH+nsIWdFPEltA5iPkhkbGNpLIXXn9OOG1dMnfdTAAMBLR1BTjg
         VZqhDrA9I9R/pcNOMM6I1N/u9Fl1wkR3tFBOxVQuczYu7QRsEQoJ9UcfjsVVazLKFhp2
         Vf1/bLPpUVL962QvTMTuvOcPVfWeHJOa5FN0I172gak10iIl+njJOB5Cm0wqOgw21sXp
         AMNQ==
X-Gm-Message-State: AOAM5319CMQU2IfGMZG5XeVslsLGDhqZoIRXvqJ9A3SJr7mpgLJQNqY6
        C6eR6EFg71fL6CZE6b72Bd9Fc1HFJDLNZwAWIhhymg==
X-Google-Smtp-Source: ABdhPJzsWOdDJHOMjHDQrcC6m+XTKm8emOB/0is3CABIgP+xvTnUtGAWCNKsftUnsw9k4IThb+kSo1/KyqI2UpdtODI=
X-Received: by 2002:a17:906:915:: with SMTP id i21mr1638194ejd.113.1599825745575;
 Fri, 11 Sep 2020 05:02:25 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <20200911110018.GD4895@sirena.org.uk> <9a6ce5d0-2f39-eb55-c3a9-cae2a8093fbc@arm.com>
In-Reply-To: <9a6ce5d0-2f39-eb55-c3a9-cae2a8093fbc@arm.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK/xI2P7uxCBV5mjF/xjkF3M143zQFA0ZONANRlRQCngC+DsA==
Date:   Fri, 11 Sep 2020 17:32:24 +0530
Message-ID: <01f42ace75808be76c78a4a67b78ec06@mail.gmail.com>
Subject: RE: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ard Biesheuvel <ard.biesheuvel@arm.com>
> Sent: Friday, September 11, 2020 4:46 PM
> To: Mark Brown <broonie@kernel.org>; kuldip dwivedi
> <kuldip.dwivedi@puresoftware.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> <arokia.samy@nxp.com>; Samer El-Haj-Mahmoud <Samer.El-Haj-
> Mahmoud@arm.com>; Paul Yang <Paul.Yang@arm.com>
> Subject: Re: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
>
> On 9/11/20 1:00 PM, Mark Brown wrote:
> > On Fri, Sep 11, 2020 at 01:58:06PM +0530, kuldip dwivedi wrote:
> >
> >>   	/* find the resources - configuration register address space */
> >>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "fspi_base");
> >> +#ifdef CONFIG_ACPI
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0); #endif
> >
> > This is buggy, it is equivalent to just removing the name based lookup
> > since we'll do the name based lookup then unconditionally overwrite
> > the results with an index based lookup.
> >
>
> Also, note that CONFIG_ACPI kernels may still boot in DT mode.
In case of ACPI we need to use indexed based lookup.
For reference Please see , Line :23 and Line:24
https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platfor
ms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/FSPI.asl?h=LX2160_UEFI_
ACPI_EAR3
Here I can think two possible approaches
1. Changes in DT to use indexed based lookup
2. We Can check for ACPI fw node to distinguish between DT and ACPI like
below..
if (is_acpi_node(f->dev->fwnode))
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
else
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
"fspi_base");
Please share your thoughts

Thanks
