Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA7C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13409206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl4+8Usj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgAQD6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:58:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40201 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgAQD6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:58:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so9288397plr.7;
        Thu, 16 Jan 2020 19:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=shqXRsJsdu/xy1Xl+XnJg4wnSngJgxD5PsfBp0ubXcY=;
        b=Rl4+8UsjEd48fdTqJC6jxbv9kZ9+2+uNUKrmvAZeUJylkmOjjLCzm+epgcQRrcbl7i
         SB1SSof0XbxlvsWvif2elBjfu1R8s8nWd+eYso3x6nOFy2AM2KGQ2zu26iWj5Jj0NyX+
         BZ39gdxuoq55b4KjCHSNlkpXboVYH7MrFVra47bYJr4FiQh19I5Ce4ywVv0AdplOSA86
         dZkE1yta68GK1xZq4GdxlQZ7Rz61USlzESc5WDecZV481Dtbwp5O1s8z4PJBksHjuJXW
         LaiwQeza8eKCjX4HyhCJbkcnwnCVp20dEhs7tp1pkSCoSGNfR/JFPM0Cz4GihTOWsMmE
         TUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shqXRsJsdu/xy1Xl+XnJg4wnSngJgxD5PsfBp0ubXcY=;
        b=ZH1Ch1bJ3pTwRkwsXfgPf+/fKA7jsMLG3X6TXDcPUCftA4SUyS5IksbQ0p1N0jHzts
         UZqnHkeQtaHZYAYcpzwFyaTU1CgYDGw99H+8xx9wMAYo+H7dcfT9bObCwxvAq/A61aco
         z7n8saFpj0iNhFeNmdQmgWSn3z84CTr8d3wAgNzYyA0VJEz/g1tjEwkPdGpDi7gWXXhy
         gCOde6Dl+pHItdfAqIc52xNYvByKWNt/Vu7z9HxY9KstpPV284Z4PqfQHQ6e4k5fGZ5b
         RnQRTBpbEHYZWN+eASztHdba9g860is+xUJwv3k2kc2Z5cp5bx5jcHJtu7YiVgwVjLbU
         QdcA==
X-Gm-Message-State: APjAAAVRLqQhOGDWXgLOydPPJwfOtllTS3+4wa/VADUd/VykuflFwAL/
        bwhdSrNFBMhKPyO1JmD1YirojFzI
X-Google-Smtp-Source: APXvYqyIG6Spk7Lyhx6RcHaU51tRx2ZiyXzs62UNhINGV1ayewUm94jKh83MHfiuiFRpwYl2U4yUGQ==
X-Received: by 2002:a17:90a:b008:: with SMTP id x8mr3369587pjq.106.1579233493922;
        Thu, 16 Jan 2020 19:58:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z4sm26983737pfn.42.2020.01.16.19.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 19:58:13 -0800 (PST)
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Ken Moffat <zarniwhoop73@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
 <CANVEwpZVZs5gnvQTgwZGcT6JG7WdGrOVpbHWGD08bjPascjL=g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <964a5977-8d67-b0fd-4df4-c6bd41a8ad58@roeck-us.net>
Date:   Thu, 16 Jan 2020 19:58:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANVEwpZVZs5gnvQTgwZGcT6JG7WdGrOVpbHWGD08bjPascjL=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

On 1/16/20 4:38 PM, Ken Moffat wrote:
> On Thu, 16 Jan 2020 at 14:18, Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
> I have some Zen1 and Zen1+ here.
> 
> My Ryzen 3 1300X, applied to 5.5.0-rc5
> 
> machine idle, I thought at first the temperature may be a bit low, so
> I've added other reported temperatures.  I now think it is maybe ok.
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.41 V
> Vsoc:         +0.89 V
> Tdie:         +21.2°C  (high = +70.0°C)
> Tctl:         +21.2°C
> Icore:       +30.14 A
> Isoc:         +8.66 A
> 
> SYSTIN:                 +29.0°C  (high =  +0.0°C, hyst =  +0.0°C)
> ALARM  sensor = thermistor
> CPUTIN:                 +25.5°C  (high = +80.0°C, hyst = +75.0°C)
> sensor = thermistor
> AUXTIN0:                 -1.5°C    sensor = thermistor
> AUXTIN1:                +87.0°C    sensor = thermistor
> AUXTIN2:                +23.0°C    sensor = thermistor
> AUXTIN3:                -27.0°C    sensor = thermistor
> SMBUSMASTER 0:          +20.5°C
> 
SMBUSMASTER 0 is the CPU, so we have a match with the temperatures.

> After about 2 minutes of make -j8 on kernel, to load it
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.26 V
> Vsoc:         +0.89 V
> Tdie:         +46.2°C  (high = +70.0°C)
> Tctl:         +46.2°C
> Icore:       +45.73 A
> Isoc:        +11.18 A
> 

Both Vcore and Icore should be much less when idle, and higher under
load. The data from the Super-IO chip suggests that it is a Nuvoton
chip. Can you report its first voltage (in0) ? That should roughly
match Vcore.

> SYSTIN:                 +29.0°C  (high =  +0.0°C, hyst =  +0.0°C)
> ALARM  sensor = thermistor
> CPUTIN:                 +38.5°C  (high = +80.0°C, hyst = +75.0°C)
> sensor = thermistor
> AUXTIN0:                 -7.5°C    sensor = thermistor
> AUXTIN1:                +85.0°C    sensor = thermistor
> AUXTIN2:                +23.0°C    sensor = thermistor
> AUXTIN3:                -27.0°C    sensor = thermistor
> SMBUSMASTER 0:          +46.0°C
> 
> So I guess the temperatures *are* in the right area.
> Interestingly, the Vcore restores to above +1.4V when idle.
> 
It should be much lower when idle, actually, not higher.

All other data looks ok.

Thanks,
Guenter
