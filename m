Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF590C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8690A2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584980567;
	bh=ylyAboiCvjvtXcsZ5zXBUX8wVjBy6azZWVr7YPHtxvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jy0y1zSDJJPxKxaiajhEDqq0LIr977jC2shXdo5EJkFt3UUEs1zce8wF96HeDfQMt
	 mZPrUGcEmMtcj2uNpZUUk+0+1KNjRAPsop9ANbdse6xp3as15KQjj/XTmz9qtskqT9
	 +9WqXfxH2AYQb1xUbSe1JtQ/XzTPAGFvmOcjHaZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCWQWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:22:46 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38805 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:22:46 -0400
Received: by mail-il1-f194.google.com with SMTP id m7so9597196ilg.5;
        Mon, 23 Mar 2020 09:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AogyDUiEmlQw5vvV5gkTMlCSQ1NTGUz56J9mneRbNg=;
        b=B3BjIGds0yzRRF+XP9lVZLQNBYOguBt4UTLBZFwBNRfHUI5WO+2WVWSfDfbXtg+e17
         DGLqQzxQIL5zxGzWDkGKTprLtNyEvLuVqMWZRo7QsBCUZJUvWVmEbeItPnfixqmVcAXE
         MXAA9JxqoCAcGNun58rp68RL2SennGJQYUUzF1qSWmaMvjlNN3E1IbipwwJcNq0GtVCg
         RVyR9Y6nuG7Qw/OsQ5yM9F2q/jHNJQ8c/uXi47w6JjgkYD/xAVfJuXkGCQfYM2QpKxGB
         Ot7/vdnshcclrF76w0dBYYJjvXJ+SpheExHJORzw1RiT0OCsI4cuRUnZBLsokIsheCVI
         n3Ew==
X-Gm-Message-State: ANhLgQ0jPE543ZO5GYgeczEDU7LiDmIrhQ6krvD6tBG1i1JJ69i9tcT7
        rLj2GFYwawZBt+bgZgmHcA==
X-Google-Smtp-Source: ADFU+vuyAfrL4xtCzyyFk1BrmnA4tYtXgGoAv7ML5IsBXLexidqGVitduERq3SK8EoQtiomW8ZH5HA==
X-Received: by 2002:a92:39cc:: with SMTP id h73mr21181388ilf.298.1584980565049;
        Mon, 23 Mar 2020 09:22:45 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m4sm5391558ill.78.2020.03.23.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:22:44 -0700 (PDT)
Received: (nullmailer pid 17240 invoked by uid 1000);
        Mon, 23 Mar 2020 16:22:42 -0000
Date:   Mon, 23 Mar 2020 10:22:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: remoteproc: Add documentation for
 SPSS remoteproc
Message-ID: <20200323162242.GA16639@bogus>
References: <1584754330-445-1-git-send-email-rishabhb@codeaurora.org>
 <1584754330-445-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584754330-445-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 18:32:10 -0700, Rishabh Bhatnagar wrote:
> Add devicetree binding for Secure Subsystem remote processor
> support in remoteproc framework. This describes all the resources
> needed by SPSS to boot and handle crash and shutdown scenarios.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,spss.yaml  | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 57, column 10
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/remoteproc/qcom,spss.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/remoteproc/qcom,spss.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1259273

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
