Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D854C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB8D20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDhkIBmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAMKtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:49:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbgAMKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578912538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sryvnw5c3b3zpqJMiVPTxRZdIpZiMK/8zQVbtOgTuVs=;
        b=VDhkIBmNmTgGvgm1ykqKKOr0L8FfEt83D5dlGNQKDh3A1QbDmTqQNsisOIvdLrh44J5Ffj
        juk9En4z55S0Jxx3xwkqudKXAI0+JqbRTfAtu8JufFqPthRydr8K8WrqY8dXssuAlYAdC6
        FtWOkR8Edg4yfRPZkOxI0cSdf27NJ+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-xhZ1EhEfOgGNk4movscxPg-1; Mon, 13 Jan 2020 05:48:56 -0500
X-MC-Unique: xhZ1EhEfOgGNk4movscxPg-1
Received: by mail-wm1-f72.google.com with SMTP id q26so1234603wmq.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sryvnw5c3b3zpqJMiVPTxRZdIpZiMK/8zQVbtOgTuVs=;
        b=MmTwS3d718T+GqapRztNY6dokIi0620ET61CbrFQN6ENCzIlRE/v/Qk8wxceB5kGRN
         PbC7SDznI3nDiLCxzG5EH8iL5Y7xx1BIdNilq9m6HNaBup4UQ4VEiZubBAKKxRddzng9
         y/KLdDHM2G8WWLXkkJ+x9Xy9ZSe3bzLmeNvE/vDjo+0Cf10VazcmGrxOYwmIfZg8ffhx
         SA4hF31kxosGSZOFfMiDlE32atqVxaHY/x21f30TEAT7gr4smOm8+O2cKRESZcgbLuEv
         JeOlv0MxKHMmy3614JqFRVFC8ziHPiJgUjjE/E4NIxKdZFvEQIIFvDT1mJed33xwFQEA
         snZw==
X-Gm-Message-State: APjAAAWw1blq/scbxqu3t4o8WyZv769fs+nGXYux9oadPJGNuFSsKe8P
        vKyAjnvjVJhQRuSqGUgiCOkJyZVTVfMEnWfHTNSUxi/C3Y3K3NN+T6W5rmRhsBXEoJ5Y5m4+ZP9
        cPkwPbigAOsB/XBseYLQyIgpf
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr19608567wmh.71.1578912535562;
        Mon, 13 Jan 2020 02:48:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHsSmjB3vJPcprLV9sr9PcVhPuEt/0W/kXtaQfjrdzo0qLW3rNyS4UYnlXW4g1kjsBPPVo2w==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr19608552wmh.71.1578912535410;
        Mon, 13 Jan 2020 02:48:55 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id t25sm13820084wmj.19.2020.01.13.02.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 02:48:54 -0800 (PST)
Subject: Re: [PATCH 3/3] Input: axp20x-pek - Enable wakeup for all AXP
 variants
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200113032032.38709-1-samuel@sholland.org>
 <20200113032032.38709-3-samuel@sholland.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <95bea397-ed7c-2040-a3af-61ded13aca27@redhat.com>
Date:   Mon, 13 Jan 2020 11:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113032032.38709-3-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-01-2020 04:20, Samuel Holland wrote:
> There are many devices, including several mobile battery-powered
> devices, using other AXP variants as their PMIC. Enable them to use
> the power key as a wakeup source.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/input/misc/axp20x-pek.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 38cd4a4aeb65..b910c1798e4e 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -279,8 +279,7 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
>   		return error;
>   	}
>   
> -	if (axp20x_pek->axp20x->variant == AXP288_ID)
> -		device_init_wakeup(&pdev->dev, true);
> +	device_init_wakeup(&pdev->dev, true);
>   
>   	return 0;
>   }
> 

