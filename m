Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA879C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BA6206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asHEft0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIAILC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:11:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726107AbgIAIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598947857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ywbzOyojoAfTL6CSiMEtbtQG/UWMpLz/fFs6teic35M=;
        b=asHEft0UNqUe8bG9GJ2cPQatCMykMwuQ5YT7O3legygmB2qWYfqmwkhoxb4FUs723QLSjK
        JxPkOIVe5VAjNIfB7ChF8U0QJ845fF1wIUst27uACi9eNuztP2OAmaOPnAeoGy4upmLEBC
        qQz0Ltsbd4elQ42X6qtEOzM8A+W5ZF0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-HSVVKrY1Mqucc9pI8HeXCw-1; Tue, 01 Sep 2020 04:10:54 -0400
X-MC-Unique: HSVVKrY1Mqucc9pI8HeXCw-1
Received: by mail-wr1-f72.google.com with SMTP id k11so251055wrw.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ywbzOyojoAfTL6CSiMEtbtQG/UWMpLz/fFs6teic35M=;
        b=meNZwwaB8XMONFjwAx/L/5eWfovT5+gzl4XNY8VvjOw3Yxds8XwTtZygUoXYAqx+6G
         EctuT/imi46azbWubeeXOBJYKwmLq36vShsMimHV/ERmpjttnfbvSqqa4VxdFC8L7Oi/
         fcpbMvxttWsmnZVI0g5wR2w3WWeYyr/tBqLGgZn45PHHaN9Gh94AGDEdj4w8KgYKsHSB
         vGayjJGMYPdhavx+frEV1DWtUDVMGqmTyKCK06OuxiXlKt0pjh6icANDk3YQhyjdITLO
         vzdxxesba6zSufbqY7prbIyjhzRd5njiyY7hEuwmAOHH6m0lA2mur7T5PWF5A18u0agb
         QE1g==
X-Gm-Message-State: AOAM532G3x8AWf9UDBRYS7pIIXg4FX7w9OfIckZougP/zT0SLabvqI7X
        IAygB5hqV0bawNRwCB3eqMWFzBUu12+DSw4UMHC8AeKEps7rqyHMB16wlx9hUS+2mULEztPNdpp
        U78lokMfseXdxWi9oTptriXFO
X-Received: by 2002:a5d:420b:: with SMTP id n11mr526477wrq.11.1598947852915;
        Tue, 01 Sep 2020 01:10:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys7NT738indZhV+2AmYFWU6qfb0ENn9iwBCkNPPMVDsNV8FR86m8VpWUAMS1aZrJF0pLZkcQ==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr526450wrq.11.1598947852620;
        Tue, 01 Sep 2020 01:10:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n21sm705241wmi.21.2020.09.01.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:10:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] kvm x86/mmu: use KVM_REQ_MMU_SYNC to sync when needed
In-Reply-To: <CAJhGHyCLF4+5LV8Zwu5kczL48imKPDHJKizVd+VZwVha0U8BaQ@mail.gmail.com>
References: <20200824101825.4106-1-jiangshanlai@gmail.com> <CAJhGHyC1Ykq5V_2nFPLRz9JmtAiQu6aw4fCKo1LO7Qwzjvfg2g@mail.gmail.com> <875z8zx8qs.fsf@vitty.brq.redhat.com> <CAJhGHyCLF4+5LV8Zwu5kczL48imKPDHJKizVd+VZwVha0U8BaQ@mail.gmail.com>
Date:   Tue, 01 Sep 2020 10:10:50 +0200
Message-ID: <87y2ltx6gl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai Jiangshan <jiangshanlai@gmail.com> writes:

> On Mon, Aug 31, 2020 at 9:09 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Lai Jiangshan <jiangshanlai@gmail.com> writes:
>>
>> > Ping @Sean Christopherson
>> >
>>
>> Let's try 'Beetlejuice' instead :-)
>>
>> > On Mon, Aug 24, 2020 at 5:18 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>> >>
>> >> From: Lai Jiangshan <laijs@linux.alibaba.com>
>> >>
>> >> 8c8560b83390("KVM: x86/mmu: Use KVM_REQ_TLB_FLUSH_CURRENT for MMU specific flushes)
>> >> changed it without giving any reason in the changelog.
>> >>
>> >> In theory, the syncing is needed, and need to be fixed by reverting
>> >> this part of change.
>>
>> Even if the original commit is not wordy enough this is hardly
>> better.
>
> Hello,
> Thank you for reviewing it.
>
> I'm sorry that when I said "reverting this part of change",
> I meant "reverting this line of code". This line of code itself
> is quite clear that it is not related to the original commit
> according to its changelog.
>
>> Are you seeing a particular scenario when a change in current
>> vCPU's MMU requires flushing TLB entries for *other* contexts, ... (see
>> below)
>
> So I don't think the patch needs to explain this because the patch
> does not change/revert anything about it.
>
> Anyway, using a "revert" in the changelog is misleading, when it
> is not really reverting the whole targeted commit. I would
> remove this wording.
>
> For the change in my patch, when kvm_mmu_get_page() gets a
> page with unsync children, the host side pagetable is
> unsynchronized with the guest side pagedtable, and the
> guest might not issue a "flush" operation on it. It is
> all about the host's emulation of the pagetable. So the host
> has the responsibility to synchronize the pagetables.
>

Ah, I see now, so it seems Sean's commit has a stray change in it: the
intention was to change KVM_REQ_TLB_FLUSH -> KVM_REQ_TLB_FLUSH_CURRENT
so we don't unneedlesly flush other contexts but one of the hunks
changed KVM_REQ_MMU_SYNC instead. Syncronizing MMU roots can't be
replaced with a TLB flush, we need to revert back the change. This
sounds reasonable to me, please send out v2 with the updated
description. Thanks!

-- 
Vitaly

