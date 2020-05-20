Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F19207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU4s/erR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgETUOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:14:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726943AbgETUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590005692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmIeOpvSLXXYOJ6jQiUjdVDS8jI79jLrqdKnHe80e6k=;
        b=RU4s/erRaYX5Z2m/bWJjvPNmsj2frBTkT2mpESzTy6YuCuFjU7Dl5tnYP9gJ/r5q4GbVrz
        3KjaCpG9cwezbdaXczyN86Z6vXZTVG6yp0HjavZZt0uwauzV7IcxPw9Kzs/ImC164pEgVh
        4K5uY+0oEcXiA5D2olUVbDf8PbpQudo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-wf2nKFKAPCmR5c-Ux2rUcA-1; Wed, 20 May 2020 16:14:50 -0400
X-MC-Unique: wf2nKFKAPCmR5c-Ux2rUcA-1
Received: by mail-ed1-f72.google.com with SMTP id m6so1737622eda.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TmIeOpvSLXXYOJ6jQiUjdVDS8jI79jLrqdKnHe80e6k=;
        b=TYwbi7FgXb2M0WO4n9xKkm8CTczbwUfHO+nxFF5xkplEnXW1uFgyHACyVtHiHTdh46
         9npxd5ka+5PECB0xl1IsbebT2fGkZVMTtXb56NUGxyJKCjqDEZqyix7RrILTQxeUXGfh
         ddCHgwvcwHQStvci2bedUv40dgzm1K9EXexDCGiwgDi3lBSuxPum/dkWEZ/b9lI9hy+s
         hawWL5HXx+e73cUBFiBHUvv3c/QVo93NCJbwuYoX1tcWDZc8FacAI4VxjvOSZln1oQH4
         E5lQ4drGaHnj7O9Lw42HmAKtEA59PCoSR31gj4w1ApA3jqj3F9zhTOxCOVR7bcmUokAl
         057g==
X-Gm-Message-State: AOAM5308yvGnxQPtFWPHllii09IM+MITeFMfNJ/L1EZ6TL+VyRy8tQ3Y
        CNlT7QSSlpyIyNQE+kygyBUItRRx/n4lslPAo2aOzFJF4O9BrQhYDJqjmX7uOF2cqCtUEI7QQUr
        bLzWIPwDPdaLVjQVOVfNRgMur
X-Received: by 2002:aa7:d312:: with SMTP id p18mr2277874edq.88.1590005689544;
        Wed, 20 May 2020 13:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9E4xDxfsyPrMh6r2RGpLUE9EPbfiGAvLfUmVbbGop5ohjJ6Ao+kQ7cZJbxuKy3kLG3IUc8A==
X-Received: by 2002:aa7:d312:: with SMTP id p18mr2277856edq.88.1590005689332;
        Wed, 20 May 2020 13:14:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:30f5:232:d7f0:1e71? ([2001:b07:6468:f312:30f5:232:d7f0:1e71])
        by smtp.gmail.com with ESMTPSA id be12sm2584241edb.11.2020.05.20.13.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:14:48 -0700 (PDT)
Subject: Re: [PATCH 21/24] KVM: x86: always update CR3 in VMCB
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <20200520172145.23284-22-pbonzini@redhat.com>
 <20200520182202.GB18102@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d85c2e1d-93b3-186d-7df4-80ae6aa03618@redhat.com>
Date:   Wed, 20 May 2020 22:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520182202.GB18102@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 20:22, Sean Christopherson wrote:
> As an alternative fix, what about marking VCPU_EXREG_CR3 dirty in
> __set_sregs()?  E.g.
> 
> 		/*
> 		 * Loading vmcs02.GUEST_CR3 is handled by nested VM-Enter, but
> 		 * it can be explicitly dirtied by KVM_SET_SREGS.
> 		 */
> 		if (is_guest_mode(vcpu) &&
> 		    !test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_dirty))
> 
> There's already a dependency on __set_sregs() doing
> kvm_register_mark_available() before kvm_mmu_reset_context(), i.e. the
> code is already a bit kludgy.  The dirty check would make the kludge less
> subtle and provide explicit documentation.

A comment in __set_sregs is certainly a good idea.  But checking for
dirty seems worse since the caching of CR3 is a bit special in this
respect (it's never marked dirty).

This patch should probably be split too, so that the Fixes tags are
separate for Intel and AMD.

Paolo

>>  			guest_cr3 = vcpu->arch.cr3;
> 
> The comment that's just below the context is now stale, e.g. replace
> vmcs01.GUEST_CR3 with vmcs.GUEST_CR3.
> 
>> -- 
>> 2.18.2
>>
>>
> 

