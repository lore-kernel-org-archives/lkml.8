Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E47C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE87B20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipf6+Wdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406680AbgFYRJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:09:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406608AbgFYRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593104964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CfCap0F3wZuekOuBaQ6nE/M+wEkk6ovUVrJUS5pGSM=;
        b=ipf6+WdyDvGjXi0vDOqnHkp767cXCwHV0q/KjLSAIO2ra3sRFBx55YscUpmYV1G1CQCV0O
        ljfCwPcxkQcWeCgl8BRWdN5r/MBBh9gxngP6aDjLuC9BJCkJLpgW8cXPFO18v0E1xW5TT7
        PYlDYWVrPgufc8d69pdTPtf3FIwS6rA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-HntFCAGGM86kMBBU-pu3PA-1; Thu, 25 Jun 2020 13:09:22 -0400
X-MC-Unique: HntFCAGGM86kMBBU-pu3PA-1
Received: by mail-ej1-f72.google.com with SMTP id a26so1042183ejr.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CfCap0F3wZuekOuBaQ6nE/M+wEkk6ovUVrJUS5pGSM=;
        b=XZx8+ubaNfJlZBy8Q+wu18cSnPqKy6dDwsdJcKxwYWkkfmnxo3WM1R5Io4vwIRebJq
         XuExuYZCy1JLlP9iqI+KFoDH6QrYxvhQDjgz4fuA8JHUCiq+1LdV0hKaVDYF2CdP2wwI
         BxC+wP0/I9He5d5FTQpsCOmTBT+PU8yf2NRVnXY5TtppF6ZrpYHH6gPqNn2acFg5r2fM
         uEx9gdkZ9jmzA6Ayw76YQlKQqf5kZYtlRJ7uP45T0uPpDoE3mo4q1YP5WPHcllBK/nRA
         C9ISTp5umKfBM++zmCRRvHSnaTl9637yqNu2I7CwN4O9M1/Sq3sMF6NV7iJLxt14M4Mh
         21ZQ==
X-Gm-Message-State: AOAM531smVf6SUNuJb2snmBlWKBSt+oXOVU4DwHtQBcWFUeYDtQIVdos
        gPw5KSt5bQxZNC7krQZxXjFVDyj/hS6S/ltHtcTVO50kVmXLr3FsQrxsi57J3q7wlTKM6605YDZ
        UkUcnPaulEGl0/8bJZDH4OYfS
X-Received: by 2002:a50:9f6a:: with SMTP id b97mr7418229edf.322.1593104961247;
        Thu, 25 Jun 2020 10:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZTjd/YE7d5FmBNF9ZnN/QkhB3RzdoBfx/jxbtUHsAmF7gle9idP0YebzTqxtW7V6HeE10/w==
X-Received: by 2002:a50:9f6a:: with SMTP id b97mr7418199edf.322.1593104961004;
        Thu, 25 Jun 2020 10:09:21 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id e20sm17061524ejh.22.2020.06.25.10.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 10:09:20 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: Transform compatible string for FW loading
To:     matthias.bgg@kernel.org, arend.vanspriel@broadcom.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        mbrugger@suse.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200625160725.31581-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <389d35d9-fb94-b5fd-7b87-9511dacad0b2@redhat.com>
Date:   Thu, 25 Jun 2020 19:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625160725.31581-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/25/20 6:07 PM, matthias.bgg@kernel.org wrote:
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
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c  | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index b886b56a5e5a..8a41b7f9cad3 100644
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
> @@ -25,8 +24,21 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>   	/* Set board-type to the first string of the machine compatible prop */
>   	root = of_find_node_by_path("/");
>   	if (root) {
> -		prop = of_find_property(root, "compatible", NULL);
> -		settings->board_type = of_prop_next_string(prop, NULL);
> +		int i;
> +		char *board_type;
> +		const char *tmp;
> +
> +		of_property_read_string_index(root, "compatible", 0, &tmp);
> +
> +		/* get rid of '/' in the compatible string to be able to find the FW */
> +		board_type = devm_kzalloc(dev, strlen(tmp), GFP_KERNEL);

strlen() needs to be strlen() + 1 here to make place for the terminating zero.

> +		strncpy(board_type, tmp, strlen(tmp));

Please do not us strncpy, it is THE worst strcpy function
in existence, it does not guarantee 0 termination, so
it sucks, it sucks a lot do not use, thanks.

Instead use strlcpy or snprintf(..., "%s", ...)

> +		for (i = 0; i < strlen(board_type); i++) {

(The strlen here relies on there being a 0 behind the memory you
allocated because of the missing + 1)

> +			if (board_type[i] == '/')
> +				board_type[i] = '-';
> +		}
> +		settings->board_type = board_type;
> +
>   		of_node_put(root);
>   	}
>   
> 

Otherwise this looks good to me.

Regards,

Hans

