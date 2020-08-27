Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6ADC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B572075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4jjyt8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgH0CHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgH0CHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:07:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E656C061379;
        Wed, 26 Aug 2020 19:07:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p11so2258796pfn.11;
        Wed, 26 Aug 2020 19:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vmQyc9cOnlMajeIyevmiajMFAkFRM5x/wv6mfoxl6ZY=;
        b=q4jjyt8yfICicSohouW30P9BXnuXQZu/Q8n+opQm3ULTVVkZL6kgl9ZHzC7fMLx2Yk
         Bg8zp42JuOc8QQ1ti9QBBmuyYWXy5gI0ybopD/akhWF2qAYxWtToj9c7N4kPByJq48Js
         ISu6O7JqkH3uJnMJLwrUD6rOV4hSqwLz3KBAonUx05zu9rD40s/6WpDV961+9yCiOlh9
         8yolu2k4+Q0BYZHU5+JWR1zNldmDeMOopX9Z3e6gy/s6B9j5VAVYUCtsdTJJZ34Q+66Z
         qwiq4ObhmEk8SbrPd6V8iz1lCc5860FmbPLYQC81TDVsuzw+mtbsd8JFdtfDyuk83NC+
         cprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vmQyc9cOnlMajeIyevmiajMFAkFRM5x/wv6mfoxl6ZY=;
        b=qLDu38kEnGcR1E1snxz+VgvFb1z6di8prqnmKXDPzNAiNNdiZGFme7W9wA7xF2ryCo
         FjobI0/1NGnc457vaaRx39ZoaTmFUZmcodHfASKG3+V0w1g0WlFgDkbKn9KCgUZrxPRm
         VAbmt4MMirfgKzmPcXZMiKENsTqddkIBXWWbuPmQT1sKod4FF1T2kS15YRWHmvASCHxZ
         yONAh43vl5lnYd9imEADphTPgEWUdO18ieS9/ITnVVZglQ4SQr9bvLAp1kizr9L2CEqn
         332nDI9A6/XMepSfiRRHhuyv85WUVWT5wy6wCz8l1+uWjn3kApoO+cXta3lUXCweC7gE
         p8yg==
X-Gm-Message-State: AOAM532lngmnpYnSFDN/ykviP7Xxcc8ieT720K/ytJo+ocR15/iKxx6T
        Efp+aCI6eh/YcyWTYvvQ+GGL0vmDPG0=
X-Google-Smtp-Source: ABdhPJwdOnclldZnEMkOvNOp+SVZFei8tTpvxnNhqZKhGPdD/NzwR9wCXmwM8BRb+2u8GZlC8Zq/eg==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr14679877plt.128.1598494026370;
        Wed, 26 Aug 2020 19:07:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm499427pff.192.2020.08.26.19.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 19:07:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] usb typec: mt6360: Add support for mt6360 Type-C
 driver
To:     =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1598440602-8648-1-git-send-email-u0084500@gmail.com>
 <a7d1a5d9-97e9-bcf6-23f4-2c4be356913f@roeck-us.net>
 <CADiBU3_x5-P8A0erchFpWucX4_R8M01-CdOJv38FjrPGSn+55A@mail.gmail.com>
 <627dd188-9379-1179-432e-b53948052823@roeck-us.net>
 <CADiBU3_GX+BvxQCDkMtf70sXHnwFVNmBCJsrydROHjy5Lr9B4g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f844b044-9ac4-094d-0ff8-feaceb50185f@roeck-us.net>
Date:   Wed, 26 Aug 2020 19:07:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADiBU3_GX+BvxQCDkMtf70sXHnwFVNmBCJsrydROHjy5Lr9B4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 6:11 PM, 啟原黃 wrote:
> Guenter Roeck <linux@roeck-us.net> 於 2020年8月27日 週四 上午9:02寫道：
>>
>> On 8/26/20 5:59 PM, 啟原黃 wrote:
>> [ ... ]
>>>>> +static int mt6360_tcpc_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +     struct mt6360_tcpc_info *mti = platform_get_drvdata(pdev);
>>>>> +
>>>>> +     tcpci_unregister_port(mti->tcpci);
>>>>
>>>> That leaves interrupts enabled, which might be racy
>>>> because interrupts are still enabled here.
>>> M..., yes, it will cause the race condition during module remove.
>>> I'll add disable_irq before tcpci unregister to prevent it.
>>
>> Or just set TCPC_ALERT_MASK to 0, as in tcpci.c.
> Both are right, Thx. I'll choose one.
> 
> BTW, it seems enum typec_cc_status is used by tcpci.h.
> If I don't include tcpm.h, it will raise a warning during the compile time.

Ok, thanks for the note (that means tcpci.h should include
linux/usb/tcpm.h, really).

Guenter
