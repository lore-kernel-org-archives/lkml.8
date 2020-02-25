Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33762C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFC621744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERzYkvnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgBYOKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:10:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34536 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729386AbgBYOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582639837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJJoWuth8QbpTnsnD04jwK92kDVW6k9Hdy8WzY5Xvx4=;
        b=ERzYkvnI48Px9DMruy1utbY/YqLXTI2Ij6SQH+WoVKfb5KQ4zu7Yk/StB/LxUAOvRiptXy
        m+Pxy2B4VNoMwS0Av+Yec78gAhCD0D1iztWKtGcZpi7PWBvUG3NKE5QN5/ALWL+2Bd2Na6
        9n+g3rf15WM55Rd6vlaQk9wIwF5Fb14=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-zr-iCqlPOrC3ZEgBY3dciw-1; Tue, 25 Feb 2020 09:10:35 -0500
X-MC-Unique: zr-iCqlPOrC3ZEgBY3dciw-1
Received: by mail-wr1-f70.google.com with SMTP id r1so7346867wrc.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bJJoWuth8QbpTnsnD04jwK92kDVW6k9Hdy8WzY5Xvx4=;
        b=TlsIy/ae5XMW76lMs/OuQyCe9NGbHLVuT+2wer0SVmBa/aSR5yQ/zBgjMS3v2x6Vf6
         Py8ye4j4QxPnKAOR4fU2z8Ywbp+0DxWfdN3NRqukNrFVlLP1JhmxeDrgOFDTkHZ+kmGC
         DJibLNCKQMTwDnUWjiewfOzlX47QM+XEjHh6jrZQIlf2IfOTHCtuFJN3F10Uh0+B4Dgw
         wG6pmluLBgabte2W/RKrEe8ILJkXzkoo2wM0oY73Q3U+F6n3x8bScSyUYY9D+oCVjcGr
         nrWJJ5taMZ+yLf7VQS/MqR+Qk5xBc8uImlShVRnBJUpeqRrZopdGFgr6k/lFCJPhRRSj
         7bxQ==
X-Gm-Message-State: APjAAAWp9LZ61L4cawSghD/gk/vDQwgYwTRdJ5EafIsqcttHucmLljqm
        x1lu2gd0d9RpoYNs8hg9eLCV9hbr1ugxpEY0zqND4wdXWBm1vutg1aAjqc0tXVcD4G8VVqLoMok
        e0UEefmg3joIY5UT9v2OlfoE2
X-Received: by 2002:adf:80cb:: with SMTP id 69mr69878679wrl.320.1582639833816;
        Tue, 25 Feb 2020 06:10:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCkU2zj4QT64VJRCvumUqbgag/wgbT3Dvdebf3V4A+WrmdWNFreecb/1BXJJIvkYPXUEvNkQ==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr69878666wrl.320.1582639833593;
        Tue, 25 Feb 2020 06:10:33 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm23118178wrw.54.2020.02.25.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:10:33 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 53/61] KVM: VMX: Directly use VMX capabilities helper to detect RDTSCP support
In-Reply-To: <20200201185218.24473-54-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-54-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:10:32 +0100
Message-ID: <87pne2lpuv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use cpu_has_vmx_rdtscp() directly when computing secondary exec controls
> and drop the now defunct vmx_rdtscp_supported().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c3577f11f538..98d54cfa0cbe 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1651,11 +1651,6 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
>  	vmx_clear_hlt(vcpu);
>  }
>  
> -static bool vmx_rdtscp_supported(void)
> -{
> -	return cpu_has_vmx_rdtscp();
> -}
> -
>  /*
>   * Swap MSR entry in host/guest MSR entry array.
>   */
> @@ -4051,7 +4046,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
>  		}
>  	}
>  
> -	if (vmx_rdtscp_supported()) {
> +	if (cpu_has_vmx_rdtscp()) {
>  		bool rdtscp_enabled = guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP);
>  		if (!rdtscp_enabled)
>  			exec_control &= ~SECONDARY_EXEC_RDTSCP;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

