Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC89C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4922F206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbEk651S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEKLdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729441AbgEKLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:33:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5649C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so10509841wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aghPrnxgIqTUh49Mv3GDkYVcU8sexFcoivHzenw7/H0=;
        b=sbEk651SXVWVUfKgOyAuNMUY0Rez/6FVOuhR7fakxiZncWRUCspzC598sOYUWP1JHA
         fy8/5B0h/rqg9UAOBDF/WBFjLk/PQR+FDvj6BrJPz1XBiR8wM92UPMSUHO+R+0GvKjhF
         RLc7KyQGAjo05d+lkhBTYY5Ab4NrA0EVFRH1IprvuuB94B4DnQwx4m9cy2jqHg5l+yhr
         R1QXzo9n9g50waU6k5QD6bj74oj2LEnQhBztabZDyQLrs98T5DK95cMeuU9bsV0HvJZP
         nP+ErxcZb+HbgITrLARb6ZzXPY1uNqphBbuFAjT8KnU/1qXb7N4hrjPztAnC9oZ9T/oM
         neQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aghPrnxgIqTUh49Mv3GDkYVcU8sexFcoivHzenw7/H0=;
        b=eywg5PUHwjy6Dgmt/JXXeSR9jHV5vyfRcDbk1BGgRd+RZZG89xWJuQc4rsnRMbu4Ue
         +oleOOntWbfF9C2HilPcPPGAbRp7a/uZgA7uX06/yeEtfaFesJFNy51VOYWowEYgz+80
         K6bKsPeuLiFlWdLFyaP4Zh7LQuVSPbm7piynZm6KLfhGO0RE9MEJGIDQmGVU32EIfrJU
         389UwLVhX71TBRLu42hYrnGy0WRUkxUfbzpa/a7DCis2GqJOv6PpENGbLA/MyxWfdUzy
         y04Vw+3BsdRJ/ofagNO9LNJzxsRpz4tDeohGjdsXiGLOc2/g7EDks4Mxaaij6YSfncyp
         Wmxw==
X-Gm-Message-State: AGi0PuY9vt8ar1WhXDsXHpwcBT+D9vVevxmw4dztkcHXPAQHc824/VXc
        nHrIN/0QW9s2qTuMkQVsLhMzE1mKyhc=
X-Google-Smtp-Source: APiQypJCD68/DdWjBAXUQwIfF/NSQMFW7UV/BZY7MMKd7QVOoucMJmxZJrmHKlk5MkU93TQYoDWsTg==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr1272019wrw.5.1589196829086;
        Mon, 11 May 2020 04:33:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q74sm19714950wme.14.2020.05.11.04.33.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 04:33:48 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] nvmem: core: skip nodes with compatibles other
 than "nvmem-cell"
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        linux-kernel@vger.kernel.org
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200428111829.2215-3-a.fatoum@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d03d60b0-1907-1aaf-bc98-3ae9869194df@linaro.org>
Date:   Mon, 11 May 2020 12:33:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200428111829.2215-3-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2020 12:18, Ahmad Fatoum wrote:
> The nvmem cell binding used to apply to all objects which match
> "^.*@[0-9a-f]+$", without taking a compatible into account, which
> precluded extension of EEPROMs by child nodes other than nvmem.
> 
> A previous commit changed the binding, so that nvmem cells that
> feature a compatible property must have "nvmem-cell" as the value,
> otherwise they are skipped.
> 
> Adjust the driver to observe the new binding change. This change
> does not change behavior for any device tree that was already
> compliant with the nvmem binding.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Thanks for the patch, this looks good to me, lets wait for Rob to ack 
the bindings!

--srini
> ---
>   drivers/nvmem/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 05c6ae4b0b97..eb697f5ad07d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -547,6 +547,10 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   	parent = dev->of_node;
>   
>   	for_each_child_of_node(parent, child) {
> +		if (of_find_property(child, "compatible", NULL) &&
> +		    !of_device_is_compatible(child, "nvmem-cell"))
> +			continue;
> +
>   		addr = of_get_property(child, "reg", &len);
>   		if (!addr || (len < 2 * sizeof(u32))) {
>   			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
> 
