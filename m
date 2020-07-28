Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838342065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595963786;
	bh=Ovi2zL693flr7JpR+T4wlMjLrPzwo87pUHSY91xaQrg=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=Yc3ftSNnUSuueT/zhJgokLKbPWGvu6MR2LwCwVQhf+phlw6VT65w1SiHxmMkNf4hY
	 7J9sd0VBj5t2Iq9bTczBFTEoHhPYKlHbU4DfIelGipr8jq5FdYfJiyAmU9f6V2/szC
	 QQLy1UowKmsE3Fmf0FrscbccpF/SrbN1YYF7vlMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbgG1TQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:16:24 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42493 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732601AbgG1TQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:16:24 -0400
Received: by mail-il1-f196.google.com with SMTP id i138so11278575ild.9;
        Tue, 28 Jul 2020 12:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0H+b6zQt0ezS7kYwcQh9hJueRgaTbGNjTiuGLpXHZrQ=;
        b=bGSwrrZ2wfHXtcV6fzWkn7RYngI1vN0SEtzKJEu4E8vaxmNG95wJLuWCWoiSucAAJC
         vvkCWAu/4847kf4WGWrT5dYB7kTj6nz9nvTrgkM0zDhjLVVhpeZf5Jk0sLoDPHI3xNcX
         jUUuzoTzxlv0RkQX898UgB/oCrnLa5s7pL5IdYpNTnoo7d4Z+RqVzZ60mnwY0vSP9jD2
         FBTzX5CCw2ELhOFC2Nk65KDvn8oUg6tpQ+cjxN77wyjfLe2C2+nj1VgZZbKJ3Kgtwbuc
         V+8DZCNVFX1NdEeIWDZB8Wd+hgFeZa9qk7HccTd+PDk4xu6ThpBDQwbAQlZn0Mjeu/Gm
         xwfw==
X-Gm-Message-State: AOAM53334sSnI4qWfmpSbpUATNmlOPY1S7iIwRMfUdulQb/yk7/4B15M
        BUDKECDg03Ez+wA5VjhGhw==
X-Google-Smtp-Source: ABdhPJwZSntLXAv+6Q+F7NQjzwUH5eUUeDRgDMukHAUHZqv/Km+dTvTfswJnQ7vDvyJlvzlS43odlA==
X-Received: by 2002:a92:b6d4:: with SMTP id m81mr24095574ill.72.1595963783056;
        Tue, 28 Jul 2020 12:16:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t18sm6185560ild.52.2020.07.28.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:16:22 -0700 (PDT)
Received: (nullmailer pid 2780627 invoked by uid 1000);
        Tue, 28 Jul 2020 19:16:20 -0000
Date:   Tue, 28 Jul 2020 13:16:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, soc@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mstar: Add binding details for
 mstar, pmsleep
Message-ID: <20200728191620.GA2778962@bogus>
References: <20200728100321.1691745-1-daniel@0x0f.com>
 <20200728100321.1691745-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728100321.1691745-2-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 19:03:13 +0900, Daniel Palmer wrote:
> This adds a YAML description of the pmsleep node used by
> MStar/SigmaStar Armv7 SoCs.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/arm/mstar/mstar,pmsleep.yaml     | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.example.dts:21.23-24 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1337730

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

