Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183C8C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11EB246A5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0hEMFvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgARROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:14:35 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41344 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARROe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:14:34 -0500
Received: by mail-yb1-f194.google.com with SMTP id z15so7702606ybm.8;
        Sat, 18 Jan 2020 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0T9fqAMxiYB3y9OzNxfO/MyT5XpU+aTojyxESTZY5zc=;
        b=j0hEMFvssafuwd0NXovApcEKy74ha1Sr+GUnybLUYUbK2JEGX4K7qvneiLcPU60Rir
         68DqOhcjmreKfZbNgU4DXM8KubsvlXRx9VUWABrWos2AusaEUyNmAbTk2gxdKWdh0+FX
         2tKJ1Y6uB0ziFJN+8iwZcx0oiTJorviUSWLrhV7yQGB/y0wqXO3qBFsLEsVrxZNftS0H
         o0EKRculfPAVeRLsqtgIcpFr6g0Qouto4RYBDVB7bLeaO0PkY1xhzyTzV1Pu2NCipOYA
         IX0eEmMi+/nPW0KN8pp+9zBUjgo5LvoqbQ+5hSLFpb7LeHe/yw5DEDy7YY5k47es2HAe
         WKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0T9fqAMxiYB3y9OzNxfO/MyT5XpU+aTojyxESTZY5zc=;
        b=fV/Pcx/Zszc6X92QxN3TlCR3slhwldhrssP+Mgg/efhswsqOif+kNhFsaWxVzc95lI
         0m9l7HKI2PGGOas1CtQFKHTk3c+SRevmRwqsqpN98qtzZU9VeORTm33AzZB8O/Vkl7FH
         MrOEAXrDOCQ7e4gzM061ymGpulcEMsc2DuVOl6tIrbNQFSTaxCa3W1cHHrcPLwtkf1UT
         rypq9VgFlXrR2efFiAFU2NsEy0ROW6IKwkoCa3PRP01xQc0bo5YWPuTeFHbJBGjIT9oA
         mICm+r5LiYaqPB1kxEi37Cbs+OmCeXe9SO92pKEaZ+xDtOyI5tFs+nRd0jYzv8oTXB0w
         6gbw==
X-Gm-Message-State: APjAAAU7Skh2AYRYT+Pz6zUsVuU+oSixjCpoUmM6FrWctoZdNnZNplJI
        Zw3ctcw6TzNcLrHdyQuccWmIacBU
X-Google-Smtp-Source: APXvYqwSdA56F8lye8mkBOfmoCv2Q4mKT4N7qoF9l9N0X0FU9y1RJXJ8WbYEGA74HcuehUr1HxghmA==
X-Received: by 2002:a5b:60d:: with SMTP id d13mr30236289ybq.300.1579367673610;
        Sat, 18 Jan 2020 09:14:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g29sm13421291ywk.31.2020.01.18.09.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 09:14:33 -0800 (PST)
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Brad Campbell <lists2009@fnarfbargle.com>,
        linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
 <492345ed-f82e-e4d9-20ac-924b4a00df90@fnarfbargle.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6bb6770d-cfb0-1209-6c8f-f89c5dc4fa7f@roeck-us.net>
Date:   Sat, 18 Jan 2020 09:14:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <492345ed-f82e-e4d9-20ac-924b4a00df90@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/20 12:52 AM, Brad Campbell wrote:
> On 16/1/20 10:17 pm, Guenter Roeck wrote:
>> This patch series implements various improvements for the k10temp driver.
>>
> 
> Looks good here. Identical motherboards (ASUS x370 Prime-Pro), different CPUs.
> 
> 3950x
> 
Interesting. I thought the 3950X needs a newer motherboard. Is that CPU as amazing
as everyone says it is ? And does it really need liquid cooling ?

Anyway, thanks a lot for testing!

Guenter
