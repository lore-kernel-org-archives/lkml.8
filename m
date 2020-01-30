Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B15C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F5320674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLoii9kJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgA3QEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:04:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727191AbgA3QEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580400261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqe+NoPMzT7qAg85et2NM6krGWv/koxPfAUCYSpHnTo=;
        b=aLoii9kJsSFXg7n5QfboD4aEIDFeMVUROrMpS+zuRloR54o3iLt1lOTuJ6U94xIvfpiRpG
        5N1uGsGbT6/WgyENzxzBLVU7NMOdqW+t8DBK86kOSMBKpEMCESkd4DwyN0tGsQNwrQaQAt
        UKe6KdmSz4IOCGHcx6p1tVlsA4871oc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-VIyyjeDYPNedVNJOOw-2wQ-1; Thu, 30 Jan 2020 11:04:18 -0500
X-MC-Unique: VIyyjeDYPNedVNJOOw-2wQ-1
Received: by mail-wr1-f70.google.com with SMTP id z14so1950401wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yqe+NoPMzT7qAg85et2NM6krGWv/koxPfAUCYSpHnTo=;
        b=W8i8POuJPegU5Aj4ABYxAX1PQjJKRuR1ImkD8G6Wj5QIPdlvRv1ggj52ZkwkaKFubO
         zK2Au0dawYYCENWl4oaUtSVO6lwh1HfmGE8k3g0hQuwdWX3MKAQQQt2fnZryIVNIIU0K
         RfGDD5Fl/ffASRwXGLimRR05bM4CwiNoWb4u4o4CasxiplxKp/j1YpvKfe2kxkQjRK4p
         mDPmrTe64EH/cjmhImrQ3rnjTGQLh2WqEoAdWIaGeAA0ryoQGIxVYG1IWHyPcylFWFzD
         kl7fixjfKg129QAKtaSOleWWhcym3dpBYt50wQ7+bkgkjRiAamP58L7s2mPsl/JMRvPx
         6BgA==
X-Gm-Message-State: APjAAAWWlcNn2BTkRoCD/25MfLqJBhAyFJpZGoZ/Ei09KuIerGVk9Ka9
        sUlZ8bMCBHicc3+hRvPrI6p1RNwbxkvhV3HzQIduSD8JbnipIFGveRpYeywIQd9clKkDEx+n38k
        rdy3U+SSLdr/q/P932fuNfUkD
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr537013wro.231.1580400257544;
        Thu, 30 Jan 2020 08:04:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxw6lgTdMyEhaJP7h4XlCILbKz4N9dAWcpCAl11gNAAd2FRnXy0wgPcZS9AuKOM8Uqa4Lbj6g==
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr536994wro.231.1580400257365;
        Thu, 30 Jan 2020 08:04:17 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id 2sm7773100wrq.31.2020.01.30.08.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:04:16 -0800 (PST)
Subject: Re: [PATCH 3/3] x86/tsc_msr: Make MSR derived TSC frequency more
 accurate
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vipul Kumar <vipulk0511@gmail.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Len Brown <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20200130115255.20840-1-hdegoede@redhat.com>
 <20200130115255.20840-3-hdegoede@redhat.com>
 <20200130134310.GX14914@hirez.programming.kicks-ass.net>
 <b77be8c0-7107-bece-5947-a625e556e129@redhat.com>
 <01feee20ee5d4b83ab218c14fc35accb@AcuMS.aculab.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8a8fd7a1-945e-4541-f0bc-387fae7c6822@redhat.com>
Date:   Thu, 30 Jan 2020 17:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <01feee20ee5d4b83ab218c14fc35accb@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-01-2020 17:02, David Laight wrote:
> From: Hans de Goede
>> Sent: 30 January 2020 15:55
> ...
>>>> + * Moorefield (CHT MID) SDM MSR_FSB_FREQ frequencies simplified PLL model:
>>>> + * 0000:   100 *  5 /  6  =  83.3333 MHz
>>>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>>>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
>>>> + * 0011:   100 *  1 /  1  = 100.0000 MHz
>>>
>>> Unless I'm going cross-eyed, that's 4 times the exact same table.
>>
>> Correct, except that the not listed values on the none Cherry Trail
>> table are undefined in the SDM, so we should probably deny them
>> (or as the old code was doing simply return 0).
>>
>> And at least the Moorefield (CHT MID) table is different for 0011, that
>> is again 100 MHz like 0001 instead of 116.6667 as it is for BYT and CHT.
>>
>> Note that the Merriefield (BYT MID) and Moorefield (CHT MID) values are
>> based on the old code I've not seen those values in the current latest
>> version of the SDM.
> 
> I wonder if Moorefield:11 is an old typo?

I have no idea. Andy if you can find any docs on the MSR_FSB_FREQ values
for Merriefield (BYT MID) and Moorefield (CHT MID) that would be great,
if not I suggest we stick with what we have.

Regards,

Hans

