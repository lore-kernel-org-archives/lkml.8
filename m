Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD717C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9F120776
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj0KjKiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbgFWKYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:24:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34395 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732155AbgFWKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592907884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0VMF+zOglKc79uK7nAPfjf+HV37t2ditCPtYi6hRnc=;
        b=fj0KjKiBRki4CRZ/41MI8NTE6klsTXqaJpu37yuRSd1wPUBqjVGdhMP8gk5cUhDLe1bMEf
        KyROxz8NyF1OMl07ij2V/gNihYJtyGFON2qreiiheOvHrVE+H1RfdX8MawFyMKPqlPA9NU
        sVlVEi4xWk6GGzeBhswX0Qb5KTuXpbc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-6vG4NisDPaaWD2t1OOml6Q-1; Tue, 23 Jun 2020 06:24:42 -0400
X-MC-Unique: 6vG4NisDPaaWD2t1OOml6Q-1
Received: by mail-wm1-f72.google.com with SMTP id l2so3340658wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0VMF+zOglKc79uK7nAPfjf+HV37t2ditCPtYi6hRnc=;
        b=CcaRv4eM1oQKq+6i1OQuBuRrf8CeVcsofB5b1Z+dGGsKMEsHp6MOEa8+U57CKNsqUR
         GKKSyYbigB2v+0dqZgFs1i41tOkLOhKxUTDiBOmeiVbs1sUCaydSt+EJX7pp4OXfFuSP
         4LpOtYfokDEJpXHITSO6in4fiH3AKhdcCpX5Gir4mNYDKdFEgFlbHtrc7PVDUsoj7XFS
         4+YP65YDHRqwx7Z1SoqBhk3zDyDAZ6X2Yd6T2PixqdJMWvAbRNp3mbgT/rJlzI+I41kq
         KsRngqVSzY38yCerCIy7Ko66Fxo3weYvGyiIy8jsuRj22ydhMgggV7FvX8M4+RO5fVPN
         MugQ==
X-Gm-Message-State: AOAM533/R/zKtgj5zU8zo/IT3H6H35ipBfOEJXj2+eFfBo5pBZYsUXnK
        GSUwibzytzvVXVpakfJqRqetHtXcsHExhwdIvrQAl2QGXvEze3ss/3CCX16kh8i0X8Gm6Vydayc
        dBHRzKJ/+XbucvMEQHtmDJz8K
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr16454598wrx.294.1592907881356;
        Tue, 23 Jun 2020 03:24:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7GKxnJWV0b4Mz/7lWJjdPl3+rZwUgIO80Ac5HDjj13PmRVjDey+yK0l49hJjTmncjlmTnYw==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr16454534wrx.294.1592907881013;
        Tue, 23 Jun 2020 03:24:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id c66sm3351206wma.20.2020.06.23.03.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:24:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] clean up redundant 'kvm_run' parameters
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com,
        chenhuacai@gmail.com
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <fe463233-d094-fca5-b4e9-c1d97124fd69@redhat.com>
 <3a2bee8b-20b4-5d33-7d12-09c374a5afde@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bad08799-274e-0a6f-9638-92c0010b1ba1@redhat.com>
Date:   Tue, 23 Jun 2020 12:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3a2bee8b-20b4-5d33-7d12-09c374a5afde@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/20 12:00, Tianjia Zhang wrote:
> 
> 
> On 2020/6/23 17:42, Paolo Bonzini wrote:
>> On 27/04/20 06:35, Tianjia Zhang wrote:
>>> In the current kvm version, 'kvm_run' has been included in the
>>> 'kvm_vcpu'
>>> structure. For historical reasons, many kvm-related function parameters
>>> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
>>> patch does a unified cleanup of these remaining redundant parameters.
>>>
>>> This series of patches has completely cleaned the architecture of
>>> arm64, mips, ppc, and s390 (no such redundant code on x86). Due to
>>> the large number of modified codes, a separate patch is made for each
>>> platform. On the ppc platform, there is also a redundant structure
>>> pointer of 'kvm_run' in 'vcpu_arch', which has also been cleaned
>>> separately.
>>
>> Tianjia, can you please refresh the patches so that each architecture
>> maintainer can pick them up?  Thanks very much for this work!
>>
>> Paolo
>>
> 
> No problem, this is what I should do.
> After I update, do I submit separately for each architecture or submit
> them together in a patchset?

You can send them together.

Paolo

