Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF7C2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAC920753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589323002;
	bh=F8thMHFpOoTc+X+oX0gWc13vqkuqc5TqpRly24TLFBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NC5apNrupqQK5wTvUMvDJi+DxFyqQl9BXPQ4177k8roI7SPb3662uNVCa4mJjhU/Z
	 5891wkulWupQd6MteDZSLiecmVVEZzHtpAwPL05+ZV2YJBSsLaZQ8wBv8z2Uc9JHRr
	 spjwmoxFVsdBbGB4m+1KqdQCawrsjnLKzEu3Al38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgELWgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:36:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33447 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbgELWgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:36:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id o24so19747670oic.0;
        Tue, 12 May 2020 15:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMxDIXDzLCKt7/FZAgJOYUjlucyVAROiKIdkVoNPTcE=;
        b=H/R0E+irhlDRdwJ860RBSH0wuZv8pxyn4hUv8y2kZyeABLjl1HLzwBrlNgIrTqlpTO
         OVUhroObgqK0eBSCr5UgDcRSQ0p5ifNETwxRiYGLCCQs5EpNUZumeJCPZTMGhJQMC7Ui
         Y3WBAdNrG1zvYdToXehQ3/+f+8Q67gYrvsCIDZvpwPHDvTFLBCigM+MLY0xFWRdPX9QG
         NHOybB8WflB4tNY7HSYAexFHIaU3lN+lHjIadWm7Un4fzavtJavW/VApin6ODZiUMvLF
         Ei5cwRNDCABcL6wPMApAEx2gJDe7r4D3Us2E+tx3wtI9M2IO4/W28uMpNIzdbkIvcfuZ
         qGtA==
X-Gm-Message-State: AGi0PuYyUpZN/bGSw09bDrtOggzqQ1WOVUQlw4xfUrP8nchsfYUvP06z
        olcF6jdtzioBP+tHwSnWaQ==
X-Google-Smtp-Source: APiQypJwnhyxtltXnPyrLYLZJfq4iQV22Gfpsa8yAlB/wGQ6opTOCR9z7OkySss3KITYFyLX2D2A0w==
X-Received: by 2002:aca:c546:: with SMTP id v67mr23978628oif.84.1589322997255;
        Tue, 12 May 2020 15:36:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h189sm853803oif.10.2020.05.12.15.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:36:36 -0700 (PDT)
Received: (nullmailer pid 29796 invoked by uid 1000);
        Tue, 12 May 2020 22:36:35 -0000
Date:   Tue, 12 May 2020 17:36:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     rnayak@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        saiprakash.ranjan@codeaurora.org, sparate@codeaurora.org,
        mturney@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        mkurumel@codeaurora.org, linux-kernel@vger.kernel.org,
        dhavalp@codeaurora.org, c_rbokka@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v1 1/3] dt-bindings: nvmem: Add devicetree bindings for
 qfprom-efuse
Message-ID: <20200512223635.GA29448@bogus>
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-2-git-send-email-rbokka@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589307480-27508-2-git-send-email-rbokka@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 23:47:58 +0530, Ravi Kumar Bokka wrote:
> This patch adds dt-bindings document for qfprom-efuse controller.
> 
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  .../devicetree/bindings/nvmem/qfprom-efuse.yaml    | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml:  while scanning a block scalar
  in "<unicode string>", line 30, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 34, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/nvmem/qfprom-efuse.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/nvmem/qfprom-efuse.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1288685

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

