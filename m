Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333A0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B1B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afef5u5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgCDH7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:59:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43997 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgCDH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583308739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9idwP0YJKo3uKB+4bzwXcoMlOXVhMKCyZCmIOhNfVTg=;
        b=afef5u5+UV2WH3WdeVrDLGwWJwupUfC3KC3RBf3XpEkkVRGZU1GPDS1qipiUq2B07z1YCz
        2Jb2MxevwLUBTIC+sjMo79o+WW05WzpoaA3/RIOKG2I2GNza1Gte5VkHoAG6WBNaLueKU7
        W36dTxm2fs4J/TLgAhMHCmevwKyWHlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-k-4CstyIN5aH8BRo2vrw6g-1; Wed, 04 Mar 2020 02:58:58 -0500
X-MC-Unique: k-4CstyIN5aH8BRo2vrw6g-1
Received: by mail-wr1-f70.google.com with SMTP id h10so343785wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9idwP0YJKo3uKB+4bzwXcoMlOXVhMKCyZCmIOhNfVTg=;
        b=VgANImvA1VYznBez3fpC1g8s/I6MNuy9cU/bnZuMX9fQPLnvISmEJJxUtWilwHY0uH
         8ZyuHHKEbryxoNUTl7rhrBH1ivKkougfMPl9O5Onk/1VxqdR/sTGATiGIDHOCFFA37hH
         oVSwymHmuC4RL8XTzQbemvjifx7TokIjGBi5ztQTXA5E75tJoPtX4yErmPv7EskLMbsT
         ESsFtxixqxc5xLuD+ZOMTi3yu8EZIthM0k8yZRgpwYRNQ9XV0qTx4IPTWXDFcKBvkG/0
         40pQolZv0sOcwRpAlGehKiOmzV5g+d1seZ8OvufVlveoSV5cGyYL4olOzHEPisQIdgSt
         Bg2A==
X-Gm-Message-State: ANhLgQ0oLmuP2xvBgXS5RBcOV7iePtadwZAaGf3LxQeLQH2RWqCNYjCs
        TqdFTXaHy99gFdljH96Ex8kJ6LNWszfvz4FjoRpqx0M2zrbjD5kwWW3IAtx1K2nKrXIqd5a20+b
        LtAr5ZVsgYzTUWrkB7qnIHfgR
X-Received: by 2002:a1c:9a88:: with SMTP id c130mr2353132wme.73.1583308737286;
        Tue, 03 Mar 2020 23:58:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuCZt1yb/8rNJw+Sp6DJi+8Wr7JwjrnuNcVtNzhZUDGNMJZymKyNSwEnYnpAXn/hqNe2lQEAA==
X-Received: by 2002:a1c:9a88:: with SMTP id c130mr2353106wme.73.1583308737024;
        Tue, 03 Mar 2020 23:58:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id c8sm11521398wrt.19.2020.03.03.23.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 23:58:56 -0800 (PST)
Subject: Re: [PATCH 3/4] KVM: x86: Revert "KVM: X86: Fix fpu state crash in
 kvm guest"
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Derek Yerger <derek@djy.llc>,
        kernel@najdan.com, Thomas Lambertz <mail@thomaslambertz.de>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200117062628.6233-1-sean.j.christopherson@intel.com>
 <20200117062628.6233-4-sean.j.christopherson@intel.com>
 <ca47fce8-a042-f967-513c-93cabac2122d@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c467967-a499-af4e-29df-ddfeb196714f@redhat.com>
Date:   Wed, 4 Mar 2020 08:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca47fce8-a042-f967-513c-93cabac2122d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/20 08:41, Liu, Jing2 wrote:
>>       trace_kvm_entry(vcpu->vcpu_id);
>>       guest_enter_irqoff();
>>   -    /* The preempt notifier should have taken care of the FPU
>> already.  */
>> -    WARN_ON_ONCE(test_thread_flag(TIF_NEED_FPU_LOAD));
>> +    fpregs_assert_state_consistent();
>> +    if (test_thread_flag(TIF_NEED_FPU_LOAD))
>> +        switch_fpu_return();
>>         if (unlikely(vcpu->arch.switch_db_regs)) {
>>           set_debugreg(0, 7);
> 
> Can kvm be preempt out again after this (before really enter to guest)?

No, irqs are disabled here.

Paolo

