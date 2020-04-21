Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFAEC38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DEB20782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgDUC7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDUC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:59:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6AFC061A0E;
        Mon, 20 Apr 2020 19:59:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id C6B722A11CD
Message-ID: <2d1da0b9d857c5607c989be85a04c9d7d9d19b38.camel@collabora.com>
Subject: Re: [PATCH v4] dt-bindings: rockchip-vpu: Convert bindings to
 json-schema
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh@kernel.org
Date:   Mon, 20 Apr 2020 23:59:33 -0300
In-Reply-To: <12f6d7cf-6af6-4f54-3188-65e73b703a72@gmail.com>
References: <20200326191343.1989-1-ezequiel@collabora.com>
         <12f6d7cf-6af6-4f54-3188-65e73b703a72@gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Johan,

On Mon, 2020-04-20 at 15:33 +0200, Johan Jonker wrote:
> Hi Heiko,
> 
> This patch was applied by the media people Hans and Ezequil without note
> and test I think.
> 

I did test it, but I guess something felt thru the cracks.
If you'd be kind enough to submit a patch, that would be lovely.

Thanks!
Ezequiel

> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> 
> Errors for example:
> 
>   DTC     arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml
>   CHECK   arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml
> arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: video-codec@ff350000:
> interrupts: [[0, 9, 4]] is too short
> arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: video-codec@ff350000:
> interrupt-names: ['vdpu'] is too short
> arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: video-codec@ff350000:
> interrupt-names:0: 'vepu' was expected
> 
> See:
> https://lore.kernel.org/lkml/20200403124316.5445-1-jbx6244@gmail.com/
> 
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    oneOf:
> +      - const: vdpu
> +      - items:
> +        - const: vepu
> +        - const: vdpu
> 
> Vs.:
> 
> 
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: vepu
> +      - const: vdpu


