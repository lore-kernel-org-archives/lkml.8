Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E96C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8252B2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBKJWuOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEGQVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:21:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588868482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uauPqEKc6UVzX7GhKV0bkB/W3wZHCC/w2jsufvTYHDk=;
        b=eBKJWuOK8Lcc6NfVGfoTLO2MzCB4f2Gve3zOot4T1YCioC0E0rb/yMKKR1+e9oyFECqmyo
        /TIlhY0B0mpZKL+VNwTeEr+dV+bx0eBA/p06EeQCD7gIKSF9uNjz68ycU7XYiNqm7i3aPm
        RpYj3BkAU8RXKtPnpsiyt406Wki8I+8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-BebdZDdNMumaZoY-14cLeg-1; Thu, 07 May 2020 12:21:21 -0400
X-MC-Unique: BebdZDdNMumaZoY-14cLeg-1
Received: by mail-wm1-f70.google.com with SMTP id n17so2803657wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uauPqEKc6UVzX7GhKV0bkB/W3wZHCC/w2jsufvTYHDk=;
        b=sF0+LDbWQr+j0giOMvM5ocsGV0KUZVgH5OdELTQ+WYQv5mG0Jpul3P04puSTvq6VGB
         FfXZvqRxxLCb0AmYFsXJEVRk30mYpYdiim4BvSC7SicaTBW8GYB5zK6bNR4R13ZC18jJ
         AmBiFxJb7K+twmoJWsHvpzpb9QsMQujFfPkLwxbL0w4srWDBxuosbsJFLzZ50pzfHHea
         FNFvUPQjWMriJ6uhJ8FuPS7xgZmGVYXFbd4mdrsOgBY0Yf6LiY0viM37xn6GY12hcey2
         ZreRD1jwNAS1Bf/mw5nRlvvc+z+XCA/2UDNZoSLwWRKXxDQCbli1aEowXDvjG+I4D+Ep
         zhwg==
X-Gm-Message-State: AGi0PubYzQa2lG9aLn0CrEiLaFRe8Z6priBfZIkIFFCkQUJNkVKWzaMj
        FGK3SropaGO/a3GzRfugehXkx6ckMR2Up+uJhy0/h4hQppLMVA2PAuz/rtVMBmYEemlS+CSoEpK
        cIIwfdkWFeP0E1qUaNRbohlJL
X-Received: by 2002:adf:e812:: with SMTP id o18mr17170880wrm.185.1588868479597;
        Thu, 07 May 2020 09:21:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlD2aWgLcfJmYsanf2JcFh67EG6I64TLsOvj8abuHuKjLOq+W3EmBYLtX1ngf3pRXS6ERGig==
X-Received: by 2002:adf:e812:: with SMTP id o18mr17170857wrm.185.1588868479332;
        Thu, 07 May 2020 09:21:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id l1sm9215989wrc.24.2020.05.07.09.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 09:21:18 -0700 (PDT)
Subject: Re: [PATCH 9/9] KVM: VMX: pass correct DR6 for GD userspace exit
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-10-pbonzini@redhat.com>
 <20200507161854.GF228260@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7abe5f7b-2b5a-4e32-34e2-f37d0afef00a@redhat.com>
Date:   Thu, 7 May 2020 18:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507161854.GF228260@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 18:18, Peter Xu wrote:
>>  		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
>> -			vcpu->run->debug.arch.dr6 = vcpu->arch.dr6;
>> +			vcpu->run->debug.arch.dr6 = DR6_BD | DR6_RTM | DR6_FIXED_1;
> After a second thought I'm thinking whether it would be okay to have BS set in
> that test case.  I just remembered there's a test case in the kvm-unit-test
> that checks explicitly against BS leftover as long as dr6 is not cleared
> explicitly by the guest code, while the spec seems to have no explicit
> description on this case.

Yes, I noticed that test as well.  But I don't like having different
behavior for Intel and AMD, and the Intel behavior is more sensible.
Also...

> Intead of above, I'm thinking whether we should allow the userspace to also
> change dr6 with the KVM_SET_GUEST_DEBUG ioctl when they wanted to (right now
> iiuc dr6 from userspace is completely ignored), instead of offering a fake dr6.
> Or to make it simple, maybe we can just check BD bit only?

... I'm afraid that this would be a backwards-incompatible change, and
it would require changes in userspace.  If you look at v2, emulating the
Intel behavior in AMD turns out to be self-contained and relatively
elegant (will be better when we finish cleaning up nested SVM).

Paolo

