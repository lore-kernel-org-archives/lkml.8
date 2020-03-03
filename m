Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C83C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FAD20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkYGi/Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgCCO7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:59:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31809 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728975AbgCCO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583247559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3INcNmfvd0keaFFtSvq7kLrMBsEvlegDlXL3LDjJtw=;
        b=EkYGi/Lz6IwyKMUHm/arpMCGRnYzpEJc1+RORYLgOP9UheVQJGmVnVXlc3T8DuHPcdMh2z
        VYEFVWQLNkrShCuAM2AoKJPzLJhY9/zgKvXX5XwubRTjwkJAtFSlDcNE36FQoWYmDFPL91
        gYXA1mEk8lklbQsdzXDPkioj+8DHTHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-_nU7jHx4OhmJDuQj8ReilQ-1; Tue, 03 Mar 2020 09:59:17 -0500
X-MC-Unique: _nU7jHx4OhmJDuQj8ReilQ-1
Received: by mail-wr1-f70.google.com with SMTP id w8so537137wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3INcNmfvd0keaFFtSvq7kLrMBsEvlegDlXL3LDjJtw=;
        b=Z/DeoOsLuA/zCxYkDaLvXiUcyRkCxyA9n1L5ff/LmwTKf9Y4GfOL0IsjHub7dHGIi/
         MtK5ktQVa8IqXxFmxd6/6SM0eOrcxjueCIMO2Hkqi8yiKy8wxN6ro+ZG7n91TRlkAY/U
         jqSsAzznQAzyxFkVjrkc++53mfDCcAEbWaCPzq5rBBlDVzbeKFtJe992BfUm28dK3ok0
         X5ojZjMkCveUqr8n23meT8f4U4y4glbkyj/lChIBCN4EbRaQltqyT5TXoD2863aFWrsI
         T/9ponAkWQAdD0I1uLs9eYxZiAtEPHtz9wAVl9bDj0r8jplP8Slo9YW0g1U2xLwIJpZ5
         xlUA==
X-Gm-Message-State: ANhLgQ03WGNYZV2aLn0ygM3RSXXGV2umOdK30Up+lCD2SpAhaf995BJG
        efWUFGPBPpS6AoGOpqguJORQnqssjpldkC7xD2ivlUZSZcGrzFgGcEjiuoOWExYq/MYl0LIm8oU
        xJQDq1RLkL1YnXAQqZNlAF8Hm
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr3142879wmi.32.1583247556403;
        Tue, 03 Mar 2020 06:59:16 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt1RLURtABBn8aSSBG+jqW4QAi/m+dn0RH1ZEcCXqdMzBZSlAaAyddA7kBq72kciM4FXajzwQ==
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr3142865wmi.32.1583247556134;
        Tue, 03 Mar 2020 06:59:16 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id 12sm4252542wmo.30.2020.03.03.06.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 06:59:15 -0800 (PST)
Subject: Re: [PATCH v2 36/66] KVM: x86: Handle GBPAGE CPUID adjustment for EPT
 in VMX code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-37-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90df7276-e586-9082-3d80-6b45e0fb4670@redhat.com>
Date:   Tue, 3 Mar 2020 15:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-37-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:56, Sean Christopherson wrote:
> Move the clearing of the GBPAGE CPUID bit into VMX to eliminate an
> instance of the undesirable "unsigned f_* = *_supported ? F(*) : 0"
> pattern in the common CPUID handling code, and to pave the way toward
> eliminating ->get_lpage_level().
> 
> No functional change intended.

And no functional change is done indeed but there is a preexisting bug 
that should be fixed.

cpu_has_vmx_ept_1g_page() has no relationship to whether 1GB pages should be
marked as supported in CPUID.  This has no ill effect because we're only
clearing the bit, but it results in 1GB pages not being available when
EPT is disabled (even though they are actually supported thanks to
shadowing).

The right fix should be this:

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 84b9a488a443..8bbba8eb4ce5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -416,8 +416,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	int r, i, max_idx;
 	unsigned f_nx = is_efer_nx() ? F(NX) : 0;
 #ifdef CONFIG_X86_64
-	unsigned f_gbpages = (kvm_x86_ops->get_lpage_level() == PT_PDPE_LEVEL)
-				? F(GBPAGES) : 0;
+	unsigned f_gbpages = F(GBPAGES);
 	unsigned f_lm = F(LM);
 #else
 	unsigned f_gbpages = 0;
@@ -691,6 +690,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	case 0x80000001:
 		entry->edx &= kvm_cpuid_8000_0001_edx_x86_features;
 		cpuid_entry_mask(entry, CPUID_8000_0001_EDX);
+		if (!tdp_enabled)
+			cpuid_entry_set(entry, X86_FEATURE_GBPAGES);
 		entry->ecx &= kvm_cpuid_8000_0001_ecx_x86_features;
 		cpuid_entry_mask(entry, CPUID_8000_0001_ECX);
 		break;

Paolo

