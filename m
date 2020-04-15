Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1311C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08D5206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2aiBz4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635619AbgDOIIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:08:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635561AbgDOIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586938028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDdYfSg43KpYWuuPakF4B4tcdGZPYljqQUL9gLxwyrs=;
        b=W2aiBz4ualxEo/496vq76TreYWhNzLmc3EAetuqeGhLNdcNJPmw+A/CPTI6Jg6XcLu1qnN
        SaQX4AN0ZHp+WR2jiwJGwhwgEhxxbAYUbjzkG+Oa8x6g9EiqWWkZF6mzADyyGrGNf1s7TZ
        UFGA0r2SvIA+yYr7Gn2SF8GILNjhYlc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-P9wXlSKWOL-EXoRNtwSBLA-1; Wed, 15 Apr 2020 04:07:06 -0400
X-MC-Unique: P9wXlSKWOL-EXoRNtwSBLA-1
Received: by mail-wr1-f72.google.com with SMTP id q10so3643767wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDdYfSg43KpYWuuPakF4B4tcdGZPYljqQUL9gLxwyrs=;
        b=fv1KvyLktcwNM0VapT4jRzOEOiic93+5WwxMsPFTakokmW3yl7UnFMHAn6fWz8Ip4u
         C2BQ/wmNMWDXWIz3sazPyaahnQcydTtqhwtrfEemGoC7jaHmI0iQbAsSEsUecILm9rTa
         aD6OcOFXuuG1SixBQVBs+TB8dH6UZCFAEt8ilP4UVZFZU46bS8VwpHUcPF1tzLMoaos6
         EQBrFTgbPBxMGuvbqz2dTWqOxKEQWzB0d+L6u67MxNqunMFskOlrVSQG5MFo74rkKPmz
         3SnWdbpYf8lOjRktBUiZPQF8bvMnxcsk95tEs9fYsars61JuYELwbr1W7DtuN6TET0GV
         feRg==
X-Gm-Message-State: AGi0PubX+5Mp2zh+XX46pFtE5UYT81eNxmhNsPnsmB+XDk1ehVJY9m4e
        +Lfz03WpYE6g/YJz6HhCMfvKipxY1vgohQflQ+2boSNvVcFHsyK0lmJDQZ0m4gSDsiBS+YB9Sb4
        WIwpRh74HV1KDKKv44BzRX+41
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr4163561wmr.25.1586938025008;
        Wed, 15 Apr 2020 01:07:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLM8/guNljwdxt33+rGLqxJ5oJ/t0p2TiWjT5KUdTEEF6BNudkLy+55c9aOC9WA4m3vasp/fw==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr4163541wmr.25.1586938024762;
        Wed, 15 Apr 2020 01:07:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m14sm20326145wrs.76.2020.04.15.01.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:07:04 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_charger: Omit superfluous error
 message
To:     Tang Bin <tangbin@cmss.chinamobile.com>, sre@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8f9ae92b-9aab-34a2-dc15-a9c3514c7ca8@redhat.com>
Date:   Wed, 15 Apr 2020 10:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/15/20 6:27 AM, Tang Bin wrote:
> In the axp288_charger_probe(), when get irq failed, the function
> platform_get_irq() logs an error message, so remove redundant
> message here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>

Thank you for this nice cleanup patch:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/power/supply/axp288_charger.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index 1bbba6bba..16fb4ae1c 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -825,10 +825,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
>   	/* Register charger interrupts */
>   	for (i = 0; i < CHRG_INTR_END; i++) {
>   		pirq = platform_get_irq(info->pdev, i);
> -		if (pirq < 0) {
> -			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
> +		if (pirq < 0)
>   			return pirq;
> -		}
> +
>   		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
>   		if (info->irq[i] < 0) {
>   			dev_warn(&info->pdev->dev,
> 

