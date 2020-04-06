Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D5C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A0C21D7A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zY1kXP2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDFMds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:33:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgDFMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:33:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so14941202wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5JCqf97/DKBM1QS5WGd/SUELCzyeEQ70qy+I4TgOFeQ=;
        b=zY1kXP2HO33tQ2ZkUAJ/jNEECu2MXgoeH44JpVJhSnnlQt1J2j+UEZGAX4oQzRMi7F
         2pZlg1bbdNGFw4E5qPlIX0XBHzLoYNHrpFquq6B6KSXfrNCRG4V+XaQ1HjYyqhntHH5X
         PlerEGiVHm0EEi24k0+tQED1iKpPOxPx0vYSoXJyQNbNSduW9MPJLQ6tcUX+ZnHiRc7I
         /3H2baaFNqmCaTkL3lfDofU2MtokK+VSFPEMUSMGjMlgoU7OWnawel9X/Qe1H3rzNOxA
         bF+6EOO6wN5eIUoh1PPLC4wvy0pGPecrU//RJdRPdCG2lZx2AIeW00ob/ZfOekq6VrwH
         j5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JCqf97/DKBM1QS5WGd/SUELCzyeEQ70qy+I4TgOFeQ=;
        b=ZBcC24PjiTC/rmwD8/W5Dq1gQoHRKxpkG+Hebfylc4afoumft70FF/0R/rzbEG8Cxf
         1lAdQJZ7LzdqUgIbl5tjFWbWOJbi3b857iapEP1pocz+NUsAjGoK1MoLpZA03Oz1XLT+
         0Ce9cS/j8vYmm0LHwUQql1BkQvOI8bfjEcjCDl+8JEzojMnQmL2OmDw41HyWeVvTRD8N
         xrPALhZCbkvHgPWB+POeoP4/8yUt9gc/p9B4sDD/q3xdwog4lhQWxaY2qWDURrIy23i9
         8IvwF94h83gKqbUguN5OwrfkrttciPfoxX3SKAqhI6M6ZX5p4eUPHS4CRZ5EVXJWhs/1
         1kYw==
X-Gm-Message-State: AGi0PubLB0lexV/zYHbeVdk8peGBPaMnPPJ+d4PmB/fTDjcehpGODKf9
        4trjOTtmBI76kzQp3QiVRUubR8BEhCI=
X-Google-Smtp-Source: APiQypI2vPLoGfUpnuQm87l7ziHhn33LjPFZVTmzJUdHMUEeR+XXP+Ofc0J/GUl0TQstZuB8bRe7XQ==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr22203109wrc.285.1586176424587;
        Mon, 06 Apr 2020 05:33:44 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t16sm3998269wmi.27.2020.04.06.05.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:33:43 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: don't consider subnodes not matching
 binding
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     kernel@pengutronix.de, Christian Eggers <CEggers@arri.de>,
        linux-kernel@vger.kernel.org
References: <20200323152850.32657-1-a.fatoum@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d59007d1-f4e3-f550-cecd-64b788a534bc@linaro.org>
Date:   Mon, 6 Apr 2020 13:33:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200323152850.32657-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2020 15:28, Ahmad Fatoum wrote:
> The nvmem cell binding applies to objects which match "^.*@[0-9a-f]+$",
> but so far the driver has matched all objects and failed if they didn't
> have the expected properties.
> 
> The driver's behavior in this regard precludes future extension of
> EEPROMs by child nodes other than nvmem and clashes with the barebox
> bootloader binding that extends the fixed-partitions MTD binding to
> EEPROMs as it tries to interpret the "fixed-partitions"-compatible
> partitions node as a nvmem cell.
> 
> Solve this issue by skipping all subnodes that don't contain an @.
> 
> This still allows for cell names like `partitions@0,0', but this
NACK.. thats nasty hack!
Its standard practice as per device tree specs to have nodes name as 
"node-name@unit-address"

Ref: 
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf


> is much less likely to cause future collisions.

There have been discussions on this topic in the past at:

https://patchwork.ozlabs.org/patch/890741/

We need to come up with a better solution!

--srini

> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>    use ->full_name instead of ->name as to not break existing correct
>    cells (Christian)
> ---
>   drivers/nvmem/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243f36..f051051fb1a8 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -278,6 +278,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   	parent = dev->of_node;
>   
>   	for_each_child_of_node(parent, child) {
> +		if (!strchr(kbasename(child->full_name), '@'))
> +			continue;
>   		addr = of_get_property(child, "reg", &len);
>   		if (!addr || (len < 2 * sizeof(u32))) {
>   			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
> 
