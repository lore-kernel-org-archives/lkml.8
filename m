Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F67EC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B5F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8lB6BQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgA3Pz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:55:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727158AbgA3PzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580399724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIniRKH5eJWirOTGDpCMRoL0u0EMZtrsaB2G31yPt3o=;
        b=h8lB6BQEMaEdELRYIY3iqver3iLUmwi5ecRGg8HxA3+ZXBm7dtd31DJGq/V0hd+NfOASJa
        a6/xms8up3LeJghtt9Hpul5/WWf7XAj/39EtWR4p653p4UfEib99lDNj/f3uEud02NJJGH
        PmW8RP7g8mVLho+ycrXtUcHvznHEQTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-eGEjH5H9MyCmMgntl8eIIg-1; Thu, 30 Jan 2020 10:55:22 -0500
X-MC-Unique: eGEjH5H9MyCmMgntl8eIIg-1
Received: by mail-wm1-f69.google.com with SMTP id q125so656142wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIniRKH5eJWirOTGDpCMRoL0u0EMZtrsaB2G31yPt3o=;
        b=qccflf2eCNV+acpYIIl3aL6IWhgZNJhZaKQc9UlYWhqYkEvmEtgUrhmZpG1XN1lnp6
         VS2PzsawMqvc3ESLrJJlN/xZjM9e365lHD9usdRn4eUN9X9ZbT1bpoqzSjGpWv4iKgKg
         UMTW8ET6kzngfhEycbCKvjJ/W5WzkDrTcr0NkuBIzOpiZHIO75QVS9k+xYWVu9W6cPkr
         dHmvl7QQP8ERKlOuvpKA9Wn5XFFqG/bboZHmOoqplkdDkVkdRvhBR5bdZd/cuNPwoTFJ
         vEIHDPDR9VxuUx7reEF0N0vkSNTEIt+hDwNV6eEH8gx/CsGaHnWlpvUeiyszitXV3pDF
         iuxQ==
X-Gm-Message-State: APjAAAVfr03CaoCmniIqSZqUapihOZIvGHcM/y+zHFcFfPdIVlf/WN7/
        SmjKCC6gKXNFDzK6AAh5dCv4fMqZGclk+MlaP2Km7ddrj5e6pT0LMgjkfmtGojyGViHcPzJ3KuA
        QDWKg54UNXvYmLOSEYTmcI1rg
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr6406197wrx.102.1580399721567;
        Thu, 30 Jan 2020 07:55:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4JCE3hAbo6a58Qel295x1BWP+bB1/n/AGwgwfoPvCjVp1leiQC7pEq1zSbfkxfaZD9o/q4g==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr6406161wrx.102.1580399721288;
        Thu, 30 Jan 2020 07:55:21 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id r3sm8057075wrn.34.2020.01.30.07.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:55:20 -0800 (PST)
Subject: Re: [PATCH 3/3] x86/tsc_msr: Make MSR derived TSC frequency more
 accurate
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vipul Kumar <vipulk0511@gmail.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Len Brown <len.brown@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200130115255.20840-1-hdegoede@redhat.com>
 <20200130115255.20840-3-hdegoede@redhat.com>
 <20200130134310.GX14914@hirez.programming.kicks-ass.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b77be8c0-7107-bece-5947-a625e556e129@redhat.com>
Date:   Thu, 30 Jan 2020 16:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130134310.GX14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-01-2020 14:43, Peter Zijlstra wrote:
> On Thu, Jan 30, 2020 at 12:52:55PM +0100, Hans de Goede wrote:
> 
>> This does not matter though, we can model the chain of PLLs as a single
>> PLL with a quotient equal to the quotients of all PLLs in the chain
>> multiplied.
>>
>> So we can create a simplified model of the CPU clock setup using a
>> reference clock of 100 MHz plus a quotient which gets us as close to the
>> frequency from the DSM as possible.
> 
> s/DSM/SDM/ ?

Yes.

>> For the 83.3 MHz example from above this would give us 100 MHz * 5 / 6 =
>> 83 and 1/3 MHz, which matches exactly what has been measured on actual hw.
>>
>> This commit makes the tsc_msr.c code use a simplified PLL model with a
>> reference clock of 100 MHz for all Bay and Cherry Trail models.
> 
> 
>> + * Bay Trail SDM MSR_FSB_FREQ frequencies simplified PLL model:
>> + *  000:   100 *  5 /  6  =  83.3333 MHz
>> + *  001:   100 *  1 /  1  = 100.0000 MHz
>> + *  010:   100 *  4 /  3  = 133.3333 MHz
>> + *  011:   100 *  7 /  6  = 116.6667 MHz
>> + *  100:   100 *  4 /  5  =  80.0000 MHz
> 
>> + * Cherry Trail SDM MSR_FSB_FREQ frequencies simplified PLL model:
>> + * 0000:   100 *  5 /  6  =  83.3333 MHz
>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
>> + * 0011:   100 *  7 /  6  = 116.6667 MHz
>> + * 0100:   100 *  4 /  5  =  80.0000 MHz
>> + * 0101:   100 * 14 / 15  =  93.3333 MHz
>> + * 0110:   100 *  9 / 10  =  90.0000 MHz
>> + * 0111:   100 *  8 /  9  =  88.8889 MHz
>> + * 1000:   100 *  7 /  8  =  87.5000 MHz
> 
>> + * Merriefield (BYT MID) SDM MSR_FSB_FREQ frequencies simplified PLL model:
>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
> 
>> + * Moorefield (CHT MID) SDM MSR_FSB_FREQ frequencies simplified PLL model:
>> + * 0000:   100 *  5 /  6  =  83.3333 MHz
>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
>> + * 0011:   100 *  1 /  1  = 100.0000 MHz
> 
> Unless I'm going cross-eyed, that's 4 times the exact same table.

Correct, except that the not listed values on the none Cherry Trail
table are undefined in the SDM, so we should probably deny them
(or as the old code was doing simply return 0).

And at least the Moorefield (CHT MID) table is different for 0011, that
is again 100 MHz like 0001 instead of 116.6667 as it is for BYT and CHT.

Note that the Merriefield (BYT MID) and Moorefield (CHT MID) values are
based on the old code I've not seen those values in the current latest
version of the SDM.

> Do we want to use the Cherry Trail table (for being the most complete)
> for all of them?

The old code had per model tables, and at least for BYT the SDM specifies
that only the lowest 3 bits of the MSR_FSB_FREQ register should be used,
the rest is marked as reserved (with no defined/default value given for them)
and on BYT only 000 - 100 are defined as being used, note 101 - 111 are
not marked as reserved, they are simply not documented for BYT.
_4_ bits should be used and there are frequency values defined for 0000 - 1000
again 1001 - 1111 are not marked as reserved, they are simply undocumented.

And for both MID variants I have no docs.

Regards,

Hans

