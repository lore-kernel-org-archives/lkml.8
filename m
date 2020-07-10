Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8FF2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx7Qn635"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGJRkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:40:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbgGJRkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594402849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5YCjh7Ir73wQYt476RH2SlBQc/3pjz78qQVd8aGWVE=;
        b=Wx7Qn6351PkvmUaad78HjLbzOEod4rllaBWiRjO3ctsk+pqf1DngHiEw0vJRD3gmGz2UJZ
        xQ7PB4AjnehHNz4zuCPK+nUiqg08SI26l70oLO/j7GAUj64Wj4UFhmUceRMXrZa4y2IudF
        0gJWnsbnzuHBW+dhMz3jjxhbvgKTLNw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-27wpWHwiMfyYV7titEWuiA-1; Fri, 10 Jul 2020 13:40:48 -0400
X-MC-Unique: 27wpWHwiMfyYV7titEWuiA-1
Received: by mail-wr1-f71.google.com with SMTP id g14so6697108wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5YCjh7Ir73wQYt476RH2SlBQc/3pjz78qQVd8aGWVE=;
        b=ek06+Tk4k9xHti3NTAhCXyumOyK1ZKzzaazAfajQIp+GW+zUgOwdKcQHAw5JlPKZUB
         PHUkgoxU+Rex5JFe1MWQMkcjZATon2c/rpT1f//OD7aQZtGyIKaAriCgv8GjisELITcr
         Yzsvng9LDpx0Anl+/csrjT+MFlRU9tdSiC7u4MEsihbkc/vNMri0Q3sgBZepBK0GEwoX
         KfivEQa0FGW8+rs5MeP6wo9pQIDu4PrqvZxVkniRAS1SepSZkLd4F6WPoYWluc+lt0wX
         knGOfx10VkZwD6g/9JOUc1RQGf8EU+wLuCVaQkF7Y5Df07BjiIMrdTkFNc9Lazc03lTX
         kC+w==
X-Gm-Message-State: AOAM530jpSJ5TH2S13IIdJzZRJAqbql15XhWtT1VIIDHsP1Ts8GjHmPC
        8HlXMH8qvvHEv//D0WJSO57W/lOk4PAFy1cJ2IJFWlCwdWnQXnd2FGCiX9DxhLCG4mSjg8IpA75
        zynWvL1s8iWXjJ7ydS29/SYqn
X-Received: by 2002:adf:ec88:: with SMTP id z8mr68672305wrn.395.1594402846968;
        Fri, 10 Jul 2020 10:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAyJuA0aVT6OCO/QR9ECKytqX2ohs3nnhcAp0+m2w0tDW3u6NMegvOnDIlWBMqLatUMq+seQ==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr68672292wrn.395.1594402846714;
        Fri, 10 Jul 2020 10:40:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id d13sm10875974wrn.61.2020.07.10.10.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:40:46 -0700 (PDT)
Subject: Re: [PATCH v3 9/9] KVM: x86: SVM: VMX: Make GUEST_MAXPHYADDR <
 HOST_MAXPHYADDR support configurable
To:     Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Babu Moger <babu.moger@amd.com>
References: <20200710154811.418214-1-mgamal@redhat.com>
 <20200710154811.418214-10-mgamal@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c01fb991-8352-53be-3aab-8de808ead5ea@redhat.com>
Date:   Fri, 10 Jul 2020 19:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710154811.418214-10-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 17:48, Mohammed Gamal wrote:
> The reason behind including this patch is unexpected behaviour we see
> with NPT vmexit handling in AMD processor.
> 
> With previous patch ("KVM: SVM: Add guest physical address check in
> NPF/PF interception") we see the followning error multiple times in
> the 'access' test in kvm-unit-tests:
> 
>             test pte.p pte.36 pde.p: FAIL: pte 2000021 expected 2000001
>             Dump mapping: address: 0x123400000000
>             ------L4: 24c3027
>             ------L3: 24c4027
>             ------L2: 24c5021
>             ------L1: 1002000021
> 
> This shows that the PTE's accessed bit is apparently being set by
> the CPU hardware before the NPF vmexit. This completely handled by
> hardware and can not be fixed in software.
> 
> This patch introduces a workaround. We add a boolean variable:
> 'allow_smaller_maxphyaddr'
> Which is set individually by VMX and SVM init routines. On VMX it's
> always set to true, on SVM it's only set to true when NPT is not
> enabled.
> 
> We also add a new capability KVM_CAP_SMALLER_MAXPHYADDR which
> allows userspace to query if the underlying architecture would
> support GUEST_MAXPHYADDR < HOST_MAXPHYADDR and hence act accordingly
> (e.g. qemu can decide if it would ignore the -cpu ..,phys-bits=X)
> 
> CC: Tom Lendacky <thomas.lendacky@amd.com>
> CC: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

Slightly rewritten commit message:

    KVM: x86: Add a capability for GUEST_MAXPHYADDR < HOST_MAXPHYADDR support
    
    This patch adds a new capability KVM_CAP_SMALLER_MAXPHYADDR which
    allows userspace to query if the underlying architecture would
    support GUEST_MAXPHYADDR < HOST_MAXPHYADDR and hence act accordingly
    (e.g. qemu can decide if it should warn for -cpu ..,phys-bits=X)
    
    The complications in this patch are due to unexpected (but documented)
    behaviour we see with NPF vmexit handling in AMD processor.  If
    SVM is modified to add guest physical address checks in the NPF
    and guest #PF paths, we see the followning error multiple times in
    the 'access' test in kvm-unit-tests:
    
                test pte.p pte.36 pde.p: FAIL: pte 2000021 expected 2000001
                Dump mapping: address: 0x123400000000
                ------L4: 24c3027
                ------L3: 24c4027
                ------L2: 24c5021
                ------L1: 1002000021
    
    This is because the PTE's accessed bit is set by the CPU hardware before
    the NPF vmexit. This is handled completely by hardware and cannot be fixed
    in software.
    
    Therefore, availability of the new capability depends on a boolean variable
    allow_smaller_maxphyaddr which is set individually by VMX and SVM init
    routines. On VMX it's always set to true, on SVM it's only set to true
    when NPT is not enabled.
    
    CC: Tom Lendacky <thomas.lendacky@amd.com>
    CC: Babu Moger <babu.moger@amd.com>
    Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
    Message-Id: <20200710154811.418214-10-mgamal@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

