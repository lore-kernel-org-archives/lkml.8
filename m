Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F63C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0342920828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIyP1mP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCHTWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:22:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50931 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCHTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:22:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so7717723wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D7+79NwrEk95vLhnhqaYEUgUdXDmRjOIGLsgZ0X1kRw=;
        b=hIyP1mP82HEjKwYkK6Qczyu5S6k56AX/xd4eZnJeT/xKxNvhxKdubhRFjvnKawCry/
         hqnxOCUZy6p1xQpAF2huP3IZbSJo4aaYGgZ25ZF+ptn2MrRoktHyGUNiSKMKm2uiRJzv
         3nKobObqO93N4XKTV1q3rV6d/Pw84A6U9cHsJ3a7FyHFJNTRYVmXes3ZdxYbB3TaX184
         ZHaARSL/xg6BkDErgRSTp11u0lQTkp8wWNRb4FILrgu4IWEaXjOXXQlvii/O0fYgz4Sv
         CQCLKGPJJTgsaZA5yODi1uaM61LGovNuksSE1b08jF/sJLQ5TH7gw9UnlH7OLG1/Uenh
         vHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7+79NwrEk95vLhnhqaYEUgUdXDmRjOIGLsgZ0X1kRw=;
        b=Ex/G2cYL1S29rddX7Gem2O321SEPY08x1T1JDhMAI1ZodgWDtmaPl7bRQQX8zPdqpX
         xtm8Z7VeZfMaLD8SeVdMGsxs5OL9qezJVR2DSQ2dpn7DK0CJKQD1iECodcCZnl6IknRl
         qakioR/nLFvBIwVsIjnQmTT+US98HMlYO2yBNJ3RjDcYRORX0jPFL+HhtRa2CcFu4KV+
         QZeM6WfbApEbDD4xsY/2byjry+Rcs1m4UfCqjBhtMVXXnZcUHl3T8szVKo0GtSMzWfnt
         OL8QLAlvwcX0LDLhXcqXblIyZq1fWS8oANvJsapfT8ow0ChPLvNC825FdwzgPRSynERi
         L0GQ==
X-Gm-Message-State: ANhLgQ1QzZrswz5c7/fnkVvvAn5RtZXsEvuX9nNkROsKzhKfBp7UKOuf
        q0w+umNRcvPi8w/BGnIE48w=
X-Google-Smtp-Source: ADFU+vsimzND9hNjfuJemOYs6CO9wGT5V9Ylg0dKLRicgR7dX/djBgKE989ZF0qNyFVha5+lUwvPWQ==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr15511807wmf.184.1583695330527;
        Sun, 08 Mar 2020 12:22:10 -0700 (PDT)
Received: from [192.168.43.18] (92.40.248.47.threembb.co.uk. [92.40.248.47])
        by smtp.gmail.com with ESMTPSA id p10sm55410271wrx.81.2020.03.08.12.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 12:22:10 -0700 (PDT)
Subject: Re: [PATCH] staging: vt6656: Use BIT_ULL() macro instead of bit shift
 operation
To:     Oscar Carter <oscar.carter@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
References: <20200307104929.7710-1-oscar.carter@gmx.com>
 <20200308065538.GF3983392@kroah.com> <20200308161047.GA3285@ubuntu>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <561bc968-f88c-40e3-f53c-5c03f74f75ea@gmail.com>
Date:   Sun, 8 Mar 2020 19:22:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308161047.GA3285@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>   */
>>>  #undef __NO_VERSION__
>>>
>>> +#include <linux/bits.h>
>>>  #include <linux/etherdevice.h>
>>>  #include <linux/file.h>
>>>  #include "device.h"
>>> @@ -802,8 +803,7 @@ static u64 vnt_prepare_multicast(struct ieee80211_hw *hw,
>>>
>>>  	netdev_hw_addr_list_for_each(ha, mc_list) {
>>>  		bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
>>> -
>>> -		mc_filter |= 1ULL << (bit_nr & 0x3f);
>>> +		mc_filter |= BIT_ULL(bit_nr);
>>
>> Are you sure this does the same thing?  You are not masking off bit_nr
>> anymore, why not?
> 
> My reasons are exposed below:
> 
> The ether_crc function returns an u32 type (unsigned of 32 bits). Then the right
> shift operand discards the 26 lsb bits (the bits shifted off the right side are
> discarded). The 6 msb bits of the u32 returned by the ether_crc function are
> positioned in bit 5 to bit 0 of the variable bit_nr. Due to the right shift
> happens over an unsigned type, the 26 new bits added on the left side will be 0.
> 
> In summary, after the right bit shift operation we obtain in the variable bit_nr
> (unsigned of 32 bits) the value represented by the 6 msb bits of the value
> returned by the ether_crc function. So, only the 6 lsb bits of the variable
> bit_nr are important. The 26 msb bits of this variable are 0.
> 
> In this situation, the "and" operation with the mask 0x3f (mask of 6 lsb bits)
> is unnecessary due to its purpose is to reset (set to 0 value) the 26 msb bits
> that are yet 0.

The mask is only there out of legacy originally it was 31(0x1f) and the
bit_nr spread across two mc_filter u32 arrays.

The mask is not needed now it is u64.

The patch is fine.

Regards

Malcolm


