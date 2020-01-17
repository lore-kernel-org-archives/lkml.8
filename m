Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423D7C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1904D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPdj3+g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAQOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:14:40 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41991 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgAQOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:14:40 -0500
Received: by mail-yw1-f65.google.com with SMTP id l14so14395592ywj.9;
        Fri, 17 Jan 2020 06:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VgRK7owqFXqx1Er/WrhHguchgkosTUUF7rP053YZqDk=;
        b=FPdj3+g1oeemik7XvV+UzRawtP+NRK1UfI8QHBpyiFZufzctyk6ot82zs8sYKI3eSZ
         /wlcnx5tAmi96GU42dBxLqVlQYd+gfe4ZzcOE/pgLShRG58LIYvZA8pjEMhEKEQGCZFl
         jkTS6ERTyhOxrnvFbd/WQ4DXhWmFQMWxu4IRV2rAfjx5JfgisfzPxuxFDOHVcsfCQl7R
         3Mrobd6hLcCapTi6YPW/cme8Yn1mdiHazSqwD4xb7ss8JuXpdNYj3Uoyh4V/INJZ7pM5
         JQP0LRot1JZQhCzBkZyofDVwGwLHJI8RWP+FwlgtbNVZLhZdL7XYfSzZwfrWj9vTG1fj
         bLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VgRK7owqFXqx1Er/WrhHguchgkosTUUF7rP053YZqDk=;
        b=MJfhNDlOiXRGI7CcF13Y1CbFrsECDPff5rjQt1VukDmNjWFdETk5WWN2ZMo8gnfyO8
         zGOecm/B2/sDoXSW5vJM8Mrozg64WOeGLFOiowrVQrnW9ie+yTZNhvbcRAXyTdsosiOL
         KzIi1bkV8tFNfxy7HJdAJuWi+bhkee1qBRjJoyDNb8kH7zWwH+GPU44m45idQotJakf2
         LobvWvT4JDB1J6uDTo90y8v3AyZmtFSkto9WTKi52xs0n1prS78ewwKb3tkrnD7DLLmj
         +b7WzAb6faLxzc84qjUDVinBEKJmMUnb/jQmp77mg9d5UDPc+3NFepCkuj6Drw7P/ZNJ
         HprA==
X-Gm-Message-State: APjAAAVeaEeR1yIkqUvcx2kxS5mA5ObZ3f187xMaYrlty+sC101C7UuH
        iNChJUNGhFjoHCHqFZv/B+qdx0R8
X-Google-Smtp-Source: APXvYqwanZ2evU3NjoOuixklvovr3pE8yxEkzSZ1P6n/7MXb1uUZoyyBCZywMBKKiXZ4AOfCZAZF1Q==
X-Received: by 2002:a0d:e8ce:: with SMTP id r197mr26519344ywe.500.1579270479218;
        Fri, 17 Jan 2020 06:14:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u185sm11477843ywf.89.2020.01.17.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:14:37 -0800 (PST)
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Ken Moffat <zarniwhoop73@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
 <CANVEwpZVZs5gnvQTgwZGcT6JG7WdGrOVpbHWGD08bjPascjL=g@mail.gmail.com>
 <964a5977-8d67-b0fd-4df4-c6bd41a8ad58@roeck-us.net>
 <CANVEwpZnaHBfF_NWp_3_wM4S3fhFrFuDXQWRMrp=-K4L0m1b6w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <00c42e87-dd87-9116-607f-a0bdbf49d948@roeck-us.net>
Date:   Fri, 17 Jan 2020 06:14:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANVEwpZnaHBfF_NWp_3_wM4S3fhFrFuDXQWRMrp=-K4L0m1b6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 8:47 PM, Ken Moffat wrote:
> On Fri, 17 Jan 2020 at 03:58, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi Ken,
>>
>> SMBUSMASTER 0 is the CPU, so we have a match with the temperatures.
>>
> OK, thanks for that information.
> 
>>
>> Both Vcore and Icore should be much less when idle, and higher under
>> load. The data from the Super-IO chip suggests that it is a Nuvoton
>> chip. Can you report its first voltage (in0) ? That should roughly
>> match Vcore.
>>
>> All other data looks ok.
>>
>> Thanks,
>> Guenter
> 
> Hi Guenter,
> 
> unfortunately I don't have any report of in0. I'm guessing I need some
> module(s) which did not seem to do anything useful in the past.
> 
> All I have in the 'in' area is
> nct6779-isa-0290
> Adapter: ISA adapter
> Vcore:                  +0.30 V  (min =  +0.00 V, max =  +1.74 V)
> in1:                    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> AVCC:                   +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> +3.3V:                  +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:                    +1.90 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:                    +0.90 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in6:                    +1.50 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:                   +3.47 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> Vbat:                   +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in9:                    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> in10:                   +0.32 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in11:                   +1.06 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in12:                   +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in13:                   +0.94 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in14:                   +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 
> and at that point Vcore was reported as 1.41V (system idle)
> 

Looks like someone configured /etc/sensors3.conf on that system which tells it
to report in0 as Vcore. So there is a very clear mismatch. Can you report
the values seen when the system is under load ?

Thanks,
Guenter
