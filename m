Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D70C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D48C214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581070120;
	bh=8jLe6rSSf6FWHXfitPl09OLektearNo8HZpSCtWDM4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TbhxqMAbT4sKc3UJzMIIfedgG3jqLmlQzpTeED24D2617O+VfzEpr71HMw/6t1uOs
	 wfir3N/+lO2QSAZyllUjr73qggWgR+jp6kfLetClJmCMQxMpFp6pOoUxb9s6ObMsfq
	 y9aSiZJjoMYnl5m6CIGFSq1X7jIdCoz0mVdvfehg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGKIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgBGKIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:08:39 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A0C20838;
        Fri,  7 Feb 2020 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581070118;
        bh=8jLe6rSSf6FWHXfitPl09OLektearNo8HZpSCtWDM4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wl1qroiicDKU9khmi8OtLGmq1rxCX687CNqtMQN8VxNmeVesN2CwljNFD+4HRVhLe
         FJVHrVJD+gNAGldMbsyRowJQhFJDngdJJ1p7Ou88YtJxfMorECIUGsrnCFbkvwgCmJ
         o1fmNSDqXtrbaT44q9vc4bft47V+7545cvLwzNGs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j00Yu-003VJ6-IL; Fri, 07 Feb 2020 10:08:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Feb 2020 10:08:36 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     peng.fan@nxp.com
Cc:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, andre.przywara@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
In-Reply-To: <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
Message-ID: <7875e2533c4ba23b8ca0a2a296699497@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peng.fan@nxp.com, sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, f.fainelli@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-06 13:01, peng.fan@nxp.com wrote:
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
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index f493d69e6194..03cff8b55a93 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -14,7 +14,7 @@ Required properties:
> 
>  The scmi node with the following properties shall be under the 
> /firmware/ node.
> 
> -- compatible : shall be "arm,scmi"
> +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
>  - mboxes: List of phandle and mailbox channel specifiers. It should 
> contain
>  	  exactly one or two mailboxes, one for transmitting messages("tx")
>  	  and another optional for receiving the notifications("rx") if
> @@ -25,6 +25,8 @@ The scmi node with the following properties shall be
> under the /firmware/ node.
>  	  protocol identifier for a given sub-node.
>  - #size-cells : should be '0' as 'reg' property doesn't have any size
>  	  associated with it.
> +- arm,smc-id : SMC id required when using smc transports
> +- arm,hvc-id : HVC id required when using hvc transports
> 
>  Optional properties:

Not directly related to DT: Why do we need to distinguish between SMC 
and HVC?
Other SMC/HVC capable protocols are able to pick the right one based on 
the PSCI
conduit.

This is how the Spectre mitigations work already. Why is that any 
different?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
