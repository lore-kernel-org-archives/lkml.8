Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41552C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216F022574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594747175;
	bh=4ujwalavyEmuGFk+InGk1RjmBZGtUe2vr88gZml6JC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lsKCFidCNTIWPzTywXtQ7dyihPegM8+uiQqPnAfE/+jcZMRV9Q3+ukadQpgUZVHHm
	 dzZGnZ+yi4o4U1e0NI9qxAL9t1e4KfCSgRlr8BHRJBHVm/WA8dUd/An7ceNEvo11LL
	 6IjFdoB88OAnDua7D17PPeHVuZQRdKiZR/hEDAQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgGNRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:19:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44611 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:19:33 -0400
Received: by mail-io1-f68.google.com with SMTP id i4so18074191iov.11;
        Tue, 14 Jul 2020 10:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zi/Jq7DBazT7PKPowTAfmfi9qVl4RbGq0AWblTBzN5w=;
        b=TwdgM30H3qr/Ek7P1zkllADMhnied5cSzCQQXgzXbwn8DJ7u1Ow7z1c0d57d9R/wOC
         JzAqk3TjLKF43NA56mSOidkH8R1lVhtEqoAEbQIOuG0SZeYHzR1EHOqwjTnyACvTP2rW
         Eb0tmtAsvD/Zg+0G3hGDCkNWE/OghyhLTasWs8+zVfZjjirmKo5Vxds0KZ8ow6+XiI2z
         koCsKVjfyQTzOXjAYYF0dXXvGCjssFNzRJV3h6fNRre7ufHrnag08RQH/vF5af7cSP/0
         bBw6Iq8e4sjMnv0bCOk317Uq+izHHUepbZG/LXycH0wWxLZeZKZjKWqw+lL156F8Yk1K
         LYRg==
X-Gm-Message-State: AOAM533F0+WPKccjJXq4SBhIKDIn1yiETH7hOrFrBetkPOkjrLSUvueU
        UKJiPfah2SJnI4F+K5Np/Q==
X-Google-Smtp-Source: ABdhPJyKq2MmJTjJW8+ZieKuXTdPtT8A+LvD3KRPJ1H57ivL83rZePTd7osq3UoXSLgBgZ9DYBjV8Q==
X-Received: by 2002:a5e:9b08:: with SMTP id j8mr4309335iok.116.1594747172300;
        Tue, 14 Jul 2020 10:19:32 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s17sm9571499ioj.10.2020.07.14.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:19:31 -0700 (PDT)
Received: (nullmailer pid 2557105 invoked by uid 1000);
        Tue, 14 Jul 2020 17:19:30 -0000
Date:   Tue, 14 Jul 2020 11:19:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ohad@wizery.com
Subject: Re: [PATCH 1/6] dt bindings: remoteproc: Add bindings for MT8183 APU
Message-ID: <20200714171930.GA2551057@bogus>
References: <20200713132927.24925-1-abailon@baylibre.com>
 <20200713132927.24925-2-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132927.24925-2-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 15:29:22 +0200, Alexandre Bailon wrote:
> This adds dt bindings for the APU present in the MT8183.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../bindings/remoteproc/mtk,apu.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml: properties:pinctrl-names:maxItems: False schema does not allow 2
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/remoteproc/mtk,apu.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/remoteproc/mtk,apu.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml: ignoring, error in schema: properties: pinctrl-names: maxItems
warning: no schema found in file: ./Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml: ignoring, error in schema: properties: pinctrl-names: maxItems
warning: no schema found in file: ./Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1328008

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

