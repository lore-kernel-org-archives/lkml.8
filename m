Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BA3246B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB1Mfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:35:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Mfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:35:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E87D4B2;
        Fri, 28 Feb 2020 04:35:38 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36883F7B4;
        Fri, 28 Feb 2020 04:35:36 -0800 (PST)
Subject: Re: [PATCH 1/4] dt-bindings: arm: fix Rockchip Kylin board bindings
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200228061436.13506-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <73b41bd1-01e9-6af8-afc8-b1a96614d026@arm.com>
Date:   Fri, 28 Feb 2020 12:35:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228061436.13506-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2020 6:14 am, Johan Jonker wrote:
> A test with the command below gives this error:
> 
> arch/arm/boot/dts/rk3036-kylin.dt.yaml: /: compatible:
> ['rockchip,rk3036-kylin', 'rockchip,rk3036']
> is not valid under any of the given schemas
> 
> Fix this error by changing 'rockchip,kylin-rk3036' to
> 'rockchip,rk3036-kylin' in rockchip.yaml.

Although I can guess, it might be worth a note to explain why it's the 
binding rather than the DTS that gets changed here.

Robin.

> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 874b0eaa2..203158038 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -443,7 +443,7 @@ properties:
>   
>         - description: Rockchip Kylin
>           items:
> -          - const: rockchip,kylin-rk3036
> +          - const: rockchip,rk3036-kylin
>             - const: rockchip,rk3036
>   
>         - description: Rockchip PX3 Evaluation board
> 
