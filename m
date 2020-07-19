Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D829C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D77621744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIGJo3xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGSWWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSWWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:22:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A095C0619D2;
        Sun, 19 Jul 2020 15:22:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so7770917pls.9;
        Sun, 19 Jul 2020 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QP8qQ2p5avBdXQA2nBAY5X1Qqfpbaf6zXvGPQgmznGs=;
        b=CIGJo3xgRucjp5JBHghwe78JC9naVlrJgh2+uweGqt/1YV1pnmt2Q8Qg14etC/ugZ9
         WuaiFCb1SexXsfIiN/yK404RVMHqIHwt1ZFG1yfl0bOA2PLOL4nvByK99B2Etx8iGdwt
         I5MeMmIFeKzDMY/HuxepbkXPdEQ9pGnrzaG7Yktee8qzT56ZGzUrFlKl6cxkuWoV75XJ
         DI9RJcNXxkzCFNNR9gdF8+4XDwFUru09pGUZW/o+4BCOIP+QjtskGACyG5UBEGsWhMlC
         /rD++QgHyshWrVUPA0VYe4RjID/Qd3OOW/7G96M96ovnTYw+cBtGoYrl6bY8YtoySQ5X
         1Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QP8qQ2p5avBdXQA2nBAY5X1Qqfpbaf6zXvGPQgmznGs=;
        b=G2DiQl9MgBSWOeB8FRv01vuhuEst5MOKm5oUpxPech1O4zAkdGv0OPZjhFLcbj/o6x
         5fY4nbmlU4VhwP1Pqqu0lo24zDsPCbekMp+iF1hFQjsYkt/h6uc30kTi5wwxvSl0Zmn3
         Ms5tjhFwzg4XUohjkPaU0zJL2RB4iIyl/rG0/y8NuHLg5QdzsEInfNcQIe2F54eoWWql
         szLKCOCGE6lIxSMKgKfvmLAMrPl9z2RSh1ftEZSjRwFfsLU3F+FoKW47mnFVuc0baIpl
         BOuQo1ZpjYLHW6bOp6UxDMwQfHFH8Pl1/8kvk90J0FJvjpyWFV8Wb44PaU8wNJy7Dg09
         pXAw==
X-Gm-Message-State: AOAM533uXOVwY+7FJX2/eeyusAWo2LTzL2MeWAY858zDPdSpnaCGu5c+
        WlbjAD6uFQDTpWR3nlU+Klg=
X-Google-Smtp-Source: ABdhPJxuQ4dAfbCSy0LligSucfdKVj67MtooSVzEPuwxG94aGsldF4y3rz0MZ8nCeS2gwjxbEONZkg==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr21670132pjb.170.1595197344672;
        Sun, 19 Jul 2020 15:22:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8sm15635667pfu.68.2020.07.19.15.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 15:22:23 -0700 (PDT)
Date:   Sun, 19 Jul 2020 15:22:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqil@google.com
Subject: Re: [PATCH] dt-bindings: hwmon: adm1272: add
 adm1272-adm1275-temp1-en binding
Message-ID: <20200719222222.GA78762@roeck-us.net>
References: <20200710004258.296017-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710004258.296017-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:42:58AM +0000, Chu Lin wrote:
> Problem:
> 	adm1272 and adm1278 supports temperature sampling. The
> current way of enabling it requires the user manually unbind the device
> from the driver, flip the temperature sampling control bit and then bind
> the device back to the driver. It would be nice if we can control this in a
> better way by reading the dt.
> 
> Solution:
> 	Introducing device tree binding adm1272-adm1278-temp1-en. If the
> flag is set, flip the temp1_en control bit on probing.
> 
> Testing:
> make dt_binding_check
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>  Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> index 1ecd03f3da4d..4403fe30f005 100644
> --- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
> +++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
> @@ -15,6 +15,8 @@ Optional properties:
>  
>  - shunt-resistor-micro-ohms
>  	Shunt resistor value in micro-Ohm
> +- adm1272-adm1278-temp1-en
> +	Enable temperature sampling. This is supported on adm1272 and adm1278

I suspect this should be something like "analog,temp1-enable". Either case,
I would suggest to resend the series and copy DT maintainers at least on
this patch.

Thanks,
Guenter

>  
>  Example:
>  
> @@ -22,4 +24,5 @@ adm1272@10 {
>  	compatible = "adi,adm1272";
>  	reg = <0x10>;
>  	shunt-resistor-micro-ohms = <500>;
> +	adm1272-adm1278-temp1-en;
>  };
