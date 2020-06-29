Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7E0206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467929;
	bh=JaTM7OpwurAOBBFLTAzbnjTnVOjccL2UK9UeapBg/7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bGpOKRxyTFgtVCa4mJXeZ3zErro1Z/g7WYBA9VudPKfD6mPeb+eD1WBHJgNOnQ0HJ
	 NCkfj675GN2oDqUEpWte1ll28cUx3vAELJ+wuFWJxrqBR6JSUU4UoBYFouiJyiQhid
	 eVwllKnnng1m2hcBwUXx/BrYRNM4CRXJE/Fk3Gr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404770AbgF2V6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:58:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39213 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgF2V6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:58:42 -0400
Received: by mail-il1-f193.google.com with SMTP id k6so15862732ili.6;
        Mon, 29 Jun 2020 14:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QT2CxKngMlY2p6AbcTTZAUqsEvoLy2nz/okkRGauIc=;
        b=lUp/19A7OQSUweoHI2QEAowtTQzqfc2lloX74hWdQME3l6d04TbFg9uaAKJkEZgTVG
         P7rRIS3F1R3SShw2kyEAjSVL1YDPeDbfIIByNwf7RDW+95blrcRu77A1x3i8+17nEcnC
         dbE89/8fqM8FS09XGD4CmFtwIv4J6sqSYfWax0HsIbPwSsiQ6nozeoZOLRMnM/FGIUzK
         6rObPbd7dfRmV1z6ZoxJPXRYrsZ779rSrLHnVldNMrboR5+CruKN392Zwk3QGqMl9fyx
         Mi01wCC05p7NADXAB8xJBqQ0qe9jwRmPii4L2SvQWKO1X2dkdmLRwIK7cDDIwh2/QgpC
         CBZQ==
X-Gm-Message-State: AOAM530kYFx0mchKQIasRRp81PyQLwgO3FrzYBgB7Ly0JozI8yel7UsC
        2vtxG2ldVr1x3oQZ0bh+hg==
X-Google-Smtp-Source: ABdhPJylefPN6e1fWTB8vAdKMAzJZl6DuCBfuuXfmf35nWeNuXIU1oLVRKCxPnf1E3+V6I0ZxzpOqw==
X-Received: by 2002:a92:bf0c:: with SMTP id z12mr17464216ilh.151.1593467921338;
        Mon, 29 Jun 2020 14:58:41 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id b8sm669748ilc.42.2020.06.29.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:58:40 -0700 (PDT)
Received: (nullmailer pid 3006922 invoked by uid 1000);
        Mon, 29 Jun 2020 21:58:39 -0000
Date:   Mon, 29 Jun 2020 15:58:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     kuba@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        davem@davemloft.net, andrew@lunn.ch, mark.rutland@arm.com,
        linux@armlinux.org.uk, corbet@lwn.net, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com,
        f.fainelli@gmail.com, leoyang.li@nxp.com, netdev@vger.kernel.org,
        madalin.bucur@oss.nxp.com
Subject: Re: [PATCH net-next v3 2/7] dt-bindings: net: add backplane dt
 bindings
Message-ID: <20200629215839.GA3004274@bogus>
References: <1592832924-31733-1-git-send-email-florinel.iordache@nxp.com>
 <1592832924-31733-3-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592832924-31733-3-git-send-email-florinel.iordache@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 16:35:19 +0300, Florinel Iordache wrote:
> Add ethernet backplane device tree bindings
> 
> Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
> ---
>  .../bindings/net/ethernet-controller.yaml          |  7 ++-
>  .../devicetree/bindings/net/ethernet-phy.yaml      | 50 ++++++++++++++++++++++
>  .../devicetree/bindings/net/serdes-lane.yaml       | 49 +++++++++++++++++++++
>  Documentation/devicetree/bindings/net/serdes.yaml  | 42 ++++++++++++++++++
>  4 files changed, 146 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/serdes-lane.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/serdes.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/serdes.example.dt.yaml: example-0: serdes@1ea0000:reg:0: [0, 32112640, 0, 8192] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/serdes-lane.example.dt.yaml: example-0: serdes@1ea0000:reg:0: [0, 32112640, 0, 8192] is too long


See https://patchwork.ozlabs.org/patch/1314386

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

