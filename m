Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E9E206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcnGrycJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGIRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:17:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45373 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725825AbgGGIRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594109839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kxw8jGSvoStBvcs9wwLMwSg4FTlFK/RnZoowv393PM=;
        b=BcnGrycJRbw+4AsftoQcs3DeAia8HdvNIFmnTtSLDbls1CUMrV9b7F5pU+PNEgXLbTwhMt
        /bLffY09oU7cB8aupX4MYyIXBkx4VwY7SI/fdjzW21qMsySHVBKmsr7RnTNIl7yHRiekkb
        8PUm53/Gbqw6/KKw7RHGBuZWfP2r1Cs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-CIRxmmJHPbKixR5GW39XJw-1; Tue, 07 Jul 2020 04:17:17 -0400
X-MC-Unique: CIRxmmJHPbKixR5GW39XJw-1
Received: by mail-wm1-f72.google.com with SMTP id e15so51720041wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2kxw8jGSvoStBvcs9wwLMwSg4FTlFK/RnZoowv393PM=;
        b=FifwTn7NSid7R8D6FDYC7iY3/yHrtkkPaW3iNKrAEgqE0sYtDWoRDFgcIH8C3XD4jw
         ytDfV0GhtzsjJRMC6nSSz0VfqltLb2GRgnlEqbvdC1Cxos/3LdzSfXrfqn5uOGYFpAmN
         f+iBRcIwMklTStDN7AhqOLvj9tSSj/dbKOq0duu7B5xy8g2c0d8h2HsmwVssjPgZM1iQ
         jPp8Dtlg3LXWcDChEBKBLayCGLSe+rie73/+wGEXPKKTNnfylfcKITCsNUIKS8wljOqL
         T+W0EauegB3170Qvnu5XMRDBpqY3Gn6FzGCX/3K5IyRjbHahyjuw114V+pqrfLQ78JQk
         sDsA==
X-Gm-Message-State: AOAM530PQWWV2jhBsWjS2Xqc5z9HzjZu8ZRGRiLhZLai38l8RjliJfw1
        lfB7uFdsTcsIpTW6GNfz8zk4kU0tKmFr9sh+zk8Uu5jO5yoegWKhXnFReuHyDajEeO3KPD/QzCl
        pKjkFgQ1YP9hXMN//miBzs0/g
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr55317230wrr.296.1594109836840;
        Tue, 07 Jul 2020 01:17:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRRgsZcT5qn/1NYBhutG36Ov7sfbQPzmiPv2vi5AaTnoUJjAOQ7wg/jDiQ45EN3SXy2rIVeQ==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr55317207wrr.296.1594109836609;
        Tue, 07 Jul 2020 01:17:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46? ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
        by smtp.gmail.com with ESMTPSA id v3sm27637294wrq.57.2020.07.07.01.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:17:16 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: rewrite kvm_spec_ctrl_valid_bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>
References: <20200702174455.282252-1-mlevitsk@redhat.com>
 <20200702181606.GF3575@linux.intel.com>
 <3793ae0da76fe00036ed0205b5ad8f1653f58ef2.camel@redhat.com>
 <20200707061105.GH5208@linux.intel.com>
 <7c1d9bbe-5f59-5b86-01e9-43c929b24218@redhat.com>
 <20200707081444.GA7417@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5da32da-6cb2-85b1-a12b-da796843d2bb@redhat.com>
Date:   Tue, 7 Jul 2020 10:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707081444.GA7417@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/20 10:14, Sean Christopherson wrote:
>>> One oddity with this whole thing is that by passing through the MSR, KVM is
>>> allowing the guest to write bits it doesn't know about, which is definitely
>>> not normal.  It also means the guest could write bits that the host VMM
>>> can't.
>> That's true.  However, the main purpose of the kvm_spec_ctrl_valid_bits
>> check is to ensure that host-initiated writes are valid; this way, you
>> don't get a #GP on the next vmentry's WRMSR to MSR_IA32_SPEC_CTRL.
>> Checking the guest CPUID bit is not even necessary.
> Right, what I'm saying is that rather than try and decipher specs to
> determine what bits are supported, just throw the value at hardware and
> go from there.  That's effectively what we end up doing for the guest writes
> anyways.

Yes, it would prevent the #GP.

> Actually, the current behavior will break migration if there are ever legal
> bits that KVM doesn't recognize, e.g. guest writes a value that KVM doesn't
> allow and then migration fails when the destination tries to stuff the value
> into KVM.

Yes, unfortunately migration would also be broken if the target (and the
guest CPUID) is an older CPU.  But that's not something we can fix
without trapping all writes which would be unacceptably slow.

Paolo

