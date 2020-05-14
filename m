Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCA620675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej7RVucZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgENSOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:14:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgENSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589480076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzIRU4hVPjXb67rBZK7y/2XlzdUyGaI9NSRoPkeSbzM=;
        b=ej7RVucZZp7pD3E+g2drq3xqyWwsU+OiMNkcwkO37qkGBQDVfXC6ZbFf9PGgxTNVtZDFmr
        osYZQWuYisxGc55c9G7YCiNuR2diKijfkvoC0JUXa+exQI+q3VYL+GfZR9Lch491gqkD2z
        F4THVaQMNJZxfOqOd5JpS2/VOpiRKqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-V41MK8G9NO-5Kwk3i6aC_A-1; Thu, 14 May 2020 14:14:34 -0400
X-MC-Unique: V41MK8G9NO-5Kwk3i6aC_A-1
Received: by mail-wr1-f70.google.com with SMTP id d16so1943762wrv.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mzIRU4hVPjXb67rBZK7y/2XlzdUyGaI9NSRoPkeSbzM=;
        b=P85K+rtDo2TTjpYOxk10GodUoHimapa5c/PypJUKP1BhdDoLv+rmjkXtuRYL66CwXS
         oWbl0YKbi+FbYeCOOcD295kli9UZhz6VzTrQ9faG0fRQ36KXCbZdHn4vexmO85BU/chl
         554pXPr+gaghjC6sO6z6ab/xm996To99kqzQYwg+8yUNEXcHPn1KJQIVf45iooznM/oi
         4kCMLvHNQiXT+biAkMOdXdrmHhhuO/XoYQvIAcZYwv4lB8p7DkRm9ZZk6MzMQ6K2pV2a
         8j0x5qP/4RYfrvkbr58s/3N8AuviRRogfORuoapMRt7wJwuLonNjsKxaXeFLXtT0siAM
         4whA==
X-Gm-Message-State: AOAM531EngybbYZdP24WUo8hClhbKajPW+d0KKja1cZGk17yMmRPH+8J
        3eI4Wzc2vIZPoWboSeHZC5LikmfaEyRgFItQ66GZ6B9IKTBSxXUD3MkwilJdrq7i3WjsIBKW3gw
        P4iNY7JZMLQgG8rKXIhp0SlmW
X-Received: by 2002:a5d:6984:: with SMTP id g4mr6936857wru.205.1589480073478;
        Thu, 14 May 2020 11:14:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeTxfc3WgAu3tduIxRklHv12LODcL10ChQ0vTuJJthnagTCTpnhId4fsqEruy7KgrIjEIUEw==
X-Received: by 2002:a5d:6984:: with SMTP id g4mr6936819wru.205.1589480073134;
        Thu, 14 May 2020 11:14:33 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b145sm20013128wme.41.2020.05.14.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:14:32 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] KVM: x86: Interrupt-based mechanism for async_pf 'page present' notifications
In-Reply-To: <20200513141644.GD173965@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com> <20200513141644.GD173965@redhat.com>
Date:   Thu, 14 May 2020 20:14:31 +0200
Message-ID: <87lfluwfi0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, May 11, 2020 at 06:47:44PM +0200, Vitaly Kuznetsov wrote:
>> Concerns were expressed around (ab)using #PF for KVM's async_pf mechanism,
>> it seems that re-using #PF exception for a PV mechanism wasn't a great
>> idea after all. The Grand Plan is to switch to using e.g. #VE for 'page
>> not present' events and normal APIC interrupts for 'page ready' events.
>> This series does the later.
>
> Hi Vitaly,
>
> How does any of this impact nested virtualization code (if any).
>
> I have tried understanding that logic, but I have to admit, I could
> never get it.
>
> arch/x86/kvm/mmu/mmu.c
>
> int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
>                                 u64 fault_address, char *insn, int insn_len)
> {
>         switch (vcpu->arch.apf.host_apf_reason) {
> 		case KVM_PV_REASON_PAGE_NOT_PRESENT:
> 			kvm_async_pf_task_wait(fault_address, 0);
> 		case KVM_PV_REASON_PAGE_READY:
> 			kvm_async_pf_task_wake(fault_address);
> 	}
> }
>

"[PATCH 8/8] KVM: x86: drop KVM_PV_REASON_PAGE_READY case from
kvm_handle_page_fault()" modifies this a little bit.

Basically (and if I understand this correctly) we have the following APF
related feature (bit 2 in MSR_KVM_ASYNC_PF_EN): "asynchronous page faults
are delivered to L1 as #PF vmexits.". When enabled, it allows L0 to
inject #PF when L2 guest is running. L1 will see this as '#PF vmexit'
and the code you cite will do exactly what do_async_page_fault() is
doing.

When we switch to interrupt based delivery for 'page ready' events we
don't need a special handling for them in L1 (as we don't need any
special handling for all interrupts from devices in kernel when KVM
guest is running).

I have to admit I haven't tested nested scenario yet, "what could go
wrong?" :-)

-- 
Vitaly

