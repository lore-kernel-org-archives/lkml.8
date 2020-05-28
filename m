Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A682C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28E220814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590675351;
	bh=5rkdDhvLnr0HQbP4/kDxx+h7aXgJ7zet0owDXLHQxJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IAvAsNtZBANi3xC/q7SrqXyIEXR7jf77duvtwg7Q+ckO/b/mNSJDDIJuv03yVcNyZ
	 D3aO/DhetrEnPltviZZk6TOHkjEjzbQK1SE6dFaymddkwdEm4datBHxMWjAehLjZyx
	 2SzXCbUPs/fmNPLOvDHahCRSK8Z5RQAHK8H7RD0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbgE1OPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:15:49 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43561 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390900AbgE1OPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:15:46 -0400
Received: by mail-il1-f195.google.com with SMTP id l20so229544ilj.10;
        Thu, 28 May 2020 07:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Je+Wciu3uBC2CRy874Nn2/ScwzmE+3jA16l+4SU5qIk=;
        b=WHuqkKqVPMQGfqiAln1ZOIOdYRXaUMhmuAwijW0ZDSWK/K9WFZjKj7L+A11U3Zrvfv
         5DkDAOsNSuLYHIjBcisq93rDfwTPund4ubzcBL1SUZ5qTH+HL/a880/Zmh0mju9ZYiXC
         KrAhgoVyFWN2M27f+r8n8neKvWLcPDYubwBCYZUocR+ij1qY71UHyw6Zslq/1HMXgUNK
         p886nCEwuWl/ZVQdQsxmT4wT4HlWmy9cRMkmNd/qJ97wnislLMdCtFe+Y576oNLte7+g
         nfUVbSgFMbYWwUH8z+VDt4/Pnsiv2aE/2PfPar3xKN8avLBx27VlLCPFpmDyiJKKMLZi
         3VSw==
X-Gm-Message-State: AOAM5314Rpic8aqMfgQlZoIpp+yLb4G8wAgOdSa3Giv/PCmkCrsrxfpZ
        A11qQW6iSYM7xwsH5nzfIw==
X-Google-Smtp-Source: ABdhPJxqgYgQsTnkwnSdGoqz/4f0E7HlZ7jvhwSGKnRTHkVRl/yC0BQTNyjlTd0+HmAG45bgvBjFLA==
X-Received: by 2002:a92:8c0d:: with SMTP id o13mr2892315ild.117.1590675344761;
        Thu, 28 May 2020 07:15:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q6sm3419232ill.59.2020.05.28.07.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:15:43 -0700 (PDT)
Received: (nullmailer pid 4186889 invoked by uid 1000);
        Thu, 28 May 2020 14:15:42 -0000
Date:   Thu, 28 May 2020 08:15:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     robh+dt@kernel.org, ryans.lee@maximintegrated.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, steves.lee.maxim@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [V6 PATCH 1/2] dt-bindings: Added device tree binding for
 max98390
Message-ID: <20200528141542.GA4186430@bogus>
References: <20200528103755.17381-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528103755.17381-1-steves.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 19:37:55 +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> Changed since V5:
> 	* Change txt to yaml and fix up the examples.
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example
> 
>  .../bindings/sound/maxim,max98390.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/sound/maxim,max98390.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 22, column 97
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/sound/maxim,max98390.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/sound/maxim,max98390.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/maxim,max98390.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/maxim,max98390.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/maxim,max98390.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/maxim,max98390.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1299651

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

