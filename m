Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C5C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F4E2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqeugUNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEDKBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:01:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728166AbgEDKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588586460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJkyvpNgmDmt2g0SlWdBRcilG1I4swf/Cj3EYZFCe0o=;
        b=CqeugUNxmO1cLBMF6HsKJu/K8hR6+w2ti34cz4NRO/jyleq2lL4C4yTmWhONmldnDOIZ2S
        IQOtONIk2FnaXlOJ4OHtWy6cj8EHaZ7ONnKn2AMdbVrJVh1LYnmFpyihU5+k4qiVX3VmP9
        HOnUFYvTcVA3QL0oxZQfKoZx+OQnrpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-H9KJjw06NOWL479MUheNQw-1; Mon, 04 May 2020 06:00:58 -0400
X-MC-Unique: H9KJjw06NOWL479MUheNQw-1
Received: by mail-wm1-f71.google.com with SMTP id j5so4595405wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 03:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJkyvpNgmDmt2g0SlWdBRcilG1I4swf/Cj3EYZFCe0o=;
        b=U7WYVNbKbkX0wowW+blWQhC6Hkgw91XEjc1HD/D1+yz7UxMN9MB7bzPwXBzLI2t7OM
         ezcdm+S0ZK9YlDiUHjX1F0wMYF/CyU1EOmh6IilaC2iqWk3QDkel432kcxtMt3sEbLiq
         mr3qN+Z1T8qjUUCnUEDgdG0lTTR75aiWNDGtCEUHc8cse+Z4y6t5uQNeE2fvsIlW6vow
         AeWHWu0EGsNHRMOdxc27aTGIe9pYdfVYgQ3OvpSZ12keYoH+90jV9+bqNm1G+3uLtKdj
         pimVJ+FaDxLprPo5YWHlwpUL8zw3MYJiCwqpc9L3Zu9OEzOkpzbF9RQcRgKJ0R3mKiVP
         5LOA==
X-Gm-Message-State: AGi0Pua3ZlozxwITsF3dltpTq1cwsl3O2T5uZIS7sPnQY0QnQfFptWRP
        CmclRMF2nBT3TU4XJU/oEza70RJHkRPB8j1B4awRKQmnQHFylWEnIURhMCTPXNwtgXArjsqCiYe
        r9B3PbXiYmS9gf9Th7hh4ttG1
X-Received: by 2002:adf:8169:: with SMTP id 96mr18097873wrm.283.1588586456908;
        Mon, 04 May 2020 03:00:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQy5hLsDEnTJRu3PFA8DqRI0Fz/y/rb45ogQc0EtnB3c3GLHDSSMAYlKb28Ib+4V9VlkGOng==
X-Received: by 2002:adf:8169:: with SMTP id 96mr18097855wrm.283.1588586456718;
        Mon, 04 May 2020 03:00:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id c190sm13003942wme.4.2020.05.04.03.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 03:00:56 -0700 (PDT)
Subject: Re: [PATCH] i2c: cht-wc: Remove superfluous error message in
 cht_wc_i2c_adap_i2c_probe()
To:     Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200503132339.17718-1-aishwaryarj100@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0605496b-d4f1-c87c-5b45-699c8c3dcaec@redhat.com>
Date:   Mon, 4 May 2020 12:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200503132339.17718-1-aishwaryarj100@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/20 3:23 PM, Aishwarya Ramakrishnan wrote:
> The function platform_get_irq can log an error by itself.
> This omit a redundant message for exception handling in the
> calling function.
> 
> Suggested by Coccinelle.
> 
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

Thank you for the patch, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/i2c/busses/i2c-cht-wc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 35e55feda763..343ae5754e6e 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -314,10 +314,8 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>   	int ret, reg, irq;
>   
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "Error missing irq resource\n");
> +	if (irq < 0)
>   		return -EINVAL;
> -	}
>   
>   	adap = devm_kzalloc(&pdev->dev, sizeof(*adap), GFP_KERNEL);
>   	if (!adap)
> 

