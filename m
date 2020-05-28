Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28731C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A8520B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI2kl/Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgE1Imq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:42:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727085AbgE1Imp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590655363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fvx+64wD7VVw0aAEs3VYwAWqeGVZ/eQWc2QHhJjKSZs=;
        b=OI2kl/Lb8vtLFSgujsX90Ss0cV6ounzFGa6SY4QNfyLuy9BoHMZ35Ys8dX+EWQH3x2FWOi
        SoqthLg5w1q+7frNtHiVFnojVZ5NFBYkdDNucSX4S6q62e8L9J87RT3rKdrgUP62Njqod9
        VSHe+XB+oWDckhTCgxsRbz/SgbZGAHU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59--GpBdHiyNEmD6T_-ob-rUQ-1; Thu, 28 May 2020 04:42:42 -0400
X-MC-Unique: -GpBdHiyNEmD6T_-ob-rUQ-1
Received: by mail-ed1-f72.google.com with SMTP id df5so11298873edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Fvx+64wD7VVw0aAEs3VYwAWqeGVZ/eQWc2QHhJjKSZs=;
        b=A/95EWZ+kns4bAN5Ih1mQcLDYSUzYTLB+gQF6KHVZe9CHTzcfB/Rt07HOWHG4QxMWl
         cXoOF3vUtXwiXoa3C27vDuVUUgDk2AStSM6f+5w0VmbGkugJO5zvOLtRM9CdiVB0/N9/
         vKb+GgttyFxU5yivsi7kXC0hhRihgug500V6mqzQAnnUzVmWxIDztH0LgMTJh2Uoe1iF
         FUOiD35Q0gckfNmXI6RtWCSBkUfRCiRduu8m/yAslrLEOiqvLXnLSuBqSOAWUqYfj5NF
         KB63YFzyQ8LteH6ve7ptfqAgcYs0LxYr1Ax31p/wkTfGPgS2zfOPULDnlp4VYOiCLN9V
         gQGg==
X-Gm-Message-State: AOAM533PwsJwpGbskB/VciA2FwUC7qgTTWjZhAUQ92SRbjcOaOkLekj6
        HiFxv0wn0W9lhl6TI4o+SB/oKGv1/5NubuoH8sCKiJT+xTD0pMtfyJ5EFAJ5L5drjqdrBAbmgwf
        5M2Stt8RMM//QCvaPQ5cxSag6
X-Received: by 2002:a05:6402:1434:: with SMTP id c20mr1863676edx.27.1590655360783;
        Thu, 28 May 2020 01:42:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmwuFe03uOkyVF7/OHMQGe1m9vs1yVv9lSdGU5anfJ+bfgT3LjEFTVBq0ghQke7oQvGAigYg==
X-Received: by 2002:a05:6402:1434:: with SMTP id c20mr1863652edx.27.1590655360464;
        Thu, 28 May 2020 01:42:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b14sm394893ejq.105.2020.05.28.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:42:39 -0700 (PDT)
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
Subject: Re: [PATCH v2 02/10] KVM: x86: extend struct kvm_vcpu_pv_apf_data with token info
In-Reply-To: <20200526182745.GA114395@redhat.com>
References: <20200525144125.143875-1-vkuznets@redhat.com> <20200525144125.143875-3-vkuznets@redhat.com> <20200526182745.GA114395@redhat.com>
Date:   Thu, 28 May 2020 10:42:38 +0200
Message-ID: <875zcg4fi9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, May 25, 2020 at 04:41:17PM +0200, Vitaly Kuznetsov wrote:
>> 
>
> [..]
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 0a6b35353fc7..c195f63c1086 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -767,7 +767,7 @@ struct kvm_vcpu_arch {
>>  		u64 msr_val;
>>  		u32 id;
>>  		bool send_user_only;
>> -		u32 host_apf_reason;
>> +		u32 host_apf_flags;
>
> Hi Vitaly,
>
> What is host_apf_reason used for. Looks like it is somehow used in
> context of nested guests. I hope by now you have been able to figure
> it out.
>
> Is it somehow the case of that L2 guest takes a page fault exit
> and then L0 injects this event in L1 using exception. I have been
> trying to read this code but can't wrap my head around it.
>
> I am still concerned about the case of nested kvm. We have discussed
> apf mechanism but never touched nested part of it. Given we are
> touching code in nested kvm part, want to make sure it is not broken
> in new design.
>

Sorry I missed this.

I think we've touched nested topic a bit already:
https://lore.kernel.org/kvm/87lfluwfi0.fsf@vitty.brq.redhat.com/

But let me try to explain the whole thing and maybe someone will point
out what I'm missing.

The problem being solved: L2 guest is running and it is hitting a page
which is not present *in L0* and instead of pausing *L1* vCPU completely
we want to let L1 know about the problem so it can run something else
(e.g. another guest or just another application).

What's different between this and 'normal' APF case. When L2 guest is
running, the CPU (physical) is in 'guest' mode so we can't inject #PF
there. Actually, we can but L2 may get confused and we're not even sure
it's L2's fault, that L2 supported APF and so on. We want to make L1
deal with the issue.

How does it work then. We inject #PF and L1 sees it as #PF VMEXIT. It
needs to know about APF (thus KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT) but
the handling is exactly the same as do_pagefault(): L1's
kvm_handle_page_fault() checkes APF area (shared between L0 and L1) and
either pauses a task or resumes a previously paused one. This can be a
L2 guest or something else.

What is 'host_apf_reason'. It is a copy of 'reason' field from 'struct
kvm_vcpu_pv_apf_data' which we read upon #PF VMEXIT. It indicates that
the #PF VMEXIT is synthetic.

How does it work with the patchset: 'page not present' case remains the
same. 'page ready' case now goes through interrupts so it may not get
handled immediately. External interrupts will be handled by L0 in host
mode (when L2 is not running). For the 'page ready' case L1 hypervisor
doesn't need any special handling, kvm_async_pf_intr() irq handler will
work correctly.

I've smoke tested this with VMX and nothing immediately blew up.

-- 
Vitaly

