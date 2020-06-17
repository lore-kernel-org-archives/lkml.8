Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F914C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BDA21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592413881;
	bh=OnyQwQduYy6WKNxkVPuURfiiyYSTTZHIr/2hdBtAQEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fxKs1lSfgIYUUFwYacravji8VFP0JJyhkxbUxKIoId3Slv2cszTAsqMbkLNU++G+/
	 qIFLlzfuqyGYvBdYNZKNpjb9huN4oiDxPHm+nkaeHdYcl6qiv0gX6+8fjdMUlbpNm5
	 X2iylqaNB5HygessPLPTU+vCkankuU8USXAlwbag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQRLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:11:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45475 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:11:18 -0400
Received: by mail-io1-f66.google.com with SMTP id y5so3596821iob.12;
        Wed, 17 Jun 2020 10:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jtHmvg50fwj4vKSvDtfXUFXgpMlM97RSYpyPG/P1dQ=;
        b=VmqbB/GuQG2JxocWhFLbjoVXJtPiQvZLXwOygJhCa0QpxeQQkWbrx5+O53i3bNCvaN
         M1RDTv/FloGG4gMoNYtkWmWY+GB/tit+2+f4DQ+P2T6DMqszKqhckW3ToUuuthLuur3S
         eeBsOGraO//N66mFDzNaU5uaT+pizIseNm5XpM78HbP57nQDFNHhxAYx/VrZzJx+oTbD
         /AYjctSvpaLh4NOmwEvRnkTbfmedQt0wQ/2y9LMO5OXrUcfA6SJ1Bx/fajxgiVc+sQwr
         so4fBB96wPZjCOMfJb9iDcQ4H5ulNGQoN841g/dhmtjZtUF6YKOTmSmruX62fN6ypEqy
         VBpw==
X-Gm-Message-State: AOAM533HWJJO8XljYyQB10DYx51r1NhU0U1Y5xjzo4UhjqhsqGxwNVOt
        A/hE6qSMKXDFNVZQ7Oo35doAzX+oNA==
X-Google-Smtp-Source: ABdhPJxRByoDYwCLqBc8/jcxwM6M3+z1NGMwD6icIx5TmL0Xm82gTRE8ovFe98SOJxGWsgwyn5J+pQ==
X-Received: by 2002:a05:6602:5ce:: with SMTP id w14mr396142iox.178.1592413877663;
        Wed, 17 Jun 2020 10:11:17 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l20sm110443ilk.70.2020.06.17.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:11:17 -0700 (PDT)
Received: (nullmailer pid 2322270 invoked by uid 1000);
        Wed, 17 Jun 2020 17:11:16 -0000
Date:   Wed, 17 Jun 2020 11:11:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: lp87565: convert to yaml
Message-ID: <20200617171116.GA2321816@bogus>
References: <20200617131145.15696-1-luca@lucaceresoli.net>
 <20200617131145.15696-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617131145.15696-3-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 15:11:43 +0200, Luca Ceresoli wrote:
> The definition of "xxx-in-supply" was generic, thus define in detail the
> possible cases for each chip variant.
> 
> Also document that the only possible I2C slave address is 0x60 as per the
> datasheet and fix the second example accordingly.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v2:
>  - this patch replaces patch "regulator: lp87565: dt: remove duplicated
>    section" in RFC,v1 (Rob Herring)
>  - use capital letters consistently (Lee Jones)
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       |  79 -----------
>  .../devicetree/bindings/mfd/ti,lp875xx.yaml   | 134 ++++++++++++++++++
>  2 files changed, 134 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/mfd/ti,lp875xx.example.dts:20.9-14 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/mfd/ti,lp875xx.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/mfd/ti,lp875xx.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1311194

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

