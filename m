Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA9C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005D820754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584571433;
	bh=RPUpDSRkoMVZF2rKv6MfDn4VBERlMj6dw3OMoxfcRG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wy5MYiEhR3CcWxNBITPvs+zoUgp3qLtwQr/MXk0AN4J2cwO3y1F9vaeC8nV+wH/IO
	 Rw/3yjiK7LWSnRkKTscfmFia/6XI902PRYPEyw7gT2XUeMFBs4yajc6Nfl7fPiBOvc
	 g3Sjid8uesNjU6Djr2BFewSJKIkBn/+dJYUsyeHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCRWnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:43:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43474 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:43:51 -0400
Received: by mail-io1-f67.google.com with SMTP id n21so234213ioo.10;
        Wed, 18 Mar 2020 15:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UbWcmYV7Yk+Clr9xPUcjHEM8UjChZ0Ube2X+QPUWkcY=;
        b=YB6lOO8AbfuKsy8r9AReBvsEsfG+nCJb09MQNVF5Qg2GpEfPI6lZldsN0pPKundrUu
         yUKkQdaTBpKXkTTLwRhwsYMet5iefhYKKlaIcSFHVEbUXYjuZNXc+EQ84W2tM5nIV7Cb
         993p9Mq2rKOHi3/bvGO6YNw2n5amq5hvvjK7Lmus+4/C6F7qLS7ndpzvS6cWYRlTvQ2i
         XTzFaq7vdHe2tlVAtLoCdZ9Ng6dDe909YuJzQlhzULCSO9p75ooCliCzNM79vzWhj31e
         +RKWKK60dGe62dpKah9L+csMZxtpVzVE9sYvyYGYANbaZATDTPeowyx9nHSC8wrWcJ1l
         0iNA==
X-Gm-Message-State: ANhLgQ1zkhXGk1bGhQpZDBpPKc+97KaAK9c4VevyzXYDXLCe8YwmF9k3
        FL44CFU99TQrX5HmB47bZw==
X-Google-Smtp-Source: ADFU+vuKZ5nQigQX/gmK6fyGJCYz1mOJ8JDdLBfylffuuRMp7AeJ8OWk0BKHi5uLykgsBx99vlqsSw==
X-Received: by 2002:a02:7787:: with SMTP id g129mr352527jac.29.1584571430672;
        Wed, 18 Mar 2020 15:43:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w11sm93346ilh.55.2020.03.18.15.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:43:50 -0700 (PDT)
Received: (nullmailer pid 7184 invoked by uid 1000);
        Wed, 18 Mar 2020 22:43:47 -0000
Date:   Wed, 18 Mar 2020 16:43:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: sram: convert rockchip-pmu-sram
 bindings to yaml
Message-ID: <20200318224347.GA2792@bogus>
References: <20200317163555.18107-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317163555.18107-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 17:35:54 +0100, Johan Jonker wrote:
> Current dts files with 'rockchip-pmu-sram' compatible nodes
> are manually verified. In order to automate this process
> rockchip-pmu-sram.txt has to be converted to yaml.
> 
> A check with the command below gives for example this error:
> 
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff700000:
> compatible:0:
> 'rockchip,rk3288-pmu-sram' was expected
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff700000:
> compatible:
> ['mmio-sram'] is too short
> 
> Fix this error by adding an extra 'mmio-sram' compatible and
> 'if then' structure to filter yaml warnings.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/
> rockchip-pmu-sram.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/sram/rockchip-pmu-sram.txt | 16 --------
>  .../bindings/sram/rockchip-pmu-sram.yaml           | 46 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
>  create mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.example.dt.yaml: sram@ff720000: '#address-cells' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.example.dt.yaml: sram@ff720000: '#size-cells' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.example.dt.yaml: sram@ff720000: 'ranges' is a required property

See https://patchwork.ozlabs.org/patch/1256661
Please check and re-submit.
