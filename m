Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D513BC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA552173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582057482;
	bh=5f98cBuHe/a1fe/SI4s1hmsWb7iBUYv/dCU9M1zj2/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IfdXdplucpZj5f67RTaRr37kMLm74n7oLM3Iis7yIokdaYdjAteDHrnko5n1isDX2
	 XYdokYI4LmZkuzTAgU6jGCFsF08QmOlgB6rI64kUvE8hdq4hqZBct+k14O+N6rAXvi
	 FxtyDqIqi+c8IlIcC9+M3i7vYY7THtSaGejUTddw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBRUYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:24:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44894 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:24:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so21422725oia.11;
        Tue, 18 Feb 2020 12:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tO19nIckNkDU5JzuGmfbb1T3kIAPq1F96qlDELrXEPQ=;
        b=YqbQ4XGoim0kYtlIQpOTu7pFKX5oP0arTkOTmIyXGgXV0OW25ro5shIRcDel8p+Sr+
         VXJpD5MptyQ/LIo56gkPXEOYBMHUxtwf19PgWepDt84zfTKgVL7CXIPnr7c2mlya8Bz2
         jBrF0/nlnrP9qxUQCV08Jzb/yuHpwTqM8y36XZyhhXoqYxU49lxiGEUFQ8ffn3SQdWJm
         5wl9KG/wNWQRPTzSnthJb9h1rWzMJCD3DNTJrZhDAsJY2/y16cuX1+4YwM8g+8BrWBve
         k6KrNLOInog4wkCzb5gaw2JIkkD2I/nYk78jkxat6KndrrOLyWH2Zllntdjw0C8LmdHK
         eKfA==
X-Gm-Message-State: APjAAAWAhy6tTnnvGXMJnaEIADZ8z+qvtIPasm+qChXL521vqYdpbFty
        X1hTuYKpnb6WdDqFZ6gxjQ==
X-Google-Smtp-Source: APXvYqx1k9+vtqpJhauuPUQGR/hJ0ExvHHpLBsIXoeSA3F4fnMZwLCKBfV9B2Eu8nKNc1Bl0nOCHVg==
X-Received: by 2002:a05:6808:611:: with SMTP id y17mr2348472oih.146.1582057480260;
        Tue, 18 Feb 2020 12:24:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm1543312oia.21.2020.02.18.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:24:39 -0800 (PST)
Received: (nullmailer pid 6545 invoked by uid 1000);
        Tue, 18 Feb 2020 20:24:39 -0000
Date:   Tue, 18 Feb 2020 14:24:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, logan.shaw@alliedtelesis.co.nz,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: Document adt7475
 bypass-attenuator property
Message-ID: <20200218202439.GA4617@bogus>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
 <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 12:46:54 +1300, Chris Packham wrote:
> 
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> 
> Add documentation for the bypass-attenuator-in[0-4] property.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adt7475.yaml: patternProperties:^bypass-attenuator-in[0-4]$:maximum: False schema does not allow 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adt7475.yaml: patternProperties:^bypass-attenuator-in[0-4]$:minimum: False schema does not allow 0
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/hwmon/adt7475.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/hwmon/adt7475.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1239694
Please check and re-submit.
