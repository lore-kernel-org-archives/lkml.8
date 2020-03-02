Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C4C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FDB24699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrCICCWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCBIj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:39:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44278 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726887AbgCBIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583138367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In6B5Nqay6OjSYXjdC6WBXSSPvDHOlAmJirTMaGmDew=;
        b=IrCICCWHWoW+OoRAj9ehBwvedpC9Mn2D1w2R514EZ9FfKB7Ekw1nU8olL0Vs406NSKyyKw
        EoN2HsVT9+Jc6sKhrvq7lsoywQrh86r/dVav41cbfrdaZTUwgoqEMGah8OxYEplcv3SDRX
        o8n5UEz5lMoFwMqZO7t5+mxJS3BXcUM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-E063r6AHO1yal838BUmHJA-1; Mon, 02 Mar 2020 03:39:23 -0500
X-MC-Unique: E063r6AHO1yal838BUmHJA-1
Received: by mail-wm1-f70.google.com with SMTP id g78so352010wme.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=In6B5Nqay6OjSYXjdC6WBXSSPvDHOlAmJirTMaGmDew=;
        b=a1R6oGN/ToM+Y6qQFCPHR8fgVbUMMADn6Q00V+ayjfOY1j4qTIH8z7Ht1xFlxvXRsY
         ot+qBH7lfgvtiCJRnhyl7UXTExkiGM6MMOI8kwXWzr2HjhZBmNDP2LJPFoTyc3xt1Ek+
         TyK3xsFKcLCsaBAS+IGbTZ99q7beaIAMgIGUum29VfDlojyzTKW6UxayxXnYc4p8GGF5
         MJfGaZSqttMkrtTjw0mp9gTkfotH2ACpJ3tF4dmkzhfL4T1xYDf+TAC9fWdcSxX3fFYX
         qOtKFl7Z/YQ9z4HwalfxdxFoxSl7mrEwFjjRu1+eeHWI8gmQCLIve58kDsZDZj1xkl7h
         1uWA==
X-Gm-Message-State: APjAAAVNOfayb1TZTdzgaau8+cp5VbjuBJPY7VU2oADinJyW+qvAMp3B
        +X5G3TeJuSwmnKcP82jQRMN3MLSWUkpy5JZZvdOFWSdE31OC+9q4VE9Ugyfiz+Z92ZgdiypEdv5
        C7p4qNrUyXyGa4VcLlkDhknHu
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr19197776wmp.140.1583138362691;
        Mon, 02 Mar 2020 00:39:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHCi5FmYsYSJxxm8KEIjI1zi72JmZ0Mwdaa2HdULA6dydXqlr9ZV3N/74rR/Xnlui4XCw8sQ==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr19197754wmp.140.1583138362459;
        Mon, 02 Mar 2020 00:39:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e1d9:d940:4798:2d81? ([2001:b07:6468:f312:e1d9:d940:4798:2d81])
        by smtp.gmail.com with ESMTPSA id w19sm13954120wmc.22.2020.03.02.00.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 00:39:21 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Fix dereference null cpufreq policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1583133336-7832-1-git-send-email-wanpengli@tencent.com>
 <ab51f6c9-a67d-0107-772a-7fe57a2319cf@redhat.com>
 <20200302081207.3kogqwxbkujqgc7z@vireshk-i7>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73a7db77-c4c7-029f-fd8a-080911fde41e@redhat.com>
Date:   Mon, 2 Mar 2020 09:39:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302081207.3kogqwxbkujqgc7z@vireshk-i7>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 09:12, Viresh Kumar wrote:
> On 02-03-20, 08:55, Paolo Bonzini wrote:
>> On 02/03/20 08:15, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> cpufreq policy which is get by cpufreq_cpu_get() can be NULL if it is failure,
>>> this patch takes care of it.
>>>
>>> Fixes: aaec7c03de (KVM: x86: avoid useless copy of cpufreq policy)
>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>
>> My bad, I checked kobject_put but didn't check that kobj is first in
>> struct cpufreq_policy.
>>
>> I think we should do this in cpufreq_cpu_put or, even better, move the
>> kobject struct first in struct cpufreq_policy.  Rafael, Viresh, any
>> objection?
>>
>> Paolo
>>
>>>  		policy = cpufreq_cpu_get(cpu);
>>> -		if (policy && policy->cpuinfo.max_freq)
>>> -			max_tsc_khz = policy->cpuinfo.max_freq;
>>> +		if (policy) {
>>> +			if (policy->cpuinfo.max_freq)
>>> +				max_tsc_khz = policy->cpuinfo.max_freq;
>>> +			cpufreq_cpu_put(policy);
>>> +		}
> 
> I think this change makes sense and I am not sure why should we even
> try to support cpufreq_cpu_put(NULL).

For the same reason why we support kfree(NULL) and kobject_put(NULL)?

Paolo

