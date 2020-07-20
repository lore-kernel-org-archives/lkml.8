Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F25D2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmKUYfsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgGTXmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTXmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:42:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311FC061794;
        Mon, 20 Jul 2020 16:42:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so9832569pfc.10;
        Mon, 20 Jul 2020 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dwf64VoPveqHaMsqSb3Glspy3+Et16aff8CDM8+xs3Q=;
        b=AmKUYfsZw2qswY7IAGom6z7jj65jSxabtAsf7Ek3iIaqvTiFIMfXoKDGTtryrDGXto
         RSMQphyEJw3IeY0OYM2fORusYHwMcz5pBGAi9U63eIaZ71vvVToAt5xN4DkV19b9fDFz
         Ehl4r9McXwxYTGldRZmqxa3JSaj44TE2DrdSAk+H5WvO1tmc1zhPBMI51KHWglcK8MpQ
         dy3F8YcdDQ0bN35SnDO7v5JO/eADreEso5z7fMaLu8q/4+X6IFS/uHmvN1i4kjw9p3jz
         xnpM/UaBs1jq55jF0hfGVPWInmGywJiGJG/LvqEpgDCz/6uPKazaRLryb1DWea/by9u7
         TbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dwf64VoPveqHaMsqSb3Glspy3+Et16aff8CDM8+xs3Q=;
        b=WCu1k521jl7M67R8WNMnFA9/XKdV718uTP/6OiVN88iEbtYEMPv6rBl+qC64WEYfrl
         Qq7sPST2oh1wzLvNyw8PBaQpf5urrKBjkeZWjyxc6U9nHz6oD2ZgL2fUxanAkwnMna68
         Whf32QlWKAqvtLJXvMFwxPVj01M3pGQLW1lNUjLmUiL862Qqzf228Ctb8EnMGM2MGYvS
         o1GQlofMFFWF5R5nGB5hoecYfBxT2KUHbIShUFTKCIAT8xjG2pl2cIyncn1pXLAbvFP9
         s9hLtGLfNdsrtzmNGoMsN0GjiXyx+YVtedLujT9j7W3Xv8HUTGSh/usRmzbpVnG8v+Kn
         8Vww==
X-Gm-Message-State: AOAM530C30OGImj60wY2acntjbi2Rung19UsAYQGl1Q/MKjK5EYvoKQC
        qW7T9ahptSOJGcV4vnDbAETJjHn4
X-Google-Smtp-Source: ABdhPJwUn4rw/Tr157znRKEJ0Lygyt+vcIFd9uUiucFIazJpHMQkEp+eZJIovKMdODmpVL30M8TX9Q==
X-Received: by 2002:a62:d44d:: with SMTP id u13mr22594854pfl.21.1595288566094;
        Mon, 20 Jul 2020 16:42:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bx18sm672226pjb.49.2020.07.20.16.42.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 16:42:45 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:42:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, =belgaied@google.com,
        jasonling@google.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqil@google.com
Subject: Re: [PATCH v2] dt-bindings: hwmon: adm1272: add
 analog-temperature1-enable binding
Message-ID: <20200720234244.GA34281@roeck-us.net>
References: <20200720201422.1869389-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720201422.1869389-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 08:14:22PM +0000, Chu Lin wrote:
> Problem:
> 	adm1272 and adm1278 supports temperature sampling. The
> current way of enabling it requires the user manually unbind the device
> from the driver, flip the temperature sampling control bit and then bind
> the device back to the driver. It would be nice if we can control this in a
> better way by reading the dt.
> 
> Solution:
> 	Introducing device tree binding analog-temperature1-enable. If the
> flag is set, flip the temp1_en control bit on probing.
> 
> Testing:
> make dt_binding_check
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
> ChangeLog v1->v2:
>   - Rename adm1272-adm1278-temp1-en to analog-temperature1-enable

This needs to be either analog,temperature1-enable or analog,temp1-enable
(comma instead of '-').

Thanks,
Guenter

> 
>  Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> index 1ecd03f3da4d..7a345c7794a2 100644
> --- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
> +++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> @@ -15,6 +15,8 @@ Optional properties:
>  
>  - shunt-resistor-micro-ohms
>  	Shunt resistor value in micro-Ohm
> +- analog-temperature1-enable
> +	Enable temperature sampling. This is supported on adm1272 and adm1278
>  
>  Example:
>  
> @@ -22,4 +24,5 @@ adm1272@10 {
>  	compatible = "adi,adm1272";
>  	reg = <0x10>;
>  	shunt-resistor-micro-ohms = <500>;
> +	analog-temperature1-enable;
>  };
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
