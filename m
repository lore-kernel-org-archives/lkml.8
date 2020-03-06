Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF1C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5A2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIMd7g9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFJDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:03:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36949 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbgCFJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583485422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6hHlu4u9pl0gr61Q0hqOcfTBLsfleChBZw4ki+HhSs=;
        b=hIMd7g9EAM5NflZCGSNIiP5ipNk234D4ro5J3DxdtU06XAUZuYyC3hrmwdHttv+MvK3qBO
        IoPgmHWInHgLL8Ihcc+On2WOOEsmtJAtyaKyf96hEGJRfl5H6eswf7QYgi8CTR/XsrFlxR
        nt5zVLD/ZUzjJ+bEd7YzNyMYUtlaxM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-qKHIxJqZOFi_uU3Lm9Ox9Q-1; Fri, 06 Mar 2020 04:03:40 -0500
X-MC-Unique: qKHIxJqZOFi_uU3Lm9Ox9Q-1
Received: by mail-wm1-f69.google.com with SMTP id w12so381640wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r6hHlu4u9pl0gr61Q0hqOcfTBLsfleChBZw4ki+HhSs=;
        b=krzuEMTOd5OVSIT1dOjvg9DKs7zkgPivWw4o0IRjceYCVFcQ0hNCoWS0+IoAgJ+yPv
         pMO3JZF1fenUQrUk7RvKBgFNQJUsYvv0/iLQXOAhrcjH+hgTSgy6AuvUholT5CuOtzEd
         VVRtQUuqFo3KOYXE9FSjLhT5g79yEfNtyQDCxL1h57IGDX44Xv/43usDySP6xA8A0JB+
         kfmnZaKtIrrY9dk4gjv4mNvESIybEYWStPOIFo0NMmSNxAIQKoMXrjwZe0qBNYUTHtpw
         Bhx6G++ypVeQ1Z8A8e9iWU0+hxecWspSZiGdJjVx9u94i17r18W4v/jUPN8oIsYC07LT
         f57w==
X-Gm-Message-State: ANhLgQ2M9MrzM2MmzqST1fBPRdnki6a1HylnrzLWYORLH4q8d7/dJB+f
        yIUDmF8DkdFdbh2jVPwIdQVsx92PEBYBCX9u7WZ5pR/8nur8n4EjmvpcdBZDqoCvN15/PqCsVUz
        3jM8MGiZ8REx52PaZFG3wxTNj
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr2844683wmh.134.1583485419347;
        Fri, 06 Mar 2020 01:03:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsZO2rja5Eg1hV4u0r3e03rSF/NHnpK/09XscrzRU6x3ksC1Fnqv688SJGqraKNNW3h7xNhIg==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr2844629wmh.134.1583485418812;
        Fri, 06 Mar 2020 01:03:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e? ([2001:b07:6468:f312:b99a:4374:773d:f32e])
        by smtp.gmail.com with ESMTPSA id v131sm13743426wme.23.2020.03.06.01.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 01:03:38 -0800 (PST)
Subject: Re: [PATCH v2 4/7] KVM: x86: Fix CPUID range checks for Hypervisor
 and Centaur classes
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
References: <20200305013437.8578-1-sean.j.christopherson@intel.com>
 <20200305013437.8578-5-sean.j.christopherson@intel.com>
 <CALMp9eRRWZ54kzMXdTqRCy2KmaUAq+HVVVzbxJNVdgktg65XCA@mail.gmail.com>
 <20200305192532.GN11500@linux.intel.com>
 <CALMp9eRxdGj0DL0_g-an0YC+gTMcWcSk7=md=k4-8S0Zcankbg@mail.gmail.com>
 <20200305215149.GS11500@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5567edf6-a04c-5810-8ed5-78a0db14b202@redhat.com>
Date:   Fri, 6 Mar 2020 10:03:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305215149.GS11500@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 22:51, Sean Christopherson wrote:
>> Ah. So cross-vendor CPUID specifications are not supported?
> Cross-vendor CPUID is sort of allowed?  E.g. this plays nice with creating
> a Centaur CPU on an Intel platform.  My interpretation of GET_SUPPORTED...
> is that KVM won't prevent enumerating what you want in CPUID, but it only
> promises to correctly support select leafs.

But in practice does this change anything?  If the vendor is not Centaur 
it's unlikely that there is a 0xc0000000 leaf.  The 0x80000000 bound is
certainly not going to be at 0xc0000000 or beyond, and likewise to 0xc0000000
bound is not going to be at 0xd0000000 or beyond.  So I'm not sure if
anything is lost from this simplification:

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ed5e0bda672c..f43a8875c126 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -963,8 +963,7 @@ static bool cpuid_function_in_range(struct kvm_vcpu *vcpu, u32 function)
 
 	if (function >= 0x40000000 && function <= 0x4fffffff)
 		class = kvm_find_cpuid_entry(vcpu, function & 0xffffff00, 0);
-	else if (function >= 0xc0000000 && function <= 0xcfffffff &&
-		 is_guest_vendor_centaur(basic->ebx, basic->ecx, basic->edx))
+	else if (function >= 0xc0000000)
 		class = kvm_find_cpuid_entry(vcpu, 0xc0000000, 0);
 	else
 		class = kvm_find_cpuid_entry(vcpu, function & 0x80000000, 0);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 12ddfa493bae..3cb50eda606d 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -424,13 +424,6 @@ static inline bool is_guest_vendor_hygon(u32 ebx, u32 ecx, u32 edx)
 	       edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx;
 }
 
-static inline bool is_guest_vendor_centaur(u32 ebx, u32 ecx, u32 edx)
-{
-	return ebx == X86EMUL_CPUID_VENDOR_CentaurHauls_ebx &&
-	       ecx == X86EMUL_CPUID_VENDOR_CentaurHauls_ecx &&
-	       edx == X86EMUL_CPUID_VENDOR_CentaurHauls_edx;
-}
-
 enum x86_intercept_stage {
 	X86_ICTP_NONE = 0,   /* Allow zero-init to not match anything */
 	X86_ICPT_PRE_EXCEPT,

