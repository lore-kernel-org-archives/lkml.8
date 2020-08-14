Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F8C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F001620771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597437317;
	bh=L/3DYyfktU8B/cezz0etPQuAUuoDwhrqFRWdcYI48Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UeixtwKSZdusLqrhZaAezgdNIiGGCjV5AaxQmdgGyL17Y7Y67EU41AxDYzwAKeerl
	 dsfImSLSrGKMmeXnZHVr93vOa7Mh1vyl/aELH5zU8K4lRuV+munGiH8cuXae0n8DL+
	 DSpTS9iYpzrJN2u5x9ioVXngqrvPsUJgHKUmVXKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHNUfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:35:15 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36669 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNUfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:35:15 -0400
Received: by mail-il1-f194.google.com with SMTP id z3so9544354ilh.3;
        Fri, 14 Aug 2020 13:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7VJwYAXFZ6Ufn7CcoYq556rpEmGdS1leQGrqebgoaI=;
        b=T1FHWVTBjk6CeFIbOvMtoJCgXSioHSQWLU9E9NIIWE6B1e71ZnxThwDyFJw4EtMDvm
         ftMyLMnpK96JvIn/MTBamvFSUNM1wPfI6b46kimJrHw3M7EwbEJiJ+ODKyeAw8Jep0CJ
         7LJbRAIa/Rj4vRawpkou3Gjm64cacco5KELl2CN7Z7Z4hWMc2ZOzqAadzSZfSvBOjBOE
         uhXSwwXhyoBQMVh83ieCKHJ8IQxH9LyZA4zExgrOOWw94R/ESaGFS2ypd83+qsWkMDWs
         VnZ9RhfeGyUR8/Hdb+j/KXbllT8mF5aC0nzlLwkcggnetzuA7YRag2LDUh7esdjTWkiF
         3Jww==
X-Gm-Message-State: AOAM530W2psN772chsXvKLVdDn0q22NgtM4IoQkOoq93q79mH50LrCbg
        uQtEk99kH553cF8cZTNrfw==
X-Google-Smtp-Source: ABdhPJw7lbUSWmXUBct7QfLqwc7xx86eiX8VrPJdFiFlp0rBR/0A6M7+NRHhaYEjlhvwIOQ8MSxSrw==
X-Received: by 2002:a05:6e02:14cf:: with SMTP id o15mr4018343ilk.239.1597437314081;
        Fri, 14 Aug 2020 13:35:14 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id l19sm4571121ioj.37.2020.08.14.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:35:13 -0700 (PDT)
Received: (nullmailer pid 2726996 invoked by uid 1000);
        Fri, 14 Aug 2020 20:35:12 -0000
Date:   Fri, 14 Aug 2020 14:35:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     devicetree@vger.kernel.org, cy_huang@richtek.com,
        gene_chen@richtek.com, robh+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: rt4801: Add DT binding documentation
Message-ID: <20200814203512.GA2724480@bogus>
References: <1597418824-15906-1-git-send-email-u0084500@gmail.com>
 <1597418824-15906-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597418824-15906-2-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 23:27:04 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add a devicetree binding documentation for the rt4801 regulator driver.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt4801-regulator.yaml        | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: additionalProperties: ['enable-gpios'] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: additionalProperties: ['enable-gpios'] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: additionalProperties: ['enable-gpios'] is not of type 'object'

make[1]: *** [Documentation/devicetree/bindings/Makefile:19: Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1334: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1345081

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

