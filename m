Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8486DC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A0E2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587416836;
	bh=/FpT8ksiKDbw1yVouJLSolarDDcbilaTOatw/DM0Vuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8/7RXQKBvH4nuGqLVPBIAmFsi6+ps0u/C2QQCjsFbI76MP6AiEIUv89HM79Wj9d2
	 4b2jiP9vet7mKwItTedpS7h2oclqzswcr1NaAWmraqQU/aCK7haVWOv75Y9idhsNbC
	 PPKINEyvSZyi3k+CNxwrqAIHg+qZiWCt8P7cFck4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDTVHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:07:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38468 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgDTVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:07:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id r66so10143914oie.5;
        Mon, 20 Apr 2020 14:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GTuvfZESUSaD2cb5a/OYsH9GmHAeQ64hx5GzbXm64AA=;
        b=fcm4LIvgzUFT4ZNv7pzzNhn09+ib7PmYvYIbFNmwkCpzGmkZ2ZnN+yPNjrayRFwQw8
         uSKktUZ4FLCrZ7Sa+yeRJECLsJdafFlr4A9rMyGfYVbOPt6Dy6URmnFLGyzoF/lHKhPr
         DK19ug9YPqPLAWsozYikFmNwVUNAf6toaQY37HyvqLIvXPqVOaK5Hi5eBU9JTq2bdr+G
         ePSHbPrjPNQdE7o92XKsSakzzm933f+1DcPXPsvfPh2gDhEy5tfZPW85jwDRIjep3Wyk
         Fj2Jbk2328TG44KODmjsuzHrKJXiuZlJSjyD2Hb09yV6Fu2XTpW0odNEb7Pnoj8piC1o
         +5Ew==
X-Gm-Message-State: AGi0PuYoZZoPv3iQ0vmnhNmBX8dG922CsRnVL8cD4IRnKkUXiwlJZ2H9
        b53MfXRMSrcSrW+pm3wbOw==
X-Google-Smtp-Source: APiQypKrG3RWQAvo3MmqD+u47KUx3xOLde7ElyFgphXU66gxeWTAst9XMMIpUdQZ6JbzkpLbQ6+fxA==
X-Received: by 2002:aca:dc44:: with SMTP id t65mr1015715oig.176.1587416834721;
        Mon, 20 Apr 2020 14:07:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i21sm152725ooe.26.2020.04.20.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:07:13 -0700 (PDT)
Received: (nullmailer pid 30251 invoked by uid 1000);
        Mon, 20 Apr 2020 21:07:11 -0000
Date:   Mon, 20 Apr 2020 16:07:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        jaswinder.singh@linaro.org, linux@rempel-privat.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: imx-mu: correct example
Message-ID: <20200420210711.GA30172@bogus>
References: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 21:24:27 +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The example use i.MX8QXP MU, but actually the MU is compatible with
> i.MX6SX, so add the compatible.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
