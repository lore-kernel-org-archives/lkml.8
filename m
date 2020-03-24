Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58000C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0D320724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Wm/vJx6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCXIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:35:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45696 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgCXIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:35:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id t17so6962151ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3b7FZkiDds06qo8TzF4qfUT61SceJd/XCklzwI25LFQ=;
        b=Wm/vJx6MM+SSPmtt/iK9wCEQekmmqneaEAvMnEdF5/SOxoH8/p5SpWS7d1L9HGbrw9
         jZmCPu2ipKcu+X6CDcRafunrtw4TmPKkFjGd6nNc0lp3lE558d+fF+l0gnycKybJJtX0
         yI0oAZp8n+c/5JL2hM0deT+ySjic8Mkdype1p9MZOrgqmJiJiSsgmUOuQdcU7lQfFghY
         72xVSbLydDr+NT9ghsLMHhE6u6/zym1DhdQtyvrxWrcv/eAgXcyYuPpiAl8nmigBYHlG
         Hy5/qfwaz5mCiRjqUSm04YLwzn9aqssmuGbjON2tY4BqwB7AJ5FTeAY7iHwvaqwG0SIi
         AR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3b7FZkiDds06qo8TzF4qfUT61SceJd/XCklzwI25LFQ=;
        b=aWMpRqyDoQUN/jzTzGDB0NtVCTnULxPcLD9WjnEwuYECAQaPtIMSsMi2A1meYmweFT
         PPeYbjqn8vYwfGEd2+AiNXSL6s79mfoVefy9QMKbO9eJ44A0hnjwFe0djSGKjA4WCMPY
         ZhCfw5Br4GEo8o0AnGWvA8+l8/2WywHj/Q50eNiS+JrfqxC4RTp9p/Q66NrRX0LeLiqM
         WB5Qhuj23Pj+V6bD71EhcwnjxOBIA1nLRwE6vfT0AB9FTv/6Iru6dxPGP1go15C0YJGv
         WVc5voMj/HQzK61ThP61Rbyi3Ju/bU9FkkrNrUSbRsIhh3jcsBy9D3OVZzqkl0tmF/QA
         PbXQ==
X-Gm-Message-State: ANhLgQ32qXvHZ8ZIzAKtbubjK9VzR9XqEOlvHTM/Av/f+1TUULqZ5hlY
        tFkABGlNdMT2pVaKYrjE6PKvOvAtexMdAQ==
X-Google-Smtp-Source: ADFU+vugTIUZH75uq8w/el+ZzqvPgN6W46s/AxHjqOiKpf9MdjPpWlDACKh3kiXwV+fGZHR3bRYS9A==
X-Received: by 2002:a2e:8e77:: with SMTP id t23mr16751281ljk.221.1585038941413;
        Tue, 24 Mar 2020 01:35:41 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:810:155c:a932:22bc:6638:ad28? ([2a00:1fa0:810:155c:a932:22bc:6638:ad28])
        by smtp.gmail.com with ESMTPSA id m6sm9440075lfc.1.2020.03.24.01.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 01:35:40 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: bcm63xx_udc:remove useless variable
 definition
To:     Tang Bin <tangbin@cmss.chinamobile.com>, cernekee@gmail.com,
        balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200324062932.8364-1-tangbin@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5f67315d-18c1-e444-03e7-a79a21d48b02@cogentembedded.com>
Date:   Tue, 24 Mar 2020 11:35:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324062932.8364-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24.03.2020 9:29, Tang Bin wrote:

> In this function, the variable 'rc' is assigned after this place,
> so the definition is invalid.

    What definition? Did you mean assignment?

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>   drivers/usb/gadget/udc/bcm63xx_udc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
> index 54501814d..a7afa8c35 100644
> --- a/drivers/usb/gadget/udc/bcm63xx_udc.c
> +++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
> @@ -2321,8 +2321,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	rc = -ENXIO;
> -
>   	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)

MBR, Sergei
