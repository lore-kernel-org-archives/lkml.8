Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FABFC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnLEXZde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3J1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:27:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3J1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588238828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vie47UJ1oW/NhA/rX/zyO/BjzssU/nJjeCxNVmVx9Q=;
        b=VnLEXZdecQgAWz0l3vW6p/9oMt/+ZHTYGeagvboLY0EA8Kw1CCKvDyxRPY4VaMRfe9bNGI
        +mM+Mz1ggbTXQ3aozFmtA45y/twSOcoyW7CFaOhY1+zwvyyhg7UG3dTcrleS0zS0a/pRa9
        M5k1CZTRQJJP8t4CrKpv0rI2LNOG9lA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-CohHsZLVNQui3WXMAdmJLw-1; Thu, 30 Apr 2020 05:27:07 -0400
X-MC-Unique: CohHsZLVNQui3WXMAdmJLw-1
Received: by mail-wr1-f69.google.com with SMTP id p2so3558445wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vie47UJ1oW/NhA/rX/zyO/BjzssU/nJjeCxNVmVx9Q=;
        b=V+z1ofzt/dLq9vIT2m+mdnYp+eBNuBRQlBqm+l6La9KepVz7f7dBGZ52EGeZbDKJcz
         U7c8dXQxaI7I0N19MCR5Pg9XdZfp+qSTbI3UrRVAQAeyQZsXUhHV+OLpRhudKwbZKORV
         5YpLoRoQIeRaPk/6DvVj5rdxvnmzZqx4mGwStQP1qhgQX/FYczHc4Wdq+O+SVZ//tXId
         Bd2KcE884cURbVn8xAdLqPd05GBhnheMXjTkqE0Bxw/wUJnJViXehZNUk1qN9i0zdTyX
         3NVwr3HGQ/dc7ZkSiTi4pMcrXdHw0rvb8CwnzNCHGhZqDiSl6amDtr3iGjCw4744FNux
         NE8w==
X-Gm-Message-State: AGi0Pub+mne1O2c2dFF58QDwQm17lOXcmXouRipmUvdAsQyookDZGve8
        57nnTnCHPOFl77TBNURzcTcYQaX57rlNiG1QRXnw0Qad2vp/U5ySa1sDhqLIXdZZu409VQb7TE0
        PxESm/SDOyTe5q3OKO2kJi4N6
X-Received: by 2002:a7b:c456:: with SMTP id l22mr1910004wmi.148.1588238825850;
        Thu, 30 Apr 2020 02:27:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypIidEgYyupOkF7nL6eGUnI+MnsnTzTsxHxlSJH5y9TKoVaupD0CtacA6MBnjUdJnCD7NKs2TQ==
X-Received: by 2002:a7b:c456:: with SMTP id l22mr1909983wmi.148.1588238825624;
        Thu, 30 Apr 2020 02:27:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id o6sm3109407wrw.63.2020.04.30.02.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:27:05 -0700 (PDT)
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-5-vkuznets@redhat.com>
 <b1297936-cf69-227b-d758-c3f3ca09ae5d@redhat.com>
 <87sgglfjt9.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18b66e2e-9256-0ef0-4783-f89211eeda88@redhat.com>
Date:   Thu, 30 Apr 2020 11:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87sgglfjt9.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 10:40, Vitaly Kuznetsov wrote:
>>  I think in that case
>> kvm_check_async_pf_completion will refuse to make progress.
>> You need to make this bit stateful (e.g. 1 = async PF in progress, 0 =
>> not in progress), and check that for page ready notifications instead of
>> EFLAGS.IF.  
>> This probably means that;
>>
>> - it might be simpler to move it to the vector MSR
> I didn't want to merge 'ACK' with the vector MSR as it forces the guest
> to remember the setting. It doesn't matter at all for Linux as we
> hardcode the interrupt number but I can imaging an OS assigning IRQ
> numbers dynamically, it'll need to keep record to avoid doing rdmsr.

I would expect that it needs to keep it in a global variable anyway, but
yes this is a good point.  You can also keep the ACK MSR and store the
pending bit in the other MSR, kind of like you have separate ISR and EOI
registers in the LAPIC.

>> - it's definitely much simpler to remove the #PF-based mechanism for
>> injecting page ready notifications.
> Yea, the logic in kvm_can_do_async_pf()/kvm_can_deliver_async_pf()
> becomes cumbersome. If we are to drop #PF-based mechanism I'd split it
> completely from the remaining synchronious #PF for page-not-present:
> basically, we only need to check that the slot (which we agreed becomes
> completely separate) is empty, interrupt/pending expception/... state
> becomes irrelevant.

Yes, that's a good point.

Paolo

