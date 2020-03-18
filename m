Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6678C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F03320753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ugmg4MTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCRMpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:45:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36286 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgCRMpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584535506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvQfnaEYBfnYBDItpt1iU+ao5bricI+fV0mKZwprprw=;
        b=Ugmg4MTCAS9nC39tRc9AfEJAou7W1hhGVdRoz1vqSbMGP/OpENCjX63OzU8gz+8Ah7bhx1
        yf0yEmJCR105Sbf/PQFnHtOMjtmQAj2mJIM0H3YQep6chWHK7eXQsPE/sMjmA4jeM6AB3w
        SN46b3aJMYyEfot2M99TkPPHFYrv1jQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-qtSNQcyMO_m2F6KlVmNKmQ-1; Wed, 18 Mar 2020 08:45:05 -0400
X-MC-Unique: qtSNQcyMO_m2F6KlVmNKmQ-1
Received: by mail-wm1-f72.google.com with SMTP id a11so992559wmm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvQfnaEYBfnYBDItpt1iU+ao5bricI+fV0mKZwprprw=;
        b=rKTrvCKiEDKf4NJ9VqSz1J9Y4fJFGwrmTiEvKMXZOtYpAfGnQ9C78dyazkoARd7ZX2
         sBVq8cVs3JC93gvlnm23bkxk1ViOylqgX3tTVrMapEcojciCygJA/A440rvjuhvn50Rb
         yNXU6dzcvLhNiNgaI69wBUF0HWHC1C453yMHkzZQd3y1auo4a29e34yFNTQ9hJd+bakW
         wDc57Hv+YghXLgSt5z3NajtsJihwr6vphm/lTWu4W3g9scsd9lsTkvxgOuWhDoMpad2b
         YUECvCDwtBYR3ACzKG7lc3hlfrXqBRMVmvKcwmdOgcVAsVq2xVM1e21jRNU6myH6VVUG
         PdlA==
X-Gm-Message-State: ANhLgQ39ntZtZA1hua1rBSAJarYT2+QGAbf//olFa7OiNqp7gFhJ2AjX
        m8MyQEXwkvF8iVtScW7+aco6YQ8ixQoOh+qz6KHbsZaN3n7Kf1Fns168tDzHsCYhzMCEbmR6zHF
        TdRpPxvvvtVY465q0seLwlGXp
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr5014147wmd.101.1584535503090;
        Wed, 18 Mar 2020 05:45:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmhqCfpHfDDmiDeF3eEE/k96DNeOLsWLMMYaoFqlBqailxyi6r8qeWRvzFsEqwr7wAB8fj5w==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr5014125wmd.101.1584535502837;
        Wed, 18 Mar 2020 05:45:02 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id h81sm4001319wme.42.2020.03.18.05.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 05:45:01 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: x86: CPUID tracepoint enhancements
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20200317195354.28384-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7a1a4a0-7730-93a7-564e-fc4dcad4ee2c@redhat.com>
Date:   Wed, 18 Mar 2020 13:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317195354.28384-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 20:53, Sean Christopherson wrote:
> Two enhancements to the CPUID tracepoint.  Patch 01 was originally in the
> CPUID ranges series, but I unintentionally dropped it in v2.
> 
> The final output looks like:
> 
>   kvm_cpuid: func 0 idx 0 rax d rbx 68747541 rcx 444d4163 rdx 69746e65, cpuid entry found
>   kvm_cpuid: func d idx 444d4163 rax 0 rbx 0 rcx 0 rdx 0, cpuid entry not found
>   kvm_cpuid: func 80000023 idx 1 rax f rbx 240 rcx 0 rdx 0, cpuid entry not found, used max basic
>   kvm_cpuid: func 80000023 idx 2 rax 100 rbx 240 rcx 0 rdx 0, cpuid entry not found, used max basic
> 
> I also considered appending "exact" to the "found" case, which is more
> directly what Jan suggested, but IMO "found exact" implies there's also a
> "found inexact", which is not true.  AIUI, calling out that KVM is using
> the max basic leaf values is what's really important to avoid confusion.
> 
> Ideally, the function of the max basic leaf would also be displayed, but
> doing that without printing garbage for the other cases is a lot of ugly
> code for marginal value.
> 
> Sean Christopherson (2):
>   KVM: x86: Add requested index to the CPUID tracepoint
>   KVM: x86: Add blurb to CPUID tracepoint when using max basic leaf
>     values
> 
>  arch/x86/kvm/cpuid.c |  9 ++++++---
>  arch/x86/kvm/trace.h | 18 ++++++++++++------
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 

Queued, thanks.

Paolo

