Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66B020738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvB4og2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFDNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:21:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728055AbgFDNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591276862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2fWETB1TaNz9IcATv1ANUA4w7IHk/OTfNxTX41Bqeg=;
        b=PvB4og2TOzj5qwdYk3CDaiq1WdmJsO37XTIrZ3umw5OVQ5g/IF4V0IU4Nvo7IHUoBKnuV6
        vzkdVRTEjTeAp5jcc7NmsHr+Kb+Y6v9BeTtDtxBs2nIHDaT74kasZvQGDsM88AGVt21aDr
        SAIK7xxOuKOTElycGUJGmD4dLQpOZvs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-u_ahNwG3OYCQdm83nMB-4w-1; Thu, 04 Jun 2020 09:20:57 -0400
X-MC-Unique: u_ahNwG3OYCQdm83nMB-4w-1
Received: by mail-wr1-f72.google.com with SMTP id w16so2416956wru.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w2fWETB1TaNz9IcATv1ANUA4w7IHk/OTfNxTX41Bqeg=;
        b=glkq+DFdQQ7MN6hiGiAO5XCJm+EtO8Jl94T4hmdA2LGcN/D9t77ntHVcYNy2oxqAiR
         U4hbI86RCNkKDF05Bu/ONvHlS9Rklp90+1T5Md7OIxCLR+XEOwhOFZ0fH4E4YajTrqEd
         VhSaKy1jRqqo06Bm/5AMYDHxsJY8DOlcD5Q9QzgPgeDec/V7yE+Tg5e6iId3O2RdMfN3
         IZKYs+NQRuOXQV8lxavAnKz7yXsg8FmLrIJv4MIrJlnv8d+sOz8oSW1rORADw42u0YSk
         Hgc9rVDiaVEF4rQft0+kxQDwyPM3Gn3FZPC6eakSHWTmEjNgmMY1KO6WEV87WgXRmbkv
         uaog==
X-Gm-Message-State: AOAM5308H3+v7g5SVqx75J4di/QeY0HvYvEAeRDQUFzzqKSOnTGJKSoc
        9UmLo1AmJCGXIHPMiMkcofAXibXb/1+nlz38Nr6+TDOfmMk1QYxlFzomHxFpBBaQfNkFaryQq1x
        lae1VAONYNLHhqTxJEX+M7u6j
X-Received: by 2002:adf:fec8:: with SMTP id q8mr4638998wrs.2.1591276855840;
        Thu, 04 Jun 2020 06:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7bVhcWIgCtyiIS/HcBgCGmNBSEIn+XtgiwQg8Y7cLzf42w5pKcKysY6nUP5xQe0z5YU0Inw==
X-Received: by 2002:adf:fec8:: with SMTP id q8mr4638981wrs.2.1591276855606;
        Thu, 04 Jun 2020 06:20:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id a1sm7316698wmj.29.2020.06.04.06.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:20:54 -0700 (PDT)
Subject: Re: WARNING in kvm_inject_emulated_page_fault
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        sean.j.christopherson@intel.com
Cc:     syzbot <syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wanpengli@tencent.com, x86@kernel.org
References: <000000000000c8a76e05a73e3be3@google.com>
 <874krrf6ga.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c15b3ad0-0062-f106-0746-d018cf33adbb@redhat.com>
Date:   Thu, 4 Jun 2020 15:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <874krrf6ga.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 12:53, Vitaly Kuznetsov wrote:
> Exception we're trying to inject comes from
> 
>  nested_vmx_get_vmptr()
>   kvm_read_guest_virt()
>    kvm_read_guest_virt_helper()
>      vcpu->arch.walk_mmu->gva_to_gpa()
> 
> but it seems it is only set if GVA to GPA convertion fails. In case it
> doesn't, we can still fail kvm_vcpu_read_guest_page() and return
> X86EMUL_IO_NEEDED but nested_vmx_get_vmptr() doesn't case what we return
> and does kvm_inject_emulated_page_fault(). This can happen when VMXON
> parameter is MMIO, for example.
> 
> How do fix this? We can either properly exit to userspace for handling
> or, if we decide that handling such requests makes little sense, just
> inject #GP if exception is not set, e.g. 
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9c74a732b08d..a21e2f32f59b 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4635,7 +4635,11 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer)
>                 return 1;
>  
>         if (kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e)) {
> -               kvm_inject_emulated_page_fault(vcpu, &e);
> +               if (e.vector == PF_VECTOR)
> +                       kvm_inject_emulated_page_fault(vcpu, &e);
> +               else
> +                       kvm_inject_gp(vcpu, 0);
> +
>                 return 1;
>         }
> 

Yes, this is a plausible fix (with a comment explaining that we are 
taking a shortcut).  Perhaps a better check would be 

	r = kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e);
	if (r != X86EMUL_CONTINUE) {
		if (r == X86EMUL_PROPAGATE_FAULT) {
			kvm_inject_emulated_page_fault(vcpu, &e);
		} else {
			/* ... */
			kvm_inject_gp(vcpu, 0);
		}
		return 1;
	}

Are you going to send a patch?

Paolo

