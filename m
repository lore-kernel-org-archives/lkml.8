Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB6C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A3B20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCTMBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:01:11 -0400
Received: from foss.arm.com ([217.140.110.172]:48106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgCTMBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:01:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA5D31B;
        Fri, 20 Mar 2020 05:01:10 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E89A3F85E;
        Fri, 20 Mar 2020 05:01:07 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:01:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt: psci: Add arm,psci-sys-reset2-vendor-param
 property
Message-ID: <20200320120105.GA36658@C02TD0UTHF1T.local>
References: <1583435129-31356-1-git-send-email-eberman@codeaurora.org>
 <1583435129-31356-2-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583435129-31356-2-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

On Thu, Mar 05, 2020 at 11:05:27AM -0800, Elliot Berman wrote:
> Some implementors of PSCI may wish to use a different reset type than
> SYSTEM_WARM_RESET. For instance, Qualcomm SoCs support an alternate
> reset_type which may be used in more warm reboot scenarios than
> SYSTEM_WARM_RESET permits (e.g. to reboot into recovery mode).

To be honest, I'm still confused by this series, and I think that these
patches indicate a larger problem that we cannot solve generally (e.g.
on other platofrms and/or with ACPI).

I think the underlying issue is whether the semantics for:

a) Linux's RESET_WARM and RESET_SOFT
b) PSCI's SYSTEM_RESET2 SYSTEM_WARM_RESET

... actually align in practice, which this series suggests is not the
case.

If those don't align, then I think that commit:

  4302e381a870aafb ("firmware/psci: add support for SYSTEM_RESET2")

... is not actually reliable, and not something we can support by
default, and we should rethink the code introduce in that commit.

If (a) and (b) are supposed to align, and the behaviour on your platform
is an erratum, then I think we should treat it as such rather than
adding a property that is open to abuse.

Thoughts?

Thanks,
Mark.

> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 8ef8542..1a9d2dd 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -102,6 +102,13 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/arm/idle-states.txt
>  
> +  arm,psci-sys-reset2-vendor-param:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +        Vendor-specific reset type parameter to use for SYSTEM_RESET2 during
> +        a warm or soft reboot. If no value is provided, then architectural
> +        reset type SYSTEM_WARM_RESET is used.
> +
>    "#power-domain-cells":
>      description:
>        The number of cells in a PM domain specifier as per binding in [3].
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
