Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87634C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4978320772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRD/j9QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGCWU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCWU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:20:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD347C061794;
        Fri,  3 Jul 2020 15:20:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so13069107plq.6;
        Fri, 03 Jul 2020 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XtW4kgIxGhzSntIpFfvQDv1AeRNdLODkkUcS1jWxitc=;
        b=lRD/j9QMC8rJ3et3zghUGujtENsRH9TxKspfbynBISjt6NZMGmz/cqbMOBklK+C9ff
         2Vf3VEuQNH8iZNO7Pxoky2HPb5YGH3aArHatY63r+z/3V9keliwkOUeoJ51mj7SIZv8U
         oSijLkbyWwlz3LqAVrJV75tLnbtuvCw4Sjl0lSsTq3N+t4Mys45tw+Ea+7wwXoWeKsSb
         tLLS1zVLjyXZA5INFIJDYJG9w0EiAE2Az75gzvPnPYLtX7sszvesCfg9zx9x0Pv2tfXQ
         c6GmYqkxQD08MIAeSF8BkXutE374k11Rg2AgHp7+4SwCHwswh4vsBKR1zkjJ49Ixc7l7
         CB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XtW4kgIxGhzSntIpFfvQDv1AeRNdLODkkUcS1jWxitc=;
        b=ed8caME5aofIa/JItra4jrTC3usP8EwW43CI0ln1swM0T6LD11PjyXRzrCTq4mKAzr
         Gq8nJ5X3cHCrUjR/bcb1U2+7LBJ3CNqefWjZhKkuFqsgaaYdROm+UXv68v4qnJ67zCzf
         THvUkGWsACyP0meiEZqIqr9epY3Umaej2k+YLS8qU2wLMoGW0ML4yBJ20zdbVKGvhi+x
         pJ8iuJ4qT1Ki2e+gvuoUx1VsSy82ByKBDwLNIvDk4xKUaA168HwZd1Ast7BS/3RU4ZPo
         kiPAc6qMzZHv1qIQj5dk75OoT/eXi6CxfUscLTXocgmnGKbwILBq3/vvMBw8yizScu3e
         yY1A==
X-Gm-Message-State: AOAM531vuLKJXnWET5JSnM9aAeqwu3cJ6Dk7JfVmLPeA1/5QPjx1s2Ab
        tCmMYH+VR6jd+c2N1fW+iPw=
X-Google-Smtp-Source: ABdhPJze612DIcqR6L8aexzuHxPjvstq0GKNpx3Q6jGFnJCkC05bV4dzAz5AXtx/gux1JSL4+8oLjQ==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr29010074pjb.209.1593814857487;
        Fri, 03 Jul 2020 15:20:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm12581481pfd.166.2020.07.03.15.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 15:20:56 -0700 (PDT)
Date:   Fri, 3 Jul 2020 15:20:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        etremblay@distech-controls.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: TMP513 hardware
 monitor driver
Message-ID: <20200703222056.GA35408@roeck-us.net>
References: <20200703185657.15329-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703185657.15329-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 08:56:57PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied, after adjusting subject line to match the expected
hwmon subsystem form.

Guenter

> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml | 4 ++--
>  Documentation/hwmon/tmp513.rst                         | 4 ++--
>  drivers/hwmon/tmp513.c                                 | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
> index 90b2fa3f7752..c17e5d3ee3f1 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
> @@ -18,8 +18,8 @@ description: |
>    consumption.
>  
>    Datasheets:
> -  http://www.ti.com/lit/gpn/tmp513
> -  http://www.ti.com/lit/gpn/tmp512
> +  https://www.ti.com/lit/gpn/tmp513
> +  https://www.ti.com/lit/gpn/tmp512
>  
>  
>  properties:
> diff --git a/Documentation/hwmon/tmp513.rst b/Documentation/hwmon/tmp513.rst
> index 6c8fae4b1a75..f2dfc1677ad9 100644
> --- a/Documentation/hwmon/tmp513.rst
> +++ b/Documentation/hwmon/tmp513.rst
> @@ -9,13 +9,13 @@ Supported chips:
>  
>      Prefix: 'tmp512'
>  
> -    Datasheet: http://www.ti.com/lit/ds/symlink/tmp512.pdf
> +    Datasheet: https://www.ti.com/lit/ds/symlink/tmp512.pdf
>  
>    * Texas Instruments TMP513
>  
>      Prefix: 'tmp513'
>  
> -    Datasheet: http://www.ti.com/lit/ds/symlink/tmp513.pdf
> +    Datasheet: https://www.ti.com/lit/ds/symlink/tmp513.pdf
>  
>  Authors:
>  
> diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
> index df66e0bc1253..23908dc5611b 100644
> --- a/drivers/hwmon/tmp513.c
> +++ b/drivers/hwmon/tmp513.c
> @@ -5,12 +5,12 @@
>   * TMP513:
>   * Thermal/Power Management with Triple Remote and
>   * Local Temperature Sensor and Current Shunt Monitor
> - * Datasheet: http://www.ti.com/lit/gpn/tmp513
> + * Datasheet: https://www.ti.com/lit/gpn/tmp513
>   *
>   * TMP512:
>   * Thermal/Power Management with Dual Remote
>   *	and Local Temperature Sensor and Current Shunt Monitor
> - * Datasheet: http://www.ti.com/lit/gpn/tmp512
> + * Datasheet: https://www.ti.com/lit/gpn/tmp512
>   *
>   * Copyright (C) 2019 Eric Tremblay <etremblay@distech-controls.com>
>   *
