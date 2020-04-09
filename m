Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A8FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D7B20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR1P9Yaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDIUdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:33:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgDIUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:33:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so4239181plr.11;
        Thu, 09 Apr 2020 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4SVDgN+C0tk45KKPvKPH2audguqznA2eb50JRgni7xU=;
        b=VR1P9YajX8xf0bhzUGipEzuU0IJbACEc1yGsZgSRtRhXW01lSu+eHhCDA8hhBzMMEA
         Z9NafHl1FNHgSfPq1gL2x86TmxMdX/olc5Q1+X0mexxz8Q36F+FPyfPlqXa2B0/QLela
         1bCGKT1EK9eTFAhn8+X9E549oT4QAqffFgwMJqRXWuBCxSO1mSU8faWwmiCty6pDktp8
         7ygCZeZvjSDoWNnioBu8KaCV1AigVMwL1d57JuQEzRNIAFcpl62savNaLVRKOt47/G4S
         U5b6NietzpVGnIH1NlzmiOXV2ZA0X4kPadz5P7l9xEUfhs6/sXZCWZ2jkFM++FYuyX0A
         eGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4SVDgN+C0tk45KKPvKPH2audguqznA2eb50JRgni7xU=;
        b=D3jeCVUXIQk1c3mY6q1cQycChEIzo00AsyMxkqe3Cegonw8+Z9EInGiGo6wE3yvwPv
         l4u0HlX2hqJe2Z6/J3U+aawz0ibvzVv2dYiRi31UMo/g7XiHpMSM7ahj0/1twY/+bWJV
         9tFxzH5blNqXgdONGXfU+yzG4XI+CKaQ0r9vlNAcp/2/cPQVQfIAcTmn3XdvdZDZfUk1
         PWEcMRIYCwI6jio23PDcZJ8q3702okXuZBd9sQ1LhJHsEqOal2k7g58jozl+gLbqaZfi
         65wP/5BntHkkvXrACb/ndYvZK0bY0/MpgBj71UpKQe44paxoPp75o7K2jDx/dM6zuxWE
         PSYA==
X-Gm-Message-State: AGi0PuZWKtQZY08zH/h41uszD5SElC4NxmW8ay1/s5LlpeZy7yShz1nE
        NgQx0zqM5HS1f7OGJuy4xhY=
X-Google-Smtp-Source: APiQypJYO/LqKd+ZR+Upyyv6N8ejP4NQFYcNUfx8WDETT5uQGgeME1tRvPM1titORrQcYNY+YCkRUg==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr1422940pjb.145.1586464395801;
        Thu, 09 Apr 2020 13:33:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm16040880pfd.140.2020.04.09.13.33.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 13:33:15 -0700 (PDT)
Date:   Thu, 9 Apr 2020 13:33:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Fix incorrect $id paths
Message-ID: <20200409203314.GB143353@roeck-us.net>
References: <20200409202516.25282-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409202516.25282-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 02:25:15PM -0600, Rob Herring wrote:
> Fix the path warnings in the adi,axi-fan-control and adt7475 bindings:
> 
> Documentation/devicetree/bindings/hwmon/adt7475.yaml: $id:
>   relative path/filename doesn't match actual path or filename
>   expected: http://devicetree.org/schemas/hwmon/adt7475.yaml#
> Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml: $id:
>   relative path/filename doesn't match actual path or filename
>   expected: http://devicetree.org/schemas/hwmon/adi,axi-fan-control.yaml#
> 
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Will take this via the DT tree.
> 
> Rob
> 
>  .../devicetree/bindings/hwmon/adi,axi-fan-control.yaml          | 2 +-
>  Documentation/devicetree/bindings/hwmon/adt7475.yaml            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> index 29bb2c778c59..7db78767c02d 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2019 Analog Devices Inc.
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/hwmon/adi,axi-fan-control.yaml#
> +$id: http://devicetree.org/schemas/hwmon/adi,axi-fan-control.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Analog Devices AXI FAN Control Device Tree Bindings
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index 76985034ea73..46c441574f98 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/adt7475.yaml#
> +$id: http://devicetree.org/schemas/hwmon/adt7475.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: ADT7475 hwmon sensor
> -- 
> 2.20.1
> 
