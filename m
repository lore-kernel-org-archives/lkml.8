Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51994C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3020675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbHD4O4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLLiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:38:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727007AbgBLLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1R9MDslW/r3AzZWZ503wB4G8/M2cmEynec0RayrkLsE=;
        b=cbHD4O4ixXwkgiRVXIiVGQG/WwVr1Lgfq1zSQDKc2mPE5KFwkE3taj/DKQlWP1U0BUTWW0
        yE4ZILyELRId1c6Xg99r6HQFntpY8DH+ZWSPSIJOaFXVVjNH50Q91o7dOU9ASQJTjdMaDL
        PWvYADYzJ9oKjS2EdyoacUuSYBir8rM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-CqZQ10O6MZ6nnXd6pMWQuQ-1; Wed, 12 Feb 2020 06:38:47 -0500
X-MC-Unique: CqZQ10O6MZ6nnXd6pMWQuQ-1
Received: by mail-wr1-f72.google.com with SMTP id 90so704805wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1R9MDslW/r3AzZWZ503wB4G8/M2cmEynec0RayrkLsE=;
        b=Ksl5pryvCkCVtRjjkxrhlh1zR4t1pdnDZchhpmAd4cHC/wRaWuw/I3McgmOlzJ2A0s
         s05BZbdnERHn7t0Zyc8oXLkComGU6Xor4EZQwBuEm5ZYG4t/rKqHmH3Mn4ASKfV1hxdX
         ewvkEqsUtMc5+PSr4HymaA4pDAhNBEdc48Rs3q4N89wp+NZz5DSwnVfg73ezT1ZGWOWM
         ZYFcpBozwyBFUGLB9KyoFpsRfDrsciF0vdfPZna/ufoOQJLBkRrlYdKt8YBH+v/NYn2k
         QVh3r1X2fyh7RL7yo4/VQYZ211FhEJPXxiRdEmLUZ0pyuWZde/jIgGs2ga40Q1vtJ+TA
         n/+Q==
X-Gm-Message-State: APjAAAUgcBNSgM5obCzjP+zEIpQUp/mnHEy6btaOxkpDsdLJjq4bBu+C
        Xkgq79pZmCIaBJGWqT5Xm+Hhf/D84TRNYF1pQCs+n3FHEjMMUhCJKNf5gLhEhXgupIyl5508m2g
        olhnJVEsMv1128IbTiOSbSfrs
X-Received: by 2002:a5d:6445:: with SMTP id d5mr14710579wrw.244.1581507526677;
        Wed, 12 Feb 2020 03:38:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiyKNAHEirMBzSFoYbFCwdySkFn3k/DgKaESjlbORlcaN0YvvNgu9bN+TL2Mg3ChyNa0sqLA==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr14710563wrw.244.1581507526405;
        Wed, 12 Feb 2020 03:38:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id h205sm391938wmf.25.2020.02.12.03.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:38:45 -0800 (PST)
Subject: Re: [PATCH v4 2/3] selftests: KVM: AMD Nested test infrastructure
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com
References: <20200206104710.16077-1-eric.auger@redhat.com>
 <20200206104710.16077-3-eric.auger@redhat.com>
 <92106709-10ff-44d3-1fe8-2c77c010913f@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0df83591-880f-df40-d160-fc847dcdf301@redhat.com>
Date:   Wed, 12 Feb 2020 12:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <92106709-10ff-44d3-1fe8-2c77c010913f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/20 23:57, Krish Sadhukhan wrote:
>>
>> +
>> +void nested_svm_check_supported(void)
>> +{
>> +    struct kvm_cpuid_entry2 *entry =
>> +        kvm_get_supported_cpuid_entry(0x80000001);
>> +
>> +    if (!(entry->ecx & CPUID_SVM)) {
>> +        fprintf(stderr, "nested SVM not enabled, skipping test\n");
> I think a better message would be:
> 
>     "nested SVM not supported on this CPU, skipping test\n"
> 
> Also, the function should ideally return a boolean and let the callers
> print whatever they want.

It would be "not supported by KVM", which is equivalent to "not enabled"
for all purposes.

Thanks,

Paolo

