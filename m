Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A4C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30482073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262837;
	bh=WMJ2pJnh6QMcfvG69Ieu9+wX+tck5MGFWnZuMkvAUiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ok1zzSmHNa2k75BT1zXUDkkMIwQFwkt+KQ7QD1gHpgxfAhu72XI5C5fg64SnvphOE
	 4n7oY2gsh5wWNP/mZOcq4T9cTjBVX14fR2MJ5wF2+uHJwCanTNQyJsTEY46eUc+mzL
	 ffMmEumt/2ZE0M8fFuDjY5FPYSOKnQ6PNW053934=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbgGTQd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:33:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39659 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388962AbgGTQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:33:54 -0400
Received: by mail-il1-f193.google.com with SMTP id k6so13834845ili.6;
        Mon, 20 Jul 2020 09:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I0wQ3YO8Vss6xaeuCLdInIi0SX7uQKxUoc58bndvXRg=;
        b=cZgYGUFjAVKN8ZX8fTOTsFvezbIe6LfiDdYMQyQv5r2NRjkk1D2GAbUmiH/HsYPY6R
         mBGY4yHL7mH7K/8eK6mEh73N5PcJ00gQ0VlH9QbkUiBdrIr4UxYEWBjU9l5Lg9ybni2H
         JlKQLL2p943NJXnTUV6/DwRCcnFGZ67pNwdOnJqp+pCFgLgaQCiFLcdyvvyPpF9D8I+J
         MnlKJELDrU0tSffteh3cntx3U0C5rdMtYmDBL+60zLMRNPtb0Pj032KRaAU8Rh84MUDY
         cGiD6Pb0rcM5Jz3bzBiRF+c56kzdp7MZ4FExFeP+Ywpi+TTPiE5vkE1ZNWCFKy6YVKu0
         Hbhg==
X-Gm-Message-State: AOAM530SCty2zVl2/b01BolON7YwYkKYWblEOExKvF6ifssQ0ntoPLjY
        xYs/X+wwTA3z6uecpzvwIC2aiFE4MQ==
X-Google-Smtp-Source: ABdhPJyWvpuSNg/zWars+w88sZJsxEErbQ5PDf/rFSRBSl5xMfKye5hioNqx7KI9vXMByvsU0WXuzA==
X-Received: by 2002:a92:5ecf:: with SMTP id f76mr22893176ilg.281.1595262833149;
        Mon, 20 Jul 2020 09:33:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i6sm8997543ilj.61.2020.07.20.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:33:52 -0700 (PDT)
Received: (nullmailer pid 2627088 invoked by uid 1000);
        Mon, 20 Jul 2020 16:33:49 -0000
Date:   Mon, 20 Jul 2020 10:33:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     yanfei.li@ingenic.com, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, zhenwenjin@gmail.com,
        aric.pzqi@ingenic.com, paul@crapouillou.net,
        rick.tyliu@ingenic.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, sernia.zhou@foxmail.com
Subject: Re: [PATCH v9 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
Message-ID: <20200720163349.GA2626388@bogus>
References: <20200720151106.112807-1-zhouyanjie@wanyeetech.com>
 <20200720151106.112807-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720151106.112807-2-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 23:11:05 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X10000 SoC from Ingenic.
> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
> 
>     v2->v3:
>     Fix wrong parameters in "clocks".
> 
>     v3->v4:
>     1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
>     2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
>     3.Modify the description in "ingenic,sysost.yaml".
> 
>     v4->v5:
>     No change.
> 
>     v5->v6:
>     1.Drop "oneOf" and the blank line.
>     2.Add "additionalProperties: false".
> 
>     v6->v7:
>     No change.
> 
>     v7->v8:
>     No change.
> 
>     v8->v9:
>     Fix warning while applying.
>     Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  | 63 ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml: properties: '#address-cells' is a dependency of '#size-cells'
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/timer/ingenic,sysost.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/timer/ingenic,sysost.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml: ignoring, error in schema: properties
warning: no schema found in file: ./Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml: ignoring, error in schema: properties
warning: no schema found in file: ./Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1332465

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

