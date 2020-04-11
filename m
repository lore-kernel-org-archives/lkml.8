Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D6C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336BC20769
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0o/5Q26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgDKBTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:19:53 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39789 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDKBTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:19:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id o1so512744pjs.4;
        Fri, 10 Apr 2020 18:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q76ZSajaC/YJBLj5bVJ6v4ueopAFGHt7xFuqf9dHOiA=;
        b=m0o/5Q26w51bz/i8QX0xLdmc8c3ZYgQccVoUadlaBxY5748EImtGd6leTW9Trq0L7O
         T6OXGpCYgjCUaVDw8a89mvZE7VJIXkXjrFtBrmuxRophoecdwdlGtcKQpitmeAQgfyBK
         b1DU3fYHeyvYuKUb2EKYjgxkzE6d4eeqGsLa4f6KGuG9Gw6aoPXzOAEFNakP9FTb/uRZ
         Ho1V2iOo/MH/G/MvLUKobVlSBqIY+dNcL0CSE/UavvRdVZa8sEaUbHUnAeafwGKtc2mW
         i4xU45QmCyUylww0kfcEO+yYjymJGqISK3NP1Schr/e2rUXOEHhIN3HSbvDz5CSuBwn3
         jd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q76ZSajaC/YJBLj5bVJ6v4ueopAFGHt7xFuqf9dHOiA=;
        b=CZj4SJ9PuBENuH6efh1xlsG3PUCg+MuevimkpzdbkkBu0TSVIzqwi6xhiHOuTE+UiZ
         vysHyKVxXiC3pRHQWivXg/W3fzx1OTLwUWP31yehGW5Jx0ajPeD9Ra/GfAzEA+bUoLCR
         QwHfYoKfpm1iA7V2bBqHMdbJJ6gnMY0HCqyHrCc4B9H4hA410A+JenKIy75s61ElquXs
         vOg8Z1A2+oBGYsf9irUjkwNZnMfiTMvNI5wycK4CNbJj1OGatbuDdrSGGZ1ZiPI+7Tx1
         fFNleDbhXxqjWLu3uszYv/+oklsmd3TAfshdRfkqhtHGeJJKHDrsjELcgzjko1PQ2HBK
         UODQ==
X-Gm-Message-State: AGi0PuYoWNZAJFXHEwBVTzIF4xTZfoMExT/Mi6bzmJAVd4PTK30n4jGc
        0b1eRejl0Q+xAusL+R6BOuM=
X-Google-Smtp-Source: APiQypLV+LFP74oTLjRpgu3lSxCWC5nNL7O5GpBPXhJclCHv0BTdgEhV3lV0B7jZupzjYMe591ttmA==
X-Received: by 2002:a17:90b:90e:: with SMTP id bo14mr8406843pjb.104.1586567992343;
        Fri, 10 Apr 2020 18:19:52 -0700 (PDT)
Received: from i7.zsun.org ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e187sm2879946pfe.50.2020.04.10.18.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 18:19:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] Bluetooth: btrtl: Add support for RTL8761B
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, icenowy@aosc.io
References: <20200410145420.108868-1-sztsian@gmail.com>
 <20200410145420.108868-2-sztsian@gmail.com>
 <5CD9EBAA-44A6-4DFF-870E-4F862FB7A60E@holtmann.org>
From:   Zamir SUN <sztsian@gmail.com>
Message-ID: <bb48d88a-3b4f-dfa6-bbed-777a76d072ed@gmail.com>
Date:   Sat, 11 Apr 2020 09:19:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5CD9EBAA-44A6-4DFF-870E-4F862FB7A60E@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/20 1:36 AM, Marcel Holtmann wrote:
> Hi Zamir,
> 
>> Add new compatible device RTL8761B.
>>
>> Signed-off-by: Ziqian SUN (Zamir) <sztsian@gmail.com>
>> ---
>> drivers/bluetooth/btrtl.c | 10 +++++++++-
>> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> can you also please include the content of /sys/kernel/debug/usb/devices for this device in the commit message.
> 
> And if you run btmon before plugging it in, I like to see what LE Features of Bluetooth 5.0 this dongle really offers.
> 

Hi Marcel,

I think you want this section

         Supported settings: 0x0001bfff
           Powered
           Connectable
           Fast Connectable
           Discoverable
           Bondable
           Link Security
           Secure Simple Pairing
           BR/EDR
           High Speed
           Low Energy
           Advertising
           Secure Connections
           Debug Keys
           Privacy
           Static Address
           PHY Configuration

Full log of btmon is available here, with the mac address masked 
http://fars.ee/Lu85

I'll send a v3 to include the usb info in the commit message shortly.

> Regards
> 
> Marcel
> 

-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E
