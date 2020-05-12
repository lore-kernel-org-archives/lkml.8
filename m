Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F3C2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CF223126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589323588;
	bh=EO45bDm9+0Fogd+gV/k2+dRRMcWlbNQq3BDPs6njVaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LLBbOWagq7CFZ/nOqkgTlsIrYFhYJ/LBafBz1YwsvGIRMZEQUjNCgkK+jlbLupajd
	 gOlFiiq92s+gfX3sQc5t9tv12Nrqku7qP4m5MZ2sDQuaYZtJbstPsuoFGQEomIHyvR
	 xCmj+1jdQqMBdszdiNayooUJEe+JJyR3fS/HPb74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgELWq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:46:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34567 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:46:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id c12so18752870oic.1;
        Tue, 12 May 2020 15:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NEH+7SARXeuh8kiPRG/4dEfu8xc6xOm69JDfLXrymY=;
        b=doVjEtUfJp4gYJjHAEoanjvfpJ6nLRkZNwoJWL1TrWmQFRYPqud+rzgdeNbmnrCoUS
         v5ItkNfSxMM01sjpOICDl0BHxLg69x3/xGNZN8NPeMhy2/J4EC0QxNheZ9ullMRuUXMj
         WqdS5zO71sL/xdYJMYxjS8fHL/Tqh3yaHqJezasP/BAT66y7uxxK92r8sfkx87j8dgao
         XIORxKTKXtb2xskP+2Lk3qF3ZtEFye8U1EDm0rb/CRFDEXGWovFsaS5+Sv9aEafA4nuJ
         Ko9xQEyirx6H5NF/WLTiUeLdP4wkpKJVBz0Ws+nqWTNLZizo5JaEKt5KA5n6ozGNcyh8
         AA2w==
X-Gm-Message-State: AGi0PuaGLy7g9wAnVV3BbihCDLzuRDZNkb2fNzOXiuKYyNxCZikSjrlN
        SG4v5vdsqayUnW6mTfXNNw==
X-Google-Smtp-Source: APiQypJgZjsNILFhaWjt+kB9/f8g2HY/ByKnFjus4qryCE4IopPXggQZRvyvg4JU/6hrhvK9adXRiA==
X-Received: by 2002:aca:53cd:: with SMTP id h196mr25365798oib.104.1589323586174;
        Tue, 12 May 2020 15:46:26 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 62sm3790678ota.65.2020.05.12.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:46:25 -0700 (PDT)
Received: (nullmailer pid 15065 invoked by uid 1000);
        Tue, 12 May 2020 22:46:24 -0000
Date:   Tue, 12 May 2020 17:46:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     mturquette@baylibre.com, agross@kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        bjorn.andersson@linaro.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/8] dt-bindings: mailbox: Add YAML schemas for QCOM
 APCS global block
Message-ID: <20200512224624.GA14949@bogus>
References: <1588573224-3038-1-git-send-email-sivaprak@codeaurora.org>
 <1588573224-3038-2-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588573224-3038-2-git-send-email-sivaprak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 May 2020 11:50:17 +0530, Sivaprakash Murugesan wrote:
> Qualcomm APCS global block provides a bunch of generic properties which
> are required in a device tree. Add YAML schema for these properties.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  [V4]
>   * Addressed Rob's review comments
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 88 ----------------------
>  .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 86 +++++++++++++++++++++
>  2 files changed, 86 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
