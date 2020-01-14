Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2550C24684
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijdJg9u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgANONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:13:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55625 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgANONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:13:39 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so5754641pjz.5;
        Tue, 14 Jan 2020 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RqFXdgT3LlFr0BDIsZ4AkGZfGr6feSH5yxzOu+zCNSA=;
        b=ijdJg9u0y8HQtUMQC6bTqYlb+yzR+A9CetjNaAiOUJ8y48b2GdY/MmEYcpEvTBchSU
         QA+02mmmPreon+F8I+rs37vSly1Vj4ushL4+K+Dl5TeUgzWW3EllM5RJiVVHdX3lO8VA
         BgPZ2FLkKWidqhteoQcwiMx6iD0nY2BPxZDaR4bHH1NvkH6sA8I8aCpfLBmZDoCiSZ10
         /b/d44sjfOHnproo3KAhstLlbkMKMUUJ2LmgYksPDtLwNQrkKb6O+qXZH4P0q7SN+Pp7
         7Sg/IzqGl2QRmHXTq/76dOIQHdWJEbm+VSZw+bTTrJDYMrWpT4rnrTNVQfe2yf6enM7R
         Q2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RqFXdgT3LlFr0BDIsZ4AkGZfGr6feSH5yxzOu+zCNSA=;
        b=Ky6UweRvxD8f3RHqC0aZCzsJCscEGmrNxuCG/g8hX7pxJl5bJ2M5Vhx4xZh87hiar2
         JjvMm71SOSvt0bcoytV97ITJDMJ+ktPb0SIFRo+GsrgXuPCAwUtu3Am/C4q7Jfo9XU1W
         /VvIbFs7F6dmo+V3wA3HFVhN2X3IMeGa4IGYZScw78dGL+S5W27245rIqFzoCsyOBWUz
         maIBL97A5i+64JnO7+ptfEL1vMYBRf0eH0Q5SiSnzRJrAr3MrGvtmUUcOspyDyTCcgWN
         2lFppun1NbVYFN4pH6ZYDz3COkdlMfN/tWZ5J6HauDQEQU4MMNFCKMUla8U8N0tFcWuv
         QUrQ==
X-Gm-Message-State: APjAAAVB5AZ8MOgKtaZ2vYf2cAzv7nMLb/sQSUG8bQgJyvZ8qkjW+7DP
        ZA9lJxT4BTuHI2Eh2eIIiWA=
X-Google-Smtp-Source: APXvYqxjQGSoPS5oTAT9D0cQglVKshJ9Vv9jKAtTk9hoiRjnujw/stvy9RNQ7AGtuzfCkLCiyrYtQw==
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr29363741pjc.20.1579011218933;
        Tue, 14 Jan 2020 06:13:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10sm13391223pjq.14.2020.01.14.06.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 06:13:38 -0800 (PST)
Date:   Tue, 14 Jan 2020 06:13:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, biabeniamin@outlook.com
Subject: Re: [PATCH v4 3/3] MAINTAINERS: add entry for ADM1177 driver
Message-ID: <20200114141337.GA28002@roeck-us.net>
References: <20200114112159.25998-1-beniamin.bia@analog.com>
 <20200114112159.25998-3-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114112159.25998-3-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:21:59PM +0200, Beniamin Bia wrote:
> Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
> Changes in v4:
> -nothing changed 
> 
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd5847e802de..a71f56d3b891 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -975,6 +975,15 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  F:	drivers/iio/imu/adis16460.c
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>  
> +ANALOG DEVICES INC ADM1177 DRIVER
> +M:	Beniamin Bia <beniamin.bia@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +L:	linux-hwmon@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/hwmon/adm1177.c
> +F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> +
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org
