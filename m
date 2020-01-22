Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A7C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77922467E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579712358;
	bh=Pah8FKEowSfuW3oA2vi7xcChlEyJ6Lz6Hk0Zu1ZJQmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9n9AoJBz0qJhn8j/kNwhrIGJ+zps6HkTUI+jUC1b/s+c8QfOIpYb7gr5j4k9+AMU
	 3pU88igPJNhzPZnTImldFGaJ/HDZMF2CaVuNYvRkZJQA6d0WXMyCealWAGQyHzTeU+
	 D/C6ya2/gEgdOFDzMJhigYzdwVsh4KaWZHyHslTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAVQ7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:59:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45296 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgAVQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:59:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so6690726oie.12;
        Wed, 22 Jan 2020 08:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mou9J8YjfkvnsPaT9Al7wgNVF7rWGQkRBCyvGjZr+Wo=;
        b=ThOaV9wZzW/jb23FnbhBqmyl4KgC78rflMRx1XnDzGo8kwjJkznfeimugjv7BBOo2k
         SZF6MM7r/Fzc31UWUSxJ1E0M7Bj9am/i+ttQkQp7mqztC7uliHwTIv/KsYndnjODyMTW
         RBDi7ppRj1he5giOhTQbzf5VQVJPpOenZA7bdIsI+Jw81eeSpKJZaTh9zcSPcaK1Pw0a
         V+MiQ8qBTnDTcD92iZqaP9QUR2AIFv3BVrtDSxKsV7TcFcXmiEhJN0u0dLL4Js7/+bYK
         AEq4OwOmnueM0xURX/F3A09CYeRqsk2NOaCFZLifMRnp4ljmKhgmN/sLowuvhoxlewKp
         oaLQ==
X-Gm-Message-State: APjAAAUBAXakKCMQhQw//SrZ7VJ3s8AODUjCK1sBx8KHLGKSqoDmyQVd
        d9qElYJDVm1vQl7S21QeXg==
X-Google-Smtp-Source: APXvYqxRqMrZcWvMtfS9saD5x2uaT9DVAasTND+05WtLmz/+OCZmcSwYW9MtXWDUc9h2IyEzc0blQQ==
X-Received: by 2002:aca:5083:: with SMTP id e125mr7643124oib.96.1579712355982;
        Wed, 22 Jan 2020 08:59:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e21sm13187177oib.16.2020.01.22.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:59:15 -0800 (PST)
Received: (nullmailer pid 6651 invoked by uid 1000);
        Wed, 22 Jan 2020 16:59:14 -0000
Date:   Wed, 22 Jan 2020 10:59:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20200122165914.GA3900@bogus>
References: <20200121192405.25382-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121192405.25382-1-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 20:24:05 +0100, Saravanan Sekar wrote:
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
> 
> Notes:
>     Changes on v7 :
>       - added regualtors child-node under patternProperties, added required
>       - mps,buck-ovp-disable is not common property, regulator subsystem provides
>         only over current protection support.
> 
>  .../bindings/regulator/mps,mpq7920.yaml       | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: ignoring, error in schema: properties: regulators: properties: mps,switch-freq
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:properties:mps,switch-freq: {'$ref': '/schemas/types.yaml#/definitions/uint8', 'enum': [0, 1, 2, 3], 'default': 2, 'description': 'switching frequency must be one of following corresponding value\n1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz\n'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:properties:mps,switch-freq: 'not' is a required property
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:properties:mps,switch-freq:enum:0: 0 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:properties:mps,switch-freq:enum:1: 1 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:properties:mps,switch-freq:enum:2: 2 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:properties:mps,switch-freq:enum:3: 3 is not of type 'string'

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-softstart: {'$ref': '/schemas/types.yaml#/definitions/uint8', 'enum': [0, 1, 2, 3], 'description': 'defines the soft start time of this buck, must be one of the following\ncorresponding values 150us, 300us, 610us, 920us\n'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-softstart: 'not' is a required property
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-softstart:enum:0: 0 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-softstart:enum:1: 1 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-softstart:enum:2: 2 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-softstart:enum:3: 3 is not of type 'string'

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-phase-delay: {'$ref': '/schemas/types.yaml#/definitions/uint8', 'enum': [0, 1, 2, 3], 'description': 'defines the phase delay of this buck, must be one of the following\ncorresponding values 0deg, 90deg, 180deg, 270deg\n'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-phase-delay: 'not' is a required property
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-phase-delay:enum:0: 0 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-phase-delay:enum:1: 1 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-phase-delay:enum:2: 2 is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml: properties:regulators:patternProperties:^buck[1-4]$:properties:mps,buck-phase-delay:enum:3: 3 is not of type 'string'

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/regulator/mps,mpq7920.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/regulator/mps,mpq7920.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1226717
Please check and re-submit.


The errors are too helpful here. The problem appears to be that '$ref' 
has to be under an 'allOf' if there are other constraints.

Rob
