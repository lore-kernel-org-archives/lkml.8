Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E855D2070C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkNEywdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAUO0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:26:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgAUO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579616793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wB7oBUxPFMMo41Dhy/A6/q8IlRImdTJH/qsnmSwn8s8=;
        b=SkNEywdQxA2MNtBg974Sn0ZydviqoFf7LucDrjpzy39Tsk8ub9HgZig3tiUC1+XV8YjbVC
        dTZMVC1+cXJQ0Y9JvlxcvsQVNTw2JT79hjDojprlb9ehkrPWMN4i5j+ONb6/mm5FEXWbh0
        xgCF491KvV5JkAxjJhjWm2briBhiIR8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-UMC63w-4Nh27IvYyCBP84w-1; Tue, 21 Jan 2020 09:26:31 -0500
X-MC-Unique: UMC63w-4Nh27IvYyCBP84w-1
Received: by mail-wr1-f72.google.com with SMTP id u18so1370425wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wB7oBUxPFMMo41Dhy/A6/q8IlRImdTJH/qsnmSwn8s8=;
        b=O5buA5WJUaXlN1ukUfr38iJjXA7GexYaUPlZ+owX2lFuZJ1yN9sP0qv36Sc54oNYO5
         wXpFZw7Uk1OJSJQ4UY6RsB6H1St59Ztp2KMES9/xBNiFQxNJxABsC+QRfPTj8hfaqcnN
         6/UslfXQbGUttULL26IuXhAx0Q+aKjLju7OMfNSUprIp+Zo6LMq8ZRbjDE9Rij52PVoV
         G6i81QBky6vsrKDuYtCER0Pz5G4pWMgKTPX8eXzdxCBCj5KObgfUAVwyVPPoHgkjG4lu
         sJ3kUBgiRXO7SMRAjPSD9F6W+fYnCqigVUuWB3NdNw2LeknikajxphYRUaRQK/+a0T2P
         yn8A==
X-Gm-Message-State: APjAAAVZbbKf7i5G/2q/BK5XFet4brOMXJRt/pPwow6VLEEVbgMpQE1n
        Y+lF7Tpi1fikn7PWRl7fRAqBeYh73Y/r2QpIoHG7ROuEHwDNc56Rq9dl2vfUnXr7+2kS7AMTlBF
        miN7EPVJS7FlAWFKlh+OZzXzi
X-Received: by 2002:a5d:6089:: with SMTP id w9mr5614971wrt.228.1579616790220;
        Tue, 21 Jan 2020 06:26:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWjz4Oe+H/gSHDnoSQ5o2pah30WIinDPbt454AQ/QK4v/OQZOFatnXxkc9zEh4soAyNb9f2w==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr5614921wrt.228.1579616789896;
        Tue, 21 Jan 2020 06:26:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id q68sm4727432wme.14.2020.01.21.06.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:26:29 -0800 (PST)
Subject: Re: [PATCH 05/14] x86/mm: Introduce lookup_address_in_mm()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Barret Rhoden <brho@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Zeng <jason.zeng@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-6-sean.j.christopherson@intel.com>
 <871rs8batm.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <175cef39-1e0e-d1b7-69bc-95a3a2a651a7@redhat.com>
Date:   Tue, 21 Jan 2020 15:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <871rs8batm.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 22:04, Thomas Gleixner wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> 
>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>> index b5e49e6bac63..400ac8da75e8 100644
>> --- a/arch/x86/include/asm/pgtable_types.h
>> +++ b/arch/x86/include/asm/pgtable_types.h
>> @@ -561,6 +561,10 @@ static inline void update_page_count(int level, unsigned long pages) { }
>>  extern pte_t *lookup_address(unsigned long address, unsigned int *level);
>>  extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>>  				    unsigned int *level);
>> +
>> +struct mm_struct;
>> +pte_t *lookup_address_in_mm(struct mm_struct *mm, unsigned long address,
>> +			    unsigned int *level);
> 
> Please keep the file consistent and use extern even if not required.
> 
> Other than that:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 

Adjusted, thanks for the review.

Paolo

