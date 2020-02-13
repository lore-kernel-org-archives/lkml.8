Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF0C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FFA20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581627154;
	bh=90lR1+e59wezNxV0B89GKQfGjUPdEHkzyxQLJ0us85Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n0Y2V5BI+gLd0RIIBntrnbDtZR7TtuPM7dhFaxejvopzkSZhG7jC55obpDNBm3LXx
	 iWFCwjnNZ8CdYX5T5yfhpM6w5QjHAAyqFR0O8HsoRI+uHEcPspuQirVD74kF5bzJo3
	 qdzNY2FtI29K6jL/hu4h4DYCo+vPnFupmjejgWGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgBMUwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:52:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41060 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:52:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so7214856oie.8;
        Thu, 13 Feb 2020 12:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s8i10ohrT2+weilggglqs0Ir1n1ZSXHJ2uT8Wx+VWFA=;
        b=YT9wfsn6eAfrNiFpk0++ZvQ/eFWC4JLuIx1hLT0IyAMVd5slna4m0j+wxKDc2PVAao
         CPot8Kcuk+KVEUZt9LtbK2AFph6l7y+F2JfE4BLuUG3W4YcWf4dAfrBtphPvbXg97rWL
         0I52w/dqE/mFlw+eQbSwGCcca6ozJViPOeDRFOMAIbrz0aVvueehdqW7Y37YoaTVZxtC
         96WVr0Pxkp/HVIPrmYKDyglgTleXz8iRtpduMYSiHMyyShG88UCD887s3P/DMdM20T5x
         /5PHOa5DxqbhIKFcMx6SQvrb5ui3OJ3p5EUE50vo+kqiO+W31Wy47wa/iPEi/5DfmTwC
         C1Dw==
X-Gm-Message-State: APjAAAVu3aTObCptF5ERZXyUVMc0fs9gpdYt6H9/fXvezZDn+vI2I38r
        tPdL6WOfAQUmra1GdYUh/Q==
X-Google-Smtp-Source: APXvYqyxzp7FojO4VNDr08MgWew7G0vsADdfBY2x0CqIPVAPAt7ZS5c/S285NmepbwZyFpewQmPbIA==
X-Received: by 2002:a54:4010:: with SMTP id x16mr4368671oie.174.1581627151779;
        Thu, 13 Feb 2020 12:52:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm1046185oic.40.2020.02.13.12.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:52:30 -0800 (PST)
Received: (nullmailer pid 14780 invoked by uid 1000);
        Thu, 13 Feb 2020 20:52:30 -0000
Date:   Thu, 13 Feb 2020 14:52:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rsnd: switch to yaml base
 Documentation
Message-ID: <20200213205230.GA13640@bogus>
References: <87tv3vqc93.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv3vqc93.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Feb 2020 14:37:04 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> It is still keeping detail explanations at .txt
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/renesas,rsnd.txt           | 518 -----------------
>  .../bindings/sound/renesas,rsnd.yaml          | 528 ++++++++++++++++++
>  2 files changed, 528 insertions(+), 518 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.6/dist-packages/dtschema/schemas/sound/simple-card.yaml'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml: patternProperties:^rcar_sound,src$:patternProperties:src-.: 'if' is not one of ['type', 'description', 'dependencies', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml: patternProperties:^rcar_sound,src$:patternProperties:src-.: 'then' is not one of ['type', 'description', 'dependencies', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/sound/renesas,rsnd.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/sound/renesas,rsnd.example.dts] Error 255
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237280
Please check and re-submit.
