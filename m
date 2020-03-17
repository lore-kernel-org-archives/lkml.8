Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2978C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91F120663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PevM1FrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQRSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:18:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29342 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgCQRSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584465484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXUpo1ZhaHsxegJLjY6D/kOQQn485KZpkhgRPPqUjR0=;
        b=PevM1FrTcCIEG9DJITqOVjrv7tYqJNaiyOQDckZNUSh7c+x9tlBcQFTByYH3iATnFnjxWA
        fFvjrouUwMVjTgSS5NYjC0i+RWTCbljJShdVJQeWN46kQu+KjvXEAhdLptgwtSTZsknGND
        LcTsiC8/zMQY9WJx1or68y0Wwo/LEn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-LYImmRONN8-4JHKekiTHeg-1; Tue, 17 Mar 2020 13:18:02 -0400
X-MC-Unique: LYImmRONN8-4JHKekiTHeg-1
Received: by mail-wm1-f70.google.com with SMTP id 20so39780wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXUpo1ZhaHsxegJLjY6D/kOQQn485KZpkhgRPPqUjR0=;
        b=DkzlYvudlobTXk4sFdZPly9ZrS6PXHmvLVYnQbsEBx6/BpCX1mC2TuT4wLGkBrjPuU
         AwCKeFIjknVerUUIoSBP11zRFjH9tm2UR4whYA8aeCEdmVVYN7kf+RxSLrZAHajubK1P
         0REPgZ1KyVwWpxwn5jMzVEZwLdaJvcNU94a/5jkYM26MNHFOCuP8h53R/5TbOB4HcY/3
         6pP9a8yS49AV7WZ2HzdYSt274WUXic29aAd3se2mdTRitzXX4+nnJ/LOm9fvpIoMlnGp
         Jw1Y8w8Cf6C/BRhkuc6xid+UbU/3cN9YAYg084RvbKjNlX/fm59fNPVtZER+DQ557C5S
         ifYg==
X-Gm-Message-State: ANhLgQ2tpwf6ZNGzmpoSyyQ3Hc9QlMbBT/2s6O3WbqVpUh+TkaB3dWVG
        cILC+WqCi30kiqB6yswTRW/0K9sERab0XDtBFVPlEUAyLs8mCS2kTGYjv9+qWn03kIhHZOm6rSl
        hrorzIc4C4mTEaZLZ7FW362NB
X-Received: by 2002:a7b:c115:: with SMTP id w21mr68905wmi.158.1584465481605;
        Tue, 17 Mar 2020 10:18:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuKYTV/Kjwq397PdHeEtnqiG4fFlpYodL/S4xQgC/bL3dV7vsEF/9gjXQGnOI/m6nnmoB/C1A==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr68878wmi.158.1584465481345;
        Tue, 17 Mar 2020 10:18:01 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
        by smtp.gmail.com with ESMTPSA id z6sm5095665wrp.95.2020.03.17.10.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:18:00 -0700 (PDT)
Subject: Re: [PATCH v2 23/32] KVM: nVMX: Add helper to handle TLB flushes on
 nested VM-Enter/VM-Exit
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
 <20200317045238.30434-24-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0975d43f-42b6-74db-f916-b0995115d726@redhat.com>
Date:   Tue, 17 Mar 2020 18:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317045238.30434-24-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 05:52, Sean Christopherson wrote:
> +	nested_vmx_transition_tlb_flush(vcpu, vmcs12);
> +
> +	/*
> +	 * There is no direct mapping between vpid02 and vpid12, vpid02 is
> +	 * per-vCPU and reused for all nested vCPUs.  If vpid12 is changing
> +	 * then the new "virtual" VPID will reuse the same "real" VPID,
> +	 * vpid02, and so needs to be sync'd.  Skip the sync if a TLB flush
> +	 * has already been requested, but always update the last used VPID.
> +	 */
> +	if (nested_cpu_has_vpid(vmcs12) && nested_has_guest_tlb_tag(vcpu) &&
> +	    vmcs12->virtual_processor_id != vmx->nested.last_vpid) {
> +		vmx->nested.last_vpid = vmcs12->virtual_processor_id;
> +		if (!kvm_test_request(KVM_REQ_TLB_FLUSH, vcpu))
> +			vpid_sync_context(nested_get_vpid02(vcpu));
>  	}

Would it make sense to move nested_vmx_transition_tlb_flush into an
"else" branch?  And should this also test that KVM_REQ_TLB_FLUSH_CURRENT
is not set?

Paolo

