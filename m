Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635E6206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591999146;
	bh=CCs9RF45QjakoSVzjaeqVLWmN7XoaPl+vnR2jsWktb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i0J2tWHKJzj/31B9f48JqAhc18ojWVyNF5AEZuMnRHLwGKXboJW0xdHv8l33DQXlq
	 OVRHLmm2K0dy0gttDwYt63HAcVCBaKuYU4zMcRc5pRXeNSwO3vA52xyyJLMLOxwHzQ
	 qWrJNNgoFZJ8kFOi6ni8ipy1rMvoIka3f/ooU3XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLV7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:59:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32930 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:59:03 -0400
Received: by mail-io1-f65.google.com with SMTP id i25so11887962iog.0;
        Fri, 12 Jun 2020 14:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcwIzuXXIINmTNZ5dabq3OUq+ijaCK5xyZMr6C5bYNU=;
        b=Fm1RD9ptNDKEY03zNasGKIXrdZ0xMxsF66dj23XjDwJ5v+9zshpYrhNIlrWwFCt8s5
         DAOBKBNH0/G3BULTEM3ewbch5WXONU2hHprLN1+sPYPZohsOygefYZ0cPcfYz/ZiaMag
         tb1Be+PNw9fjtN5LqWAzOgGGjSqp0SVA0swsiQ5I739mNMX2yM60BcYD+iHDur6r9ek1
         zDVbjSKLFICl7/rjnioXRIdq9L4m7Bhl9KLd/h1kH8l+0HSD9fehkTwy1MBpWCgrO3nW
         tU+fp6OYZjAxjp168AOr71OgeKORu+pcRDrCDTdlcWFhXdWHNX63L8EtFCIcLWLIEdIZ
         xYRg==
X-Gm-Message-State: AOAM532TMqV6tY0ophcy6mmXGqeqsgseRlaRSYRGn7nQkkOHgtAU/zsw
        lv0GxvkOGA95Z2YbRl985A==
X-Google-Smtp-Source: ABdhPJzJbmuNyKxUznuNFYomkX61jS1RECoO+1RR1nZWWD5CDCxryf1kJOvGG091Xx5OpgwCRBLhng==
X-Received: by 2002:a6b:9355:: with SMTP id v82mr14853058iod.92.1591999141862;
        Fri, 12 Jun 2020 14:59:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w21sm3819223ioa.48.2020.06.12.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:59:01 -0700 (PDT)
Received: (nullmailer pid 3887135 invoked by uid 1000);
        Fri, 12 Jun 2020 21:58:59 -0000
Date:   Fri, 12 Jun 2020 15:58:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     mkurumel@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        linux-kernel@vger.kernel.org, sparate@codeaurora.org,
        devicetree@vger.kernel.org, dhavalp@codeaurora.org,
        mturney@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rnayak@codeaurora.org, c_rbokka@codeaurora.org
Subject: Re: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for
 qfprom-efuse
Message-ID: <20200612215859.GA3886706@bogus>
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 15:18:00 +0530, Ravi Kumar Bokka wrote:
> This patch adds dt-bindings document for qfprom-efuse controller.
> 
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  .../devicetree/bindings/nvmem/qfprom.yaml          | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/nvmem/qfprom.yaml:  while scanning a block scalar
  in "<unicode string>", line 31, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 35, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/nvmem/qfprom.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/nvmem/qfprom.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/qfprom.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/nvmem/qfprom.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/qfprom.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/nvmem/qfprom.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1307399

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

