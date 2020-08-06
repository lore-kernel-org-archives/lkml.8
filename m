Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B9C43467
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6A922E00
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xjth3DIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgHFJOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:14:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725927AbgHFJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596705291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PptWRBZ+0zU2m0TTKrUzMYdhKSdC7q+oaIaAdKw+itE=;
        b=Xjth3DIHzEaq81A3sMi38JkT2CEdQAm6fP+h4qjh9+HrbjExBd1Ie1gV+65mNNsupaC4ak
        W7ZMH+BU3+QAxF8dADNzS2Vk3mbP6NYBx/30AzEdtQS93iH09zJcI14VufKT/6XjxqAImf
        dIqocf4qEcAJ1ydylbY4YoUHgOBdNLM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-cZEssO-5PHWCNn2eJrAmMQ-1; Thu, 06 Aug 2020 05:14:49 -0400
X-MC-Unique: cZEssO-5PHWCNn2eJrAmMQ-1
Received: by mail-ej1-f70.google.com with SMTP id r14so13454595eji.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 02:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PptWRBZ+0zU2m0TTKrUzMYdhKSdC7q+oaIaAdKw+itE=;
        b=Z81Gixi/S949c2/Nk8rw4+YqC8OQTiShxdqdfsbe6jX59VOHtfj8qel97/VXn43Vsr
         +udo30c82wLshmiK9Ng/y7m50zYwjKHgSHraeMFZRcmt8Q9MEUogf5yscecGx21NwEUL
         nDPt3IsgVO6iRiG0uS+W0sJb69X6RrMo5UhJpV8/OIckgqSQHMFFmITAIoyqDqx+ocKZ
         g88J7Jfs36PN6Msk33tBJNn3myewChJrzg5OH2Y4s0EyaIYox1W/KZUq9Fi6opnTpxW7
         M60FytW1lBodd2mSCYIGgDUF9tJR2aT/Bo99q27eHFyKQo0KBwAbw2BVGsa8muzzq967
         VrEg==
X-Gm-Message-State: AOAM530hL0cCx2bqNUEYKRsmmtJq3O6rZ0jBlYxBpTDTB2spnILsfRds
        6u2ckG5ptgWQ9U+NyHsjXnkyvCdMMXueddRd/Cjc2QCHNb2/kVoLwXLVIfwJYshlz74OcX/9LeV
        WPH1iZVOy3lTfV4hjahRksp9T
X-Received: by 2002:a17:906:9392:: with SMTP id l18mr3298286ejx.357.1596705288228;
        Thu, 06 Aug 2020 02:14:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI0pHI6XZUb7InmN6q7wFebkW/fuUjhF2ooS5eJKhMI9OIcTZ5cCFPIWQVQwpkr0p5dcw3eg==
X-Received: by 2002:a17:906:9392:: with SMTP id l18mr3298261ejx.357.1596705287973;
        Thu, 06 Aug 2020 02:14:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n11sm3072328edv.39.2020.08.06.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 02:14:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Xu <peterx@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] KVM: x86: introduce KVM_MEM_PCI_HOLE memory
In-Reply-To: <CALMp9eSWsvufDXMuTUR3Fmh91O7tHUaqpDbAoavSMc=prpcDzg@mail.gmail.com>
References: <20200728143741.2718593-1-vkuznets@redhat.com> <20200728143741.2718593-3-vkuznets@redhat.com> <CALMp9eSWsvufDXMuTUR3Fmh91O7tHUaqpDbAoavSMc=prpcDzg@mail.gmail.com>
Date:   Thu, 06 Aug 2020 11:14:46 +0200
Message-ID: <875z9wp249.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Tue, Jul 28, 2020 at 7:38 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> PCIe config space can (depending on the configuration) be quite big but
>> usually is sparsely populated. Guest may scan it by accessing individual
>> device's page which, when device is missing, is supposed to have 'pci
>> hole' semantics: reads return '0xff' and writes get discarded. Compared
>> to the already existing KVM_MEM_READONLY, VMM doesn't need to allocate
>> real memory and stuff it with '0xff'.
>
> Note that the bus error semantics described should apply to *any*
> unbacked guest physical addresses, not just addresses in the PCI hole.
> (Typically, this also applies to the standard local APIC page
> (0xfee00xxx) when the local APIC is either disabled or in x2APIC mode,
> which is an area that kvm has had trouble with in the past.)

Yes, we can make KVM return 0xff on all read access to unbacked memory,
not only KVM_MEM_PCI_HOLE slots (and drop them completely). This,
however, takes the control from userspace: with KVM_MEM_PCI_HOLE
memslots we're saying 'accessing this unbacked memory is fine' and we
can still trap accesses to all other places. This should help in
detecting misbehaving guests.

-- 
Vitaly

