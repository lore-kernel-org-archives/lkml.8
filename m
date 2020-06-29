Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E841C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC802076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468192;
	bh=VYq1lNey2fUgvALFz3SVmrQzywX/IIBoBeJKA6zhCz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cVBo5my2zsbo5e6YV2rJLHr45pNbydfZS6I7Y3kfWvPVO3qzgAHpCxX4FhrgJgfoF
	 amB58JiXOJbw9+aBwZbTrACd+x0e37Sa/6VbA5KVoJ4GuVYKH5RBvGetjbQJDlFj4h
	 GsD8Ylrg4CaGd6275QkgIQnQBH2Df57IkmrGyy7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbgF2WDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:03:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgF2WDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:03:00 -0400
Received: by mail-io1-f66.google.com with SMTP id m81so18904143ioa.1;
        Mon, 29 Jun 2020 15:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qeDnTuAisnNg9/O14eqv1V2d4bV/j01IJYJfWygBKh0=;
        b=DASQe9TWevNWg1Vn/H8vEWvgzHPDnwTN0KdN1sK1nVh2td2aZqmgdnstNGxb3V0Yz7
         xFD1+zyThQMfBORXqBMeNVa4fBtI4FXjvG/u1MYS54jdH76+vU14OQzfN8auC/Blg+mg
         sPZVnsyIyRVhsQ0dslf54tDCdp+CMy72BhiHl34RYJ/xMrGX6GxPg8LzmYYH4Wcje4Wd
         yZXh9sPCIJ1/1zzp3brVs4X9dNSRmDlR3p7HPhaPWSTyIQ3lAHXclZ+EAa0BVXy0LicS
         qGczzkzdtas5e7P519WVtoClfIhh8weaT8O0WqN3C1XzpCJenNa6wAZb5tbRNtLFwYRL
         5S3Q==
X-Gm-Message-State: AOAM530UBoRg9e7bqGDQBHxVqC/N39JxdiNflBJgjJHQBb+M1eadT4XD
        qEyoP+eP2DFxfLi6FJb7Sg==
X-Google-Smtp-Source: ABdhPJzJ5YH3Vs6Vibf5Q6Ji55Ezz3QnGARqFca/oQxAeka0ngDHcH9kK7ABYD+UNidUKik6XfPh0w==
X-Received: by 2002:a02:9041:: with SMTP id y1mr20056027jaf.143.1593468179688;
        Mon, 29 Jun 2020 15:02:59 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id q5sm602363ilm.73.2020.06.29.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:02:59 -0700 (PDT)
Received: (nullmailer pid 3016912 invoked by uid 1000);
        Mon, 29 Jun 2020 22:02:57 -0000
Date:   Mon, 29 Jun 2020 16:02:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Bhushan Shah <bshah@kde.org>, Sam Ravnborg <sam@ravnborg.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        dri-devel@lists.freedesktop.org,
        Purism Kernel Team <kernel@puri.sm>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 02/13] dt-bindings: panel: Convert rocktech,
 jh057n00900 to yaml
Message-ID: <20200629220257.GA3016084@bogus>
References: <20200626005601.241022-1-megous@megous.com>
 <20200626005601.241022-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626005601.241022-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 02:55:50 +0200, Ondrej Jirman wrote:
> Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../display/panel/rocktech,jh057n00900.txt    | 23 -------
>  .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml:  while scanning a block scalar
  in "<unicode string>", line 51, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 58, column 1
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1317299

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

