Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F257020768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597436239;
	bh=dE/nZhvxWYeZCBydsXwZUXsRq+k+LkliB7aNsno/FDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VjB1bIZNCv34QgM09Ft9uYZ3uckfFQs9XSXYrbg36oQvy5CoT2biCkDTsGd8NGOY1
	 1c0f/rcw+xCBRLuQBe0EA2aZG3VpozKBYvSyD8QECpPa0DQ6B7+IZemmSK26eI3chU
	 UsWOp2GP0BOM4NZKevaLuYPnFAIYsK5TD2wYmIc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHNURR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:17:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45650 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHNURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:17:11 -0400
Received: by mail-il1-f195.google.com with SMTP id k4so9483379ilr.12;
        Fri, 14 Aug 2020 13:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNoeq/3cmPqVA+RIc35kN62jsibVvRZS7HT9CMV2TpI=;
        b=EMj8QtEfFDFURBmWLITfDvCjZGo5MS61u7qQjb6ICX7bE8LU06xtX6IWww5Wbkqc8T
         LaUdKk62D7OkRy6ctveDKvicyVC2fjLckzxd7eCQtfEfJV4Mu3T5I/vI2b4X9xIIrpOj
         4rXJN5VSSNdx4RFM+9F1OE/jjElanpV40aUphnwNlhv6+MNVT/xjdLAYiC6uvC2b1l6U
         /W2QJ2PBLLTnwWbrCpC6uafucogPe7OUIe/ElcyBmgli+XComwUGF+IEY1L6JHHqzndL
         f5cB/vEltX6IZprnp3HReXdJg/fYzmjC7e4YTd3PcLULAMq+7jcG6v9l/JIfIYTXOl6X
         RgWg==
X-Gm-Message-State: AOAM530QWPlUmlNXTTmmEtgL4VUT8C++pcHFcmsYAEmV4M6+DKJGQen+
        Xo9CqkB09KWz1fi/Kse4Tg==
X-Google-Smtp-Source: ABdhPJx7cbnCdcYvPSQ4Xc47+5JkFamz29Xm/VhyWl5MfiI+mx8d4VSx2QHQtGasdNGDyDgJPkxgug==
X-Received: by 2002:a92:d786:: with SMTP id d6mr3892576iln.144.1597436230765;
        Fri, 14 Aug 2020 13:17:10 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id l5sm4883891ilj.88.2020.08.14.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:17:09 -0700 (PDT)
Received: (nullmailer pid 2668367 invoked by uid 1000);
        Fri, 14 Aug 2020 20:17:08 -0000
Date:   Fri, 14 Aug 2020 14:17:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     mauro.chehab@huawei.com, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linuxarm@huawei.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 43/44] dt: document HiSilicon SPMI controller and
 mfd/regulator properties
Message-ID: <20200814201708.GA2665752@bogus>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
 <da65a508d01aa2092999d0ce7e9c061ccfd24036.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da65a508d01aa2092999d0ce7e9c061ccfd24036.1597247164.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 17:56:53 +0200, Mauro Carvalho Chehab wrote:
> Add documentation for the properties needed by the HiSilicon
> 6421v600 driver, and by the SPMI controller used to access
> the chipset.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 182 ++++++++++++++++++
>  .../spmi/hisilicon,hisi-spmi-controller.yaml  |  54 ++++++
>  2 files changed, 236 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.example.dt.yaml: example-0: spmi@fff24000:reg:0: [0, 4294066176, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1343770

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

