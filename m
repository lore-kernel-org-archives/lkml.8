Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB8C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B0B21775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcUdbQwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBHQjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 11:39:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46110 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 11:39:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id b35so1456985pgm.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyTT17DtGxrON9z4Ni9qXKpQvVwAyB48dtmefqZzL9U=;
        b=ZcUdbQwVT2v1MI8Dj5eNpXO6ZKgT/XOmCF+9M9nzylgw5q7eHUDJ6u1F4Cp8THC01c
         wcxWj5b7LZuKfUbH15sT1T5kz0k3ef7/qBwv6U0IfI6hGHkrlhxM+jzqErgcWsbwfu2+
         1knB5oTjUAFoKkfWicttMEWyJggZDSN6g2B2u/V2ZC8QFEaFAta/H3KkdawaVwRZD1Oa
         R8q5LUlF/SCROEG79/dAbUHrRw03GkxcmTcALXmlci3FC9H4gHpd1mtxiSQ92O9Hk4k0
         DAovt+hJONlQBDLhDLS52yG3MZ99DiRgqVE0L1X9ezfJ5sdLk8pAkL5IDCb/C6RTEbx7
         Ws1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyTT17DtGxrON9z4Ni9qXKpQvVwAyB48dtmefqZzL9U=;
        b=PnjE70ZQw9xNE3oO2J1OlKTbd/FhOZ4FyVEywReYN2qok6MjMiiOv75G0ZXs6nu72l
         haDKGjuSIBEw7AHhsyLvB1v6dPwwmQ5wOhamHo5NU7usJ7LKxvwgV9UlzguqB3/Sz3Z4
         8bECQavlAWk1MKqDVregGVUixHot3niOaEghrq6P+tViv4gvjBgV9La8pcrGw/gH+uaw
         83e6u53PAV6zFUmu1JDX22wT3wB3VEUKUzuQvEyejE88W9uVwF0GC7m5YXWoyUFX/zAZ
         gR1b1NmJAl0xnSyQwFUNKg0IqTqwz/GOGYan18BL/4GqxkHWEBFMDhxhbaVQlUhQtCv+
         LVEA==
X-Gm-Message-State: APjAAAUKHwJaScVoDAEkAJHE3Un49TvBy8XvB+HrOJJ9HhOiXO7TTAPt
        BucnSYCCctnKeO2mZWn/gKDcGi8R
X-Google-Smtp-Source: APXvYqyGevnDyZbODxBAoKUXUNZk/jawmh9/Ci/deotOpaaaatRCiNd85uKZuJ1ONlzRaJEwYY1scg==
X-Received: by 2002:a63:8349:: with SMTP id h70mr5338389pge.396.1581179941325;
        Sat, 08 Feb 2020 08:39:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t66sm6923342pgb.91.2020.02.08.08.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 08:39:00 -0800 (PST)
Subject: Re: da9062_wdt.c:undefined reference to `i2c_smbus_write_byte_data'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
References: <202002082121.pOScaga1%lkp@intel.com>
 <14439325-fa91-9090-6dab-d63ce540aae7@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <184bc727-2cb5-a3c2-38ee-83da8dbd0396@roeck-us.net>
Date:   Sat, 8 Feb 2020 08:38:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <14439325-fa91-9090-6dab-d63ce540aae7@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/20 8:06 AM, Randy Dunlap wrote:
> On 2/8/20 5:14 AM, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f757165705e92db62f85a1ad287e9251d1f2cd82
>> commit: 057b52b4b3d58f4ee5944171da50f77b00a1bb0d watchdog: da9062: make restart handler atomic safe
>> date:   12 days ago
>> config: i386-randconfig-b001-20200208 (attached as .config)
>> compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
>> reproduce:
>>          git checkout 057b52b4b3d58f4ee5944171da50f77b00a1bb0d
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     ld: drivers/watchdog/da9062_wdt.o: in function `da9062_wdt_restart':
>>>> da9062_wdt.c:(.text+0x1c): undefined reference to `i2c_smbus_write_byte_data'
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> Also reported here:
> https://lore.kernel.org/lkml/ac797eb0-9b0a-d2d3-3a40-3fbd0a8b5ee0@infradead.org/
> 

Yes, I know, and 0-day reported it earlier as well. Unfortunately
neither resulted in a fix. I submitted one last night; see
https://patchwork.kernel.org/patch/11371651/.

Guenter
