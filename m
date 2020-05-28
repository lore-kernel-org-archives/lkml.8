Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8D320888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cglb7SE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbgE1Lja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:39:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388392AbgE1Lj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590665966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tU/P76gUgCUjIYLmfhLoBs07Rafiz+cVEPVVpjAFAAk=;
        b=Cglb7SE0sTjcpsSBBGlNHAR5TN4Lc4W8bzWMS1OyFTXs0qEJwCXz1Cyy/DoXiPAC4I/RTc
        E+Uoke5q3hJrg5aUAcz1xmCm2jdzoRb9xIMKLhqZ1UTfBa3fM4i1LbM+lgXsYL+Mn2iJ30
        8ap2dJzkXwjzaAK/L7ArSbvzKOHQ0II=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-XYRcPQTxM6iHkNXUMsGsmQ-1; Thu, 28 May 2020 07:39:25 -0400
X-MC-Unique: XYRcPQTxM6iHkNXUMsGsmQ-1
Received: by mail-ed1-f70.google.com with SMTP id c10so11361034edw.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tU/P76gUgCUjIYLmfhLoBs07Rafiz+cVEPVVpjAFAAk=;
        b=mc2YudK+ySJ7KIyN4swZQoP9mseTK93kdfyxxtjHmYxGeRBL7egO5vexNUL2nLI8kz
         XnBZ+LC0mwWVGDcCUoBNX+GSW+d8rxdJjFr/pDLwnS/0dVbbWHzDs/g6pwtQEXgEFWJ9
         0QflzcVCJrnwhXJ+Bpgi/BAnPDjMzLchbRFN+R5BJKkyvs86PyDJMmqhYrkl1OjanIZM
         cTag5ZMzAv6rweAEAn7XaQEBVJWUNfcLIFhTQAZ0Gz6MRXk4Wt6B+nQBerGTMXBaHptJ
         CAmbNE0Dw6GyrfhdOD4S2AAYY9ySOnobp+JlNE71PtpMOxS/uwXb02yKn9VWIEKhkXsI
         MjjA==
X-Gm-Message-State: AOAM531YGQeON7P4RBX4dga+Tho3fxWhC+ICScEMuVBYgY10VCPkkAzb
        NzdRCfqfOcy0CQNDe3KgN7Y/0ybbDNYevaGLL0WwYcMgjlt1WnPo5E2nQ2KQWql2hF8jYuPmJqn
        dC/01tOi8jtQZxBT7WMOKcauM
X-Received: by 2002:aa7:c887:: with SMTP id p7mr2576191eds.269.1590665963639;
        Thu, 28 May 2020 04:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAC0sFE6cKf2uAh541PEavwlw1Pez2X0cPDx1gikDvelrU7CmH5jbuidUWxsG3tn4K+fXDuQ==
X-Received: by 2002:aa7:c887:: with SMTP id p7mr2576164eds.269.1590665963456;
        Thu, 28 May 2020 04:39:23 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i4sm4671308eja.92.2020.05.28.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:39:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] KVM: x86: acknowledgment mechanism for async pf page ready notifications
In-Reply-To: <f9d32c25-9167-f1a7-cda7-182a785b92aa@redhat.com>
References: <20200525144125.143875-1-vkuznets@redhat.com> <20200525144125.143875-7-vkuznets@redhat.com> <f9d32c25-9167-f1a7-cda7-182a785b92aa@redhat.com>
Date:   Thu, 28 May 2020 13:39:21 +0200
Message-ID: <87wo4w2sra.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/05/20 16:41, Vitaly Kuznetsov wrote:
>> +	case MSR_KVM_ASYNC_PF_ACK:
>> +		if (data & 0x1) {
>> +			vcpu->arch.apf.pageready_pending = false;
>> +			kvm_check_async_pf_completion(vcpu);
>> +		}
>> +		break;
>>  	case MSR_KVM_STEAL_TIME:
>>  
>>  		if (unlikely(!sched_info_on()))
>> @@ -3183,6 +3189,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_KVM_ASYNC_PF_INT:
>>  		msr_info->data = vcpu->arch.apf.msr_int_val;
>>  		break;
>> +	case MSR_KVM_ASYNC_PF_ACK:
>> +		msr_info->data = 0;
>> +		break;
>
> How is the pageready_pending flag migrated?  Should we revert the
> direction of the MSR (i.e. read the flag, and write 0 to clear it)?

The flag is not migrated so it will be 'false'. This can just cause an
extra kick in kvm_arch_async_page_present_queued() but this shouldn't be
a big deal. Also, after migration we will just send 'wakeup all' event,
async pf queue will be empty. MSR_KVM_ASYNC_PF_ACK by itself is not
migrated, we don't even store it, not sure how invering it would change
things.

-- 
Vitaly

