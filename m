Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75856C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E55220787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxxHC6vY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgE0QPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:15:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730338AbgE0QPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590596133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szuzv9FjKVGOAkA2yRPWVoDFgWLJ5QQR49iMNPvrb04=;
        b=fxxHC6vYfwee1ibQG19WY1QzKTXYlmVd6v1Yyo95y4Mly0474Z11vlcOYET5W+Gejwqx0N
        HlyS98sZn8QSR865HR5O6YAVO5CQsgksAnHNS22wS2awer7ShC4qGbdPlXIuc27xrIJkIv
        bhqUsXtDBJPEOo1qLEdZcLNuKgqV9Mw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-qvCqJHBsN4Ku4bDdTTSEJg-1; Wed, 27 May 2020 12:15:32 -0400
X-MC-Unique: qvCqJHBsN4Ku4bDdTTSEJg-1
Received: by mail-wr1-f69.google.com with SMTP id a4so2222737wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szuzv9FjKVGOAkA2yRPWVoDFgWLJ5QQR49iMNPvrb04=;
        b=gaRHFQemYVtbu8lOJUhy0BIH+zEhZ1PnKkEssk1aG3knTEu8efe/lB8ly78UcsU0Gz
         BRjZbdqWBTZyhW1ocvi+cet8hFDpiZ3BwKRNYoosPQrhTCyFzSuf44k6r3F9bEw/Ehtl
         dFQAzp9neff6qZy4slwgX6Y5JhltfkK+Zq6zxGSpNQ6ud7fg9+Yp6EdCN5bwkBKugC7A
         +I/d2CYl7mLWOclKBF95aR2+3wOkLoWcMoXCnQOCgK75xnTK8SW/NdpkXfDlw0LV/SXj
         5DKqGZmdOYKtrkXgXPf3DmNR6rvGnkwYlR+dRK1zibiq3WlLSJW9zqp5ieMA0OboVeI9
         P1GA==
X-Gm-Message-State: AOAM5329JHDiTFQBlwjtRs3KxH0Fgg6VFLMmBpU/RT/g3niR3XIpD6Ya
        UxzahLy/Hec8vSqmofV8sJ48eWFCs0emBT7WHFBsAHweMAzdoiPpotrDyKbyg803JrFPNFHxQXE
        ZFOavMrnKw2dUs44iIX74Thsx
X-Received: by 2002:a5d:5492:: with SMTP id h18mr24900463wrv.330.1590596130880;
        Wed, 27 May 2020 09:15:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx54joe5BRQAwD5ipna0uYwbBkH1rExNY5+r8eX8vFQ8ZZvDbT4yU2cUwFnxyrJBdYC9V1OGQ==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr24900437wrv.330.1590596130696;
        Wed, 27 May 2020 09:15:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id 5sm3130827wmz.16.2020.05.27.09.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:15:30 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com
References: <20200527085400.23759-1-sean.j.christopherson@intel.com>
 <875zch66fy.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c444fbcc-8ac3-2431-4cdb-2a37b93b1fa2@redhat.com>
Date:   Wed, 27 May 2020 18:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875zch66fy.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 12:03, Vitaly Kuznetsov wrote:
>>  
>>  	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
>> +	vcpu->arch.tdp_level = kvm_x86_ops.get_tdp_level(vcpu);
>>  
>>  	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Looking at kvm_update_cpuid() I was thinking if it would make sense to
> duplicate the "/* Note, maxphyaddr must be updated before tdp_level. */"
> comment here (it seems to be a vmx-only thing btw), drop it from
> kvm_update_cpuid() or move cpuid_query_maxphyaddr() to get_tdp_level()
> but didn't come to a conclusive answer. 

Yeah, it makes sense to at least add the comment here too.

Paolo

