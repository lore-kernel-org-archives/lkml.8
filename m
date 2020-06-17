Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2205C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B812065F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592413255;
	bh=+6FAVvETN9cXUaIf2Ch4zxlq0PC9s85Lpx+1JU8dRTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GrZnWye1R3P6sE3KpRBNIoFwoBj9zr+rZaf0ui9sKQusR436DiKF/ibSbElYio8kY
	 wW6L3eHmRb0DgDSf9q5pW45dsztOnt+CELwSHj8VAsqChTHqKLozbFSq/TkKQqkMsw
	 dVQntyou6MnaKPC2aQo7jLsBmrJf6L9sV/BQtwdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFQRAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:00:54 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38993 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:00:53 -0400
Received: by mail-il1-f196.google.com with SMTP id p5so2887164ile.6;
        Wed, 17 Jun 2020 10:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iHARdombLlcAcKc9BvTzg31LsiHLp+VSmuiTEXi8TqE=;
        b=mQ+t3UdUYak3ZcigpjEWvFyV1g0sDILfxiU55WzBic3KyxUglGi4U3bWq2ARhLDsJU
         vt5gLuiUWBIAcgYFd9upDGpE4cL4mGwGK+HvgWxZj/HqTTzpGk8K6KM6Py4t9ZxZ476Q
         cC/fJxTLWADE7TGFvVIqFG4yh5NkQvRqpPTu463cNRv5xt2Y+M9OhekcvLpw7K2lSrtK
         6nYbA8dsaPM+V1HkqgvsFSbp4r+MLNsTFyBPqihAg9LhdDJt7xQzxxX/QttzoNUR7i94
         eHYl8Tg7hz0mkeDshDxE1uZaHfpe1Z2DG0rPBmT12Z1ciPJR1tvKRODfjZhSzg6JXLn/
         LeOQ==
X-Gm-Message-State: AOAM533XHLMD4iIZ4A/NEEs0Ya0HGPE12kJ4ZwVEbwGVxd9YeWF0GT+/
        r6p+EjAbaKuzAnSkD5Qy+Q==
X-Google-Smtp-Source: ABdhPJwtWwzz4EpNf5TPGNmFr6G7s6TFe37pZYgCZV+kvAqL/KT9PQQ5xQQKPUaApsS1CUlGt7VQXA==
X-Received: by 2002:a92:c941:: with SMTP id i1mr8652392ilq.94.1592413252645;
        Wed, 17 Jun 2020 10:00:52 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s71sm113785ili.44.2020.06.17.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:00:51 -0700 (PDT)
Received: (nullmailer pid 2304140 invoked by uid 1000);
        Wed, 17 Jun 2020 17:00:49 -0000
Date:   Wed, 17 Jun 2020 11:00:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     vkoul@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        simon@fire.lp0.eu, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, krzk@kernel.org,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Message-ID: <20200617170049.GA2303867@bogus>
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616083408.3426435-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 10:34:07 +0200, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.example.dts:22.33-34 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1310130

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

