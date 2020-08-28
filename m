Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0BC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F93220714
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598652094;
	bh=gZ0mooOz1r53V6DiPWW+cuE2PS0TlZqR2zta5+JWO9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dt6GvK7BpADYblRvd67XDHbsONt94rYVkYtlczqBq3aoPMYNI2n4tdMRKcO6aitML
	 I0qw0q6NOMGGvoJnoQSPwIMgaF82lDAaBY4aDkv/zwAeSjrMa0NdtzFkwmtglhwOTO
	 nAA46TsuwRSM8Nt4esNctfqur2pzvSn2UgEFYFA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH1WBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:01:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1WBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:01:31 -0400
Received: by mail-io1-f67.google.com with SMTP id u126so521618iod.12;
        Fri, 28 Aug 2020 15:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKWgd3SJ7Z692kwaI7suCPBIhgU2p/HMGZCVVZIzdNg=;
        b=sC4TIW8RHZleIsJYu4gped1zDlnvDbHCZgGdxOKvas0HzeYLx6JsZJDMT8nvUZixH7
         Lssx41dANhVXvbfP+jLN0DpZ/tLklOzxpSiXxdAmnTXCpbIY5FDuNj2K07nMBslUgHBi
         1vZ63FdJYjo2LR0FzlMmOWbpIUeSpBwx37dk7Qbh6OUkNOlNei1NWT/dm1/tbK7w36LU
         EH480wOP8yUL4wKgCjATw9dwQVSAwuFrOF494sotNQiLQFKMm/fZoXb04MHUO+YHsoMQ
         jqoQHBI9QfP3sxpJaUNbvfi41I8NIcJ7/oKdVESlERvVGXA92T5DmkzPtg23xL+He9QB
         iPHQ==
X-Gm-Message-State: AOAM532U7PCRG9qOAGye+onuewjTRgF5vPo8Hdrc0Vtp1FQtoCBlD5Op
        OxepUpqesgwRFQZa21uXPi7xrLHc/CVd
X-Google-Smtp-Source: ABdhPJwj523pUjRwerNKCo6en1OFpKtZ0Tg0W6kYGiNT+/Pb3YNEdImH3dRht4Wp0X63jbEU8A3DKQ==
X-Received: by 2002:a02:630a:: with SMTP id j10mr2997982jac.24.1598652089991;
        Fri, 28 Aug 2020 15:01:29 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r2sm312769ila.22.2020.08.28.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:01:29 -0700 (PDT)
Received: (nullmailer pid 3481209 invoked by uid 1000);
        Fri, 28 Aug 2020 22:01:26 -0000
Date:   Fri, 28 Aug 2020 16:01:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: fsl: Add binding for Variscite
 Symphony board with VAR-SOM-MX8MM
Message-ID: <20200828220126.GA3481139@bogus>
References: <20200824191819.11057-1-krzk@kernel.org>
 <20200824191819.11057-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824191819.11057-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 21:18:17 +0200, Krzysztof Kozlowski wrote:
> Add a binding for the Variscite Symphony evaluation kit board with
> VAR-SOM-MX8MM System on Module.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
