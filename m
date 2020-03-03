Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0420838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM5kb0i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgCCPWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:22:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgCCPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583248973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6hhj4RvcDIVxgBY1G9BhKvJtpYMpqc/o5vlGdiOVd4=;
        b=PM5kb0i+o/R75r9r4ffO7ujjTLTd2921xZH0JECQwZQUpnK9xiluauiI1kEUldkM4WGxYy
        7CLxrbS6mI1/Eg1QBUML+jqEPjvFEAEVHIyMoAt7yhpvc5WnQ1vMlHnXBWXGqeqQt/SPJU
        JNU0D5qp3Q9Ltnm7HdVXrulPc2ScPII=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-peu4YBaMMpqZe0NAkPSoMA-1; Tue, 03 Mar 2020 10:22:51 -0500
X-MC-Unique: peu4YBaMMpqZe0NAkPSoMA-1
Received: by mail-wr1-f72.google.com with SMTP id m18so1339090wro.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6hhj4RvcDIVxgBY1G9BhKvJtpYMpqc/o5vlGdiOVd4=;
        b=ubaSxn59xtfS1lsHNfJcD9s8T49EjrxN+kBt549Pcg/SJpOFr4SQJyC0DmQU2qnEKD
         8PTy+Kd96FaAOfRiowNj2nvrMDe75j+gQ5SzfPACO5G0IOD2GZIhyUnqNqa8Ed6hyFfk
         iS6zPwpETILEnq4mkjubJIikoI7gcwus7nqSy5BftCJDnWgkKuCuU+Por3UMIjuVMFEt
         a4ofmMZjROnV92Qo1uD5VJmQFvTxnyZB2XkxF953oZPjzPOxjVQZT/h61wBAd4HaAHQ5
         XZjihWUO11QPnt6p5+SMfuLvYN2DWAtM5CoDzJFmFu3OdUjmeLMCpr5VCbAASx2T1W/w
         x7vA==
X-Gm-Message-State: ANhLgQ3vQvZhHP21sqjK4dBZ4IGf7sEU00NzqfvH3N2KmV7Hz7WZECjH
        hW8glM6ra7fIpAhUvgJSdQY+y8u0AKWqCOIbtnLdEgz23BTm/ho0BivbMxU6KyI+P9+egQF4TxU
        N3JWTzlomlRHms52X4G3oLjGQ
X-Received: by 2002:a1c:9816:: with SMTP id a22mr5188131wme.16.1583248970836;
        Tue, 03 Mar 2020 07:22:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuTNzqhBy0I3FEAXGnUvMoxzAdxqzcJ4L5n+wIvurTlnl7KUwZjhKeCzWa1Ppb76Rb7y4PDpg==
X-Received: by 2002:a1c:9816:: with SMTP id a22mr5188100wme.16.1583248970533;
        Tue, 03 Mar 2020 07:22:50 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id c14sm18893149wro.36.2020.03.03.07.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:22:49 -0800 (PST)
Subject: Re: [PATCH v2 50/66] KVM: x86: Override host CPUID results with
 kvm_cpu_caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-51-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ec995c8-5fc4-eb6c-716b-3f18a05c3f77@redhat.com>
Date:   Tue, 3 Mar 2020 16:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-51-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:56, Sean Christopherson wrote:
> Override CPUID entries with kvm_cpu_caps during KVM_GET_SUPPORTED_CPUID
> instead of masking the host CPUID result, which is redundant now that
> the host CPUID is incorporated into kvm_cpu_caps at runtime.
> 
> No functional change intended.
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

The UMIP adjustment is now redundant in vmx_set_supported_cpuid, it's
done in the next patch but it makes more sense to remove it here (so the
next patch only moves code from set_supported_cpuid to set_cpu_caps).

Paolo

