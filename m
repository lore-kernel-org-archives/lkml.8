Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01735C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A5120722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596491283;
	bh=AUM+yvLlMS9mqRubh71+CUwV8yF8OXdcLCnLDg19Eoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lnyGUFUdXOS34VKvs6CzbJTCS9Ym7RKkGI7I8h1TMgx1pkpmtmeCMmFe7LcpIhVKL
	 ebrSVmUtjGGC7/gQIB99yOF21C+rYVRleUMW8JWLRjuBlhvQgf+Pzr6zNYhODbdQMx
	 VpqGi2PmwrFWnuS0Fa7LwNWZReFCufa+k3M55VsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgHCVsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:48:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35554 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHCVsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:48:01 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so32473613ilh.2;
        Mon, 03 Aug 2020 14:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHz6FTErPUV4uyPRUEgxafeUbmRMcPUvMFZhatB72Us=;
        b=Yyk1n7dzqmC4cez/CFM6wVD38vk+u2o/NTUwcWVJPvXzY/jJ+8hyXMua+5gpgYILxO
         19Jb6oUWQmnjLSJ16pjOurFrqR4YYv74Ve1DACmKnw+g72T13Dv/EH30bd97axdogKFf
         O7cpO9RaZXjHYnkEPICKp/U/7/mT1vN79+VR+SuiZREdT7DosUmxQlQyZcw31tUgFEvt
         MSgBPwCsJYjXRNQmRSdGZOz4A7bQo1TNeIomvoAoyLJW4TPRz9r6Inqi5Ab1SSO21EDu
         ATsA2utRH9Xzp0Nn/HLgJfpMMwg52S2Tc3ENkm9e6eWHYJFYxCLgw3Ff4HOqUxrim69K
         0+5A==
X-Gm-Message-State: AOAM532IPF0m8QjlR2i9xhELNUqjjftvF1DliEpIaKKd+Mknfl2zEcY2
        Ci0ESsk4FARdA8cwl+fqxw==
X-Google-Smtp-Source: ABdhPJylcuweeEkx+1+KUovLiYX8jxNRUF3xyQNwfrqYRLu+TiNCe7seRBGrPKmFOecJ6W8M8VxmBA==
X-Received: by 2002:a92:aa49:: with SMTP id j70mr1548669ili.107.1596491280702;
        Mon, 03 Aug 2020 14:48:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm10704358ioo.9.2020.08.03.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:48:00 -0700 (PDT)
Received: (nullmailer pid 3194959 invoked by uid 1000);
        Mon, 03 Aug 2020 21:47:57 -0000
Date:   Mon, 3 Aug 2020 15:47:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     devicetree@vger.kernel.org, alix.wu@mediatek.com,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: Add MT58XX
 interrupt controller
Message-ID: <20200803214757.GA3194548@bogus>
References: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
 <20200803062214.24076-3-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803062214.24076-3-mark-pk.tsai@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Aug 2020 14:22:14 +0800, Mark-PK Tsai wrote:
> Add binding for MT58XX interrupt controller.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  .../mediatek,mt58xx-intc.yaml                 | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: properties:compatible: [{'items': [{'const': 'mediatek,mt58xx-intc'}]}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: properties:mediatek,intc-no-eoi: {'description': 'Mark this controller has no End Of Interrupt(EOI) implementation.\nThis is a empty, boolean property.\n'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: properties:mediatek,intc-no-eoi: 'not' is a required property

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: properties:mediatek,irqs-map-range: {'description': "The range of parent interrupt controller's interrupt lines\nthat are hardwired to MT58xx interrupt controller.\n"} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: properties:mediatek,irqs-map-range: 'not' is a required property

Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/interrupt-controller/mediatek,mt58xx-intc.yaml#
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: ignoring, error in schema: properties: compatible
warning: no schema found in file: ./Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml: ignoring, error in schema: properties: compatible
warning: no schema found in file: ./Documentation/devicetree/bindings/interrupt-controller/mediatek,mt58xx-intc.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1340146

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

