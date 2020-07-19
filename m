Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78367207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjzXAPoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGSWF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgGSWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:05:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FFC0619D2;
        Sun, 19 Jul 2020 15:05:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s189so9366570pgc.13;
        Sun, 19 Jul 2020 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v8inPLX/0d5UZLUkRaGLJwDQpFgbuMBj393w/lPdLVg=;
        b=bjzXAPoNAs/7XVQIxkHDgRiJQqdOqPhnpjmKcqg0srk7yJxe5HrKZFRZTZdmbKUodb
         XvVhXt2fArPCTyLfNgWb0vrl/vxylIXbCx/eH518Mx2pFj1FaQOwklDRDhY2AiLXnBAu
         24bTxJAk8H9kNKz2pgmhYePzUTVIrDK6c/4utQxqQDtKI4P3/a89QOeYcYhgQVzedyrV
         Zb0FBpegtFoPOkF5SrM3hIb1jlhmQiCD7E8IlqbWP8x2PDiVEcjXvx5XwRJqVxLzMcBG
         ZMkF9DgBtXMrda6knKY7yG611nsVsrOxvwHAqyfgo39v3WYZf+VlcxOL0v/6d69Z+vrZ
         yyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v8inPLX/0d5UZLUkRaGLJwDQpFgbuMBj393w/lPdLVg=;
        b=AB09Cwe0Ie8F5W7kbFeIr0K4KT2Wy//tWuNY2yFBKY5erFzUu+dZHkGYf4RGCrvvNs
         F9cPZ2iLr838gvi3XVN2VNoRwuR3EwuI7fRUAsrLiu2E7E5Rme9cgZ2sD3q0jmOpdSdB
         JU9IdMRGfmtfu1VvbVUaBxgO69rl7QI2lkaEJKdHzehDIlMVMofJ9ZGTqNQ8/0UUlBIf
         tHby9GM139SL52LI/qZhXQiqAckTv9NgdlXG2A9gaAjBapUM8nPVq1Zhp1YrvBJh7SbN
         cbGdJvd1ChQCqNhia3lB9ooYhgbmlsAGWMzMEyHiyC1oiwM5fOONDStbi5IGKx+UJg3Z
         xOvA==
X-Gm-Message-State: AOAM5337AKMV9qMXU4KpihspN+g+b80ku1Qg/WtAfHjPfu/lK381/Ng+
        i/ZLx9KP6XtLQaPO2EfA4iw=
X-Google-Smtp-Source: ABdhPJw4exbQ13irlmb+oxrq7u4X7GGAbFmBJDxw6yGGSYQjJX1vqRA1PGIwW0axf6r4Lt9KFRP17w==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr17747215pff.132.1595196357815;
        Sun, 19 Jul 2020 15:05:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u26sm14618370pfn.54.2020.07.19.15.05.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 15:05:57 -0700 (PDT)
Date:   Sun, 19 Jul 2020 15:05:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for v5.9] docs: hwmon: Replace HTTP links with HTTPS ones
Message-ID: <20200719220555.GA77859@roeck-us.net>
References: <20200719170420.60399-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719170420.60399-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 07:04:20PM +0200, Alexander A. Klimov wrote:
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
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

hwmon series applied.

Thanks,
Guenter

> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/hwmon/adm1275.rst  |  2 +-
>  Documentation/hwmon/lm25066.rst  |  6 +++---
>  Documentation/hwmon/ltc2978.rst  |  6 +++---
>  Documentation/hwmon/max20751.rst |  4 ++--
>  Documentation/hwmon/max34440.rst | 12 ++++++------
>  Documentation/hwmon/pmbus.rst    | 18 +++++++++---------
>  Documentation/hwmon/tps40422.rst |  2 +-
>  7 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/hwmon/adm1275.rst b/Documentation/hwmon/adm1275.rst
> index 49966ed70ec6..ce6528f90e4a 100644
> --- a/Documentation/hwmon/adm1275.rst
> +++ b/Documentation/hwmon/adm1275.rst
> @@ -49,7 +49,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
>  
>  Author: Guenter Roeck <linux@roeck-us.net>
>  
> diff --git a/Documentation/hwmon/lm25066.rst b/Documentation/hwmon/lm25066.rst
> index 30e6e77fb3c8..9f1d7e4d3ca1 100644
> --- a/Documentation/hwmon/lm25066.rst
> +++ b/Documentation/hwmon/lm25066.rst
> @@ -11,9 +11,9 @@ Supported chips:
>  
>      Datasheets:
>  
> -	http://www.ti.com/lit/gpn/lm25056
> +	https://www.ti.com/lit/gpn/lm25056
>  
> -	http://www.ti.com/lit/gpn/lm25056a
> +	https://www.ti.com/lit/gpn/lm25056a
>  
>    * National Semiconductor LM25066
>  
> @@ -55,7 +55,7 @@ Supported chips:
>  
>  	Datasheet:
>  
> -    http://www.ti.com/product/LM5066I
> +    https://www.ti.com/product/LM5066I
>  
>  
>  Author: Guenter Roeck <linux@roeck-us.net>
> diff --git a/Documentation/hwmon/ltc2978.rst b/Documentation/hwmon/ltc2978.rst
> index bc5270e5a477..b99a63965cfb 100644
> --- a/Documentation/hwmon/ltc2978.rst
> +++ b/Documentation/hwmon/ltc2978.rst
> @@ -179,7 +179,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.analog.com/ltm4680
> +    Datasheet: https://www.analog.com/ltm4680
>  
>    * Analog Devices LTM4686
>  
> @@ -187,7 +187,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.analog.com/ltm4686
> +    Datasheet: https://www.analog.com/ltm4686
>  
>    * Analog Devices LTM4700
>  
> @@ -195,7 +195,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.analog.com/ltm4700
> +    Datasheet: https://www.analog.com/ltm4700
>  
>  
>  
> diff --git a/Documentation/hwmon/max20751.rst b/Documentation/hwmon/max20751.rst
> index fe701e07eaf5..f9febefce02d 100644
> --- a/Documentation/hwmon/max20751.rst
> +++ b/Documentation/hwmon/max20751.rst
> @@ -9,9 +9,9 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX20751.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20751.pdf
>  
> -    Application note: http://pdfserv.maximintegrated.com/en/an/AN5941.pdf
> +    Application note: https://pdfserv.maximintegrated.com/en/an/AN5941.pdf
>  
>  Author: Guenter Roeck <linux@roeck-us.net>
>  
> diff --git a/Documentation/hwmon/max34440.rst b/Documentation/hwmon/max34440.rst
> index 5744df100a5d..162d289f0814 100644
> --- a/Documentation/hwmon/max34440.rst
> +++ b/Documentation/hwmon/max34440.rst
> @@ -9,7 +9,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34440.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34440.pdf
>  
>    * Maxim MAX34441
>  
> @@ -19,7 +19,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34441.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34441.pdf
>  
>    * Maxim MAX34446
>  
> @@ -29,7 +29,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34446.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34446.pdf
>  
>    * Maxim MAX34451
>  
> @@ -39,7 +39,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34451.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34451.pdf
>  
>    * Maxim MAX34460
>  
> @@ -49,7 +49,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34460.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34460.pdf
>  
>    * Maxim MAX34461
>  
> @@ -59,7 +59,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34461.pdf
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34461.pdf
>  
>  Author: Guenter Roeck <linux@roeck-us.net>
>  
> diff --git a/Documentation/hwmon/pmbus.rst b/Documentation/hwmon/pmbus.rst
> index 2658ddee70eb..ea2b9b081391 100644
> --- a/Documentation/hwmon/pmbus.rst
> +++ b/Documentation/hwmon/pmbus.rst
> @@ -21,11 +21,11 @@ Supported chips:
>  
>      Datasheets:
>  
> -	http://www.onsemi.com/pub_link/Collateral/ADP4000-D.PDF
> +	https://www.onsemi.com/pub_link/Collateral/ADP4000-D.PDF
>  
> -	http://www.onsemi.com/pub_link/Collateral/NCP4200-D.PDF
> +	https://www.onsemi.com/pub_link/Collateral/NCP4200-D.PDF
>  
> -	http://www.onsemi.com/pub_link/Collateral/JUNE%202009-%20REV.%200.PDF
> +	https://www.onsemi.com/pub_link/Collateral/JUNE%202009-%20REV.%200.PDF
>  
>    * Lineage Power
>  
> @@ -53,15 +53,15 @@ Supported chips:
>  
>      Datasheets:
>  
> -	http://www.ti.com/lit/gpn/tps40400
> +	https://www.ti.com/lit/gpn/tps40400
>  
> -	http://www.ti.com/lit/gpn/tps544b20
> +	https://www.ti.com/lit/gpn/tps544b20
>  
> -	http://www.ti.com/lit/gpn/tps544b25
> +	https://www.ti.com/lit/gpn/tps544b25
>  
> -	http://www.ti.com/lit/gpn/tps544c20
> +	https://www.ti.com/lit/gpn/tps544c20
>  
> -	http://www.ti.com/lit/gpn/tps544c25
> +	https://www.ti.com/lit/gpn/tps544c25
>  
>    * Maxim MAX20796
>  
> diff --git a/Documentation/hwmon/tps40422.rst b/Documentation/hwmon/tps40422.rst
> index 8fe3e1c3572e..32a62ccea192 100644
> --- a/Documentation/hwmon/tps40422.rst
> +++ b/Documentation/hwmon/tps40422.rst
> @@ -9,7 +9,7 @@ Supported chips:
>  
>      Addresses scanned: -
>  
> -    Datasheet: http://www.ti.com/lit/gpn/tps40422
> +    Datasheet: https://www.ti.com/lit/gpn/tps40422
>  
>  Author: Zhu Laiwen <richard.zhu@nsn.com>
>  
