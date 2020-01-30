Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22959C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7372214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NycLLl0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgA3P4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:56:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727238AbgA3P4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580399807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syj/yvwtHnLk6ht7RTnOMjUaaC+K5ir6hBollPLRIhY=;
        b=NycLLl0LsyyTw0ruJafDUNWQ/d+YJDvKN3IFVPWyOoGeWLgHOXmKquJRDob6uoZX4GWBrR
        z1z9sMsTNks8jDF3c/rvbDUqjnt8hBC7+xqpmTszLGx9R2lQQ1uh6lf52UmDUpdo7kGtaX
        7T/xQ6chM8vg50G1xJsw5SchJ/uv0V8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-pjpTjYWEPNizcmha4vmz_w-1; Thu, 30 Jan 2020 10:56:45 -0500
X-MC-Unique: pjpTjYWEPNizcmha4vmz_w-1
Received: by mail-wr1-f69.google.com with SMTP id z15so1937732wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=syj/yvwtHnLk6ht7RTnOMjUaaC+K5ir6hBollPLRIhY=;
        b=XLElKB7jBmiDbF1ytOaay0bhzWDNn3t3lLUMP+SgaEWGcs/BGeIJCbUIGTKUM9LrQA
         GHJxjJ3QoNZi28/sLZgS7HckoKtADYUlZFQThfQtG/qbhENKWtM5yEhxh/FqqpTIbhno
         tLS6h27wwzBxENcv67Vv4uCq2qIgviO1Q7HEB4mzNxs36RdsPZO8dXwYulN5In16ATRM
         fL7h20kMWl3eeML6QO8YlosGe3l68kzoLcleOMPtVEZ3/boSFtuymAnVMC3+8xT6VnZm
         eko1dw4DFqHLSQ2pIuolC2PSGq3bXLiQdi22sbWNJAQplL9MupPhBjJMaZUEyA+9mulg
         aFDw==
X-Gm-Message-State: APjAAAX23IcS278g9rVWzpix7dsYsEjat/ve1T7+AmoI3vRSa+mtoSRM
        /Gu+t0vsba8zEzqgIbtEJt7BPZwabiOnlUUgp6rC9WU83DRBMekmSV9irEJfMH3idGLAWqFs30R
        QB3utQwvhjY6jw+46/oPnQwJj
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr6559863wma.32.1580399803736;
        Thu, 30 Jan 2020 07:56:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEze1huitjg4xVIZ7sJ48kp+T+DkztB1eM3ld2HNC6In5U26f3adC/JRDh8BAYmcpyxXiWyQ==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr6559841wma.32.1580399803501;
        Thu, 30 Jan 2020 07:56:43 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id t10sm6578416wmi.40.2020.01.30.07.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:56:42 -0800 (PST)
Subject: Re: [PATCH 3/3] x86/tsc_msr: Make MSR derived TSC frequency more
 accurate
To:     David Laight <David.Laight@ACULAB.COM>,
        'Peter Zijlstra' <peterz@infradead.org>
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
 <e0926d9a7bc3461a9157d24210c679df@AcuMS.aculab.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f69a2fb1-c22e-d885-43c6-0980ce187732@redhat.com>
Date:   Thu, 30 Jan 2020 16:56:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e0926d9a7bc3461a9157d24210c679df@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 30-01-2020 16:21, David Laight wrote:
> From: Peter Zijlstra
>> Sent: 30 January 2020 13:43
> ...
>>> + * Bay Trail SDM MSR_FSB_FREQ frequencies simplified PLL model:
>>> + *  000:   100 *  5 /  6  =  83.3333 MHz
>>> + *  001:   100 *  1 /  1  = 100.0000 MHz
>>> + *  010:   100 *  4 /  3  = 133.3333 MHz
>>> + *  011:   100 *  7 /  6  = 116.6667 MHz
>>> + *  100:   100 *  4 /  5  =  80.0000 MHz
>>
>>> + * Cherry Trail SDM MSR_FSB_FREQ frequencies simplified PLL model:
>>> + * 0000:   100 *  5 /  6  =  83.3333 MHz
>>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
>>> + * 0011:   100 *  7 /  6  = 116.6667 MHz
>>> + * 0100:   100 *  4 /  5  =  80.0000 MHz
>>> + * 0101:   100 * 14 / 15  =  93.3333 MHz
>>> + * 0110:   100 *  9 / 10  =  90.0000 MHz
>>> + * 0111:   100 *  8 /  9  =  88.8889 MHz
>>> + * 1000:   100 *  7 /  8  =  87.5000 MHz
>>
>>> + * Merriefield (BYT MID) SDM MSR_FSB_FREQ frequencies simplified PLL model:
>>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
>>
>>> + * Moorefield (CHT MID) SDM MSR_FSB_FREQ frequencies simplified PLL model:
>>> + * 0000:   100 *  5 /  6  =  83.3333 MHz
>>> + * 0001:   100 *  1 /  1  = 100.0000 MHz
>>> + * 0010:   100 *  4 /  3  = 133.3333 MHz
>>> + * 0011:   100 *  1 /  1  = 100.0000 MHz
>>
>> Unless I'm going cross-eyed, that's 4 times the exact same table.
> 
> Apart from the very last line which duplicates 100MHz.
> And the fact that some entries are missing (presumed invalid?)
> for certain cpu.
> 
> If the tables are ever used for setting the frequency
> then the valid range (and values?) would need to be known.
> 
> I did wonder if the 'mask' was necessary?
> Are the unused bits reserved and zero?

They are reserved without having a defined value, the appear to
usually be 0 but I would rather not depend on that.

Regards,

Hans

