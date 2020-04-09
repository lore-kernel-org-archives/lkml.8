Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD6C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E75206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586473826;
	bh=cok74IMHnuYWsgPnboRukysU7DKzK7U5gPi7WyBzanU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+T4mhGuq5bqR9jQrrZit8ZdHI060HgyaiAsxGPuMqpcZpQxBwv1eYlmP6Sw7gNOm
	 qXHKBy4fUjcLCXwLDwCKJleJdTOXe0/dO6qIJ+BObDA2SOwc/lk2kadImvFqKxalkZ
	 E4y2bz7wCfBx1wsu22b2biy1b34W7qbeceBAS588=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgDIXKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:10:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46303 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDIXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:10:25 -0400
Received: by mail-io1-f66.google.com with SMTP id i3so92319ioo.13;
        Thu, 09 Apr 2020 16:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hkv9Vin9gJRSKCAf/kk8KdwDOEdNpGQ0k0uqyqoPiNU=;
        b=BVb1fdHjKzKaSBA7+kY3LIHZu+cTpBFNMQ5nMonkZopJo2gc83Vyq2LyC8RSF9BNTs
         dlxDdgjfc0+UB4IAMTUoneAdiSktiirv3QyRBuY1LXiGDQbLNKoh2XHn5O/PaaxOWXXl
         5CyEdo40dwDRzld1ESE+B/H/x53QXQ6QuZR2ck4jUAOeE1w5LGOPiq+bqgDRfRv0SCNk
         MA7jV12s1nrrpj+fNVCqpUHy4/WCR9T9eEpu2JLg3MhsZ5peP0C4QAZgiw8o0U0LH8lN
         /svDs0TomOjzAA5Xl10TMk0bCG8IFujqWS69aioyOTu4LzSHGK5W9X1ZhWLBeyTFRe8c
         qjhQ==
X-Gm-Message-State: AGi0PubyAntFsYathbEECxTiqnMbNXaOUNQpJ0EHKCJ672AZUPlSVnYz
        ZFQvePfUwFNIxtee4XaHGw==
X-Google-Smtp-Source: APiQypIDVQQ7NtmX3YGOcYcp8Rl/QMyqAmd4Ruw2zFzqc36idNXftVPGGChHwiyDAJpKWKB//ysTJg==
X-Received: by 2002:a5d:905a:: with SMTP id v26mr1610480ioq.39.1586473824640;
        Thu, 09 Apr 2020 16:10:24 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n29sm144557ila.86.2020.04.09.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:10:24 -0700 (PDT)
Received: (nullmailer pid 25365 invoked by uid 1000);
        Thu, 09 Apr 2020 23:10:21 -0000
Date:   Thu, 9 Apr 2020 17:10:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        anarsoul@gmail.com, devicetree@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add
 rtl8723bs-bluetooth
Message-ID: <20200409231021.GA19363@bogus>
References: <20200407055837.3508017-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407055837.3508017-1-alistair@alistair23.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Apr 2020 22:58:35 -0700, Alistair Francis wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
> v2:
>  - Update bindings based on upstream feedback
>  - Add RTL8822CS
>  - Remove unused/unsupported fields
>  - Remove firmware-postfix field
>  - Small formatting changes
> 
>  .../bindings/net/realtek,rtl8723bs-bt.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:compatible:oneOf:0: 'realtek,rtl8723bs-bt' is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:compatible:oneOf:1: 'realtek,rtl8723cs-bt' is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:compatible:oneOf:2: 'realtek,rtl8822cs-bt' is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:host-wake-gpios: Additional properties are not allowed ('desciption' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:host-wake-gpios: 'desciption' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:host-wake-gpios: {'maxItems': 1, 'desciption': 'GPIO specifier, used to wakeup the host processor'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:host-wake-gpios: Additional properties are not allowed ('desciption' was unexpected)
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml: properties:host-wake-gpios:maxItems: 1 is less than the minimum of 2

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1267219

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
