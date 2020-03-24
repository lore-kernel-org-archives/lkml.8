Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66629C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367F420774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="LnXgAgYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgCXOzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:55:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33960 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCXOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:55:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so18936452ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNd0h3fsVcT6k8d64lGb4UxIfYz4swlJdfLJY5I84Pk=;
        b=LnXgAgYwJnh4LyNLf6Ei0tES9O4ek/ykjW3ITZ+X43dvYS7Ob00W597ztY5ZO6ftDg
         LAyQ8TkGy2IMIv1mwYwM3GUW2wGTlOEZtL+pcWQMoan2Xztfv0St5RZkqg5C83J37JkZ
         HXAqLmlpJBkZ1yPXRbL/b1lbZbU7+4UbmCV0ucehy7Jj2u+AoNpVWpYvu8fffUdGhm55
         LKsz9OvlTP3PSTVn9lqnGP16ngUvc8PzX1mqq1h6yiO4iPPTMuEmKkoLdbh5mOqPqSCU
         vhIT5t1FPMsUV3B1NmUfy7F5cLdqk6wDO14j7xTO43eecWD9nIal5MK3PBWXhKoWKkzq
         Ndrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BNd0h3fsVcT6k8d64lGb4UxIfYz4swlJdfLJY5I84Pk=;
        b=qk5J8nlJAPlnYCkBo/aLZaFaVGXZ/q/KAaGUSr3Mw9PVXyo2bQIYAq7MhcMwtGXU0J
         hWyxCMbmQvYHnBwYBa4f+H4h5Ft8wm9ng5hIoE5HTJHr9jn0PvKZiVgWNeZ1Y+PO421v
         qXcDnB0m250nzxUe+PGgaca6wOylNq9L6rJbFyROKX20KoxmyB7iHPPIhIoxnHpH4k7z
         93DfBGsmswztUXjqHzZO90vFCrXYg4i07iXo82REjgOx/6y02C1M4NCUg4RA7oI6gDRx
         uShvLIiLGxxzuHHgp/PEY2PFWeaNbPrzSnATL8/aHkN0x5SjhmaJtW3yruj7o9pH0pSd
         6q6A==
X-Gm-Message-State: ANhLgQ3Qb1p2GlTT3WyD4Oj4Owg7jwT7My3hIos4gSQFwlfkyVOr5MVc
        l6ieJ/4oljhjNxKrWmrKd9YYTSzvWYzuhA==
X-Google-Smtp-Source: ADFU+vsBL16mOCk78Gq17PBMvQLAA6Qth2JMTHL5EZhA1UfaBW61ACz13l083keat7MBz0Xg2o16kg==
X-Received: by 2002:a2e:858d:: with SMTP id b13mr9091346lji.227.1585061729549;
        Tue, 24 Mar 2020 07:55:29 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42d3:3567:1f77:9f32:8c0:b337])
        by smtp.gmail.com with ESMTPSA id q8sm3440800ljj.77.2020.03.24.07.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:55:28 -0700 (PDT)
Subject: Re: [PATCH v2]usb: gadget: bcm63xx_udc:remove redundant variable
 assignment
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, cernekee@gmail.com,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200324132029.16296-1-tangbin@cmss.chinamobile.com>
 <a0afd44f-177d-ad21-02b5-93b15b29399e@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <82d75ffd-0df5-d41c-7b3e-615d97c1838a@cogentembedded.com>
Date:   Tue, 24 Mar 2020 17:55:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <a0afd44f-177d-ad21-02b5-93b15b29399e@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/2020 05:50 PM, Sergei Shtylyov wrote:

>> --v1------------------------------------
>> In this function, the variable 'rc' is assigned after this place,
>> so the definition is invalid.
>>
>> --v2------------------------------------
>> In this function, the variable 'rc' will be assigned by the function
>> 'usb_add_gadget_udc()',so the assignment here is redundant,we should
>> remove it.
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> 
>    NAK.
> 
>> ---
>>  drivers/usb/gadget/udc/bcm63xx_udc.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
>> index 54501814d..a7afa8c35 100644
>> --- a/drivers/usb/gadget/udc/bcm63xx_udc.c
>> +++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
>> @@ -2321,8 +2321,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	rc = -ENXIO;
>> -
>>  	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0)
> 
>    This *if* branch goes to the 'out_uninit' label which uses 'rc' (and it should
> be negative).
>    In principle, if you change 'rc' to 'irq' below, this patch would be sane.
> It's not as is.

   Still, the other *goto* out_uninit in te loop below shoild be changed as well.
Otherwise, if the result is overriden to -ENXIO, e.g. deferred probing is borked.

MBR, Sergei
