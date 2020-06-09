Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFB2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A942074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5P3DQmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgFIJyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:54:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727037AbgFIJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591696455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC9syHJzq6iNk5VKVHnGheNpsoiQBFm88X04rtBYN08=;
        b=Y5P3DQmSRySNy1nEl5QupgHL7BGk3hVm8z+O+iQft2lFnARqUZpGT/pN1C2ZQS7z7eQKfF
        HcFF234r24EICSK5PXQpSOZkyAGQNDxvSQLypRHJD45Wfbj03clMnsMSE7qit8jtoiKv9I
        g81zp6huTG+/nfwD3saOUExDBspNSJU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-3xrtNILaNemw8DHVMedbsg-1; Tue, 09 Jun 2020 05:54:11 -0400
X-MC-Unique: 3xrtNILaNemw8DHVMedbsg-1
Received: by mail-wr1-f71.google.com with SMTP id a4so8380290wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SC9syHJzq6iNk5VKVHnGheNpsoiQBFm88X04rtBYN08=;
        b=I8yptMOb2r2e/iYPQTFXOssS8E5CxuyTuHcK4+RlNd2sWl/ZYkNgCDliM9Y7xw4Dz2
         7CBIEIFflBT9DFKbjkQGmJ2gjbkUaNojXsRFcPN4vqW27aJLHpIs3cItHamBXzKXSulf
         w0XRbeXv1mdl/DxqCjQ7CEAlQGSoIASeqjr9COJJ6gFFwTXo0k1c6cJvY+/E/xe2BCZA
         UalUj2dvsU3LII5GAifnC2fvW+wqn61Hamg4T/R2pqt4GmCbHkqTjnantbKM30LJAg2Z
         6pOOZB0QActolspTcSNsnHmyyeyf1lobyCBLcBg39HesGrW3KJvphvmPV6K7VBaZWztW
         +8hA==
X-Gm-Message-State: AOAM5331kE3obJAgEAAyxBxZWc357o9PBwbbpUzFKBV8M6+XbGbRkLWq
        4GVzu7XerFT+Y2CFuiIH9eFXN8KZVBjRH2CqekrmY6xZlgSycjAbBIYj/x4OkA00Q4BElN1uhrG
        z7c/z0P7mLAieuJ6g8C9h0MaH
X-Received: by 2002:adf:910e:: with SMTP id j14mr3319831wrj.278.1591696450442;
        Tue, 09 Jun 2020 02:54:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNaCwWIicA8xSDlpgm/W3oiuEgYalTH4d6fD5Fqj+9Mro5lSmTaPsGiPPa7w/Cmzt0VCbrlw==
X-Received: by 2002:adf:910e:: with SMTP id j14mr3319797wrj.278.1591696450189;
        Tue, 09 Jun 2020 02:54:10 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
        by smtp.gmail.com with ESMTPSA id n189sm2309651wmb.43.2020.06.09.02.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 02:54:09 -0700 (PDT)
Subject: Re: [RFC PATCH] KVM: x86: Fix APIC page invalidation race
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200606042627.61070-1-eiichi.tsukata@nutanix.com>
 <0d9b3313-5d4c-9ef3-63e4-ba08ddbbe7a1@redhat.com>
 <7B9024C7-98D0-4940-91AE-40BCDE555C8F@nutanix.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d2d2faf-116f-8c71-fda2-3fc052952dee@redhat.com>
Date:   Tue, 9 Jun 2020 11:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7B9024C7-98D0-4940-91AE-40BCDE555C8F@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/20 03:04, Eiichi Tsukata wrote:
> 
> 
>> On Jun 8, 2020, at 22:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 06/06/20 06:26, Eiichi Tsukata wrote:
>>> Commit b1394e745b94 ("KVM: x86: fix APIC page invalidation") tried to
>>> fix inappropriate APIC page invalidation by re-introducing arch specific
>>> kvm_arch_mmu_notifier_invalidate_range() and calling it from
>>> kvm_mmu_notifier_invalidate_range_start. But threre could be the
>>> following race because VMCS APIC address cache can be updated
>>> *before* it is unmapped.
>>>
>>> Race:
>>>  (Invalidator) kvm_mmu_notifier_invalidate_range_start()
>>>  (Invalidator) kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD)
>>>  (KVM VCPU) vcpu_enter_guest()
>>>  (KVM VCPU) kvm_vcpu_reload_apic_access_page()
>>>  (Invalidator) actually unmap page
>>>
>>> Symptom:
>>>  The above race can make Guest OS see already freed page and Guest OS
>>> will see broken APIC register values.
>>
>> This is not exactly the issue.  The values in the APIC-access page do
>> not really matter, the problem is that the host physical address values
>> won't match between the page tables and the APIC-access page address.
>> Then the processor will not trap APIC accesses, and will instead show
>> the raw contents of the APIC-access page (zeroes), and cause the crash
>> as you mention below.
>>
>> Still, the race explains the symptoms and the patch matches this text in
>> include/linux/mmu_notifier.h:
>>
>> 	 * If the subsystem
>>         * can't guarantee that no additional references are taken to
>>         * the pages in the range, it has to implement the
>>         * invalidate_range() notifier to remove any references taken
>>         * after invalidate_range_start().
>>
>> where the "additional reference" is in the VMCS: because we have to
>> account for kvm_vcpu_reload_apic_access_page running between
>> invalidate_range_start() and invalidate_range_end(), we need to
>> implement invalidate_range().
>>
>> The patch seems good, but I'd like Andrea Arcangeli to take a look as
>> well so I've CCed him.
>>
>> Thank you very much!
>>
>> Paolo
>>
> 
> Hello Paolo
> 
> Thanks for detailed explanation!
> I’ll fix the commit message like this:

No need to resend, the patch is good.  Here is my take on the commit message:

    Commit b1394e745b94 ("KVM: x86: fix APIC page invalidation") tried
    to fix inappropriate APIC page invalidation by re-introducing arch
    specific kvm_arch_mmu_notifier_invalidate_range() and calling it from
    kvm_mmu_notifier_invalidate_range_start. However, the patch left a
    possible race where the VMCS APIC address cache is updated *before*
    it is unmapped:
    
      (Invalidator) kvm_mmu_notifier_invalidate_range_start()
      (Invalidator) kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD)
      (KVM VCPU) vcpu_enter_guest()
      (KVM VCPU) kvm_vcpu_reload_apic_access_page()
      (Invalidator) actually unmap page
    
    Because of the above race, there can be a mismatch between the
    host physical address stored in the APIC_ACCESS_PAGE VMCS field and
    the host physical address stored in the EPT entry for the APIC GPA
    (0xfee0000).  When this happens, the processor will not trap APIC
    accesses, and will instead show the raw contents of the APIC-access page.
    Because Windows OS periodically checks for unexpected modifications to
    the LAPIC register, this will show up as a BSOD crash with BugCheck
    CRITICAL_STRUCTURE_CORRUPTION (109) we are currently seeing in
    https://bugzilla.redhat.com/show_bug.cgi?id=1751017.
    
    The root cause of the issue is that kvm_arch_mmu_notifier_invalidate_range()
    cannot guarantee that no additional references are taken to the pages in
    the range before kvm_mmu_notifier_invalidate_range_end().  Fortunately,
    this case is supported by the MMU notifier API, as documented in
    include/linux/mmu_notifier.h:
    
             * If the subsystem
             * can't guarantee that no additional references are taken to
             * the pages in the range, it has to implement the
             * invalidate_range() notifier to remove any references taken
             * after invalidate_range_start().
    
    The fix therefore is to reload the APIC-access page field in the VMCS
    from kvm_mmu_notifier_invalidate_range() instead of ..._range_start().

Thanks,

Paolo

