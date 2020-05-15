Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A800C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D213520728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC3ryUYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgEOTSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:18:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42828 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEOTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589570296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWVjSQ7npbEVbxrWhifmRkThSg5q50pTnOsQ0WvJuZg=;
        b=GC3ryUYIGADrKHRUr04r1Zvv7JqsNHUC9uIi3NVJFU1QkJ2Deykt3l3HDZNliKR6qkvoV9
        xVTtIgt7oJOvl06sINGo4eB2XqSenRoyewUzKP+qXq0ag0UWIpeJdTntqEfBxD5UOp/Mip
        R3mDMv3K5bDIIttJEdMcjRDlM0NYMpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-IVbb-xBuMUSR4mEeNZpfrA-1; Fri, 15 May 2020 15:18:12 -0400
X-MC-Unique: IVbb-xBuMUSR4mEeNZpfrA-1
Received: by mail-wr1-f69.google.com with SMTP id 90so1605098wrg.23
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWVjSQ7npbEVbxrWhifmRkThSg5q50pTnOsQ0WvJuZg=;
        b=bFQojBno+VeOPR0bJfG5UeFSCIymo0hwereWryTWpL5dVSJ1d6i51pnU01Ehytklmm
         QRe/Fk226xy7on95izzMLyTL4fXZnkk0i9wdxZrsxSGc2h+XY2onwSYzYgFslR6k0oRI
         rR0FteYdz4vket8r4wkB8J3mrvRXnytc1OChhXq6iPgfpLDHdvOJZm4fFJpP8YACNn5V
         a1cc5SyehxNKFAkSrrYUVGxTe7GZtHtrjQxXlhz35lh/B43LHhH2Ji9A2FxYoVeiDj3K
         OdyUcAKzd1D3m3H47+xNDzbjA3UGZujEgMoZfoGf9d0QxCNQ/lSF9I2/5ykSTkUnEmeO
         dhsQ==
X-Gm-Message-State: AOAM533bV/iScwGHtleBAl3r+3Q2jRs6IZxDKwzQWVcwnyErSXehu8Mt
        waHYHGThRxCRQBNSTqEEV8F1KF6r4YGfNntVDVZmP0knj18qcLuxBcj5hjQnB9uFe4pYsrlKWh9
        cck/rtx6UdBZB4RANQuCnXP0Z
X-Received: by 2002:adf:db4c:: with SMTP id f12mr5581907wrj.387.1589570290511;
        Fri, 15 May 2020 12:18:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDDW2yoWcBeIK7+KjGy8ibUQKD9q7am7akLIVsiO47SDzmrEmzMIHAPe+jdokSH0wcXJItYw==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr5581873wrj.387.1589570290122;
        Fri, 15 May 2020 12:18:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7012:d690:7f40:fd4e? ([2001:b07:6468:f312:7012:d690:7f40:fd4e])
        by smtp.gmail.com with ESMTPSA id 77sm5244034wrc.6.2020.05.15.12.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 12:18:09 -0700 (PDT)
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with
 token info
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200511164752.2158645-1-vkuznets@redhat.com>
 <20200511164752.2158645-3-vkuznets@redhat.com>
 <20200512152709.GB138129@redhat.com> <87o8qtmaat.fsf@vitty.brq.redhat.com>
 <20200512155339.GD138129@redhat.com> <20200512175017.GC12100@linux.intel.com>
 <20200513125241.GA173965@redhat.com>
 <0733213c-9514-4b04-6356-cf1087edd9cf@redhat.com>
 <20200515184646.GD17572@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d84b6436-9630-1474-52e5-ffcc4d2bd70a@redhat.com>
Date:   Fri, 15 May 2020 21:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515184646.GD17572@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/20 20:46, Sean Christopherson wrote:
>> The new one using #VE is not coming very soon (we need to emulate it for
>> <Broadwell and AMD processors, so it's not entirely trivial) so we are
>> going to keep "page not ready" delivery using #PF for some time or even
>> forever.  However, page ready notification as #PF is going away for good.
> 
> And isn't hardware based EPT Violation #VE going to require a completely
> different protocol than what is implemented today?  For hardware based #VE,
> KVM won't intercept the fault, i.e. the guest will need to make an explicit
> hypercall to request the page.

Yes, but it's a fairly simple hypercall to implement.

>> That said, type1/type2 is quite bad. :)  Let's change that to page not
>> present / page ready.
> 
> Why even bother using 'struct kvm_vcpu_pv_apf_data' for the #PF case?  VMX
> only requires error_code[31:16]==0 and SVM doesn't vet it at all, i.e. we
> can (ab)use the error code to indicate an async #PF by setting it to an
> impossible value, e.g. 0xaaaa (a is for async!).  That partciular error code
> is even enforced by the SDM, which states:

Possibly, but it's water under the bridge now.  And the #PF mechanism
also has the problem with NMIs that happen before the error code is read
and page faults happening in the handler (you may connect some dots now).

For #VE, the virtualization exception data area is enough to hold all
the data that is needed.

Paolo

