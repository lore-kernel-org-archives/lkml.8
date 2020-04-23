Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B36C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E78214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZsxJbTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgDWJkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:40:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbgDWJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587634829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3ygCTnYu/wlHXxWXOoaGQbutWunwVNrFgGVQyQXUr0=;
        b=UZsxJbTkkSth9DFtMA1BaOEOBs7v1Y0ICoJZHgSYjxjmJHZSOPMBfdqKd4gkYQrLy/Ksx3
        G07XRGZH01/K2fgdBLzIyVl9+K/bk90fG2+qxG+CS//8MrLBsf4Hddgdk0eLK371tRMH6w
        anDjnH1SC5931yp1F3Z3BxeGb9B5G/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-e_LH8LoAMVSUe7s3rANEhg-1; Thu, 23 Apr 2020 05:40:28 -0400
X-MC-Unique: e_LH8LoAMVSUe7s3rANEhg-1
Received: by mail-wr1-f72.google.com with SMTP id p16so2572966wro.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3ygCTnYu/wlHXxWXOoaGQbutWunwVNrFgGVQyQXUr0=;
        b=W6YKznXoOI62HTQhixqMScsZEL9CdUEerYNSKyImVM5ac4IlZCStmztPCTYqo3GSAO
         gSPvlAjlPO4j46PHeQVK7DMGyTQtwLNRNFVWGlLZCpEVDtPsXJyTtmakSHB96h6HUTlg
         edigJ95ffrVbclstjlw07WcZkWbQtChycX2DVh5/WnOy/5P+1P68imL01qHxBwmFklYM
         MHuZiv+QTwoK624gZY+pCf+bTnQmk1iMS+YfhAUzSziYqwP1ElE6K2foWvhiJhOxWgZN
         iYm5vbx+Wt2KuJo8wkNPM5WKiZPX1e4WlfqwjWba7mZciGbCDRjXq0Bx4U3WsWwv/V/f
         2VnA==
X-Gm-Message-State: AGi0PuaZoj8g5vNjreD0Lt8A+kWqbL4ic6UqSJTR4uq8nEE/09T5mEY/
        4pPod7JnlD95T2T3zWVzXtinCo+oM48UeCSfSpp3V5tOUSWciy/Y3y7OmUx5NzZHNzbIZIHHRhD
        J4q4zSuYznjXZNGIXiEZvuIuB
X-Received: by 2002:a05:600c:2341:: with SMTP id 1mr3045515wmq.153.1587634826801;
        Thu, 23 Apr 2020 02:40:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypI5nDN9Dp9bQCt/hSG35BrUOAHLEb9eZzK5+7BCQXTdDq2vMBThkHU8kWWVihCu3FLU21shzg==
X-Received: by 2002:a05:600c:2341:: with SMTP id 1mr3045499wmq.153.1587634826607;
        Thu, 23 Apr 2020 02:40:26 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id z1sm2881789wmf.15.2020.04.23.02.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:40:26 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] KVM: VMX: Handle preemption timer fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-6-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99d81fa5-dc37-b22f-be1e-4aa0449e6c26@redhat.com>
Date:   Thu, 23 Apr 2020 11:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587632507-18997-6-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 11:01, Wanpeng Li wrote:
> +bool kvm_lapic_expired_hv_timer_fast(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_lapic *apic = vcpu->arch.apic;
> +	struct kvm_timer *ktimer = &apic->lapic_timer;
> +
> +	if (!apic_lvtt_tscdeadline(apic) ||
> +		!ktimer->hv_timer_in_use ||
> +		atomic_read(&ktimer->pending))
> +		return 0;
> +
> +	WARN_ON(swait_active(&vcpu->wq));
> +	cancel_hv_timer(apic);
> +
> +	ktimer->expired_tscdeadline = ktimer->tscdeadline;
> +	kvm_inject_apic_timer_irqs_fast(vcpu);
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(kvm_lapic_expired_hv_timer_fast);

Please re-evaluate if this is needed (or which parts are needed) after
cleaning up patch 4.  Anyway again---this is already better, I don't
like the duplicated code but at least I can understand what's going on.

Paolo

