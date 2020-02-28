Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5CC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F2C246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1Mm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:42:59 -0500
Received: from foss.arm.com ([217.140.110.172]:37676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Mm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:42:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66E794B2;
        Fri, 28 Feb 2020 04:42:58 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 229663F7B4;
        Fri, 28 Feb 2020 04:42:57 -0800 (PST)
Subject: Re: [PATCH 3/4] dt-bindings: arm: fix Rockchip rk3399-evb bindings
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200228061436.13506-1-jbx6244@gmail.com>
 <20200228061436.13506-3-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <78b8b53f-2e2a-3804-41fb-bb2610947ca2@arm.com>
Date:   Fri, 28 Feb 2020 12:42:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228061436.13506-3-jbx6244@gmail.com>
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
> arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: /: compatible:
> ['rockchip,rk3399-evb', 'rockchip,rk3399', 'google,rk3399evb-rev2']
> is not valid under any of the given schemas
> 
> Fix this error by adding 'google,rk3399evb-rev2' to the compatible
> property in rockchip.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index d303790f5..6c6e8273e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -509,6 +509,7 @@ properties:
>           items:
>             - const: rockchip,rk3399-evb
>             - const: rockchip,rk3399
> +          - const: google,rk3399evb-rev2

This looks wrong - the board can't reasonably be a *more* general match 
than the SoC. If this is supposed to represent a specific variant of the 
basic EVB design then it should come before "rockchip,rk3399-evb" (and 
possibly be optional if other variants also exist).

Robin.

>   
>         - description: Rockchip RK3399 Sapphire standalone
>           items:
> 
