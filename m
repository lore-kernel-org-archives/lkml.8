Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4827C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937E3207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591723637;
	bh=rlFCg/xk+Oao4pWdPoTznVTk/NpdkBG9liEFPJZwAVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lwRmFDued8wZxtA/RQ+vkm0VeQfQzpq1Ud1W8GGUlhx9rqbh/tWAlUEuATfxVt6vc
	 V9PTrw3YCUov05xKh4JxDKDopn7sbl/2OnFJuqAY/xO2Re+dbZMGI2fi+S0D/bRPki
	 75a7dm64ppZRDP/gIrMEARcC+Jb8eU4QfSREf9V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgFIR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:27:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34364 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgFIR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:27:13 -0400
Received: by mail-io1-f68.google.com with SMTP id m81so23706659ioa.1;
        Tue, 09 Jun 2020 10:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzMT5lPVyIWtT5NNG9r0IznpD+jop0KaSD17rOh2S9c=;
        b=KTWCapI2unDAwzpTXq61LqqABsRMPX4cTlm8ZTs/YM7g5bYRJkeiV7eUyg/V41EcFB
         s43zhtg+Lw1lH4IkqqGdLzcaQMVTOfzu9rxGzbDDOXDr0p1FWqheQ7gAP879GzVUmBU0
         s3zcrnJZRnZFpsEhv19SykCqxX1tOWKQiP/rePu1IrgiRhFR7/8vo015A/WJGTHP/3Xz
         vT4tJW2mKt7FRANLmW3JgaG/E8yyb+QhRZDMByTFNoFlup84xEUpnDZm4Ot3TN2fZtGv
         DDPly5YusVM4ktwxbUrUvjS0bHgRs5stitSpRAH/ZabWcX7fjU57IUiwgEjyuZ9HPT7o
         SsiA==
X-Gm-Message-State: AOAM530GTM3pYdnZueq6z0AGqftUp5SykJRXuzt5UB0ViGL1cnQ5fz6G
        IPAwCBBH4cNWTfwSBEw7kQ==
X-Google-Smtp-Source: ABdhPJxCWEnQhYmYJHctyaQwbFMOsDA2DwTPjTRs2cYEIoIfm3wINvGJ7r8/9C4ky1Jmlj2/LagJOA==
X-Received: by 2002:a6b:dc12:: with SMTP id s18mr27314270ioc.56.1591723632320;
        Tue, 09 Jun 2020 10:27:12 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i10sm9595983ilp.28.2020.06.09.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:27:11 -0700 (PDT)
Received: (nullmailer pid 1111820 invoked by uid 1000);
        Tue, 09 Jun 2020 17:27:10 -0000
Date:   Tue, 9 Jun 2020 11:27:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     wsd_upstream@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: devapc: add bindings for devapc-mt6873
Message-ID: <20200609172710.GA1107294@bogus>
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
 <1591698261-22639-2-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591698261-22639-2-git-send-email-neal.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 18:24:20 +0800, Neal Liu wrote:
> Add bindings for MT6873 devapc.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  .../soc/mediatek/devapc/devapc-mt6873.yaml         |   61 ++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml: Additional properties are not allowed ('maintainer' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml: 'maintainers' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml: Additional properties are not allowed ('maintainer' was unexpected)
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/mediatek/devapc/devapc-mt6873.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1305778

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

