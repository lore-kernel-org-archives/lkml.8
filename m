Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9565220772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7ViRPt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgGAMM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:12:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730271AbgGAMMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593605574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaTa3j8pv7Vv7FPlkaiUQ9sgC3qOTtEDpxvgOBhKsTg=;
        b=X7ViRPt9irA3Gh2IgWv7XVIAdR2s1ibdwE8OCwxWzzu+V90plHKfCYR9kLRr6jj2IJ8KRQ
        zHT08TG9zRm0mtOCory1S/xlaArFXb9snR1A8+3nKpSupfA5ak5RRfhPqefM1IYqgVin0p
        iLfrrAXc3KoKtSCacfJjwlyqyFenCSE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-PqwOCs0AMpCX2fZTOPwQFg-1; Wed, 01 Jul 2020 08:12:48 -0400
X-MC-Unique: PqwOCs0AMpCX2fZTOPwQFg-1
Received: by mail-ej1-f70.google.com with SMTP id d16so8180658eje.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XaTa3j8pv7Vv7FPlkaiUQ9sgC3qOTtEDpxvgOBhKsTg=;
        b=QoRRwRbC+IfnyA1WbbMMGdi8ICAjEsRztpBspXaJsLbVbIm+V9G39RwvBauEBeZY9S
         t/cR0MB1LLEcZnYLgVo9eZuGKInuHRSiwILvsMSXmWs7QjTo7GEcgpswyvqO9nuZarji
         qbjYJFk/QJz9J5CtFHRSTSVl+PDhvILKv6+WF//ptzdYUGV/1NER+rvFwYxbYnhzwXoz
         JGQZd6yuDoHn3w3u9QTEglqbiHs959EtfNguQs5bPILSsFkxXUcRE3gC1vH4luBoW0C3
         iKpWrR8jw8OnG4vflp1xBwH4HlcnQLoKjJKMuSpIoJJ93fKPDS37CUopju0FfnOxtM98
         OUcA==
X-Gm-Message-State: AOAM530Jwinv1Tl7Tf5PqK+3KIG0S6oKeH6RXB323ilsoaWZOVvP955T
        cJ2PdlF9EsjnR16rSUTicHSwDGXHgNNxgOvs2FRr0WV/c890B3CMBbwVaW0/zc8fQjSp7sn33Kv
        QRcOsnviFOhdTwVrrbBN/yM2R
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr21964632edr.294.1593605567580;
        Wed, 01 Jul 2020 05:12:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybKmn9TXwxpznNvmXkc/EDdW74VObauZauv68Wmlu4ixsBkY7JPtu25PXyzIRbA9DwPCxw9g==
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr21964601edr.294.1593605567361;
        Wed, 01 Jul 2020 05:12:47 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id cz2sm5763973edb.82.2020.07.01.05.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 05:12:46 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: Transform compatible string for FW loading
To:     matthias.bgg@kernel.org, arend.vanspriel@broadcom.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com, mbrugger@suse.com,
        netdev@vger.kernel.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, hante.meuleman@broadcom.com,
        linux-kernel@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com
References: <20200701112201.6449-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eaf0f098-c73c-10b5-2d75-b35a5fc8dbb4@redhat.com>
Date:   Wed, 1 Jul 2020 14:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701112201.6449-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/20 1:22 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The driver relies on the compatible string from DT to determine which
> FW configuration file it should load. The DTS spec allows for '/' as
> part of the compatible string. We change this to '-' so that we will
> still be able to load the config file, even when the compatible has a
> '/'. This fixes explicitly the firmware loading for
> "solidrun,cubox-i/q".
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
> Changes in v3:
> - use len variable to store length of string (Hans de Goede)
> - fix for loop to stop on first NULL-byte (Hans de Goede)
> 
> Changes in v2:
> - use strscpy instead of strncpy (Hans de Goede)
> - use strlen(tmp) + 1 for allocation (Hans de Goede, kernel test robot)

v3 looks good to me:

Reviewed-by: Hans deGoede <hdegoede@redhat.com>

Regards,

Hans


> 
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index b886b56a5e5a..a7554265f95f 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -17,7 +17,6 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   {
>   	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>   	struct device_node *root, *np = dev->of_node;
> -	struct property *prop;
>   	int irq;
>   	u32 irqf;
>   	u32 val;
> @@ -25,8 +24,22 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   	/* Set board-type to the first string of the machine compatible prop */
>   	root = of_find_node_by_path("/");
>   	if (root) {
> -		prop = of_find_property(root, "compatible", NULL);
> -		settings->board_type = of_prop_next_string(prop, NULL);
> +		int i, len;
> +		char *board_type;
> +		const char *tmp;
> +
> +		of_property_read_string_index(root, "compatible", 0, &tmp);
> +
> +		/* get rid of '/' in the compatible string to be able to find the FW */
> +		len = strlen(tmp) + 1;
> +		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> +		strscpy(board_type, tmp, len);
> +		for (i = 0; i < board_type[i]; i++) {
> +			if (board_type[i] == '/')
> +				board_type[i] = '-';
> +		}
> +		settings->board_type = board_type;
> +
>   		of_node_put(root);
>   	}
>   
> 

