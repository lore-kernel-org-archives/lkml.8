Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C345C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FB9208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504122AbgDPJpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:45:08 -0400
Received: from foss.arm.com ([217.140.110.172]:58106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503597AbgDPJpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:45:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8E0FC14;
        Thu, 16 Apr 2020 02:45:03 -0700 (PDT)
Received: from [10.57.59.184] (unknown [10.57.59.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C3573F73D;
        Thu, 16 Apr 2020 02:45:02 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
To:     James Tai <james.tai@realtek.com>,
        linux-realtek-soc@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-3-james.tai@realtek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <05b02ba8-2959-48d8-be3f-c4a1a0bc88a4@arm.com>
Date:   Thu, 16 Apr 2020 10:45:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200204145207.28622-3-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-04 2:52 pm, James Tai wrote:
[...]
> +	arm_pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";

The binding updates have landed now, so you can use "arm,cortex-a55-pmu" 
here.

Robin.

> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
