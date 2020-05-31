Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52788C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1082074B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDBuriuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEaRXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaRXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:23:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B35EC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:23:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x27so2554993lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gan8Hs5cLhd2R8PjllgAUBiWMj838r9OJwwYSGGCD8k=;
        b=dDBuriuXusck1paeyAvVZbqTUhubuee/TOwISJbBrCcoICtysuO5DR8/1bQrKiRpVq
         WxTXJo4D/6APNYU0c0DhTcIZMxxFuRkXl7rL55sFGkx5UcpzGbWbQHCBC8OGZVbz2Rwz
         YJJzysWpOdQmvmQq94I23nDyXl2zrNN2InUoulU3G4aqg0x5al5GqkVqEpBVc/MjkZk8
         IO6g6fZ0JuAqcu1IskHfeeh28i71CgAEIcOo5j0yy3g3Tjstd3kKvOVZPdW3tQnhH2Lr
         OPfD6eswxlH3ZgW8rCS/G51Ex91m5OM3hQIatPid4uQIns8UJGjqfom0/7SpExs72p7s
         KBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gan8Hs5cLhd2R8PjllgAUBiWMj838r9OJwwYSGGCD8k=;
        b=jfqQCr56N2sNF0zyndHVmcFEG79u4TdDxO8zmA0FVVnxvgZg89EYz5WJ2RPupW6gfh
         qVFYd5yVpGJqFmMnBVzWzxI6+januJC6Q6CxDBYPbNZnDHwdlGjyTxs6KnxWL2QxRHEP
         EkDN2e0ZcBOuwJ6M5TEu4y0QPSpZdHNOr3oiuyKIQGs2snau5D2n/FYhCWqCGr7tMBGg
         4ZvRMbM0jvxu5dw0Xg4cotj6MfjxPlOcgU267heYtwKHR257zmEREnLj21KOi/bw0cNd
         dp2Q9QT3/vUH+HMymJMk789GF7IFP2hgmDd2uUzkfG6pGHf6xjzAwD7JvuHzZcWSdT5r
         ckPA==
X-Gm-Message-State: AOAM533uNXS+AFAu9HQomHHgl5nj1mkYoyALtfT08hrDMTZ8ihcoOeF6
        eaVKj1WEBau86RPJXAVLeRzL2eJK
X-Google-Smtp-Source: ABdhPJwhgVcXUg6sMnXYxPyIr1PDPj4hJk7IJi78gsp/fFui98Ztizd+IjRh3XdVQrQGGzrDhhxkbA==
X-Received: by 2002:a19:356:: with SMTP id 83mr9470602lfd.179.1590945808848;
        Sun, 31 May 2020 10:23:28 -0700 (PDT)
Received: from [192.168.0.160] (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id p68sm3927319lfa.71.2020.05.31.10.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 10:23:28 -0700 (PDT)
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
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <8e4df253-e021-6c29-96ab-24eed9b61eb2@gmail.com>
Date:   Sun, 31 May 2020 20:28:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7bf8612d3708b811e026daec5c7a1486c5954905.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/20 7:15 PM, Joe Perches wrote:
> On Sun, 2020-05-31 at 19:08 +0300, Ivan Safonov wrote:
>> Wrappers around skb_clone() do not simplify the driver code.
> []
>> -inline struct sk_buff *_rtw_skb_clone(struct sk_buff *skb)
>> -{
>> -	return skb_clone(skb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
>> -}
>> -
> []
>> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> []
>> @@ -110,7 +110,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
>>   			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
>>   				if (bmcast) {
>>   					psta = rtw_get_bcmc_stainfo(padapter);
>> -					pskb2 = rtw_skb_clone(pkt);
>> +					pskb2 = skb_clone(pkt, GFP_ATOMIC);
> 
> Why make every clone allocation GFP_ATOMIC ?

The rtw_os_recv_indicate_pkt() is always called from an interrupt handler.
