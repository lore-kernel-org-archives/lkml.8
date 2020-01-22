Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F0BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21A24689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5eG+lqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAVQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727893AbgAVQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579709290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+KDRGIU4sIqYrTCFGRumDg7Ht4/WtmtQGbhXNlfXQ0=;
        b=S5eG+lqLAgfUGDe4ytC9PJLvzsUTu6VYpkvC1+uO13+olrp4CRFBuqovlzUVljNPM7hdNf
        QlifI1uonsD437k3D77vn+Qg4uVTtcXsuOI5ymXTSQxb6ug97KFrn8goa7l39thaBtTrgx
        e3350fNiePOlCiZW+0Q0TVWaWz/Je3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-kpJ6weqpPa-wOS7qZ798wg-1; Wed, 22 Jan 2020 11:08:08 -0500
X-MC-Unique: kpJ6weqpPa-wOS7qZ798wg-1
Received: by mail-wr1-f71.google.com with SMTP id v17so3257277wrm.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+KDRGIU4sIqYrTCFGRumDg7Ht4/WtmtQGbhXNlfXQ0=;
        b=cTnlJdEGzIViIphSmKXr9H3XUom7k3fCmXzazc9l8eXhweIsLo1tn+nNcq68sv9Vcg
         gZbOisDwRencbuMbB2nxG4F6L8rdo+pB/xl/aU1bOur89/yjqI27K8+ndFkcTEW86M2P
         2dB1R7AiBf8PIxFBr2rNL6iwrx6/1Cf1IGhldO0KHdCgwyuttdMbiPEKOp+IGybPoI6F
         0tmrvLqDul7CexekrJG60h/0uAcgeBhxojYSHinMWxbH3HOBwf5VPdJ1YqKx1h4b5ORR
         m9ksaso/SRN1ZGIgMqpkMMFAzCNwRvXFBiIbme0xaa7/jAEwytvz+dFyz042UfvdTgnr
         zIrg==
X-Gm-Message-State: APjAAAXqSuXqukH/Dt0WJbKXNgM8w0nkqiFFpYhrIep74DTYQqppOCiA
        M65dBP0lpBl5jzWrjX6Vhu12Stx7a+A/dnLKT3F02sok7qzqXgcJANegxeiIZU4GToJAygRHFvW
        LU4SEgOXJTJEAxceGhI8tkpVS
X-Received: by 2002:a5d:4847:: with SMTP id n7mr11892309wrs.30.1579709287247;
        Wed, 22 Jan 2020 08:08:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1jrFrBWzdZZ+bxB+IeNrbAk/kSCOdz3k+GgU9ykZ+OKOTuhLTPyedfuGR5bYJvxBe4XTTAQ==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr11892272wrs.30.1579709286789;
        Wed, 22 Jan 2020 08:08:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id i11sm59447911wrs.10.2020.01.22.08.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:08:06 -0800 (PST)
Subject: Re: [PATCH v5 00/18] kvm: x86: Support AMD SVM AVIC w/ in-kernel
 irqchip mode
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, joro@8bytes.org, vkuznets@redhat.com,
        rkagan@virtuozzo.com, graf@amazon.com, jschoenh@amazon.de,
        karahmed@amazon.de, rimasluk@amazon.com, jon.grimm@amd.com
References: <1573762520-80328-1-git-send-email-suravee.suthikulpanit@amd.com>
 <9e3e9692-d786-844e-c625-62b69505d2c9@amd.com>
 <b4fa2422-f479-e1e4-11c6-5a4dfda53b74@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aeed73a9-5ef0-4c11-48cd-c36837536e51@redhat.com>
Date:   Wed, 22 Jan 2020 17:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b4fa2422-f479-e1e4-11c6-5a4dfda53b74@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/20 07:16, Suravee Suthikulpanit wrote:
> Ping
> 
> Thanks
> Suravee

Queued it, finally.  Sorry for the wait.

Paolo

> On 1/2/20 5:17 PM, Suravee Suthikulpanit wrote:
>> Paolo,
>>
>> Ping. Would you please let me know your feedback when you get a chance
>> to review this series
>>
>> Thanks,
>> Suravee
>>
>> On 11/15/19 3:15 AM, Suravee Suthikulpanit wrote:
>>> The 'commit 67034bb9dd5e ("KVM: SVM: Add irqchip_split() checks before
>>> enabling AVIC")' was introduced to fix miscellaneous boot-hang issues
>>> when enable AVIC. This is mainly due to AVIC hardware doest not #vmexit
>>> on write to LAPIC EOI register resulting in-kernel PIC and IOAPIC to
>>> wait and do not inject new interrupts (e.g. PIT, RTC).
>>>
>>> This limits AVIC to only work with kernel_irqchip=split mode, which is
>>> not currently enabled by default, and also required user-space to
>>> support split irqchip model, which might not be the case.
>>>
>>> The goal of this series is to enable AVIC to work in both irqchip modes,
>>> by allowing AVIC to be deactivated temporarily during runtime, and
>>> fallback
>>> to legacy interrupt injection mode (w/ vINTR and interrupt windows)
>>> when needed, and then re-enabled subsequently (a.k.a Dynamic APICv).
>>>
>>> Similar approach is also used to handle Hyper-V SynIC in the
>>> 'commit 5c919412fe61 ("kvm/x86: Hyper-V synthetic interrupt
>>> controller")',
>>> where APICv is permanently disabled at runtime (currently broken for
>>> AVIC, and fixed by this series).
>>>
>>> This series contains several parts:
>>>    * Part 1: patch 1,2
>>>      Code clean up, refactor, and introduce helper functions
>>>
>>>    * Part 2: patch 3
>>>      Introduce APICv deactivate bits to keep track of APICv state
>>>      for each vm.
>>>    * Part 3: patch 4-10
>>>      Add support for activate/deactivate APICv at runtime
>>>
>>>    * Part 4: patch 11-14:
>>>      Add support for various cases where APICv needs to
>>>      be deactivated
>>>
>>>    * Part 5: patch 15-17:
>>>      Introduce in-kernel IOAPIC workaround for AVIC EOI
>>>
>>>    * Part 6: path 18
>>>      Allow enable AVIC w/ kernel_irqchip=on
>>>
>>> Pre-requisite Patch:
>>>    * commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
>>> (de-)activation code")
>>>     
>>> (https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/
>>>       ?h=next&id=b9c6ff94e43a0ee053e0c1d983fba1ac4953b762)
>>>
>>> This series has been tested against v5.3 as following:
>>>    * Booting Linux, FreeBSD, and Windows Server 2019 VMs upto 240 vcpus
>>>      w/ qemu option "kernel-irqchip=on" and "-no-hpet".
>>>    * Pass-through Intel 10GbE NIC and run netperf in the VM.
>>>
>>> Changes from V4: (https://lkml.org/lkml/2019/11/1/764)
>>>    * Rename APICV_DEACT_BIT_xxx to APICV_INHIBIT_REASON_xxxx
>>>    * Introduce kvm_x86_ops.check_apicv_inhibit_reasons hook
>>>      to allow vendors to specify which APICv inhibit reason bits
>>>      to support (patch 08/18).
>>>    * Update comment on kvm_request_apicv_update() no-lock requirement.
>>>      (patch 04/18)
>>>
>>> Suravee Suthikulpanit (18):
>>>    kvm: x86: Modify kvm_x86_ops.get_enable_apicv() to use struct kvm
>>>      parameter
>>>    kvm: lapic: Introduce APICv update helper function
>>>    kvm: x86: Introduce APICv inhibit reason bits
>>>    kvm: x86: Add support for dynamic APICv
>>>    kvm: x86: Add APICv (de)activate request trace points
>>>    kvm: x86: svm: Add support to (de)activate posted interrupts
>>>    svm: Add support for setup/destroy virutal APIC backing page for AVIC
>>>    kvm: x86: Introduce APICv x86 ops for checking APIC inhibit reasons
>>>    kvm: x86: Introduce x86 ops hook for pre-update APICv
>>>    svm: Add support for dynamic APICv
>>>    kvm: x86: hyperv: Use APICv update request interface
>>>    svm: Deactivate AVIC when launching guest with nested SVM support
>>>    svm: Temporary deactivate AVIC during ExtINT handling
>>>    kvm: i8254: Deactivate APICv when using in-kernel PIT re-injection
>>>      mode.
>>>    kvm: lapic: Clean up APIC predefined macros
>>>    kvm: ioapic: Refactor kvm_ioapic_update_eoi()
>>>    kvm: ioapic: Lazy update IOAPIC EOI
>>>    svm: Allow AVIC with in-kernel irqchip mode
>>>
>>>   arch/x86/include/asm/kvm_host.h |  19 ++++-
>>>   arch/x86/kvm/hyperv.c           |   5 +-
>>>   arch/x86/kvm/i8254.c            |  12 +++
>>>   arch/x86/kvm/ioapic.c           | 149
>>> +++++++++++++++++++++++-------------
>>>   arch/x86/kvm/lapic.c            |  35 +++++----
>>>   arch/x86/kvm/lapic.h            |   2 +
>>>   arch/x86/kvm/svm.c              | 164
>>> +++++++++++++++++++++++++++++++++++-----
>>>   arch/x86/kvm/trace.h            |  19 +++++
>>>   arch/x86/kvm/vmx/vmx.c          |  12 ++-
>>>   arch/x86/kvm/x86.c              |  71 ++++++++++++++---
>>>   10 files changed, 385 insertions(+), 103 deletions(-)
>>>
> 

