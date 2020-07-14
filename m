Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20CAC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B647212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqpdiJTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGNJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:34:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgGNJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594719236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD/NJLwq0bamxwrGSpcfsRcNRSxti2z+zdKscIzsmx8=;
        b=aqpdiJTbxSyzYz5A5oM5qGBwedN6Z2XP4krUBoIdGuqI8/RAzX06Ic/k2gil0u0eVB9BgF
        XPC0VgGtHu9pkvLdW/6KV3xVbsDyanNFMG/LRh61N71X6F+eNZTXzOyyw6mSSvM9/PMCFP
        LajOPPz1TeZb7IFgq0b4C49EEgzFkkA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-IIOjO1v5OfWKNeJr3I5bsQ-1; Tue, 14 Jul 2020 05:33:55 -0400
X-MC-Unique: IIOjO1v5OfWKNeJr3I5bsQ-1
Received: by mail-wr1-f69.google.com with SMTP id c6so20895228wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DD/NJLwq0bamxwrGSpcfsRcNRSxti2z+zdKscIzsmx8=;
        b=EGfkDOQ82R5h48AEp1oihCqIUZVHE03Tke2xhiuDilrfFhEApOOBFB35yeiOG0CGtB
         iLzSGx0gzNsfrSefRO6yYz/xII/11fLb15CpWZMbTfVoFkZWpqVDdrSDOinZPLI3uszc
         n5OP7S56MmNYOr/S7lJyOKOdkfNXPTUV3DLBDPPkkpP9+wawSXI9YaI5J1l3IXf1Mqde
         1SKWaOLLzL22HDY4W9f/wrsoHssS2PaHQOfsm0RFpEy0Jh1ensGo5fzMicPHZDd70yUw
         l2+qZvViRINkWn85LAa9ozolXpe1ujrBP5NpzwkCBjHchoUAIv8ZJZHNKuxZbG05cSDT
         Kfpg==
X-Gm-Message-State: AOAM531JkW2feMx693261L1MGJxeHHzuKs5JKi0X+407eY6M0iIdlILq
        eI4QsqLAUqP1lgYB/UUQYvenTOANQr5yDaJ0mEEifIegBV3e/Rli36s8piwgx7Dv/ugDmtPKMdO
        wFJcKyloa9vzVP/ZJOvAWTnX3
X-Received: by 2002:adf:82f5:: with SMTP id 108mr4055590wrc.218.1594719233554;
        Tue, 14 Jul 2020 02:33:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1p/qy7933UavAoXwgcWhVOtbvoAlMJGxZoS0PdD7U/ByU3kIkzqqn/GZmkZDBKPgptMqMYw==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr4055578wrc.218.1594719233348;
        Tue, 14 Jul 2020 02:33:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a12sm28522958wrv.41.2020.07.14.02.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 02:33:52 -0700 (PDT)
Subject: Re: [PATCH 5.8 regression fix] platform/x86: thinkpad_acpi: Revert:
 Use strndup_user() in dispatch_proc_write()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200714081510.6070-1-hdegoede@redhat.com>
 <CAHp75Vd6uGNw5m3-Tc1tkABLT_Wi7CtW2yo8+B5TpYV4U8XE9A@mail.gmail.com>
 <CAHp75Ve9HF4WVkiUA77s9LsN6d8oaFPRgjLi86FnDSHgmVvTNA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <af1a7c41-071f-4c26-9a9a-7c6ffb5dde88@redhat.com>
Date:   Tue, 14 Jul 2020 11:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve9HF4WVkiUA77s9LsN6d8oaFPRgjLi86FnDSHgmVvTNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/14/20 10:27 AM, Andy Shevchenko wrote:
> On Tue, Jul 14, 2020 at 11:21 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Jul 14, 2020 at 11:15 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Commit 35d13c7a0512 ("platform/x86: thinkpad_acpi: Use strndup_user()
>>> in dispatch_proc_write()") cleaned up dispatch_proc_write() by replacing
>>> the code to copy the passed in data from userspae with strndup_user().
>>
>> user space

Ack, do you want me to send a v2, or can you fix this up after applying.

>>> But strndup_user() expects a 0 terminated input buffer and the buffer
>>> passed to dispatch_proc_write() is NOT 0 terminated.
> 
> Second though, perhaps it's a simple wrong count parameter?
> strndup_user(..., min(count, PAGE_SIZE)) or so would work?

I honestly have not looked at a better fix and given that you've just come
up with 2 suggestions which may or may not work, combined with
where we are in the 5.8 cycle I believe it would be best to just
play it safe and go with the revert for 5.8.

If you then take a second attempt at cleaning this up for 5.9 and
send it to me, I can test it for you.

Regards,

Hans

