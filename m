Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF28C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1A5223FB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDFNfg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:35:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33904 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgDFNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:35:36 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLRuX-0001tv-PN
        for linux-kernel@vger.kernel.org; Mon, 06 Apr 2020 13:35:33 +0000
Received: by mail-pj1-f72.google.com with SMTP id p14so14847876pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CSKUSqRfNTXzOLX6+efSm/2vYgKbSyfaW2ix36hULHI=;
        b=jA6hWxTgIyHBR/TonfjYPuuXneWPVkQJGeA70mFhqmn0GIy+oOO2LlWBWbQjT28MUN
         vIRrCLeD2yHFaMX5b0kdlIkeqs9p07NVldHfx4qMwLheSgwqNdZngXkWwRy2Pp55+Gin
         CbzTEQgIFAbRW3oxlbJ6wV9Vte1Qg5mYVMcs5QTqw6hHxh8beIccGesvVA7la4bH0c1R
         pdtXSsh4wMEWCJIUZr9XlqHgyeToGV6qB7GjbF7O/sfUpX27bWq/AxLRpvXzTIeaSeM1
         Lw8xaI+C8dC17ApnO4U+DGKUfsOgjdoSljcwFjHUBGAWxF2LaSSTrX//dctDt1wdLU9d
         9aNg==
X-Gm-Message-State: AGi0PuZOu2CFznvOmw6K1svj8IkefwpKG6Q850J+VZHNXwtaPzdXR5Jz
        7U+K8mSlLsCt4MrBuLOlmiF974VvZ/AkY6x4ScH0gAI3dUB0ASFdxi7jBs6OcTAayx//GRF8mYL
        d9GJelt5mT3WP70TH1tSH+4PEgLfrf66EjVkfh8V/GA==
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr26642888pjv.49.1586180132472;
        Mon, 06 Apr 2020 06:35:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJcF25kagP8I8oRos42bmY0H7Bwv4yxtPEGXfY1khLT0S5/ecXXfz8/hbPT1o2+s7NVDz0CPA==
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr26642844pjv.49.1586180132092;
        Mon, 06 Apr 2020 06:35:32 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a8sm10783890pgg.79.2020.04.06.06.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 06:35:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] rtw88: Add delay on polling h2c command status bit
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87zhboycfr.fsf@kamboji.qca.qualcomm.com>
Date:   Mon, 6 Apr 2020 21:35:29 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <83B3A3D8-833A-42BE-9EB0-59C95B349B01@canonical.com>
References: <20200406093623.3980-1-kai.heng.feng@canonical.com>
 <87v9mczu4h.fsf@kamboji.qca.qualcomm.com>
 <94EAAF7E-66C5-40E2-B6A9-0787CB13A3A9@canonical.com>
 <87zhboycfr.fsf@kamboji.qca.qualcomm.com>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2020, at 21:24, Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> 
>>> On Apr 6, 2020, at 20:17, Kalle Valo <kvalo@codeaurora.org> wrote:
>>> 
>>> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>>> 
>>>> --- a/drivers/net/wireless/realtek/rtw88/hci.h
>>>> +++ b/drivers/net/wireless/realtek/rtw88/hci.h
>>>> @@ -253,6 +253,10 @@ rtw_write8_mask(struct rtw_dev *rtwdev, u32
>>>> addr, u32 mask, u8 data)
>>>> 	rtw_write8(rtwdev, addr, set);
>>>> }
>>>> 
>>>> +#define rr8(addr)      rtw_read8(rtwdev, addr)
>>>> +#define rr16(addr)     rtw_read16(rtwdev, addr)
>>>> +#define rr32(addr)     rtw_read32(rtwdev, addr)
>>> 
>>> For me these macros reduce code readability, not improve anything. They
>>> hide the use of rtwdev variable, which is evil, and a name like rr8() is
>>> just way too vague. Please keep the original function names as is.
>> 
>> The inspiration is from another driver.
>> readx_poll_timeout macro only takes one argument for the op.
>> Some other drivers have their own poll_timeout implementation,
>> and I guess it makes sense to make one specific for rtw88.
> 
> I'm not even understanding the problem you are tying to fix with these
> macros. The upstream philosopyhy is to have the source code readable and
> maintainable, not to use minimal number of characters. There's a reason
> why we don't name our functions a(), b(), c() and so on.

The current h2c polling doesn't have delay between each interval, so the polling is too fast and the following logic considers it's a timeout.
The readx_poll_timeout() macro provides a generic mechanism to setup an interval delay and timeout which is what we need here.
However readx_poll_timeout only accepts one parameter which usually is memory address, while we need to pass both rtwdev and address.

So if hiding rtwdev is evil, we can roll our own variant of readx_poll_timeout() to make the polling readable.

Kai-Heng

> 
> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

