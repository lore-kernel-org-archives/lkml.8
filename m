Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361BF206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589461033;
	bh=zHCbr/QbRr14tVkV4ckjyaXGd6D5umIjx7AjGuz1QGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=djQSAVTR0e4pETSfgXiJIDxv/Ve6MbLXkByxPtaRGqw7mdhWIHrp9KTeH0/U8J09U
	 pR4Ajou1Y1E7lzUfe1K1AYzGDvG2qURe6S1IlKVpyJwEhDJsuTgUy2MxSc8RDjKDDj
	 CEVxNt4+coSS+PaJCyTIgL39IPGqlPqjXl4XXNaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgENM5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:57:12 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:37638 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:57:12 -0400
Received: by mail-oo1-f67.google.com with SMTP id v6so689934oou.4;
        Thu, 14 May 2020 05:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cznThrffsFgz6B9IAhrsH7SLC/KaQFz2r6H5JGNHjEw=;
        b=gg0/S2H0T8nNuVW5GCasfWCZVASdjG4H3Q0efKjW6AzFIpCNVYYP+2MfONt0CXu/YO
         llB72Euv06rHa46IDFce8/ahrFaObXEM9SLeUOp3awEfIkz+eiJ2NXuVtCW87F76DCEd
         ba3LiVHupzQSis2u7kp4jtwj4B/Uvp0VWWhNBxO4N6URCoKxKKNyE2oWhCDjL5xlZXG3
         ufME/en+BWc/wZvDlXL+lWpvau17LhYpTpq0oFlI2DIOcV5rg1N/glGBwp+lSVdtuOFe
         jvaUs9iHlYYdMo1LJTyGLspkcHNK90RUIm8oeAE1XyrHZ07bjvdNYL99CzPT5sAWIepr
         ygqA==
X-Gm-Message-State: AOAM533eQFv/IbFweYbmwavaxS9tw6xjO0jedoILA8V0dCv2YLsQclpo
        r9FH8lGYhGL8ETAmkSircQ==
X-Google-Smtp-Source: ABdhPJzJFnI8dx+4vT5VS+q5CsLxvOGqaL8uj5bcWi9aigZyaLxKb2Tzizwj/Je2B/ONKpZCJxmmjQ==
X-Received: by 2002:a4a:accf:: with SMTP id c15mr3354139oon.29.1589461031007;
        Thu, 14 May 2020 05:57:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l2sm6690090oib.58.2020.05.14.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 05:57:10 -0700 (PDT)
Received: (nullmailer pid 8973 invoked by uid 1000);
        Thu, 14 May 2020 12:57:09 -0000
Date:   Thu, 14 May 2020 07:57:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     masonccyang@mxic.com.tw, linux-mtd@lists.infradead.org,
        richard@nod.at, boris.brezillon@collabora.com,
        brendanhiggins@google.com, tglx@linutronix.de,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        anders.roxell@linaro.org, arnd@arndb.de, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, linux-mips@vger.kernel.org,
        cheol.yong.kim@intel.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: Add Nand Flash Controller
 support for Intel LGM SoC
Message-ID: <20200514125709.GA8436@bogus>
References: <20200513104615.7905-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200513104615.7905-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513104615.7905-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 18:46:14 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add YAML file for dt-bindings to support NAND Flash Controller
> on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/intel,lgm-nand.example.dt.yaml: nand-controller@e0f00000: 'dmas' is a dependency of 'dma-names'

See https://patchwork.ozlabs.org/patch/1289160

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

