Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEFB20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bvYpkG8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgCXOuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:50:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36784 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgCXOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:50:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so18891066ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=46/qQ50l1vh+J9wzA3xpUZxvvo8d7tioQFsg4+TJ/o8=;
        b=bvYpkG8m/ns3rG4ZA+zT/M4MjsHPmDeoGGnpZ5cpYzMvSfGA4iOGMFepedJZweWbNe
         2iyBmESEUeF6IAQJfDmsoYgZ5UsV0INu6mmp3Yare9tsponpOhbkMHgg+tPLmXvgBtpe
         8jeYLQx+pLubdj8l4AUXte+u0jX5TjBmNmpw79Qd/FNhuoQS4mUrMfs6399CzGjQNsxt
         +cIiJC7mz00fj6BWt/lAM9WLf99bZ7mzCNNef1hULoqwBw6HjopoNZdlf8423OjoRHx+
         34/AGy3xW1NxXaHFhRAmQu0tBqSNYOitMsFSXZBpS8G4+ZNExQxXFjHa75IYB247HWho
         VgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=46/qQ50l1vh+J9wzA3xpUZxvvo8d7tioQFsg4+TJ/o8=;
        b=QzUOeWDfH9kt/rhdZvldeO4KcD6LIIpKja/E2GcH5QHQ+PTOTGQy6mrMpWRw3dedwi
         BJ9qSoVCbWFOjGJL/vT8gsUlJXyolbxYpce8YzowMBx84lvdJcVCFHeIMfZGG5XGFdk2
         uuwJzcPw7R7YiGHTaWtwZ6s+Rjss+LDa8XZVLmppmnV6GD06HIoV/ieL/jfB0y4IgwcV
         C5G0gOasIBz8tDP7o5mhmQDb5/SaZU/HXStwZwGJT072o7xVnQa+dr67tmFpEA2sZHM7
         8v4MbSCD7/D2ZWe3EgtrlHByFoKcm6r04ohJsSHhJXOvI+VnMXorRIbOk3WC+kVwQDFv
         SU7g==
X-Gm-Message-State: ANhLgQ1qhdPlRMoGQesTr+W5QXfQNqoAcD+ykphWMc3PP9maN5D3gfuz
        cRTvKziDAUZDSb5MLw5g6KeDOPsOGdpwJQ==
X-Google-Smtp-Source: ADFU+vsduWqt1Gs363mlpwe4KUHBbe4xPS+tER4rFbeA45hsI3KGrYgm1BWdEuzCSeE6tQZKCp8hmQ==
X-Received: by 2002:a2e:9f07:: with SMTP id u7mr11833365ljk.115.1585061409797;
        Tue, 24 Mar 2020 07:50:09 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42d3:3567:1f77:9f32:8c0:b337])
        by smtp.gmail.com with ESMTPSA id x11sm1431543ljm.7.2020.03.24.07.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:50:09 -0700 (PDT)
Subject: Re: [PATCH v2]usb: gadget: bcm63xx_udc:remove redundant variable
 assignment
To:     Tang Bin <tangbin@cmss.chinamobile.com>, cernekee@gmail.com,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200324132029.16296-1-tangbin@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a0afd44f-177d-ad21-02b5-93b15b29399e@cogentembedded.com>
Date:   Tue, 24 Mar 2020 17:50:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200324132029.16296-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/24/2020 04:20 PM, Tang Bin wrote:

> --v1------------------------------------
> In this function, the variable 'rc' is assigned after this place,
> so the definition is invalid.
> 
> --v2------------------------------------
> In this function, the variable 'rc' will be assigned by the function
> 'usb_add_gadget_udc()',so the assignment here is redundant,we should
> remove it.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

   NAK.

> ---
>  drivers/usb/gadget/udc/bcm63xx_udc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
> index 54501814d..a7afa8c35 100644
> --- a/drivers/usb/gadget/udc/bcm63xx_udc.c
> +++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
> @@ -2321,8 +2321,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	rc = -ENXIO;
> -
>  	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)

   This *if* branch goes to the 'out_uninit' label which uses 'rc' (and it should
be negative).
   In principle, if you change 'rc' to 'irq' below, this patch would be sane.
It's not as is.

MBR, Sergei
