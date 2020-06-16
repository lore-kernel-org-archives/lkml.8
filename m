Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78451C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D497207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLyaUimn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgFPM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:29:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgFPM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592310538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67GIuCamd4MgSsvesfvqYg7CyR/yaU34h6Ys25meAe0=;
        b=YLyaUimnSgPa84m4KXj0OjczvmDjb8tcLayO2Ygu3E/Z+fmfw0A7fOGMKFG+qRT0/s+y/L
        jHmbZyuPKpm4W3UqgGbWI9/6dw7oXYehRWaegryqdvXQwCpLMWRD3FfrLXMbRQMtNNdvuI
        5Hu9mdfPvDnoZ5C7pRWA8LXDjCtIntI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-wuG3kYVvOVG4mvlBtbhxKA-1; Tue, 16 Jun 2020 08:28:55 -0400
X-MC-Unique: wuG3kYVvOVG4mvlBtbhxKA-1
Received: by mail-wm1-f72.google.com with SMTP id t145so1186168wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67GIuCamd4MgSsvesfvqYg7CyR/yaU34h6Ys25meAe0=;
        b=EfLHiIdzijEL1i4rFxfCjT9rWGSnqlJ3LFCjkXXrp57VihyLpsGExubopwqCblCeC4
         d2S2J1OIYzmGCoIGSNs351nYVlGFFJODL5Cyh/Llqcrc2Rr5j2wJqu9YvYmqYriVSq1S
         KhcVkITV5jrdbdFWONID5oRgZSl7b1R3W51xTOtTuqvv+8vskUG3COEjZb9h2brB3hF6
         n1AxnKCdm+3lySlncsl1JtZsvPWnFT8dkXTQDiB4aB/CVTPcblqGpOvUJeJxptvismv/
         BILPPXanL5QFP5X4rxFcYEdVU+/v+ha9Bh//FVOeBil9PyVafMGvv93p2dF4oBTvEdDM
         lY0Q==
X-Gm-Message-State: AOAM532pPnsNjSxsu1R13CjDEO/yL8YEUqf+/Uw0n4Q1eiqnxW3WgJZP
        XXzJDetVtIvsUISKj4eU78BmLoR00fhTmuBDP2mrrldiQh7UZgvlOzuYI5nEWlRtjr9mwcC8hxh
        CThMTXbUchOH1ghhkGgDlTM4O
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr2971493wru.95.1592310533566;
        Tue, 16 Jun 2020 05:28:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNsomDYYUeDLHsz6oPtzv9ic6c3G/8BovSOHkTiki/aC+lDX9Zjg+2kCJO168r708tABUNrw==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr2971469wru.95.1592310533343;
        Tue, 16 Jun 2020 05:28:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.88.161])
        by smtp.gmail.com with ESMTPSA id z206sm3745314wmg.30.2020.06.16.05.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 05:28:52 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] x86: pmu: Test full-width counter writes
 support
To:     Thomas Huth <thuth@redhat.com>, Like Xu <like.xu@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529074347.124619-1-like.xu@linux.intel.com>
 <20200529074347.124619-4-like.xu@linux.intel.com>
 <b1a5472b-f7d0-82b0-e753-dabf81254488@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1272fbd7-3ff1-5eac-e9e2-78b824fbc4e0@redhat.com>
Date:   Tue, 16 Jun 2020 14:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b1a5472b-f7d0-82b0-e753-dabf81254488@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/20 12:49, Thomas Huth wrote:
> On 29/05/2020 09.43, Like Xu wrote:
>> When the full-width writes capability is set, use the alternative MSR
>> range to write larger sign counter values (up to GP counter width).
>>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>>  lib/x86/msr.h |   1 +
>>  x86/pmu.c     | 125 ++++++++++++++++++++++++++++++++++++++++----------
>>  2 files changed, 102 insertions(+), 24 deletions(-)
> [...]
>> @@ -452,6 +468,66 @@ static void check_running_counter_wrmsr(void)
>>  	report_prefix_pop();
>>  }
>>  
>> +static void check_counters(void)
>> +{
>> +	check_gp_counters();
>> +	check_fixed_counters();
>> +	check_rdpmc();
>> +	check_counters_many();
>> +	check_counter_overflow();
>> +	check_gp_counter_cmask();
>> +	check_running_counter_wrmsr();
>> +}
>> +
>> +static void do_unsupported_width_counter_write(void *index)
>> +{
>> +	wrmsr(MSR_IA32_PMC0 + *((int *) index), 0xffffff0123456789ull);
>> +}
>> +
>> +static void  check_gp_counters_write_width(void)
>> +{
>> +	u64 val_64 = 0xffffff0123456789ull;
>> +	u64 val_32 = val_64 & ((1ul << 32) - 1);
>  Hi,
> 
> this broke compilation on 32-bit hosts:
> 
>  https://travis-ci.com/github/huth/kvm-unit-tests/jobs/349654654#L710
> 
> Fix should be easy, I guess - either use 1ull or specify the mask
> 0xffffffff directly.

Or

u64 val_32 = (u64)(u32) val_64;

I'll send a patch.

Paolo

