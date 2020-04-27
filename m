Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC60C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415052070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588023145;
	bh=2IjQwIhrptN/fqPSNXeW1+xvC3us1QlTGTFVeWQwO3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8GId/NfjrNVohaROzGxvwhDPlrwF/mcgfqHPi1jyn2g9eyMb3qGmx0qUTszYTS6i
	 UAqMU6/UkOyt1s8IRXySz/y3KrmSCIuPmiY74d/1giswKtwVHDcHqkOX375M1Dw2s8
	 5liGOG4md3TNi84u857XdDENsbR4kM4PmKHpAt9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgD0VcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:32:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37516 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgD0VcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:32:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so29038819oto.4;
        Mon, 27 Apr 2020 14:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Lh+W+OrenE6K2KqGrfInjEdQRXHsGOZ4lqRiJD6MSc=;
        b=c6g2vj4V3cHMD8kFn4weU/AIYo+gM+sPe22XEYfKMerEdd/zlvtF81c41xx8h7yh+a
         4Gkn99huJ2V/htmznhpdnjDVvuC9/ktdAnYe8C6LyWDruw0jtQynL9vk17to3DVXWW6o
         2g9c1xraufNRWBIVnLGrOiAZpKX3YlKyRrOvhXS2xRzKp98oQgOgfqgll0jwIRvQqQ4X
         C5Oi/KhKwp1bMIKzUmuENPxVilXNojQIDc6wsDOg3uJk15QrmvUaxwa1thLn8IU0Q0Y6
         pH4n9r3u88471KdmU0k8bbIFOzcEdoDh67LAk7blpVtIn2TeGgC1dHldtUec/tRcnvf9
         WBrg==
X-Gm-Message-State: AGi0PuZUaaPAdZK1MBsB4SaDxYsD0tJwadwXeScKGJXfk98oSu+rcy+N
        2+tYoQk+PTkhQ8B9iaZJ/w==
X-Google-Smtp-Source: APiQypIC4V0z/17lmRjDdI8o+qgwAzOCFqathXFshoqhtN6/h6jNp7YOpy+L5UvfgaRJ8EfmPt4ziQ==
X-Received: by 2002:a9d:7304:: with SMTP id e4mr10136654otk.243.1588023143159;
        Mon, 27 Apr 2020 14:32:23 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s73sm4337780oih.14.2020.04.27.14.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:32:22 -0700 (PDT)
Received: (nullmailer pid 31871 invoked by uid 1000);
        Mon, 27 Apr 2020 21:32:21 -0000
Date:   Mon, 27 Apr 2020 16:32:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: actions: Document Caninos
 Loucos Labrador
Message-ID: <20200427213221.GA31480@bogus>
References: <f9e48fba-0da8-7ba9-d44a-7909067a1df1@castello.eng.br>
 <20200426165835.105970-1-matheus@castello.eng.br>
 <20200426165835.105970-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426165835.105970-3-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 13:58:34 -0300, Matheus Castello wrote:
> Update the documentation to add the Caninos Loucos Labrador. Labrador
> project consists of a computer on module based on the Actions Semi S500
> processor and the Labrador base board.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/actions.yaml | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/arm/actions.yaml:  while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 24, column 1
Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/arm/actions.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/arm/actions.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/arm/actions.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/actions.yaml: ignoring, error parsing file
warning: no schema found in file: Documentation/devicetree/bindings/arm/actions.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/actions.yaml: ignoring, error parsing file
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1277145

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
