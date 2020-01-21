Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DAF24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579629633;
	bh=f63fWL0gfswfCgDyROI3UH+hAceNmDOuei+FtTK247s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HnZaZQtduHgRTavi8x9KhAOIWEkDB71Tr7f1nMTl7Dj72KC0uWhBUogTKvZLa1Oq6
	 MxrzHnLRtuVoCZ367+Ra7uJoucffN+Ga67C4+iOvegASZ/Zg11M396vW0dHDhqVAf2
	 bpkVBJHaa0M5DRegmhP+OCnieaKVvNVH3Rtx0Sog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgAUSAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:00:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44903 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:00:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so3396803oia.11;
        Tue, 21 Jan 2020 10:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SoGNpAAYd8DkgVCg9hs0SkAVcBA4n3ThwNDs+CIvNyk=;
        b=t+ezNWbDC5rg1Nq+ExG1kGjBJcafOCVblECPp0CIoK76CAGe8Eh6yi0npLrNWcDY8+
         oJgsLkJpwJLYOM7Y2B9fqbA4D1T651YKEeKvT1kkTUcM7uHyGHr8mxWz7VCQAT4ycPMb
         wJA2MAVJE2Vx6fgsFnsp2yIKTbMzQCSaibqT7uqb12udcksObCTNCLpdHUbXH0C0bgQK
         jFlavRPNv43pVt/j2Xx9eOAmYbjEdiqORWFA3XLLWtadvIhMsttw3BwrjE2Yzg1UnScY
         0Jgni9ixVNGXfVn9Z4utvb9ekvJ5Y9Kov0+qUvab/TF6Duuse+eNdotZ/e6TKzFwsPJP
         qN4Q==
X-Gm-Message-State: APjAAAUYzYZkibj7sBeXwWMPsCoys4N5XcPDaKMugGvx+zMSiYcA4GHt
        ghdPtagfJ29TPp6roAC2fg==
X-Google-Smtp-Source: APXvYqxV/jfzDtlEscsmucJbThOSjtw0N+fNnRo93t5V2zWaWVxVOSgi81r7XVL1s+pZoFyxAk9rlg==
X-Received: by 2002:aca:e146:: with SMTP id y67mr3739978oig.93.1579629631200;
        Tue, 21 Jan 2020 10:00:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83sm12139907oif.33.2020.01.21.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:00:30 -0800 (PST)
Received: (nullmailer pid 362 invoked by uid 1000);
        Tue, 21 Jan 2020 18:00:29 -0000
Date:   Tue, 21 Jan 2020 12:00:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: Re: [PATCH v4 2/2] hwmon: (adt7475) Added attenuator bypass support
Message-ID: <20200121180029.GA32498@bogus>
References: <20200120001703.9927-1-logan.shaw@alliedtelesis.co.nz>
 <20200120001703.9927-3-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120001703.9927-3-logan.shaw@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 13:17:03 +1300, Logan Shaw wrote:
> 
> Added a new file documenting the adt7475 devicetree and added the four
> new properties to it.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> ---
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/hwmon/adt7475.example.dts:19.11-24: Warning (reg_format): /example-0/hwmon@2e:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/adt7475.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/adt7475.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/adt7475.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

See https://patchwork.ozlabs.org/patch/1225573
Please check and re-submit.
