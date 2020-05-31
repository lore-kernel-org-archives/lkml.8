Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F7F204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVzRun+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEaRod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgEaRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:44:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2EC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:44:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so5267720ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2RMIV7m/Lpx/3Cc5jgcmhOCjHtYKoVJK72f4lQdlYTE=;
        b=qVzRun+Gv8KCaQjsJR4wIt57gzuhGj6TiqE5gakAl/pLFcwKNrCO4We/EAwcRPGYT5
         ZXEa/vsTlJzY7i2PmOOMDPASffsTfz1o8Y2EO5Kj7OYqafl4RMzGr0EZmnALMWaRrrix
         x4B3BKpYZUUc6SqEwOpMf3fEHCquetz9FN5eyl2igdTs+IpcF9pKXy8whjxOX69WiRMR
         SbZLl8hnQA+msMxFIcZwORvg/lIZbnM4O4ubIo3V9rAjVsbtuZ/JIUW/LuDqT/YEtDvu
         A8jwG1CHoC09UJ67a40SwL11xWShTPFFh6KqLQHbEVk7nsmzesIyijcjQDh0Y0KOWuWj
         KmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RMIV7m/Lpx/3Cc5jgcmhOCjHtYKoVJK72f4lQdlYTE=;
        b=h0QI+cT38dEZh9oQaSXegS3pqGqZ4IO67qB700l4M2lCxcXSLBlbwgKRTGhJZAY4CF
         yptxOzhf2G8W8dqqEPgCb2dL8HRP+iXYalS9GVk6jffcejmZm11nADV+qFWbUugvy4IE
         56PYicUPPaPvkJM5KyBMAyVbPMLtilrSUv3nv2YqgHOHj5W9/UvnN2yxEWKnnQWA6yzZ
         P1KvPfDEknUqe7dWSTq94k16G/qpYOExB5BRCoOIbObi/OvGEKqfa7ngrdgfjpeJ8RRd
         X6DdUGcuTtD8nLMRJ9UWDtSXCIuOGATpzSnFni0N73u9ibw4XIzy/EvfZDhyRPiRNYlL
         /Umw==
X-Gm-Message-State: AOAM5304bRBn5ntTg/iENHANhYKG7BAGI7yKtj1U8rKnR3Jg8xF8gIkf
        X2Jnk7xd1OO3mZeZ4KhnSPNlga7p
X-Google-Smtp-Source: ABdhPJy7wkS5uf1TLRX/OePMnJFbEiewbjOPz+hQoSkXkJhj2uLJnjJDT6a6H0BcEj9vrTV9sAre8Q==
X-Received: by 2002:a2e:8782:: with SMTP id n2mr1630941lji.171.1590947070585;
        Sun, 31 May 2020 10:44:30 -0700 (PDT)
Received: from [192.168.0.160] (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id 22sm1610110lju.5.2020.05.31.10.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 10:44:29 -0700 (PDT)
Subject: Re: [PATCH] staging:r8723bs: remove wrappers around skb_clone()
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lukasz Szczesny <luk@wybcz.pl>, R Veera Kumar <vkor@vkten.in>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20200531160843.39120-1-insafonov@gmail.com>
 <7bf8612d3708b811e026daec5c7a1486c5954905.camel@perches.com>
 <8e4df253-e021-6c29-96ab-24eed9b61eb2@gmail.com>
 <24e0f572511724ea338f8802fde2ad3a359ea8d5.camel@perches.com>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <1803e5d8-2629-adf3-6638-0ad843273a02@gmail.com>
Date:   Sun, 31 May 2020 20:49:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <24e0f572511724ea338f8802fde2ad3a359ea8d5.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/20 8:36 PM, Joe Perches wrote:
> On Sun, 2020-05-31 at 20:28 +0300, Ivan Safonov wrote:
>> On 5/31/20 7:15 PM, Joe Perches wrote:
>>> On Sun, 2020-05-31 at 19:08 +0300, Ivan Safonov wrote:
>>>> Wrappers around skb_clone() do not simplify the driver code.
>>> []
>>>> -inline struct sk_buff *_rtw_skb_clone(struct sk_buff *skb)
>>>> -{
>>>> -	return skb_clone(skb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
>>>> -}
>>>> -
>>> []
>>>> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
>>> []
>>>> @@ -110,7 +110,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
>>>>    			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
>>>>    				if (bmcast) {
>>>>    					psta = rtw_get_bcmc_stainfo(padapter);
>>>> -					pskb2 = rtw_skb_clone(pkt);
>>>> +					pskb2 = skb_clone(pkt, GFP_ATOMIC);
>>>
>>> Why make every clone allocation GFP_ATOMIC ?
>>
>> The rtw_os_recv_indicate_pkt() is always called from an interrupt handler.
> 
> It'd be better to indicate you know that in the changelog
> as the subject and changelog just shows removing wrappers
> and the patch code does not agree with that.

Yes, it's right.
