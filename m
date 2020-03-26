Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A18FC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2558620714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8Wwqk3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgCZTp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:45:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30116 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbgCZTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585251954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/QkZIwZAYRuVJgK41SETHWfHlCLzylTanLn5vMvqiQ=;
        b=P8Wwqk3wUhukJCt1HQEikimLeW9nCk1uT8Vqvqr9ZjgmAIIvTwrKz+0dTvVxHRMQBq2qCp
        h2epB4smHqkGPMgmVSGjXGclPB+P0swrcXgBJv/URpclV48ulAhKmvAg+jTWGBaC8Mp8SF
        cjOgZr2Nl6jM5eNhp6PztaOpzCOLsf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-5WLIZc3yOPK_ePsi0r3LpA-1; Thu, 26 Mar 2020 15:45:53 -0400
X-MC-Unique: 5WLIZc3yOPK_ePsi0r3LpA-1
Received: by mail-wm1-f71.google.com with SMTP id i9so1180883wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j/QkZIwZAYRuVJgK41SETHWfHlCLzylTanLn5vMvqiQ=;
        b=PIOcqI22QuOSJB4uPh9oXXj2LwJ7Iok/FvQ7lPhr3PipWrb5q6WlRPHtEyEEM3iAfc
         XxHVjRV17h0RmO6gGoGtJFEHMndxPU/jkA41JQ9TyKJYHCt7zWJ6qUYNScAGnwxqzlr6
         Lw4AF3Apz9ydrcoHpcGjOc7WIPYcAl8smmfuIHC0lVKwfBs5HtJU7SA4XHvad0jUk0J2
         dX8AxU2mUQkyL9IwdIO04VSKOmiaan0m5IYYDyXx2hsR9ZO0rQq8vJfDE9hB1caCgbTS
         2gLZP2YIwfSaq+nFcD8ADQtSKgb5A9cXuou5gt/kq+dQ9utf1aR7Q5s4nZcCHN7LcEo5
         2PaQ==
X-Gm-Message-State: ANhLgQ2DsmnpjjGmsHJoVI4BOEZfiVtuTJk0n7ieLa87vuLnO8XpF2Lu
        FycZuyauAQzrXftTWv1O81cbhvvrFa0RIDTBsWIPQLUIbScZqHlo9U4C166aYSGSWtPqWEeA0zv
        bxCyP/USJtQ/YiQYJVSKTimBa
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr1556647wmk.148.1585251948904;
        Thu, 26 Mar 2020 12:45:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtkzjJVQR0L2kBAgXHawkwn6IjmfgdffWupvHBQgJ6axyAXNIWiCOxX44A6i4JirFtb4neiag==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr1556624wmk.148.1585251948653;
        Thu, 26 Mar 2020 12:45:48 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id t21sm4755144wmt.43.2020.03.26.12.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 12:45:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: x86: cleanup kvm_inject_emulated_page_fault
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Junaid Shahid <junaids@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200326093516.24215-1-pbonzini@redhat.com>
 <20200326093516.24215-3-pbonzini@redhat.com>
 <877dz75j4i.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2222e81-8618-b3b0-baf3-2bda72d48ede@redhat.com>
Date:   Thu, 26 Mar 2020 20:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877dz75j4i.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 14:41, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> To reconstruct the kvm_mmu to be used for page fault injection, we
>> can simply use fault->nested_page_fault.  This matches how
>> fault->nested_page_fault is assigned in the first place by
>> FNAME(walk_addr_generic).
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/kvm/mmu/mmu.c         | 6 ------
>>  arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
>>  arch/x86/kvm/x86.c             | 7 +++----
>>  3 files changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index e26c9a583e75..6250e31ac617 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -4353,12 +4353,6 @@ static unsigned long get_cr3(struct kvm_vcpu *vcpu)
>>  	return kvm_read_cr3(vcpu);
>>  }
>>  
>> -static void inject_page_fault(struct kvm_vcpu *vcpu,
>> -			      struct x86_exception *fault)
>> -{
>> -	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
>> -}
>> -
> 
> This is already gone with Sean's "KVM: x86: Consolidate logic for
> injecting page faults to L1".
> 
> It would probably make sense to have a combined series (or a branch on
> kvm.git) to simplify testing efforts.

Yes, these three patches replace part of Sean's (the patch you mention
and the next one, "KVM: x86: Sync SPTEs when injecting page/EPT fault
into L1").

I pushed the result to a branch named kvm-tlb-cleanup on kvm.git.

Paolo

