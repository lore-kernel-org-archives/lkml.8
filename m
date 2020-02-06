Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D2C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6982821741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaUsdJDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBFLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:50:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgBFLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580989811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0m6hUgjurvubbH9fgcIpOSpOggrFujmjO/VSj3cDIk=;
        b=OaUsdJDFWqkhuWk/lIX1yvDGTDIiKDLBw8bGMsRc+7SSaW7zoLh9FwSdnyDoL8YvrgfmBj
        0Sm8cpbWmfHRDDHzODCSQVixDt+33gQppvEUCi/L++QVX/OHLERVO8xdBzHidsSYEWcMfM
        rfm2XAQtOQTBHUI8EEsfL4KbSSr22lM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-_XXCTmwRO5SDQ8k7v1_8QA-1; Thu, 06 Feb 2020 06:50:09 -0500
X-MC-Unique: _XXCTmwRO5SDQ8k7v1_8QA-1
Received: by mail-wr1-f71.google.com with SMTP id s13so3242836wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0m6hUgjurvubbH9fgcIpOSpOggrFujmjO/VSj3cDIk=;
        b=qB9MHeAhDDQDI93dcHo/UV68RrAQPsh14zc7Qopgx9eYTJzM7a3bJPUM0mZoBb4k7G
         w+0+lLtAFd55lfIti+mFGDMli02anLJjLDeEiu7pjd0WJcB8JlNkjeW2M6uCV4C0jBAL
         AuWQLSv32hRjvpcisZ+8b0pq4zjc5jbEruRv65hO4BLNKr2OaGXEgIrhBkuQUTuK2Zak
         C9/K30Edcdi1Z4c4JjREz3x4j1wApYVDyeOKJR9+j1yQ6h6Xj98C7IptMfwtfVbK0JqH
         Fiig7gTY8O9JSyMIau3EcLfVGzFphj0UXKJB1lFpvilATZzfUSHG7iGJrjNWlAmApD9q
         e2OA==
X-Gm-Message-State: APjAAAWjaIMJdTxe/Hhl9iU+PV7G7yAk2qT56ERdQ5CH1wp2tY+datMP
        KsMpJjADAUebjPG/f8JsW7F6WYrapRAfRPBEQDKcHvsvzrxci9ShBqhrJOvaGx903nsDMEKtecE
        UW1MfndVjU6U3pbyiQKn41jjE
X-Received: by 2002:a7b:c407:: with SMTP id k7mr4321220wmi.46.1580989807745;
        Thu, 06 Feb 2020 03:50:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5VYfjKfZRYNlahF2fKL5l7AV53TsvDCkTeqFBD04fnQO77xZw5rTWNGzIdfV/0AK88uogXA==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr4321199wmi.46.1580989807494;
        Thu, 06 Feb 2020 03:50:07 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id s139sm3479456wme.35.2020.02.06.03.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 03:50:06 -0800 (PST)
Subject: Re: [PATCH] ata: ahci_platform: add 32-bit quirk for dwc-ahci
To:     Roger Quadros <rogerq@ti.com>, axboe@kernel.dk
Cc:     vigneshr@ti.com, nsekhar@ti.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200206111728.6703-1-rogerq@ti.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d3a80407-a40a-c9e4-830f-138cfe9b163c@redhat.com>
Date:   Thu, 6 Feb 2020 12:50:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206111728.6703-1-rogerq@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/6/20 12:17 PM, Roger Quadros wrote:
> On TI Platforms using LPAE, SATA breaks with 64-bit DMA.
> Restrict it to 32-bit.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/ata/ahci_platform.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 3aab2e3d57f3..b925dc54cfa5 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -62,6 +62,9 @@ static int ahci_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>   
> +	if (of_device_is_compatible(dev->of_node, "snps,dwc-ahci"))
> +		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
> +

The "snps,dwc-ahci" is a generic (non TI specific) compatible which
is e.g. also used on some exynos devices. So using that to key the
setting of the 32 bit flag seems wrong to me.

IMHO it would be better to introduce a TI specific compatible
and use that to match on instead (and also adjust the dts files
accordingly).

Regards,

Hans



>   	port = acpi_device_get_match_data(dev);
>   	if (!port)
>   		port = &ahci_port_info;
> 

