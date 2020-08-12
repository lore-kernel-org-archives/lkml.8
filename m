Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9242BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD22076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249609;
	bh=6GeFowFwyF1Id1omR15S7XrREvUVZ76ncyOGmrAlumw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1MSnbYeWeAZxEvc6eVd4pwmhnF5KaXszt0Pn7aSjLkvPYqh72ZTPDu4fuT9YYnXLr
	 DtUxhGQr/t3/1sgg51nUriX+JS7TlekI4h6iD46kqJLKfUIDgrcOkb+QuRtBA1alPW
	 Z/8EpYWsJPdZUVhbWxRmgob0uMw553vAyPU0pnBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:26:48 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40321 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHLQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:26:47 -0400
Received: by mail-il1-f193.google.com with SMTP id x1so2309194ilp.7;
        Wed, 12 Aug 2020 09:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XENcqp5NrNjQoSRzJJCCLGVKZPXfg/pQnllGIbHBK8=;
        b=DHKH9OYxsZHtjM3DgTzit+SAhhcZ7wpb05GjBsgTPiBB/7GuCuBIDUYBCDRf75RGcg
         V2RvPdPaJISS5KV57T88mIbsp/qjfTI16cNuxR/0zfGx17fnAfVPaGuURs0tJufQV//X
         Nwdb4Yq8M7/NYsSF+mCtZw6BHTIuPvcN3sPYvFiD+b2Q50I9I716Efg0BX++lzW/AjEm
         WXbkgWBgbJsWMvgEBK14inSeAjkbDApHE7Dac/JEMfIRdz2dZB1VW74tY16MulUUmR98
         qYN1SFOdIqzdBoehQ2OLw03gTPsCPZ7yduRfzHSSQww5/nw+8RJ8fPHUAwog01fWcmtj
         jjDA==
X-Gm-Message-State: AOAM532wcG3n/h4YmGvcluSzJO8tjyZm/6JNxs4JjoOGdtqslsuz4Q1Q
        QvHfnXt9MmkgtFhwliUDug==
X-Google-Smtp-Source: ABdhPJzw3ALSwlMKyv/dYVMNM2FITk24C3hhy/zhgjPboTGUxsrWp7MleX8TrJ+Qm1QYD5emSx5wCw==
X-Received: by 2002:a92:40cb:: with SMTP id d72mr481292ill.116.1597249606463;
        Wed, 12 Aug 2020 09:26:46 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t26sm1327563ilb.80.2020.08.12.09.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:26:46 -0700 (PDT)
Received: (nullmailer pid 2320844 invoked by uid 1000);
        Wed, 12 Aug 2020 16:26:43 -0000
Date:   Wed, 12 Aug 2020 10:26:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, jsarha@ti.com, vkoul@kernel.org,
        tomi.valkeinen@ti.com, yamonkar@cadence.com, mparab@cadence.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
Message-ID: <20200812162643.GA2320575@bogus>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
 <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 12:12:45 +0200, Swapnil Jakhade wrote:
> Torrent PHY can be used in different multi-link multi-protocol
> configurations including protocols other than DisplayPort also,
> such as PCIe, USB, SGMII, QSGMII etc. Update the bindings to have
> support for these configurations.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 76 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 18 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/phy/phy-cadence-torrent.example.dts:93.38-39 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:330: Documentation/devicetree/bindings/phy/phy-cadence-torrent.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1334: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1342193

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

