Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6CC35659
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5D3222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXtayFz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBURc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:32:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57284 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgBURc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582306376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o96Yvzi87DPePCMyKdFlIusrR00b35JbPu9d8slr560=;
        b=aXtayFz7oDLrtuZJ+w0OlOjX68eTYuW+goE4UL0e3dRX49/AzAj7JLe+nVcYcZcLDcYFT9
        ZI3krBdLn2WCKkWA1bvCSvXSHOErP/i+55lqcOh9C0cqQoiXQ+thf/PZhCffNpXAA7NDM3
        D3Gu//70az2lDvq98rqOYtUKQ5WMmPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-DVqGwWi5N-ie9CRVQ2YvHw-1; Fri, 21 Feb 2020 12:32:54 -0500
X-MC-Unique: DVqGwWi5N-ie9CRVQ2YvHw-1
Received: by mail-wm1-f69.google.com with SMTP id b205so907599wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o96Yvzi87DPePCMyKdFlIusrR00b35JbPu9d8slr560=;
        b=SLh8ybAhFKClg+k0gcmt+tSYijUihWxx49zv2jRkQaYq/ndKMKwGl8JgQEm5gEg1VX
         b/1nlWC+lvr1AIlkpOhePqJv2QM5Hain69EUEClrUqwKnfk+nVGUWb9GDHcmq2iG3MqV
         NkcV+HjFqfUFce9ad2wJ3QKcxjfMdq16XZ/AR+SRkYqaCHMLVITXCwQNzAmXwsNvWS/j
         /JsC7vSUXjGzFoZuGOIR58WZwFop4RDbRQtz1nIkH1nZ8MamVBI5QQQUEFUCaq51ySEt
         Y1sMPVEXtVXqQuPlKSLtOCaWjh5cc40nx3nV8UWpnMvwl4454MWBm83AkteBHAMBiWkB
         KHxQ==
X-Gm-Message-State: APjAAAW1CeB+F7HtDNqG64qwzZqMKvLtHFxKs+OtPhAosfGVZz4m6Ufe
        vQCq4pJSNTakXEvjiRQg+nfPGJA/i1JN7sul2VvxqqE9a/8uE9xJGGriOu9NCMXdSq2Q7WIVMK4
        c+qkLbCElDlR5KMcGWituElHO
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr4955226wme.25.1582306373146;
        Fri, 21 Feb 2020 09:32:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxayLNZ1h9vLVc5mYWPuuY1cdEKYHllZpJcPEvt3/MdMtEG+xA001YejVgYA0jVDbPLZm/vlg==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr4955201wme.25.1582306372831;
        Fri, 21 Feb 2020 09:32:52 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id x11sm4493300wmg.46.2020.02.21.09.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:32:52 -0800 (PST)
Subject: Re: [PATCH 06/10] KVM: x86: Move "flush guest's TLB" logic to
 separate kvm_x86_ops hook
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200220204356.8837-1-sean.j.christopherson@intel.com>
 <20200220204356.8837-7-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca7bcbc2-d7eb-bc7c-4e15-a77831af8a73@redhat.com>
Date:   Fri, 21 Feb 2020 18:32:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220204356.8837-7-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/20 21:43, Sean Christopherson wrote:
> Add a dedicated hook to handle flushing TLB entries on behalf of the
> guest, i.e. for a paravirtualized TLB flush, and use it directly instead
> of bouncing through kvm_vcpu_flush_tlb().  Change the effective VMX
> implementation to never do INVEPT, i.e. to always flush via INVVPID.
> The INVEPT performed by __vmx_flush_tlb() when @invalidate_gpa=false and
> enable_vpid=0 is unnecessary, as it will only flush GPA->HPA mappings;
> GVA->GPA and GVA->HPA translations are flushed by VM-Enter when VPID is
> disabled, and changes in the guest pages tables only affect GVA->*PA
> mappings.
> 
> When EPT and VPID are enabled, doing INVVPID is not required (by Intel's
> architecture) to invalidate GPA mappings, i.e. TLB entries that cache
> GPA->HPA translations can live across INVVPID as GPA->HPA mappings are
> associated with an EPTP, not a VPID.  The intent of @invalidate_gpa is
> to inform vmx_flush_tlb() that it needs to "invalidate gpa mappings",
> i.e. do INVEPT and not simply INVVPID.  Other than nested VPID handling,
> which now calls vpid_sync_context() directly, the only scenario where
> KVM can safely do INVVPID instead of INVEPT (when EPT is enabled) is if
> KVM is flushing TLB entries from the guest's perspective, i.e. is
> invalidating GLA->GPA mappings.

Since you need a v2, can you replace the name of mappings with "linear",
"guest-physical" and "combined" as in the SDM?  It takes a little to get
used to them but it avoids three-letter acronym soup.

Paolo

