Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC7EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F3420663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJzRMXx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQRSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:18:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33260 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgCQRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584465523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g5XpwPdHQEwJufVi+3YndUETigdnZ6TaIE8j53RUJmw=;
        b=aJzRMXx4qERbBby4r9AQjGZp9DB8Gt7zZElT68tTezXqekP7LC5Y4ntLI7194WJy5jaBYi
        opl7ATkqt0TX1p3iS+YCsb6o4eF5FACWSbicvZHWovldoL6guqiuLGHQ9uNw12Rm/8LuyN
        E9cIx2/Qr4MOdS+yRtVEN36UkdQggtU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-nE4eCg_FOhiE8t0P0W2n4g-1; Tue, 17 Mar 2020 13:18:41 -0400
X-MC-Unique: nE4eCg_FOhiE8t0P0W2n4g-1
Received: by mail-wr1-f70.google.com with SMTP id o9so11003364wrw.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5XpwPdHQEwJufVi+3YndUETigdnZ6TaIE8j53RUJmw=;
        b=ed00KU6dviMzhShAV77FkCjOm6k9K3pHj+EIcNEOV+ESEqMFXvsvAeBxIod1zX6OEk
         TcKkwhCVcWPgNYrtexf2Mzrah5dkuKRVmeFFWY+wj7qB11DTB/Ifcc2zvX3mJMuN1rXq
         znpXsctaJ8T8re8ZfPuuCZp/05aaUNgAiwn+j9WLfkyM3YNOW68hmiZkTQBMv4kPR0WX
         8OL3qZNCzM+7ebJVP1R7HVNDl/4lYHPArec2jZIzTxGApu6tc/l/s4R2oTwnWxJRDCbg
         5GoWUeRKZPTrKD6tKb/g7Uj8dwf1E2L1iLX9AgiInmXbcp7G1YOohnk0iM9rGxwPPKdp
         2mvA==
X-Gm-Message-State: ANhLgQ3Y4Gynr6LH0/8pkCb/gl52BhKiX2NhIfa6CRmOEA/7e8eGcrZZ
        +q2oBBvO5CWXcVppcqKc2Rczo5Xu85LxWVXh+rG/wggVcZJPNNrO3RzfZ3x+ZhHfbVTceeUhPTm
        SBYn/XK8IH7Bm4v0OqhLriGRC
X-Received: by 2002:a7b:c341:: with SMTP id l1mr67445wmj.146.1584465520443;
        Tue, 17 Mar 2020 10:18:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtzzek2Rz3ChXItSdk+lQxOau9MzPKMaLEjYAxMfONZx6YbAwlKCBYgiLOLumRQXRY2A42boA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr67427wmj.146.1584465520187;
        Tue, 17 Mar 2020 10:18:40 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
        by smtp.gmail.com with ESMTPSA id o3sm92469wme.36.2020.03.17.10.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:18:39 -0700 (PDT)
Subject: Re: [PATCH v2 31/32] KVM: nVMX: Don't flush TLB on nested VM
 transition with EPT enabled
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200317045238.30434-1-sean.j.christopherson@intel.com>
 <20200317045238.30434-32-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97f91b27-65ac-9187-6b60-184e1562d228@redhat.com>
Date:   Tue, 17 Mar 2020 18:18:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317045238.30434-32-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 05:52, Sean Christopherson wrote:
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index d816f1366943..a77eab5b0e8a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1123,7 +1123,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
>  	}
>  
>  	if (!nested_ept)
> -		kvm_mmu_new_cr3(vcpu, cr3, false);
> +		kvm_mmu_new_cr3(vcpu, cr3, enable_ept);

Even if enable_ept == false, we could have already scheduled or flushed
the TLB soon due to one of 1) nested_vmx_transition_tlb_flush 2)
vpid_sync_context in prepare_vmcs02 3) the processor doing it for
!enable_vpid.

So for !enable_ept only KVM_REQ_MMU_SYNC is needed, not
KVM_REQ_TLB_FLUSH_CURRENT I think.  Worth adding a TODO?

Paolo

>  	vcpu->arch.cr3 = cr3;
>  	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
> -- 2.24.1

