Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3470C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DFB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvrUpy24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAWNy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:54:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58304 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgAWNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579787695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQ3Ow20PKV371NO5YgbOYBtfdI39/lSB5zP8TflCC5o=;
        b=QvrUpy24Qc8a/OWpxeQACBkXiQ7desWxfpsaxUanas0qskoLsB4IcH6OeW4y6b+fLWy9Xe
        Qr6mf9U0Z0gbbvbBbkKh3MbiS0xpr4f7Vav6bpsBaXWwD4ALMhul858nfhnk6DXbDuHwOD
        JljxnLvfI58DgkhVp6CQwaw8OybE2n8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-BTMON0v8NaGye7MRsokz_w-1; Thu, 23 Jan 2020 08:54:53 -0500
X-MC-Unique: BTMON0v8NaGye7MRsokz_w-1
Received: by mail-wr1-f69.google.com with SMTP id f10so1766081wro.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQ3Ow20PKV371NO5YgbOYBtfdI39/lSB5zP8TflCC5o=;
        b=d1Ottx2kAfGNloZgqIwR4H1VmoqPoBnZGuJrQG++m98eIRWyXwGq1xOi2PyN/sRUDs
         8BZu5n2P360reNsy4NFAKsCKFquS6ZP2ZAYMv1DW+Pw1EJvzccy89pZUk4iKvcpayCxv
         wsrLlsADNDJhOBxhQPn0m9lYIXkOwJVtGZ5ONgwBzDObO9OaafAyVH37/SWbSJCan05y
         ISYlHnhSsA2rh62yTxoBHXyb7VA7ZonwmkvSqN8pEzaXL4NBs+XtpDvw8wgME/Tf/z2W
         WrS2UrarEecZciuAVjUd7cUvU/Uc8nYs9yGX1Gg+J2DCO2YFBnxwtHzNRH/ENA/cgkIX
         Goqg==
X-Gm-Message-State: APjAAAVfU6dqQjvAZIw0+1jF7JmKcqRd4DIpr0r4hm8swpIaCOqGszk5
        aVhrP9mLh6jm/8q1A3f3ktzSGtX1z2673aCigz8UZ5JvEwGMX39QjCCNiuuhNpLQH+3vI8fq1vf
        B7uJfl8f/hXJe0oucjSVbnKRb
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr4402298wmm.143.1579787691645;
        Thu, 23 Jan 2020 05:54:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKDd2Y0rsZeFLVbKo5pHH20OQcIqSfL1QyTrAtoWCMveHeMEIT2dWY+aPKw92HxHMLD6QraQ==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr4402279wmm.143.1579787691407;
        Thu, 23 Jan 2020 05:54:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id k8sm3102469wrl.3.2020.01.23.05.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:54:50 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: x86: use raw clock values consistently
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     mtosatti@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1579702953-24184-1-git-send-email-pbonzini@redhat.com>
 <1579702953-24184-3-git-send-email-pbonzini@redhat.com>
 <87r1zqqode.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed5b7a36-b9a0-5436-c704-58c65966b7c2@redhat.com>
Date:   Thu, 23 Jan 2020 14:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87r1zqqode.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 14:43, Vitaly Kuznetsov wrote:
>> +
>> +static s64 get_kvmclock_base_ns(void)
>> +{
>> +	/* Count up from boot time, but with the frequency of the raw clock.  */
>> +	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
>> +}
>> +#else
>> +static s64 get_kvmclock_base_ns(void)
>> +{
>> +	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
>> +	return ktime_get_boottime_ns();
>> +}
>>  #endif
> But we could've still used the RAW+offs_boot version, right? And this is
> just to basically preserve the existing behavior on !x86.

Yes, there's no reason to restrict the pvclock_gtod notifier to x86_64.
 But this is stable material so I kept it easy.

>>
>> -	getboottime64(&boot);
>> +	wall_nsec = ktime_get_real_ns() - get_kvmclock_ns(kvm);
> 
> There are not that many hosts with more than 50 years uptime and likely
> none running Linux with live kernel patching support so I bet noone will
> ever see this overflowing, however, as wall_nsec is u64 and we're
> dealing with kvmclock here I'd suggest to add a WARN_ON().

You're off by a factor of 10, 2^64 nanoseconds are about 584 years
(584*365*10^9*86400). :)

Paolo

