Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638DCC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357BF20726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag+Dc9lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgBYPA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:00:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730317AbgBYPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H8npfbWdmh4zPKaCHNXPRWoIVLSdCPbN2mOYmIHU80=;
        b=ag+Dc9lWa5jqA98xML7nMRVO0nFu1J3QP7ohcwcixv4G3LrCefKTRaSnpLRAV7GtPThexO
        JcANKJ07/vaXMwkuUn2PgUN2PgptVEPVie2JL9f+jUvVxMMY8vidw81qrecur01agoWpYI
        NsQysMejkTdFgpbF374miWa2Oar6a0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-A8cgKknuP4mcDktJnIFjXQ-1; Tue, 25 Feb 2020 10:00:52 -0500
X-MC-Unique: A8cgKknuP4mcDktJnIFjXQ-1
Received: by mail-wr1-f71.google.com with SMTP id p8so7429169wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3H8npfbWdmh4zPKaCHNXPRWoIVLSdCPbN2mOYmIHU80=;
        b=l3xtUGucpornYJ8Bh6Vvy4OoeJPsZNqUQfItkqeb3DdtL+S9xf20w/BIcBLFXxX5Z6
         gwAyxEWrt9R7Y/J4iEl+vK4dcQy3wEksr7rYxy5b1u+zDANWbmmklk9fgMliFzs4NTdv
         n26RQm4Hc6URjqdfMvCwaKnwzNehicnc9UB8daYcs5G0323SpCtzTy0XO7JNEZHeccd/
         A4t+j19qRksPnq1gWTwjIFIeLbGhaEAUfd5DSSUAcHMB3lpaQE4hyJknZsxQSfa6n3eE
         1hMID0XO7RvaS4OJXCH/dnuG4CJ/dnWnyhIACFErkyD9XCRpcvnRviqUW9KmPrcfuAiF
         t7Qg==
X-Gm-Message-State: APjAAAUzZeOQ+pDeXDYUUyxFYeVwCMoUlDEJamUsAV6LexE0Grj1C7up
        AX5o/ijgy5bgfI0rYwm8+mYrfAC0GQgIESYLT0lnZL4TzM67JzcmqgQxoKAfFkZRHRmiZTasLZA
        lWy8Cx6jCaQ1BZoJswNXRdRk+
X-Received: by 2002:adf:f986:: with SMTP id f6mr76268255wrr.182.1582642851018;
        Tue, 25 Feb 2020 07:00:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBzTy7Urhf32MJINJ0M8dRKWGI5MgfBTVJZ1Mh+1hF+3v/CspRn3IbJXFjwdREllDRoZmRNA==
X-Received: by 2002:adf:f986:: with SMTP id f6mr76268230wrr.182.1582642850775;
        Tue, 25 Feb 2020 07:00:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id c74sm4663111wmd.26.2020.02.25.07.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:00:50 -0800 (PST)
Subject: Re: [PATCH 29/61] KVM: x86: Add Kconfig-controlled auditing of
 reverse CPUID lookups
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-30-sean.j.christopherson@intel.com>
 <87a758oztt.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1875741b-402d-d113-86ff-48adbf782727@redhat.com>
Date:   Tue, 25 Feb 2020 16:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87a758oztt.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/20 14:54, Vitaly Kuznetsov wrote:
>> --- a/arch/x86/kvm/cpuid.h
>> +++ b/arch/x86/kvm/cpuid.h
>> @@ -98,6 +98,11 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
>>  static __always_inline u32 *__cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry,
>>  						  const struct cpuid_reg *cpuid)
>>  {
>> +#ifdef CONFIG_KVM_CPUID_AUDIT
>> +	WARN_ON_ONCE(entry->function != cpuid->function);
>> +	WARN_ON_ONCE(entry->index != cpuid->index);
>> +#endif
>> +
>>  	switch (cpuid->reg) {
>>  	case CPUID_EAX:
>>  		return &entry->eax;
> Honestly, I was thinking we should BUG_ON() and even in production builds
> but not everyone around is so rebellious I guess, so

BUG_ON is too much, but I agree the cost is so small that unconditional
WARN_ON makes sense.

Paolo

