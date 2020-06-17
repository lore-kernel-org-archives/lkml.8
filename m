Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F35A21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlflOshl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgFQRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:17:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726511AbgFQRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592414271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syoG//epP3bFi8zAl2b0mjdOvXOrZ7ZffbKVm7T0ZmA=;
        b=HlflOshlo52J6ZhvX5Ck+yggWTJzKaAGY/BNndxwnCmnrTo4Y8d2H2F0Y/zy1bSwEE0gfT
        TqP5pPbC2o4VhljDjhBiI3YTjRL2RE3P4kSenYlNR3TWUaKpjKGJCaaA9Lol5jRw1sJi3m
        dV8gc/OGvYJY3TrnAEQwyOrr2BwKEgM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-LQZ-XmOuMq6KQxphfDbC4Q-1; Wed, 17 Jun 2020 13:17:48 -0400
X-MC-Unique: LQZ-XmOuMq6KQxphfDbC4Q-1
Received: by mail-wm1-f71.google.com with SMTP id r1so1502891wmh.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=syoG//epP3bFi8zAl2b0mjdOvXOrZ7ZffbKVm7T0ZmA=;
        b=famyAfVVZnuUqtva0EZ/9C0jUAIMX/n7FGz/hsgKQ0V0vr/t/D6ZdfVaH5/bXov0vK
         DO8anvuml5jJsNKSqz112zdjmyHAZ73S0z4Smj7Fqj+Cxm/L2R6+etbL3ahT0AfnjxXe
         GLHksfTdzsD8fePobNgSR6ZSP1JZa6dNFvIb+WkWwkiTxYyJNiJ9Ifemb0dpVZmZJHaM
         +iUDlUrVBWXnQyv5Q+G1g+QwEZI0PL0jmopYFrQttLanJOMpqjujGBNQyUWXBSQRDwmr
         anYZM9F8j5dn7WUbAX/aBqjnvZrjYF0VrOCFQFSvLdQE0wQoL5pK+O1DN8t1ppPs6qaL
         MZMA==
X-Gm-Message-State: AOAM532dn2R8bXDaOitu4Pwo7PjoEZ+2/ZAvy5Gx3Up0THhG4lizAHGC
        KUmUU14s+MI2xWYXk/51ZkvfJ9NBmI0LcPNx5BZKl24bmAsi2sTs7DSLZeAmwKIQV2lcPT74wpC
        y3z/ETXQRcOgGt12/Fa3ZxVTr
X-Received: by 2002:a1c:e40a:: with SMTP id b10mr9258262wmh.41.1592414266555;
        Wed, 17 Jun 2020 10:17:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLVxP68bp+s83lap0HNMsWZSZhomS98RZJPhW0GgtvOxsW+p3Qva87d7QFsCgkfzvuBpUIIw==
X-Received: by 2002:a1c:e40a:: with SMTP id b10mr9258238wmh.41.1592414266343;
        Wed, 17 Jun 2020 10:17:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:48a4:82f8:2ffd:ec67? ([2001:b07:6468:f312:48a4:82f8:2ffd:ec67])
        by smtp.gmail.com with ESMTPSA id 23sm464714wmg.10.2020.06.17.10.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 10:17:45 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated
 MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200616161427.375651-1-vkuznets@redhat.com>
 <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
 <87366vhscx.fsf@vitty.brq.redhat.com>
 <CALMp9eQ1qe4w5FojzgsUHKpD=zXqen_D6bBg4-vfHa03BdomGA@mail.gmail.com>
 <87wo45hqhy.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36ebc576-52c0-4164-1c83-e31146806b6b@redhat.com>
Date:   Wed, 17 Jun 2020 19:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87wo45hqhy.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/20 13:38, Vitaly Kuznetsov wrote:
> 
> For KVM_GET_MSR_INDEX_LIST, the promise is "guest msrs that are
> supported" and I'm not exactly sure what this means. Personally, I see
> no point in returning MSRs which can't be read with KVM_GET_MSRS (as
> this also means the guest can't read them) and KVM selftests seem to
> rely on that (vcpu_save_state()) but this is not a documented feature.

Yes, this is intended.  KVM_GET_MSR_INDEX_LIST is not the full list of
supported MSRs or KVM_GET_MSRS (especially PMU MSRs are missing) but it
certainly should be a sufficient condition for KVM_GET_MSRS support.

In this case your patch is sort-of correct because AMD machines won't
have X86_FEATURE_PDCM.  However, even in that case there are two things
we can do that are better:

1) force-set X86_FEATURE_PDCM in vmx_set_cpu_caps instead of having it
in kvm_set_cpu_caps.  The latter is incorrect because if AMD for
whatever reason added it we'd lack the support.  This would be basically
a refined version of your patch.

2) emulate the MSR on AMD too (returning zero) if somebody for whatever
reason enables PDCM in there too: this would include returning it in
KVM_GET_FEATURE_MSR_INDEX_LIST, and using kvm_get_msr_feature to set a
default value in kvm_pmu_refresh.  The feature bit then would be
force-set in kvm_set_cpu_caps.  This would be nicer since we have the
value in vcpu->arch already instead of struct vcpu_vmx.

Thanks,

Paolo

