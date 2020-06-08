Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0220774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWZRVtYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFHNNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:13:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44557 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729130AbgFHNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591621999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE4uxEFzisXgU373/MFQA+2UMs2/qJwN6z64o4N5Dt4=;
        b=WWZRVtYpu9ySuOKBqXCV/LROPoHRC8m6l4DyYCK2fmx+5w0HeE0J4CjbdJz/ZDPT+V6GLW
        fQ0hmdp9BLq9NbOF1zxRm8ilw/jbxMcuHAXu/8VKT9SwggcX0LlsHpl5JbMAQieXnciRyO
        A9qJO3iw39Q/R4UZi440JNXfZfd72bI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-4bvbmqNUMOGyBy3NnguoGQ-1; Mon, 08 Jun 2020 09:13:13 -0400
X-MC-Unique: 4bvbmqNUMOGyBy3NnguoGQ-1
Received: by mail-wr1-f71.google.com with SMTP id j16so7087294wre.22
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 06:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aE4uxEFzisXgU373/MFQA+2UMs2/qJwN6z64o4N5Dt4=;
        b=Kqf94LswCZSyVN2hpf0ZuTzuVqTov2TlA9jccL/KgbRNVbxr6NiW2Z+b0brhy/BOXk
         pL2+zqZ6yLogMihD7hYwFur7YF9dAoVpk26YIhcv0su5YrDmTA8pGsy5b09j9MRSrZa3
         kWyNQP/+Q8LhqMP62+m3ZmI3uuGYtGz04/iRPsuBynFiAms0l+f9rdoanBQixJjcSU1g
         7zGHD6kT6i3V0dIBS2fvJpP60c0ZSj0qu+6U7uxnbMbjk5/nOr14YHFB/mIMOZZcZJ0z
         pHKatTr5bn6ZpHjLTQZCJhntc4jhryNYllq3XybxdUG/CyW8YCBHnsZghZW7xYvdNnH7
         0AAQ==
X-Gm-Message-State: AOAM532ygyenaNdb6Ud0y9w46NXcq9ectD5YtBPvXwXuvY/e7hvuERzO
        f8WS4qJFKRHYOzkJAZahnCY/Euz0Sq7c+4Oi9Y0k8daxoWA+km76gCI6R6NNq03leiSmMUzDDWW
        nJH0boz4ZlwCVPmfCg+ZTKB+l
X-Received: by 2002:adf:9163:: with SMTP id j90mr23117170wrj.65.1591621992172;
        Mon, 08 Jun 2020 06:13:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFKKUfkK+tx2dyjLJychJAOnf6ou8lGUS/UM9N0R8J5nM/pSwyG9zl28UmZ6GGRGsYFCgLVg==
X-Received: by 2002:adf:9163:: with SMTP id j90mr23117143wrj.65.1591621991883;
        Mon, 08 Jun 2020 06:13:11 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
        by smtp.gmail.com with ESMTPSA id u4sm23511562wmb.48.2020.06.08.06.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 06:13:11 -0700 (PDT)
Subject: Re: [RFC PATCH] KVM: x86: Fix APIC page invalidation race
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     felipe.franciosi@nutanix.com, rkrcmar@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200606042627.61070-1-eiichi.tsukata@nutanix.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d9b3313-5d4c-9ef3-63e4-ba08ddbbe7a1@redhat.com>
Date:   Mon, 8 Jun 2020 15:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200606042627.61070-1-eiichi.tsukata@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/20 06:26, Eiichi Tsukata wrote:
> Commit b1394e745b94 ("KVM: x86: fix APIC page invalidation") tried to
> fix inappropriate APIC page invalidation by re-introducing arch specific
> kvm_arch_mmu_notifier_invalidate_range() and calling it from
> kvm_mmu_notifier_invalidate_range_start. But threre could be the
> following race because VMCS APIC address cache can be updated
> *before* it is unmapped.
> 
> Race:
>   (Invalidator) kvm_mmu_notifier_invalidate_range_start()
>   (Invalidator) kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD)
>   (KVM VCPU) vcpu_enter_guest()
>   (KVM VCPU) kvm_vcpu_reload_apic_access_page()
>   (Invalidator) actually unmap page
> 
> Symptom:
>   The above race can make Guest OS see already freed page and Guest OS
> will see broken APIC register values.

This is not exactly the issue.  The values in the APIC-access page do
not really matter, the problem is that the host physical address values
won't match between the page tables and the APIC-access page address.
Then the processor will not trap APIC accesses, and will instead show
the raw contents of the APIC-access page (zeroes), and cause the crash
as you mention below.

Still, the race explains the symptoms and the patch matches this text in
include/linux/mmu_notifier.h:

	 * If the subsystem
         * can't guarantee that no additional references are taken to
         * the pages in the range, it has to implement the
         * invalidate_range() notifier to remove any references taken
         * after invalidate_range_start().

where the "additional reference" is in the VMCS: because we have to
account for kvm_vcpu_reload_apic_access_page running between
invalidate_range_start() and invalidate_range_end(), we need to
implement invalidate_range().

The patch seems good, but I'd like Andrea Arcangeli to take a look as
well so I've CCed him.

Thank you very much!

Paolo

> Especially, Windows OS checks
> LAPIC modification so it can cause BSOD crash with BugCheck
> CRITICAL_STRUCTURE_CORRUPTION (109). These symptoms are the same as we
> previously saw in https://bugzilla.kernel.org/show_bug.cgi?id=197951 and
> we are currently seeing in
> https://bugzilla.redhat.com/show_bug.cgi?id=1751017.
> 
> To prevent Guest OS from accessing already freed page, this patch calls
> kvm_arch_mmu_notifier_invalidate_range() from
> kvm_mmu_notifier_invalidate_range() instead of ..._range_start().

