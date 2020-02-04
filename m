Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37285C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6352082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2jpMKPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgBDOhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:37:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727250AbgBDOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580827018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4oID/MjfqTQ+n08/EIWcONdJe6Z2nq4WI7xtUbHDEI=;
        b=b2jpMKPN4ZkcVTOIyiCIiBnZCxncdCbEEVLFwP+IZj9MZ45OiNI/zqm+BH38hyE8R5I9Ut
        zN8UMVnTRswXbC+UFZQg3khWasyH1wpJ57UHmS4OIev5HU3JBjPUN0CIG8JBeoZLKD4qHv
        PWE75WRwn+rLZXY/wT8CUtPithAiTMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-D0XqkzqUPe6e6N2DKR8IVA-1; Tue, 04 Feb 2020 09:36:56 -0500
X-MC-Unique: D0XqkzqUPe6e6N2DKR8IVA-1
Received: by mail-wr1-f72.google.com with SMTP id s13so10210421wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d4oID/MjfqTQ+n08/EIWcONdJe6Z2nq4WI7xtUbHDEI=;
        b=MfOTtqt7yWkiNF7NNffH5Z1gxn2yqVGbL+UGnfWlFDl+9E3njqcdX/f5S4pYqVcmZ2
         o899yz93LHfXjwsPnSSxORYtoosiffHwJGoi5qpEJ72FnA4L76vxalZyLnGxGV/NxBVF
         96a4hkseoJ9d7fdG3Hkqnk3Wq9c2jJ0MMZ8aMJ7+WAiQOi+mnFSQEbQd9v+azhp4MwYm
         +nHVryDhMF3NsqEcu/NpLZMgBbX9UkOAPFu2oIiLq2SrgK3TqvYZbkKyKJyz/v3u4AVs
         3Yj2NiTCoV131nVzF06FrAJmkXJC3UXJUA9oCUB68NoUq0nBX/YOEVgo6XcnoivnmZ/L
         dA/Q==
X-Gm-Message-State: APjAAAXN3iGRPUcCySZyTKtCsH9w7rQPbey0LmdtbCCB8RiJa/Hy1Hyr
        nBRoPqXij+nfpOkVkzgq2KpvMp/srypRYeWoVtmPLrMY2lhk85XhUxWpsRs2OyAmp8JXg0HZFTU
        Xf6Thv8vm5NV/3dk2LXyKJnWz
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr5906151wme.23.1580827015035;
        Tue, 04 Feb 2020 06:36:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyac0/Vwg6esCkpMW9u2CVE28Xh1fpnOCRV5CRBnFdTm1nx54yPw5Wkor5FBNIjnBmuYfZhGg==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr5906138wme.23.1580827014828;
        Tue, 04 Feb 2020 06:36:54 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e18sm29407471wrw.70.2020.02.04.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:36:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] KVM: Pre-allocate 1 cpumask variable per cpu for both pv tlb and pv ipis
In-Reply-To: <CANRm+CzkN9oYf4UqWYp2SHFii02=pvVLbW4oNkLmPan7ZroDZA@mail.gmail.com>
References: <CANRm+CwwYoSLeA3Squp-_fVZpmYmxEfqOB+DGoQN4Y_iMT347w@mail.gmail.com> <878slio6hp.fsf@vitty.brq.redhat.com> <CANRm+CzkN9oYf4UqWYp2SHFii02=pvVLbW4oNkLmPan7ZroDZA@mail.gmail.com>
Date:   Tue, 04 Feb 2020 15:36:53 +0100
Message-ID: <874kw6o1ve.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

>>
>> Honestly, I'd simplify the check in kvm_alloc_cpumask() as
>>
>> if (!kvm_para_available())
>>         return;
>>
>> and allocated masks for all other cases.
>
> This will waste the memory if pv tlb and pv ipis are not exposed which
> are the only users currently.
>

My assumption is that the number of cases where we a) expose KVM b)
don't expose IPIs and PV-TLB and c) care about 1 cpumask per cpu is
relatively low. Ok, let's at least have a function for

	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))

as we now check it twice: in kvm_alloc_cpumask() and kvm_guest_init(),
something like pv_tlb_flush_supported(). We can also do
pv_ipi_supported() and probably others for consistency.

Also, probably not for this patch but it all makes me wonder why there's
no per-cpu 'scratch' cpumask for the whole kernel to use. We definitely
need it for hypervisor support but I also see
arch/x86/kernel/apic/x2apic_cluster.c has similar needs.

-- 
Vitaly

