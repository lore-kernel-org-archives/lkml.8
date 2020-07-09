Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FE72078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594314270;
	bh=IwKCTQQXrFHxNTBTAQmV6GhJe3H+h3CsMgHsOwMP1tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NuIG0Yzx7sK3632mKy2XbgatSgvr1R2nSxIRqqsImGEm+/vk9IcqhJAzZyaKuC3hi
	 gTMn8egzOSWFaWp4gZ8Q9O+I91xU9lWIpC+A/MOCvn3yvZ9rUWdc+UsaQ3BgBPQou4
	 JOS+OuF4GrCl4D6hcz+0ABXdOTaNqH9gg1oXt+LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGIRE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:04:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41056 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgGIRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:04:28 -0400
Received: by mail-io1-f66.google.com with SMTP id o5so3057344iow.8;
        Thu, 09 Jul 2020 10:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rPAal+mCKD1RasPvCnP9R4UBzZrvC6ReDEPohFK+PY=;
        b=Q0JHPa38p9kqbits7C1aHENojvOEmr4WlftvVr1cbgiEU1Jc4Fo2mwg8OLeZsFtsF7
         Md3oYZJp0UlkhTKYJLELSAuqMyV6AQQJlqC/2g1hEIuHFTzZbaPMApjCqvbRAzvJ78Q5
         q4z+enP9ceiyoTeiGIsGHPiYyF3wGiJ24xbBZa5MZq7Fps30E3tFO1S8BOEJcdBfXuSV
         rtymAr2fXYY0gggvYsvv1SIxgeFtBACfX76p7gH/KVRHEilUFF0SOmCNZ+YutWD/D2Xw
         PNwgiH59P1j3zIiF5Qg1VHDzW5YcgmNKlotHWBPIOKWt5g+SZ7curTpwVxdyLPbe5Oxj
         zu9w==
X-Gm-Message-State: AOAM5302Q6r+DO5dn1iKY5gsPl3M4Y39PcgXApqPE/Vg3BT0C/BN76TH
        OsKsB0/tiy2g66NHbqvz6AO3xMNScg==
X-Google-Smtp-Source: ABdhPJxcDPa2tPUnhuBohvevfmSj6UngPYNU7IBK1nJG52EbsFCNEeMqhNHXUml2E//n3ivhfutJTA==
X-Received: by 2002:a05:6638:2649:: with SMTP id n9mr37848979jat.126.1594314267183;
        Thu, 09 Jul 2020 10:04:27 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id f18sm2414188ion.47.2020.07.09.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:04:26 -0700 (PDT)
Received: (nullmailer pid 523550 invoked by uid 1000);
        Thu, 09 Jul 2020 17:04:25 -0000
Date:   Thu, 9 Jul 2020 11:04:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: i3c: Describe Silvaco master binding
Message-ID: <20200709170425.GA523194@bogus>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com>
 <20200709080159.2178-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709080159.2178-2-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020 10:01:57 +0200, Miquel Raynal wrote:
> Silvaco provide a dual-role I3C master.
> 
> Description is rather simple: it needs a register mapping, three
> clocks and an interrupt.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/i3c/svc,i3c-master.yaml          | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

builds/robherring/linux-dt-review/Documentation/devicetree/bindings/i3c/svc,i3c-master.example.dt.yaml: example-0: i3c-master@a0000000:reg:0: [0, 2684354560, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1325811

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

