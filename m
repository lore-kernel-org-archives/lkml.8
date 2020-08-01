Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8103DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA392087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL9gNmMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgHANGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgHANGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 09:06:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B8C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 06:06:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so5265349ljj.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 06:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ax/Pwtq3Y2qHbJF4PNVmYOhd6N3XKnpfypY6/+4jDSQ=;
        b=nL9gNmMxybnQZTmKhmktw6ICgX7KYugtpBE1pauZoZD9eeGW6gkjbvePdNAVQVcgG3
         g9qZRJwtZ23WuyMGsXNSRD44IexYLcUfhMqszXYfTR5tKOClBIv5dFEvEk0AeMGi9HYy
         crNOrZmu9cYlA6TUqd4aLbcXbj0snsu3dN0yu9svNqj3MY06jpf959nKDLqQIxjLz84N
         D9ySzdRAPpJhp7PXyDRd5xBSGep1jjutiBfOsXsNBjwF7ojSxey4/3ZcfZMQLzZKSVeH
         qa1/V8NwLgh+JuCxQ/3ttqW+4koxZb34hJT6ZSrbN7wHh/JT9YGB4ybXsu+OyhwN3QAS
         pnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ax/Pwtq3Y2qHbJF4PNVmYOhd6N3XKnpfypY6/+4jDSQ=;
        b=YCQaMeMgpBU1DT0EPaI60IIQEtd8sEJAfW7ZhchbCjclYcSBxgl+ouemEHfXBeEVR8
         xB5vdE204q/DnXIrapb1tDkhcKEvT3NDUTdAj1SWSP2f6mqmtLe+JZReczXosswbpdqm
         mGOjbOdF7d/QDTa8x4IGsZbtQteIW4QzFB+Xb5NnU8EVMUu2aYDpBTgZq+gZs90LgYiN
         J8eNKm2OnX91mfBzieVE/LqGDudoKtzk3hJ3raLCvPa9fQNrPtaqs/pK7xRHGeRpzbcH
         IjVXB7boRkffKnYpBugR3RxfnhM9AtVjZF3Yf1Nv96J11Aaz+haGD6Iq0QNzUoyOsekv
         NFvQ==
X-Gm-Message-State: AOAM5329imMGzdH5Fy1Ucn4oYOMooSx+Hu0567wFdEB/ZqmAEjT3El3D
        QEktYC4vqwYzQoXX81YPpAYsZUBa
X-Google-Smtp-Source: ABdhPJwkxTq9dQhrA86Zsgn0YMviwS47EPdxu8xVn+mmvAaIcYc+JWEmxqpqj/gaU/UJzqu/RrgBhw==
X-Received: by 2002:a2e:88d4:: with SMTP id a20mr4006508ljk.326.1596287207222;
        Sat, 01 Aug 2020 06:06:47 -0700 (PDT)
Received: from [192.168.0.160] (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id u21sm896714ljl.11.2020.08.01.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 06:06:46 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: replace rtw_netdev_priv define with
 inline function
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        linux-kernel@vger.kernel.org
References: <20200801094707.13449-1-insafonov@gmail.com>
 <20200801095108.GA2840539@kroah.com>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <968d30fc-4e5f-b495-e986-b18b05e9a895@gmail.com>
Date:   Sat, 1 Aug 2020 16:11:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200801095108.GA2840539@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/20 12:51 PM, Greg Kroah-Hartman wrote:
> On Sat, Aug 01, 2020 at 12:47:07PM +0300, Ivan Safonov wrote:
>> The function guarantees type checking of arguments and return value.
>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>> ---
>>   drivers/staging/rtl8188eu/include/osdep_service.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
>> index 31d897f1d21f..e0ccafdea9cd 100644
>> --- a/drivers/staging/rtl8188eu/include/osdep_service.h
>> +++ b/drivers/staging/rtl8188eu/include/osdep_service.h
>> @@ -71,8 +71,10 @@ struct rtw_netdev_priv_indicator {
>>   };
>>   struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv);
>>   
>> -#define rtw_netdev_priv(netdev)					\
>> -	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
>> +static inline struct adapter *rtw_netdev_priv(struct net_device *dev)
>> +{
>> +	return (((struct rtw_netdev_priv_indicator *)netdev_priv(dev))->priv);
>> +}
>>   void rtw_free_netdev(struct net_device *netdev);
> 
> Is the cast really needed?

(struct rtw_netdev_priv_indicator *) cast needed for access to '->priv'.

The (struct adapter *) return type is a starting point for simplify
     struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
constructions.

> 
> And no blank line before the next function prototype?

In v2.

> 
> And is this really needed?  Type checking is already happening as this
> is a "simple" macro, right?

1. The flexibility of macros is not needed here.
2. The macro silently assigns ->priv to any pointer, while the function 
indicates such a compile-time error.

Ivan Safonov.
