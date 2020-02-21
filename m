Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B12CC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C95208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+otHOqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgBUR2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:28:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgBUR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582306092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7Mf64hpMBasfDiIU6phFS9p20JIfzD0ekOkjx1qN/c=;
        b=L+otHOqgc7Fo7+oTEo/f8mcvILbnkDrkwossMNLwkgN6wh7fcaVOND3JrF96qEt4uc/MDL
        gpMMoRbIkRmSnh6j95o/mnTEIgs3BjXPngHbP5LV8AkHcqeuqAVAjYKsInAowMRP2+uvni
        jfKygZZZeXi8n97k3SdRiIypQmlXkz8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-3XlxiK6wPUy4h6Lf0RK8UQ-1; Fri, 21 Feb 2020 12:28:10 -0500
X-MC-Unique: 3XlxiK6wPUy4h6Lf0RK8UQ-1
Received: by mail-wm1-f70.google.com with SMTP id p2so850718wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7Mf64hpMBasfDiIU6phFS9p20JIfzD0ekOkjx1qN/c=;
        b=ZI6gwy38Cx7H394dxyq6o91hCeizZbiXXEm+6AA6RbWUfEidTEV/6bJl9hBieiEJVP
         z7j4eSSYruaED7NPyzOnHACM6Ys+RxiKqg+VWYrSn2a1IvV+6PYwYe788fcfBDAhtTyC
         v8CMxlA42XU4lqvZHlx3KE00Hfp5UyYXN03i+LMxcTnpBlnpLll6FQ6yHFGoWYJSk0ab
         tJr3Irpf9OmPaACRdfUBl7PWqc+WMIPM0uDNsUxAQZN2S7gohmZa8QX0zMyGCNkHZtQZ
         i0oz9a+ixrUkm5JTrxOr5xlhjLP/GqCcWyeGDrI7T1Nc4euwuC1t/+KFrUq4rNLzLNLp
         41Jg==
X-Gm-Message-State: APjAAAVLrMDMgfznO8WlSoJgjHIRCLTbc/5CByRW40K/jeopI8ZvmZdC
        h+wft+coKoWZC9FIe008abFITwuCYZmMFPAUYPtl4u766XzZQL0dClqimTNiLsaCdL0IZhvsi6H
        OIh2oCdiESKpYktasBD/CHOFo
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr47748930wrx.381.1582306089245;
        Fri, 21 Feb 2020 09:28:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2hwqrWQ+Xv4wufLWVs/IPNmmZxQDAPd6VAd7ervfhXQWz6yUUfUoV8VyMG6OR3LrEZSYNsg==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr47748917wrx.381.1582306089024;
        Fri, 21 Feb 2020 09:28:09 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id g19sm4602188wmh.36.2020.02.21.09.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:28:08 -0800 (PST)
Subject: Re: [PATCH 04/10] KVM: VMX: Fold vpid_sync_vcpu_{single,global}()
 into vpid_sync_context()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200220204356.8837-1-sean.j.christopherson@intel.com>
 <20200220204356.8837-5-sean.j.christopherson@intel.com>
 <87zhdcrrdk.fsf@vitty.brq.redhat.com>
 <20200221153244.GD12665@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c117f11a-bd57-2929-d5bc-47f4eaffe279@redhat.com>
Date:   Fri, 21 Feb 2020 18:28:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221153244.GD12665@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/20 16:32, Sean Christopherson wrote:
>> In the original code it's only vpid_sync_vcpu_single() which has 'vpid
>> == 0' check, vpid_sync_vcpu_global() doesn't have it. So in the
>> hypothetical situation when cpu_has_vmx_invvpid_single() is false AND
>> we've e.g. exhausted our VPID space and allocate_vpid() returned zero,
>> the new code just won't do anything while the old one would've done
>> __invvpid(VMX_VPID_EXTENT_ALL_CONTEXT, 0, 0), right?
> Ah rats.  I lost track of that functional change between making the commit
> and writing the changelog.
> 
> I'll spin a v2 to rewrite the changelog, and maybe add the "vpid == 0"
> check in a separate patch.
> 

What about this:

diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
index eb6adc77a55d..2ab88984b22f 100644
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -255,13 +255,10 @@ static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
 
 static inline void vpid_sync_context(int vpid)
 {
-	if (vpid == 0)
-		return;
-
-	if (cpu_has_vmx_invvpid_single())
-		__invvpid(VMX_VPID_EXTENT_SINGLE_CONTEXT, vpid, 0);
-	else
+	if (!cpu_has_vmx_invvpid_single())
 		__invvpid(VMX_VPID_EXTENT_ALL_CONTEXT, 0, 0);
+	else if (vpid != 0)
+		__invvpid(VMX_VPID_EXTENT_SINGLE_CONTEXT, vpid, 0);
 }
 
 static inline void vpid_sync_vcpu_addr(int vpid, gva_t addr)

