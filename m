Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA7C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39822072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585582731;
	bh=HAdnNiaSEN8tcbJsyDVz27UaMDUEFZ4dnJ1Gx9aV1TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yYGMPMma/wJCyAp0kR7eeotm7Ahyval1InGjUNKPwYm5SqgwO98vw3DvSU0CYX5Qa
	 QQQayXXDxWSL69k8BpDyfK62mnmfYsQ6D6yh5nke2HMQhxlTLt3vb9lcnXg8Fl1MzS
	 qHSXhZ67JW991bkWm/WJYyCsrAinGyGCsVwPHqnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgC3Piu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:38:50 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45346 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgC3Pit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:38:49 -0400
Received: by mail-il1-f196.google.com with SMTP id x16so16212236ilp.12;
        Mon, 30 Mar 2020 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kjvQ/aX+nqXYP/8xlPBLanrss6H0Kukdfj5oOHWtkGI=;
        b=hP9tI0NoKNVkhPr+puV2t6qaHGdKshYfsGCJ7RHckXXJxsfzghY60Vj14r6EkEI8zE
         WhHbrZqQTSeLTVc4JJGyzmwb7wmzSPX9SxvO25aGopi4xpnkwUeM5HjYoC1bQwj7T5Eo
         d/6gL+HSDA/RgPT3+zmQgSAPu2ElV5xW/pRvIgwfH/tC4xXj0q0ZSt5L+Gsk/hUqMq0N
         +eHj9h2TTCeQ0gzZ2mJmbk7RhxJNult3wfkaTcnlwcLS7hqjDBu07RVfUghnNjfYlwvt
         jwyNb5dwOj00oK69jbleO9yrA85/nMVJRz7EPMsBlJysW4D/FpcQJEsy0rJe7cnoaaOf
         ypzA==
X-Gm-Message-State: ANhLgQ0LYOoUWsrFRoCYXE5g42i/u79SkMk+4iE4MnuxwOeNFVv8kHdp
        +W50k6apgmPx7+dOJ2LA4BMumN4=
X-Google-Smtp-Source: ADFU+vub9x8UsaNR5rZlhFtYZGuK9nLpiz/UHXGujrMmTJO3dB/kG0f8isqdsyg/WtZalr/2pwB4Bw==
X-Received: by 2002:a92:d7cc:: with SMTP id g12mr12180998ilq.260.1585582729078;
        Mon, 30 Mar 2020 08:38:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k16sm4958078ila.38.2020.03.30.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:38:48 -0700 (PDT)
Received: (nullmailer pid 19882 invoked by uid 1000);
        Mon, 30 Mar 2020 15:38:46 -0000
Date:   Mon, 30 Mar 2020 09:38:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: Add IPK DSI subsystem bindings
Message-ID: <20200330153846.GA19314@bogus>
References: <cover.1585067507.git.angelo.ribeiro@synopsys.com>
 <0bc20739facfa519296defe2a367774a7b5a355d.1585067507.git.angelo.ribeiro@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc20739facfa519296defe2a367774a7b5a355d.1585067507.git.angelo.ribeiro@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 18:18:19 +0100, Angelo Ribeiro wrote:
> Add dt-bindings for Synopsys DesignWare MIPI DSI Host and VPG (Video
> Pattern Generator) support in the IPK display subsystem.
> 
> The Synopsys DesignWare IPK display video pipeline is composed by a DSI
> controller (snps,dw-ipk-dsi) and a VPG (snps,dw-ipk-vpg) as DPI
> stimulus. Typically is used the Raspberry Pi
> (raspberrypi,7inch-touchscreen-panel) as DSI panel that requires a
> I2C controller (snps,designware-i2c).
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> ---
>  .../bindings/display/snps,dw-ipk-dsi.yaml          | 163 +++++++++++++++++++++
>  .../bindings/display/snps,dw-ipk-vpg.yaml          |  77 ++++++++++
>  2 files changed, 240 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml: properties:reg:minItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml: properties:reg:maxItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml: properties:resets:minItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml: properties:resets:maxItems: False schema does not allow 2
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1260819

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
