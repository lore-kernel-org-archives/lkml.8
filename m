Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A41C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96615206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHQNAgma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgC0JHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:07:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26799 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgC0JHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585300022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71Cru4C3vnzvZ26+jzuOXh79FYop4hgTcQe3zQfrsj4=;
        b=GHQNAgmatnOZmH4Je0XLmmF0zJd2u5G5an5iKZL+Ipfz6XCPanNZfUTVsmDrabwK2ikBkG
        0Hyv6acmKjak7A0l2FZJ3cXzCZ6uns8wm7b5vkYLG8Nuj7DnvaYqy+k81cWl+NvU4CW5cK
        d7i30h6XK47Wowy7QtzTj2+po7gYmhY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-WEU5GBywO2ii0uXV-Fw0IQ-1; Fri, 27 Mar 2020 05:07:01 -0400
X-MC-Unique: WEU5GBywO2ii0uXV-Fw0IQ-1
Received: by mail-wr1-f71.google.com with SMTP id c8so2355110wru.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=71Cru4C3vnzvZ26+jzuOXh79FYop4hgTcQe3zQfrsj4=;
        b=iATBKyaUCNG51eTi4Z42Yp3SqoRZa2kCgtPRe5yyxTVzhcFnkXmXaoimEzymj0iLfJ
         cIzF49X4PHY5iTZEYvmw2zeDRkdP0bGCHbsZOQ+Kq+Sf3lPPf22wZMqvQ0jfvxSQsp96
         138FGkmPTeMhSE1vPT7no1W+rx6dx6aCsSk/HpGNfln2aESr4MHySaiJBYqduYwJ31yK
         /3HVVrk9QG9Sjkjv1+kQAmIfj1VJfiYZTmhOGuxZXz9IiBjHM3xQ9QB3kh0JfzseUwOK
         Ha4I6w4JPCsnfiB69QIzfqlGF3jjyn3hbtov/k7HBYByYMUfXCNxH57tjL3m++QzAL1e
         Slzg==
X-Gm-Message-State: ANhLgQ0SMg56Y4SDrZW2BGhA7Bi5LTMQqVAtvpWl72iYFP0ntzwJhBYK
        FyXE47Z8N4G7nEAqcOtvcBi4s/J0YlzwRWcUJMjFK94DkZH7WNF1Wcnt+Mq551h0rfkeI1du1yw
        ibJDKQtfgIEip5pHhRI/atORj
X-Received: by 2002:a1c:456:: with SMTP id 83mr4350164wme.54.1585300020155;
        Fri, 27 Mar 2020 02:07:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtZ4qh8zvYAdJlTYjI7+wfGokNX7n+hK9IBSpYR6QPlJ9hK8Hp1qimejmKl24bCB91TTDz8pA==
X-Received: by 2002:a1c:456:: with SMTP id 83mr4350146wme.54.1585300019959;
        Fri, 27 Mar 2020 02:06:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b11sm7419945wrq.26.2020.03.27.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 02:06:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] KVM: LAPIC: Don't need to clear IPI delivery status for x2apic
In-Reply-To: <1585290240-18643-2-git-send-email-wanpengli@tencent.com>
References: <1585290240-18643-1-git-send-email-wanpengli@tencent.com> <1585290240-18643-2-git-send-email-wanpengli@tencent.com>
Date:   Fri, 27 Mar 2020 10:06:57 +0100
Message-ID: <87eete415a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> IPI delivery status field is not present for x2apic, don't need 
> to clear IPI delivery status for x2apic.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 3 ++-
>  arch/x86/kvm/x86.c   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 88929b1..f6d69e2 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1942,7 +1942,8 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>  	}
>  	case APIC_ICR:
>  		/* No delay here, so we always clear the pending bit */

'Always' in the comment above now reads a bit odd, I'd suggest modifying
it to 'Immediately clear Delivery Status field in xAPIC mode' - or just
drop it altogeter.

> -		val &= ~(1 << 12);
> +		if (!apic_x2apic_mode(apic))
> +			val &= ~(1 << 12);
>  		kvm_apic_send_ipi(apic, val, kvm_lapic_get_reg(apic, APIC_ICR2));
>  		kvm_lapic_set_reg(apic, APIC_ICR, val);
>  		break;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 495709f..6ced0e1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1562,7 +1562,6 @@ static int handle_fastpath_set_x2apic_icr_irqoff(struct kvm_vcpu *vcpu, u64 data
>  		((data & APIC_MODE_MASK) == APIC_DM_FIXED) &&
>  		((u32)(data >> 32) != X2APIC_BROADCAST)) {
>  
> -		data &= ~(1 << 12);
>  		kvm_apic_send_ipi(vcpu->arch.apic, (u32)data, (u32)(data >> 32));
>  		kvm_lapic_set_reg(vcpu->arch.apic, APIC_ICR2, (u32)(data >> 32));
>  		kvm_lapic_set_reg(vcpu->arch.apic, APIC_ICR, (u32)data);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

