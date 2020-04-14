Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77008206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5VaZIUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgDNP5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:57:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732398AbgDNP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586879828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YYLNoHPS0R9msE++qaePEk7EKWnckmMQYzoCYqpJRk=;
        b=L5VaZIUX94Up2eOkbcGXD9ia6HQsLwWIG5x2EBP15ZVOAg0FYzA7/4JiAQ/Fn0e9zucPzj
        cijSY8Y2Y28v1AhrGRN49yO+erNIXQ/Z7xWUPdqMb98nGB9Iy07jDACxr9zzYzhaFqH2qr
        tzp5EynSZH27B3q5RamSSbSuYG38mL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-YPgEzeE1N0-LMzRI4KUYyg-1; Tue, 14 Apr 2020 11:57:06 -0400
X-MC-Unique: YPgEzeE1N0-LMzRI4KUYyg-1
Received: by mail-wm1-f72.google.com with SMTP id b203so3977792wmd.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+YYLNoHPS0R9msE++qaePEk7EKWnckmMQYzoCYqpJRk=;
        b=NYaZZqXagNoOug0fnaVJs2/uDCiC88mHI0kltR7OcLsWTMCY9XYJFwmMRvaaIvhqqv
         hWuY8PfaJxmetFSccbd7mP6SxQ4oX78qMnC5cN0t+BoUQEgCULB/CVg4FX+EHP4mUufM
         IefherYiDhlkC6e7JUoQJS8yyWIWMC2gwmcc7r33kzmFbk0VAGUdKfYOq6PBnjKU2XBW
         JsI26uTbcNjYYEQ6rfFxQfxSCJcLO8fFTlRVVSvUE2Wklm97A2NKvTI4Xo3LRYpP+cBX
         y7qw6oM+ckTTh9eTMCWrqnL/ugs2djWGS6Buvqlg9jxP63LD2oSHCBSHMAmoo5EIEguQ
         knNg==
X-Gm-Message-State: AGi0PuYRbFc7+z5+G9xiLhjWyzAgTAuRrYiTOZGc9l878KNn+jbo9nPF
        UPi5ZA/41GuPQjKjOuEZow2VGBA4WX7txjb0L5QqZ9nG/crLzl0KKMHsyUoM876KK2mvNb+ZEsk
        H5twiz5xJMxzPLYIgLo17MCA2
X-Received: by 2002:a1c:5502:: with SMTP id j2mr502954wmb.93.1586879825158;
        Tue, 14 Apr 2020 08:57:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypK43hPUptF5L9yvQziVzJGJV/VyMhS23tlGH7dzBh06iijjr98+S1d6K1K1pTXXFtXi18cgZQ==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr502914wmb.93.1586879824909;
        Tue, 14 Apr 2020 08:57:04 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.210])
        by smtp.gmail.com with ESMTPSA id j10sm16390309wmi.18.2020.04.14.08.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 08:57:04 -0700 (PDT)
Subject: Re: [PATCH] kvm_host: unify VM_STAT and VCPU_STAT definitions in a
 single place
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        kvm@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20200413140332.22896-1-eesposit@redhat.com>
 <03a481a8-bcf2-8755-d113-71ef393508bf@amsat.org>
 <bf870876-9f9a-7ba8-d941-a3883e519eed@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <a5e9246e-2bf3-204e-b79b-0ed4c40fcc5d@redhat.com>
Date:   Tue, 14 Apr 2020 17:57:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bf870876-9f9a-7ba8-d941-a3883e519eed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 10:18 AM, Paolo Bonzini wrote:
> On 13/04/20 23:34, Philippe Mathieu-Daudé wrote:
>>> +#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
>>> +#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__
>> I find this macro expanding into multiple fields odd... Maybe a matter
>> of taste. Sugggestion, have the macro define the full structure, as in
>> the arm64 arch:
>>
>> #define VM_STAT(n, x, ...) { n, offsetof(struct kvm, stat.x),
>> KVM_STAT_VM, ## __VA_ARGS__ }
>>
>> Ditto for VCPU_STAT().
>>
Hi Philippe and Paolo,
> 
> Yes, that's a good idea.  Emanuele, can you switch it to this format?

Sure, I just submitted the v2 version.

Thanks,

Emanuele

