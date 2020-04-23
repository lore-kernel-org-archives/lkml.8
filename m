Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CB3C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4D12076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA27skT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDWJZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:25:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59601 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgDWJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587633905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=do8zJdc7I4uHXHEben8lWabWs6HgpJn+cw0sGKbh2zc=;
        b=IA27skT5UHBBlazwPOyGuCxq3BNUM2Iv84uGXyrC4Py7l7I1QcZNdL7QfNhZ9J3QZBBo8d
        WU3mbJEzu+izGEAu+jRMvcCvBBU/AmfCnYAblQCNrtfUZJxLAAoGqAz2hK+hBQSV4vM+aR
        Ct8gxxncjgW4JfuaPwAJu/tByWABTNE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-ekMwkEZ0PtmWCLZr-fo10w-1; Thu, 23 Apr 2020 05:25:04 -0400
X-MC-Unique: ekMwkEZ0PtmWCLZr-fo10w-1
Received: by mail-wr1-f72.google.com with SMTP id m5so2554093wru.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=do8zJdc7I4uHXHEben8lWabWs6HgpJn+cw0sGKbh2zc=;
        b=YVM1TLSUFyuk4HE3auIA1WJ8v/f2aUAizRyCRSSY1OFCRMCkLGalp+FDk6/EAKCX3t
         LmwHOb19zPMBq2wX7RduC8GLEY04bhjIrozsIlzMY3SInE2mmj6WgxGSBnsE/lqNpe1z
         qwTCBI2uqaTBiiEI3Msw7PHPv64Oy+GNManBdHMJN17cCNzi1H3OKpw7cQlGxK5S0vkV
         tDrRGHKl8+lj2/xayKbSCEyTgDOIbqt4lxbKTF9h7mmKgCGo0UFDdrF/8n48jOaDD82a
         Oz5wl4vPV8rCEDZ8Nkq3fl8Stax2Ssszgu4wVmq4KNPLmbZneHTfv6cVlftH5rwNEqLQ
         IeoA==
X-Gm-Message-State: AGi0PuaNarrSegvymqj5YP1FSrO+pUJBkAcFZ9UyyD2YgbZFtNKJ8k3p
        nCi/zEaumdu/i7qBT3IxOaraFIia6kzt0bzZRB9pTNBL6AurY9DR39hDqPfi5ZFdSL6E0IDnTKM
        37xx9kfZf4VwsGAje0gCIcI99
X-Received: by 2002:adf:f648:: with SMTP id x8mr3763901wrp.257.1587633902901;
        Thu, 23 Apr 2020 02:25:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfSJ+2+dBWEkydp4auYku0fYvTDUrKMch6QWddxKWBQoac935UdKFUm+uuf3gEakhZSfBc3w==
X-Received: by 2002:adf:f648:: with SMTP id x8mr3763873wrp.257.1587633902615;
        Thu, 23 Apr 2020 02:25:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id t16sm3114627wrb.8.2020.04.23.02.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:25:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] KVM: LAPIC: Introduce interrupt delivery fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09cba36c-61d8-e660-295d-af54ceb36036@redhat.com>
Date:   Thu, 23 Apr 2020 11:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587632507-18997-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 11:01, Wanpeng Li wrote:
> +static void fast_deliver_interrupt(struct kvm_lapic *apic, int vector)
> +{
> +	struct kvm_vcpu *vcpu = apic->vcpu;
> +
> +	kvm_lapic_clear_vector(vector, apic->regs + APIC_TMR);
> +
> +	if (vcpu->arch.apicv_active) {
> +		if (kvm_x86_ops.pi_test_and_set_pir_on(vcpu, vector))
> +			return;
> +
> +		kvm_x86_ops.sync_pir_to_irr(vcpu);
> +	} else {
> +		kvm_lapic_set_irr(vector, apic);
> +		if (kvm_cpu_has_injectable_intr(vcpu)) {
> +			if (kvm_x86_ops.interrupt_allowed(vcpu)) {
> +				kvm_queue_interrupt(vcpu,
> +					kvm_cpu_get_interrupt(vcpu), false);
> +				kvm_x86_ops.set_irq(vcpu);
> +			} else
> +				kvm_x86_ops.enable_irq_window(vcpu);
> +		}
> +	}
> +}
> +

Ok, got it now.  The problem is that deliver_posted_interrupt goes through

        if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
                kvm_vcpu_kick(vcpu);

Would it help to make the above

        if (vcpu != kvm_get_running_vcpu() &&
	    !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
                kvm_vcpu_kick(vcpu);

?  If that is enough for the APICv case, it's good enough.

Paolo

