Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E0C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE220678
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPWrV2L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWMYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:24:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:24:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so2867343wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRCL8CXLlmFTGIYCIJvvzGt8RhcbFX8onxSEFC39pLg=;
        b=bPWrV2L6zXSCAka0nsq3AXmYmStWPCZOw6FqAC3Wi7Fj9VB6Wasl5uEkFWjml4tfCk
         9Ib74vYOV/xcE6mFhtqdgFzLJBpzEEwcFMzR2XGSXsr4TJ/dBgmPwqWLtUgCOxM/kT6o
         LhT8Oi8Eetck6727TSDRwaxnHG2NU3FTlCPU6goueVSnz9qjuxoEJnMFLvAuep/D9NfS
         TevHeta+AenlMWl5o0n9DY0UzVZdNd+Sy5xUuYrLMczRj10UILpFODrzfKaU8OEPPo7S
         UfFlQPkeohFBFw6hnpBSxPyXq57RterAp+bSy4D50/l+YarAzUI0M51qqf5wmRAL8VD8
         myzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRCL8CXLlmFTGIYCIJvvzGt8RhcbFX8onxSEFC39pLg=;
        b=ELWx3Pg4em/D2+CDO0SoJlAkOlZ5qTfLHtU+oZ2JQSyKnXrxnJV28mtFNkDGoIEIt9
         cYakYWzrYUDOuWXPVVIXv60OqvRapgtn4LwCPwN3bGSXKVNUuTjQzCVg9yu+B9rC/byL
         6IaShQqhpFjyKPuuLAz+z+qW5YdD6DvPB/FYxPIq5MXMqxlufjEjvxabu86FMPTTEkIH
         bJBCC9siMk+9M59Y0s6guNN+xiPK+JeMzdo5ojE0LlIpaV9joCXHswn14KgTHveuzg9i
         nDWE6QllqbWyVu1zheFPnidGXhm51QQGst3bmh2wQkOs6QK+O4h6Vis9Nm0vIoeL31kj
         FWFA==
X-Gm-Message-State: APjAAAWPwUIIaG0fKRjepjbjWoZNxyeMqFVleJG2QwWTyTaTYGGKEfUJ
        dWTOtzGl2jbk5V2u7m1mVA+ewOCqZ8G8+7v2oTRNaQ==
X-Google-Smtp-Source: APXvYqznG0VbuLKScctM26duGop+x5oKIy8U/BxpchFYBRD/Ti2/Zk+F2VZOrzfyUjgQ8M1dxPxvSzT6kL/j40OwWok=
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr17531764wrt.208.1579782249072;
 Thu, 23 Jan 2020 04:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20200114141647.109347-1-ardb@kernel.org> <20200114141647.109347-2-ardb@kernel.org>
 <0effdeeeccdb9544cc69f185fd23cd06828ae8fc.camel@linux.intel.com>
In-Reply-To: <0effdeeeccdb9544cc69f185fd23cd06828ae8fc.camel@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 23 Jan 2020 13:23:58 +0100
Message-ID: <CAKv+Gu_4Y18CF-h36JKKJrcdvUL8KM1YSbDTgED7kurgN6xk_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: tpm-tis-mmio: add compatible string
 for SynQuacer TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 at 13:22, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> > Add a compatible string for the SynQuacer TPM to the binding for a
> > TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> > slightly differently on this hardware, so it requires its own
> > identifier.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > index 7c6304426da1..b604c8688dc8 100644
> > --- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > +++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > @@ -12,6 +12,7 @@ Required properties:
> >  - compatible: should contain a string below for the chip, followed by
> >                "tcg,tpm-tis-mmio". Valid chip strings are:
> >                 * "atmel,at97sc3204"
> > +               * "socionext,synquacer-tpm-mmio"
> >  - reg: The location of the MMIO registers, should be at least 0x5000 bytes
> >  - interrupts: An optional interrupt indicating command completion.
> >
>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Someone else needs to give reviewed-by as I am not expert on DT bindings.
>

Cheers Jarko.

Rob's ack should be sufficient for this to go via another tree.

However, I am still waiting to hear back from Masahisa to confirm that
the SPI command sequencer approach works 100% on this hardware, so
shall we park these patches for the time being?

Thanks,
Ard.
