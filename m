Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD30C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C868208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532606;
	bh=SoyS9n5uzrCTeisHdfFQF2I8r8kuXmqmf/eQd1xljCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B5xvNuG7+Eiu6+mLglWHVl9V8lShltNpGX3OrJzwC+/fH656gpN5YWQRR0WtEgnyo
	 v1H13S+JrygQWHZpD2vHxxqzvvOrnDB/AkIajkphOTiC+XoW+e1UNTkz54qIgr18rm
	 UsMlO7VeutyDbk00WFkuLGv5dhqf0prCZo5RZBrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404472AbgEZWgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:36:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44149 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgEZWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:36:45 -0400
Received: by mail-io1-f68.google.com with SMTP id p20so10448084iop.11;
        Tue, 26 May 2020 15:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tj8N2mepZ2doGS8o5HvQFvU4E1JvXzOMzruiM4qqlkA=;
        b=UoDCzV920leTmz0b5clKHCtdKhl1tG5bX0jTGsmRVpECNpLC7GgUgudy346Uy8ugs5
         F26EF2VbvwuRs/BEjhWJ8XqCbVIqyJW5u8Au8dTEoAfIUYmBRtfaNhWq0yomnDq2Isrn
         3K8MAtSb6a7jYi11HGKyEfcigNuANh3ndzg6/2XN0MAar1C6vhvMdxWwZ4Cs4i4trSBh
         1I5iCrn3UzU3e19SpMQYo+K8MpbG76B1Qx6guHcWlGYxRBhGN7Zamzea9Uf0PGFOtlML
         RoHHwQs9BpQRXwba13nr2IbOUuq8v5/tz7qLOwCIIe3CetOb85jeEnvDxrdur/5AGHlS
         rjBQ==
X-Gm-Message-State: AOAM530nYJPrOczTynA816lZ0ZfjrjuEahTMWZlSzf42B7KSDzF04Obz
        orY/GNoJGv+YDv05Olj0qYFwi1Q=
X-Google-Smtp-Source: ABdhPJwnkJMGWyVt/cg8hbEkr6MQZUJOiTQ9GhmS2gEM3rC+m3jVY0ILT9haJVEEAeAQUNbmuDB0zQ==
X-Received: by 2002:a02:a899:: with SMTP id l25mr3122374jam.101.1590532604273;
        Tue, 26 May 2020 15:36:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v76sm664733ill.73.2020.05.26.15.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:36:43 -0700 (PDT)
Received: (nullmailer pid 512636 invoked by uid 1000);
        Tue, 26 May 2020 22:36:42 -0000
Date:   Tue, 26 May 2020 16:36:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.com,
        ryans.lee@maximintegrated.com, steves.lee.maxim@gmail.com
Subject: Re: [RESEND][V5 PATCH 1/2] dt-bindings: Added device tree binding
 for max98390
Message-ID: <20200526223642.GA506893@bogus>
References: <20200518004930.20973-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518004930.20973-1-steves.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:49:30AM +0900, Steve Lee wrote:
> Add documentation for DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> 
> 
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example

You are obviously sending patches too quickly. Give folks a chance to 
review.

> 
>  .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++

Bindings are now in DT schema format. Please convert this. See 
Documentation/devicetree/writing-schema.rst

>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
> new file mode 100644
> index 000000000000..0ddd4c6ae55e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max98390.txt
> @@ -0,0 +1,26 @@
> +Maxim Integrated MAX98390 Speaker Amplifier
> +
> +This device supports I2C.
> +
> +Required properties:
> +
> + - compatible : "maxim,max98390"
> +
> + - reg : the I2C address of the device.
> +
> +Optional properties:
> +
> +- maxim,temperature_calib
> +  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
> +
> +- maxim,r0_calib
> +  u32. This is r0 calibration data which was measured in factory mode.

Unless these are shared already with other Maxim chips, s/_/-/.

> +
> +Example:
> +
> +codec: max98390@38 {

amplifier@38

> +	compatible = "maxim,max98390";
> +	reg = <0x38>;
> +	maxim,temperature_calib = <1024>;
> +	maxim,r0_calib = <100232>;
> +};
> -- 
> 2.17.1
> 
