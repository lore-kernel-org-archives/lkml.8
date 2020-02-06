Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30DC352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03B3214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581026392;
	bh=UPOTq0a1wwemy3i0Bqe1m6zV6WB9xk2D9tJOiwwIqAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I4kwbGUI6Mf7tee+WyxqckNOdDZ6i2RWljD4Qs68Yf7CxLzBILGJMAeH3YS48iypg
	 vgZRAXJiaXCUiwF2NT+pEwV4JZJ6AvXt+jzv3ogyC+6XhF9hvIQUqyppXgfqz+D1Wo
	 YgYWqrxjR0WKQ94ZMOV4jMYlMNLO1OxUFdbCJ2jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBFV7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:59:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:59:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so97293pll.13;
        Thu, 06 Feb 2020 13:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVXixa0B18zMPBUSYheGAsct/qyckxIS2tHmquk4WAY=;
        b=gJH5kA6dCGEhZ/3W03hp6v/kLHQtNaGbLVveZZzxmn4ccBop06p7TniQvv61wknVov
         lJJwxRj5ZfA2PMXRwmcQpLjO8Pm2zi7mcfxFoCIKwy39mpvrTZTAjKDHimHtE5CoEv+o
         8RWzlGHkw6CPp/cSlKdlNomL5a6EAOo0zV7kW3wP+vhJu41QXOsvyGZQFgXxb31LXsLg
         ygVE/TCvXZu3wqw4TA0poWzqp4szDa+6rbQI8RgvWOMkffQwUVLRBSbsieuHd2epwDjX
         tvzVWgQDPRCMi7C8zDKQKDic5/+B5O5rq1Ou7+8l0eNI58YPDHptH34ZK7uzGTch/fRZ
         2S4w==
X-Gm-Message-State: APjAAAUT7Uc0eLCACGklNlG4ABPUbGvbnJmjbgmldvPzjuPdoi/UQQgP
        5xSsVKevPa3c/aa6CyKefw==
X-Google-Smtp-Source: APXvYqzQ9YsVc8gaumvlVWv2GaV+63IJpG8P6rBR7UaLfsBaOKX7ODYfLVMDfZ2RjAeHqRqV4JhmWg==
X-Received: by 2002:a17:902:d205:: with SMTP id t5mr6261830ply.138.1581026389477;
        Thu, 06 Feb 2020 13:59:49 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id v25sm343170pfe.147.2020.02.06.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:59:48 -0800 (PST)
Received: (nullmailer pid 23357 invoked by uid 1000);
        Thu, 06 Feb 2020 21:59:47 -0000
Date:   Thu, 6 Feb 2020 14:59:47 -0700
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     sudeep.holla@arm.com, mark.rutland@arm.com,
        viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Message-ID: <20200206215947.GA21514@bogus>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:01:25PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI could use SMC/HVC as tranports, so add into devicetree
> binding doc.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index f493d69e6194..03cff8b55a93 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -14,7 +14,7 @@ Required properties:
>  
>  The scmi node with the following properties shall be under the /firmware/ node.
>  
> -- compatible : shall be "arm,scmi"
> +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
>  	  exactly one or two mailboxes, one for transmitting messages("tx")
>  	  and another optional for receiving the notifications("rx") if
> @@ -25,6 +25,8 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  protocol identifier for a given sub-node.
>  - #size-cells : should be '0' as 'reg' property doesn't have any size
>  	  associated with it.
> +- arm,smc-id : SMC id required when using smc transports
> +- arm,hvc-id : HVC id required when using hvc transports

Don't the SMC ids get standardized?

>  
>  Optional properties:
>  
> -- 
> 2.16.4
> 
