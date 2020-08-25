Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925092071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kV5mTYPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgHYMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgHYMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:44:18 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F5C061574;
        Tue, 25 Aug 2020 05:44:18 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D69115C234A;
        Tue, 25 Aug 2020 14:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1598359451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IZQHFETOpjnhPeM+CTUxB0PCC3vGiT/h25l4mGED5A=;
        b=kV5mTYPL00hXKtDehuNlhVBXVoopFZyBR32wotpKs0Uf2t6AsDgRbzxmLqhCdaXDsPW8iY
        OF+84r6uLjz1jnXn+o57uSxkY+XU6pE/dL6ssjSUnxZsyp7sObDV9yjoVyVQoL1v5gni+T
        lz2PILM5rKaWpQ4fkivJ88xE9JVIXGA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 14:44:11 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Chris Healy <cphealy@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, maitysanchayan@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, stable@vger.kernel.org,
        andrew.smirnov@gmail.com
Subject: Re: [PATCH v4] dt-bindings: nvmem: Add syscon to Vybrid OCOTP driver
In-Reply-To: <20200825030406.373623-1-cphealy@gmail.com>
References: <20200825030406.373623-1-cphealy@gmail.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <a0a1958d393eb92ecc884be7a0dc0449@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-25 05:04, Chris Healy wrote:
> From: Chris Healy <cphealy@gmail.com>
> 
> Add syscon compatibility with Vybrid OCOTP driver binding. This is
> required to access the UID.
> 
> Fixes: 623069946952 ("nvmem: Add DT binding documentation for Vybrid
> OCOTP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
> Changes in v4:
>  - Point to the appropriate commit for the Fixes: line
>  - Update the Required Properties to add the "syscon" compatible
> ---
>  Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> index 56ed481c3e26..72ba628f6d0b 100644
> --- a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> +++ b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> @@ -2,7 +2,7 @@ On-Chip OTP Memory for Freescale Vybrid
>  
>  Required Properties:
>    compatible:
> -  - "fsl,vf610-ocotp" for VF5xx/VF6xx
> +  - "fsl,vf610-ocotp", "syscon" for VF5xx/VF6xx
>    #address-cells : Should be 1
>    #size-cells : Should be 1
>    reg : Address and length of OTP controller and fuse map registers
> @@ -11,7 +11,7 @@ Required Properties:
>  Example for Vybrid VF5xx/VF6xx:
>  
>  	ocotp: ocotp@400a5000 {
> -		compatible = "fsl,vf610-ocotp";
> +		compatible = "fsl,vf610-ocotp", "syscon";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x400a5000 0xCF0>;
