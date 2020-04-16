Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69307C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B7021D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fE2lTEaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393800AbgDPOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:36:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24085 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390697AbgDPOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587046451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwfafyNJV35A9XzjzoUpov1lD8f8Bo7599mF7Sou/xg=;
        b=fE2lTEaqz8zhmfu90wq7qSv1ZUI60vc6URs/I0F6CH/KwjmfULnVG5ZmD6QK4o/kiMSvdP
        UVZRWhGcYlOsTaeJzaM58UN/NvLVGF/kX6Xa152BDU/5yLN4iXvAiUgLiSHJncYNZGaKS6
        CIZakVAR/dQKpBW2h7ZefUN81rmRPkY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-D5ew2p0iMEOGkNcz7RvQ9A-1; Thu, 16 Apr 2020 10:14:10 -0400
X-MC-Unique: D5ew2p0iMEOGkNcz7RvQ9A-1
Received: by mail-wm1-f72.google.com with SMTP id c196so1245311wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZwfafyNJV35A9XzjzoUpov1lD8f8Bo7599mF7Sou/xg=;
        b=gGqSROjDlvljXLg/qPI1F6yvzyYJQla9E50oNUukmdTNy0d0yLbV2OITX0SZdVmrBw
         yN1AaXXRl2ehnSbsCIW6WjSeqidlK3H8CjX1L3LcSnnQkvRw779RTqoAcFww7k/KeEDn
         N0O4imoSJIYzTfGCfEoYQsArii8D8V9GU+NTgCNjWE1ohoBjNMVCsLhswKrSkfYYDenH
         mgSWv//stLW+bm1IcyisHHAbo71UEDanJj8Ojhv8Z3h5JjPIEvqPhLSWqBY4KE1+rAfM
         usB289UvM5//Tw8tdOaph/sgHGaBvl0rF3qL2Afpmv+CidV4hOQgKXmmf+XIrXYECqWz
         PGUA==
X-Gm-Message-State: AGi0PuZavsDkfNCVGGUT5aeRGambvGHjShAT2Ka681mYt/mdybXioabs
        py1a+ryQ4KFGtvkjSpnlgjaM5ywKYihlrNhrULlMDN6JYu91KL0UmFIXWz/CUE+SYp1HKfVV7+Y
        A+CmhFcMaQA/KC/y8X4I3Qj+2
X-Received: by 2002:a7b:c941:: with SMTP id i1mr4761807wml.132.1587046446917;
        Thu, 16 Apr 2020 07:14:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ5Hb6SR8Fvh2FXPLrhFm6KxJHb0F0gaOopm4Hzze+cRXgN3/biIfKsxemtqaSiStUFpWNlMQ==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr4761786wml.132.1587046446638;
        Thu, 16 Apr 2020 07:14:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id l16sm12705971wrp.91.2020.04.16.07.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 07:14:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Disable Intel PT before VM-entry
To:     "Kang, Luwei" <luwei.kang@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>
References: <1584503298-18731-1-git-send-email-luwei.kang@intel.com>
 <20200318154826.GC24357@linux.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738A9724@SHSMSX104.ccr.corp.intel.com>
 <20200330172152.GE24988@linux.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B1A1C@SHSMSX104.ccr.corp.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21fa3505-8198-5f32-9dfd-3c9d9cc5ef7e@redhat.com>
Date:   Thu, 16 Apr 2020 16:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E1738B1A1C@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/20 05:29, Kang, Luwei wrote:
>> Ah, right.  What about enhancing intel_pt_handle_vmx() and 'struct
>> pt' to replace vmx_on with a field that incorporates the KVM mode?
>
> Some history is the host perf didn't fully agree with introducing
> HOST_GUEST mode for PT in KVM.

I don't think this is accurate.  IIRC the maintainers wanted packets in 
the host-side trace to signal where the trace was interrupted.  In the 
end we solved the issue by 1) dropping host-only mode since it can be 
achieved in userspace 2) making host-guest an opt in feature.

I think it would make sense to rename vmx_on into vmx_state and make it an

enum pt_vmx_state {
	PT_VMX_OFF,
	PT_VMX_ON_DISABLED,
	PT_VMX_ON_SYSTEM,
	PT_VMX_ON_HOST_GUEST
};

KVM would pass the enum to intel_pt_handle_vmx (one of PT_VMX_OFF, 
PT_VMX_ON_SYSTEM, PT_VMX_ON_HOST_GUEST).  Inside intel_pt_handle_vmx you 
can do

	if (pt_pmu.vmx) {
		WRITE_ONCE(pt->vmx_state, state);
		return;
	}

	local_irq_save(flags);
	WRITE_ONCE(pt->vmx_state,
		   state == PT_VMX_OFF ? PT_VMX_OFF : PT_VMX_ON_DISABLED);
	...

and in pt_config_start:

	...
	vmx = READ_ONCE(pt->vmx_start);
	if (vmx == PT_VMX_ON_DISABLED)
                perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
        else if (vmx == PT_VMX_ON_SYSTEM ||
		 !(current->flags & PF_VCPU))
                wrmsrl(MSR_IA32_RTIT_CTL, ctl);
	...

Thanks,

Paolo

