Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ACC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95E520776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz9XxbyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgDQNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDQNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:04:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF16C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:04:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so1810768wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7271KD2VNpOMViwYotEslE4D6OjUz13Ef0kZtzEl5zY=;
        b=fz9XxbyBBqtvW5YgOol8fJzRb6ZvBP6kWOp8cr9iR/HK2F0ZcfgYt28ellAJjD3PMB
         qLzRKsqbBT/P0Jz1W6OOD8jeCmJnvM/NRYIwfcw8ju6Y6xNb9ACAmQYZGpzKXGgsavAa
         6dfFJ4IATdHMcWceO4jTmCvtzA3C5LKr0lkn2OLP2AkvXxCZ1C2T8S+YjxvHfkNET7nl
         I3M7+jQXHTw82I0vGzWjoVcpUKU32qLIwrH4uSUABmex0dFWN6Iri43auzhC4hQw8oyt
         Xi+m7c4jhEItpC78WH0ze4FDa74rWS7JknFjPnCSRUyLnfCjCkJpXLTFJLsfqVE5+6x0
         84AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7271KD2VNpOMViwYotEslE4D6OjUz13Ef0kZtzEl5zY=;
        b=rCb24FkXUtToQshVzWuoEUoLRJI0VXUM/Za/pOkCVuXwROAsyuKiiOakhtqFIJCdHm
         lYc9QexciEt/K5YjAyL74USeLuH1vD5DlNkoy/oKy1DHHwqeDzZVS9ax9M/YvneGJCgG
         CheMLraMY2vDMczma24YfrSS1RG4SQ0vkydLv5dQV17V557y/ckZsYTsVeX1JMm8P2Tn
         ZiOVXi1PuoHyLtU4ibc2s89vG5LVj8oWYIA0H4hIwe31j6cmNINDjng8Aq5KkBDvDwv/
         B6kj3e0Llk863PWWq15k/BPJpztLD/TaM45g/O9dP/X+76dZzYx2hCMwO82piJTJJ6Ay
         OxqA==
X-Gm-Message-State: AGi0PuZd+82tBGKPgavdTHXV6/bz3Px3VSbW9KEw+/keP4DYrxqPITD8
        8/qVQXH4QxUJsVGQ6lfdtsF3z2R1
X-Google-Smtp-Source: APiQypL4OnX5WERtK+wI+mW9HBYL/JNaMj3Vi68Bikb523we8SnBClqp6R1HJspLG2lPE4E8sfwLew==
X-Received: by 2002:a1c:9989:: with SMTP id b131mr3007477wme.176.1587128668578;
        Fri, 17 Apr 2020 06:04:28 -0700 (PDT)
Received: from ?IPv6:2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21? ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id k3sm22998141wru.90.2020.04.17.06.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 06:04:27 -0700 (PDT)
Subject: Re: [PATCH] Changes in w1_therm.c and adding w1_therm.h
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <greg@kroah.com>
References: <20200414170248.299534-1-akira215corp@gmail.com>
 <20621587067856@mail.yandex.ru>
From:   akira215 <akira215corp@gmail.com>
Message-ID: <531d8c36-82d4-f589-e10d-f20d8b541777@gmail.com>
Date:   Fri, 17 Apr 2020 15:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20621587067856@mail.yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your answer and for your encouragement. Sorry for the 
previous mail, it was a mistake from my side, you can obviously delete it.

Akira SHIMAHARA

Le 16/04/2020 à 22:12, Evgeniy Polyakov a écrit :
> Hi
> 
> 14.04.2020, 20:03, "Akira Shimahara" <akira215corp@gmail.com>:
>> From: Akira SHIMAHARA <akira215corp@gmail.com>
>>
>> Patch for enhacement of w1_therm module. Added features :
>>   - Bulk read : send one command for all the slaves
>>                   on the bus to trigger temperature conversion
>>   - Optimized conversion time regarding to device resolution
>>   - Dedicated sysfs entry for powering read,
>>                   resolution set/get, eeprom save/restore
>>   - Alarms settings and reading
>>   - Code optimization to mitigate bus traffic
>>                   (devices information are stored to avoid
>>                  interrogating each device every-time)
>>
>> Following sysfs entry are added :
>>   - temperature (RO) : return the temperature in 1/1000°
>>   - ext_power (RO) : return the power status of the device
>>   - resolution (RW) : get or set the device resolution (supported devices)
>>   - eeprom (WO) :trigger a save or restore to/from device EEPROM
>>   - alarms (RW) : read or write TH and TL in the device RAM
>>   - therm_bulk_read (RW) : Attribute at master level to trigger
>>                   bulk read and to survey the progress of devices conversions
>>   - w1_slave has been kept for compatibility
>>
>> Main motivation was to improve temperature reading speed, which depend
>> on resolution settings of devices. The module store the powwer status and
>> the resolution of each device so that during reading operation, no
>> transaction is required on the bus, which improve speed.
>> The harware status is checked as soon as a new device is detected,
>> when a user change occured, or when the corresponding sys file is
>> accessed by user.
>>
>> The bulk read allow to trigger convserion of all devices on the bus at
>> the same time. It will apply a strong pull up on the line if at least
>> one device required it. The duration of the pull up is the max time
>> required by a device on the line.
>>
>> Please let me know any feedback you have on this patch.
>>
>> Thanks ahead,
>>
>> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> 
> Looks good to me, thank you!
> These are really good changes.
> 
> Greg, please pull it into your tree, thank you.
> 
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> 
