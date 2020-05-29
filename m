Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8923206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFF+g2WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407587AbgE2D17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407291AbgE2D15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:27:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34405C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:27:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d10so678723pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YfQD59/8VXpWRfWyl7lhMnw3JHFFbKj7kQDpDrTZ2Aw=;
        b=zFF+g2WBv4BPtKeJQa4f87xC8rOOizNvHRjpnPOoO692vzyZ1e3TH9d/vHE+EJ/KP+
         AA+At0QGCpzTRuoAfgiBOYSuZw89Ol72yGXdqwZtujOqJL458prjozh8rhX8Ec2SyHNY
         0f5Dupic0ZTh5kVynbbjzsc8PozzY+xKT5ffUDdpXLEuACp/93jKtDDbeI0xjKWQvGjj
         v4McRdW70GPhIoD/EOp+1/v6dAzXz3LdQccFX0I/hcxPLCdxtWN9dJ2NACxzOhxJGO7t
         KkigzWhMnvAZUWyFwL7Mcqv7CfNpPCckyLWkwWOvJqFzZVBUxdMFJzVgm5RKWnPX4+Oq
         Kb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YfQD59/8VXpWRfWyl7lhMnw3JHFFbKj7kQDpDrTZ2Aw=;
        b=OCp/+nSNp9ThXDtYg3Hi9NYHrnf9k2RztxssTqG93GXcwdJgGZXeVh8DX8EOURFglo
         jilYv34/a5MlZ50bMR9t3gSmzNjYSKqcjhgIQNlM9xRIPZ6iqN1ljazW7M4W2rONFSRE
         CjTiqn0pCmb5Ojc+068pfBaaXn8XPuHYf0p0e1lJKyU9iYq0Fla8q2eTZNK+JHCmW4g5
         rxGc/ehzpy+daNRpPleig9wQWMmQOSj9nKN00wFB3MOzWGMdB1Q75BLCLhNDxsY4MM29
         f4BJlcuGW4vRXhzwXKXSeMFTpMp7URqpeb6kGJIpYLFbGp8KqrkxtBOuDuYJmRTQi1+G
         FKlA==
X-Gm-Message-State: AOAM530aT4PK8VUkCsYXSyih+qVcl1NA6cdx2JAf0E5zWChCjs42EZa2
        8NmJqrgbrjOvi1llUrObUO+6og==
X-Google-Smtp-Source: ABdhPJylV+ZqVxVNM6+iLvxKmK2pwW48QRbVcI4+ub5B9Xk/g+pOb4LOAtupoBzcRcZbi/tPJIIJgA==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr6367008pfc.228.1590722875630;
        Thu, 28 May 2020 20:27:55 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v12sm6171985pjt.32.2020.05.28.20.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:27:54 -0700 (PDT)
Date:   Thu, 28 May 2020 20:26:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: rename spmi node to spmi_bus
Message-ID: <20200529032649.GD279327@builder.lan>
References: <20200523132104.31046-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523132104.31046-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 May 06:21 PDT 2020, Jonathan Marek wrote:

> The pm8150 dtsi files refer to it as spmi_bus, so change it.
> 

Applied. Also removed "qcom," from the node name while we're poking at
the line.

Thanks,
Bjorn

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 04c9c215ffcd..a273b99bf1e6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -578,7 +578,7 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> -		spmi: qcom,spmi@c440000 {
> +		spmi_bus: qcom,spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0 0x0c440000 0x0 0x0001100>,
>  			      <0x0 0x0c600000 0x0 0x2000000>,
> -- 
> 2.26.1
> 
