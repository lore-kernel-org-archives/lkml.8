Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D1FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCCD206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/CcgAop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgHaNJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:09:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbgHaNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598879361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2GnCcv2WvVq5iCUqDhGffUDjlXCs353uZj6NC6srVM=;
        b=Z/CcgAopq/6i6ULRgyXIVrRnhIm9JDBvCUJAdeGa+0yTuoQGBs0tWJV88IiDI++nIhJJ6i
        hpAWQYlG1j4KsIrXemHcLPqm/jXD91JB2drGS8r/ryvucGj9CIbfMwzIJjFpeuixkjuYCL
        c6JqcJp/8IyFbcCkJTGaicWG0i66eCk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-3yW9H--1MzGakJ9kbkUgYQ-1; Mon, 31 Aug 2020 09:09:19 -0400
X-MC-Unique: 3yW9H--1MzGakJ9kbkUgYQ-1
Received: by mail-wm1-f71.google.com with SMTP id b73so979956wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=l2GnCcv2WvVq5iCUqDhGffUDjlXCs353uZj6NC6srVM=;
        b=oATwywiMMzj9cPz2ROcFEd5b8cVZOeN7nscR70vur0eBT3SwfGuMOzyuCUa7sy+WN4
         5gPc/58LCMj0au87kEDGaZW7g2PPQKnSSy4KDzQISccdgG8MwH75RCLNr+YxL3ipeDeT
         ivS9vz+/uy4/5Xeo5y5fruYxtukVeDAFZM3t1pURlg1Ix/X/PCQ6bXvsSIabhgPwqPwl
         DiSDBh/BDjC24GiwCt6IMKSvFK1uM/R/dOk/oWExwQHAxaQoKSSChVuYgUU6I8gwHCGn
         0bPCNGNCquQVPKd+tIM6a3LvNLAMsZqapS8gukx1abdVLrfxOY0k767be1/aZLs8lNGN
         5s1Q==
X-Gm-Message-State: AOAM530wf4zzL8/l9hLNW7gnxT/M7lKIlaY8cAYeZun9ugkdCLiW/tHl
        SRxyS+Q8SMyyePqzAlrMt2TX/BCHed6MjacMEdgVMu+iijGw0NdxEUSdCBkl7BtYMqVXJJncnZg
        G44hL6ZbV1uIzMhOVywBA0fB3
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr1710317wrj.92.1598879357888;
        Mon, 31 Aug 2020 06:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/1+vKHyvkY7iAfm+ukdoRDuyURSwkR27pytCRbfzdoM7lD9CNUTZ+Lt7aTkXhxMzxGsxqHA==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr1710303wrj.92.1598879357649;
        Mon, 31 Aug 2020 06:09:17 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k184sm11767549wme.1.2020.08.31.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 06:09:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] kvm x86/mmu: use KVM_REQ_MMU_SYNC to sync when needed
In-Reply-To: <CAJhGHyC1Ykq5V_2nFPLRz9JmtAiQu6aw4fCKo1LO7Qwzjvfg2g@mail.gmail.com>
References: <20200824101825.4106-1-jiangshanlai@gmail.com> <CAJhGHyC1Ykq5V_2nFPLRz9JmtAiQu6aw4fCKo1LO7Qwzjvfg2g@mail.gmail.com>
Date:   Mon, 31 Aug 2020 15:09:15 +0200
Message-ID: <875z8zx8qs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai Jiangshan <jiangshanlai@gmail.com> writes:

> Ping @Sean Christopherson
>

Let's try 'Beetlejuice' instead :-)

> On Mon, Aug 24, 2020 at 5:18 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>>
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> 8c8560b83390("KVM: x86/mmu: Use KVM_REQ_TLB_FLUSH_CURRENT for MMU specific flushes)
>> changed it without giving any reason in the changelog.
>>
>> In theory, the syncing is needed, and need to be fixed by reverting
>> this part of change.

Even if the original commit is not wordy enough this is hardly
better. Are you seeing a particular scenario when a change in current
vCPU's MMU requires flushing TLB entries for *other* contexts, ... (see
below)

>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>  arch/x86/kvm/mmu/mmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index 4e03841f053d..9a93de921f2b 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -2468,7 +2468,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>>                 }
>>
>>                 if (sp->unsync_children)
>> -                       kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>> +                       kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);

... in particular, why are you reverting only this hunk? Please elaborate.

>>
>>                 __clear_sp_write_flooding_count(sp);
>>
>> --
>> 2.19.1.6.gb485710b
>>
>

-- 
Vitaly

