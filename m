Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A4BC3B18A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006E1218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgBMKyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:54:20 -0500
Received: from foss.arm.com ([217.140.110.172]:44846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:54:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 804641FB;
        Thu, 13 Feb 2020 02:54:19 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134BA3F6CF;
        Thu, 13 Feb 2020 02:54:17 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:54:13 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, viresh.kumar@linaro.org,
        f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Message-ID: <20200213105413.GA23374@bogus>
References: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
 <1581566330-1029-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581566330-1029-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:58:49AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI could use SMC/HVC as tranports. Since there is no
> standardized id, we need to use vendor specific id. So
> add into devicetree binding doc.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index f493d69e6194..dacc62dc248b 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -25,6 +25,7 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  protocol identifier for a given sub-node.
>  - #size-cells : should be '0' as 'reg' property doesn't have any size
>  	  associated with it.
> +- smc-id : SMC id required when using smc or hvc transports

IIUC, "arm,smc-id" is preferred more.

Why did you drop "arm,scmi-smc" ?

--
Regards,
Sudeep
