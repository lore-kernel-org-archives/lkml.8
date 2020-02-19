Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4693C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2382176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582120476;
	bh=pZWh7elbnmiV7gJ/AjqZyG8cWHBS5zE3C38XtoAFYJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JyVpab1R2nykA4mrvYo/M6A67IjqDXKZ7kSQR0p9fUpH4PA8FF9r5Z+qjWg5XRPlM
	 PhbrBpj6OBVFl0X1pWtK3V7vU5xTgTqtLOWOZ4VetqbmlK6bqzTWqwbvrMV48H30pk
	 ULQV5D+XNKgtRGpsRlw39kqNWe3FzroIzSZhKOYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBSNyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:54:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39343 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgBSNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:54:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so23844606oih.6;
        Wed, 19 Feb 2020 05:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9M75KITIRI2fIyzJ9QLJNNG7LlFCUvrsVp2MLwGj1Cw=;
        b=LqkaPc/ypRNKhAuFQgXDYGzaDO+zdqP10HAkEodZLLlKG3SbzipeHqQJrCHNd27Q+9
         nxskLQev761lzl42vhWXwiU0dmJQJApo13NYNnOmnSbWIacIAHltO0Casz/vDJ/aZOMa
         4YW3dzsyoXMrmXOjrBH6tjYJo3xIesO4eMkUQNACFrND8qxAQCY3WKMVdhlcQ34Mm8OD
         rQPlBB3r70pYtYphK8+eYOmXEl2CHm+BcBCCts2QY6VpqS0MYM5HgHBi/vvNnDCVwrJ9
         dMfpFnBy78aA+vn+B5LvKbPtJnUbPQogZZIz5EejF9sumyLqu2rUzWU9azassVgJcRYX
         Ai+g==
X-Gm-Message-State: APjAAAWmzc9NMLcLnr3TUelpSZkQru4uxmtx1WzGTb+Cpxb3WJPH3SOF
        /ilvq4QL/jtbHJS6c6ZIbw==
X-Google-Smtp-Source: APXvYqxgkdnhXnfTH91w1CcgAgn8QY+egrxCu7nYqMzFGcTKbBJz8JhR7QEK1WiYhqYJ7Dht+Fql3g==
X-Received: by 2002:a05:6808:18:: with SMTP id u24mr4722231oic.10.1582120472746;
        Wed, 19 Feb 2020 05:54:32 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm644661otq.64.2020.02.19.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:54:31 -0800 (PST)
Received: (nullmailer pid 18549 invoked by uid 1000);
        Wed, 19 Feb 2020 13:54:30 -0000
Date:   Wed, 19 Feb 2020 07:54:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add YAML schemas for Intel
 Combophy
Message-ID: <20200219135430.GA17628@bogus>
References: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 11:31:29 +0800, Dilip Kota wrote:
> Combophy subsystem provides PHY support to various
> controllers, viz. PCIe, SATA and EMAC.
> Adding YAML schemas for the same.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v2:
> 
>  Add custom 'select'
>  Pass hardware instance entries with phandles and
>    remove cell-index and bid entries
>  Clock, register address space, are same for the children.
>    So move them to parent node.
>  Two PHY instances cannot run in different modes,
>    so move the phy-mode entry to parent node.
>  Add second child entry in the DT example.
> 
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml: properties:intel,phy-mode: {'$ref': '/schemas/types.yaml#/definitions/uint32', 'minimum': 0, 'maximum': 2, 'description': 'Configure the mode of the PHY.\n  0 - PCIe\n  1 - xpcs\n  2 - sata\n'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml: properties:intel,phy-mode: 'not' is a required property

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/phy/intel,combo-phy.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/phy/intel,combo-phy.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1240526
Please check and re-submit.
