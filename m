Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23A92075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596811882;
	bh=GtxQUSKT1X96i+MH8TbBld412JSil7Bjc/gO8cpknGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RIJRGHL75UeTYZK1xYBTAaUSJSJnAJlK2Gh8gSVnPxIR+t7g8cOlKTJnek6sJNIW3
	 jiZBDqlc78Ord4/z3JBMUHxQK09JgQn6PsxKR7pCyNS5vlqLTy0ed431C0OTEXQSt5
	 GIits2Qlem1uRQF9W2SddQdnS8EWhvGHEqZiyDOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHGOvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgHGOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:51:13 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3562075D;
        Fri,  7 Aug 2020 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596811872;
        bh=GtxQUSKT1X96i+MH8TbBld412JSil7Bjc/gO8cpknGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z7kwa10CwRgjBbI0D+XhoJjmqonW7PubkJXY0+tI2NCi5UZbUoFTmztWuOokC0ZLw
         Le+oI17nNcDBkiFI81fFh3E0dcfs9bJRzxPjaMFWpGSGLmulVziYeZQFjSrRNFT3Cf
         cNMRVVTTuDZTA3fgy1mYPpx27u4p1ryAqHEXUUmk=
Received: by mail-oi1-f175.google.com with SMTP id l84so2112684oig.10;
        Fri, 07 Aug 2020 07:51:12 -0700 (PDT)
X-Gm-Message-State: AOAM531QA7pfbSExFUAG3PV68PbC/ld8Toxoe47wrewAU35bcU70HPl1
        sI9cGR3hNlspdZu89uZ3tfL5mfh8+8TtfDwsRQ==
X-Google-Smtp-Source: ABdhPJzVlQPsijU2HYarRxphJJUVYNBzdoVdIPIsY8KlTginPw3B+qvmkby+kzYCLtt9HJBLG9aWsVdjUnfuAkS8/5o=
X-Received: by 2002:aca:190c:: with SMTP id l12mr11745091oii.147.1596811871568;
 Fri, 07 Aug 2020 07:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200727031513.31774-1-xiaoning.wang@nxp.com> <CAL_Jsq+M0bjH6KnrT4ob6YF7VZxUtgUeAJOE84Omp4PNH2hSZQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+M0bjH6KnrT4ob6YF7VZxUtgUeAJOE84Omp4PNH2hSZQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Aug 2020 08:51:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+vchPP3fJaqx4N4qYFc-w8-BO6FDgzTBKDhN0vYDN9g@mail.gmail.com>
Message-ID: <CAL_JsqL+vchPP3fJaqx4N4qYFc-w8-BO6FDgzTBKDhN0vYDN9g@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] dt-bindings: lpspi: New property in document DT
 bindings for LPSPI
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, Anson Huang <Anson.Huang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 11:38 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sun, Jul 26, 2020 at 9:15 PM Clark Wang <xiaoning.wang@nxp.com> wrote:
> >
> > Add "fsl,spi-only-use-cs1-sel" to fit i.MX8DXL-EVK.
> > Spi common code does not support use of CS signals discontinuously.
> > It only uses CS1 without using CS0. So, add this property to re-config
> > chipselect value.
> >
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> > Changes:
> > V2:
> >  - New patch added in the v2 patchset.
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > index 143b94a1883a..22882e769e26 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > @@ -34,6 +34,12 @@ properties:
> >        - const: per
> >        - const: ipg
> >
> > +  fsl,spi-only-use-cs1-sel:
> > +    description:
> > +      spi common code does not support use of CS signals discontinuously.
> > +      i.MX8DXL-EVK board only uses CS1 without using CS0. Therefore, add
> > +      this property to re-config the chipselect value in the LPSPI driver.
>
> This breaks linux-next and you didn't test with 'make dt_binding_check':
>
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml:
> properties:fsl,spi-only-use-cs1-sel: {'description': 'spi common code
> does not support use of CS signals discontinuously. i.MX8DXL-EVK board
> only uses CS1 without using CS0. Therefore, add this property to
> re-config the chipselect value in the LPSPI driver.'} is not valid
> under any of the given schemas (Possible causes of the failure):
>  /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml:
> properties:fsl,spi-only-use-cs1-sel: 'not' is a required property
>
> The problem is you need a type definition for a vendor specific
> property. In this case 'type: boolean'.

Ping! And now Linus' tree is broken. If you can't be bothered to fix
this, perhaps it should be reverted.

Rob
