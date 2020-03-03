Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A2DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E3220873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqaTprow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgCCIss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:48:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38603 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727357AbgCCIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftw6CClaVi/KV6ybxr6PLOeZCprvp/dOBx6WJEM3zx0=;
        b=VqaTprowHSbTfBrRQSNsEYAlvJFD6Xe9a78tPiL0wQaWh2Giku2EGkEcdaBKIuD9hEdOlY
        E6mQGevk2vUvf6snnEugSdqIbUIsPt+IMQ8sXxTiH0OZoUCZW2uB4WLuo1hltq+/0HNQIs
        YHDkzDaP6I6XOioz31PofbB6ynlspjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-nQPfjMpQOWSf6d-b_KQD3g-1; Tue, 03 Mar 2020 03:48:45 -0500
X-MC-Unique: nQPfjMpQOWSf6d-b_KQD3g-1
Received: by mail-wm1-f72.google.com with SMTP id 7so783874wmo.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ftw6CClaVi/KV6ybxr6PLOeZCprvp/dOBx6WJEM3zx0=;
        b=TIG8LsxgVnY+ulyMgQPwg8WhX22BlM5ljvxCix+G/xKgK9fuvA0V4hAwBuuR7PEU+7
         XDbvQfURlC1DbUIoCRX9v1PZ5BQKncwzirfFnxU5cgRDc7flHtCkDy2uS2cmME7fsK2X
         aZg5OS2spvaQgnXE8OkhFmXlBmCev8KuZgT9/pue7KMXHRBDLFIO+GxAoKAiOLVyv6G1
         N7l5EZheKrU7IgGno+fdcj3eUFJLwT8EyXOV2WDcCGfIgWzCMjpTXSBjmlrUKgbdri2y
         92EBaiYkcoW/YnKLDWMq6erM81T0AFS+fVnkOFqFw5frRYH2m2yprZ9FdHjfB2uI6ue7
         vE8Q==
X-Gm-Message-State: ANhLgQ2xB3W3/2M/gjq1jD4orAoyj58OArAo3rC+ofTOwcbVTnKR8lnG
        bQrFJLlcIlT65Hk3yF1HxTUinb6xs8Ep0QEfX+RZIqYvbTCuRYNp1zUYqMLvm4rsfxADyo70wZr
        PLj4GBEJWoEGspxl6bzw32dJr
X-Received: by 2002:adf:f2cf:: with SMTP id d15mr4284123wrp.397.1583225324615;
        Tue, 03 Mar 2020 00:48:44 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsPedn1piaC4hRCk1GX5tH2GntaDmgyO2i44PbFtdZUWg40PKgxP48EnWv8cbxXlJesnnfsMg==
X-Received: by 2002:adf:f2cf:: with SMTP id d15mr4284101wrp.397.1583225324400;
        Tue, 03 Mar 2020 00:48:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id h10sm2955423wml.18.2020.03.03.00.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:48:43 -0800 (PST)
Subject: Re: [PATCH 0/6] KVM: x86: CPUID emulation and tracing fixes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302195736.24777-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4a13ce0-1545-4ef7-d95c-2ce2db24a90d@redhat.com>
Date:   Tue, 3 Mar 2020 09:48:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302195736.24777-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 20:57, Sean Christopherson wrote:
> Two fixes related to out-of-range CPUID emulation and related cleanup on
> top.
> 
> I have a unit test and also manually verified a few interesting cases.
> I'm not planning on posting the unit test at this time because I haven't
> figured out how to avoid false positives, e.g. if a random in-bounds
> leaf just happens to match the output of a max basic leaf.  It might be
> doable by hardcoding the cpu model?

It would be best suited for selftests rather than kvm-unit-tests.  But I 
don't really see the benefit of anything more than just

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b1c469446b07..c1abf5de4461 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1001,6 +1001,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	       u32 *ecx, u32 *edx, bool check_limit)
 {
 	u32 function = *eax, index = *ecx;
+	u32 orig_function = function;
 	struct kvm_cpuid_entry2 *entry;
 	struct kvm_cpuid_entry2 *max;
 	bool found;
@@ -1049,7 +1050,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 			}
 		}
 	}
-	trace_kvm_cpuid(function, *eax, *ebx, *ecx, *edx, found);
+	trace_kvm_cpuid(orig_function, *eax, *ebx, *ecx, *edx, found);
 	return found;
 }
 EXPORT_SYMBOL_GPL(kvm_cpuid);

