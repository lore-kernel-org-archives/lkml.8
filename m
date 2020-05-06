Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F82C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BF42075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLt2BxSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgEFJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:30:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40661 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728952AbgEFJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588757438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRDsoW4PqOKDTvl02CnBAXvAH/isXXOqF537drR3NpQ=;
        b=RLt2BxSd1U0s2Rxno8/WoGJ0yA7iFTaU+cxB249jnGOQD8SuYKgdkeTz5Udhmd/O2/jdyA
        Z/2HrSsLN2W6+FnkrD8JvmxQNrY4NEsyi639/5xX6aAGo8AwgtmOgki0dsmFi12pDiccnQ
        GC2yf102YjoNy90r8xwDs6IORcYEVtc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Y_X15eDWNXWIgA012FnxTg-1; Wed, 06 May 2020 05:30:36 -0400
X-MC-Unique: Y_X15eDWNXWIgA012FnxTg-1
Received: by mail-wr1-f70.google.com with SMTP id 30so991346wrp.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRDsoW4PqOKDTvl02CnBAXvAH/isXXOqF537drR3NpQ=;
        b=V0hwGoD1XVwThiBvl6sAZTp91OtT6LtoLS6GZwntYhWZBscfTttCSpkd+NJCOmECU4
         0PcZdnyurrGjLMourpOVKP1wK/9sqC6PvZN0kSWAkvHGOsbO3UIGAgIJZ6ROU4TIo73v
         3LsmK/AwDWFrdxi7RbpWvY+lBBZOqId6VRxMp2xKfXDy+FDb2X+KWtywsURxpkv2YrLK
         FcRVfV+gMtV12UBIpajn0ehSvFQU53WU7G/qxFl9nj4l2edMEvHwixlrgUysmuFm19y7
         QLzTp2gzkd/6GpUKrnF+wM7t95I0M+s9wlAszJYdSw/9BLBCxLJxgjAwm0ll+xjJYRUY
         zduw==
X-Gm-Message-State: AGi0PubIJrG2EyEIH3eLhjrXsMC4bB9r1HOdvNb3fm7Uj0ei4Vx5T3F9
        Argk+8RrlwZc7crM+Hc6v1ZUU0zk9ioQrCTxf1fMv/qxYqV3Y6y7pLAc6+FzaVtaDCr3683igcl
        XyMPz7D2RU1Z7QNp9aHvhqufd
X-Received: by 2002:adf:80ee:: with SMTP id 101mr8745386wrl.156.1588757435330;
        Wed, 06 May 2020 02:30:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypK1zeUGnOlegWT/WV63eeUClJZUURP0CVxjtygCGm2d+x+81dM3Mdu5VfF57GS88O4fQlC22A==
X-Received: by 2002:adf:80ee:: with SMTP id 101mr8745370wrl.156.1588757435104;
        Wed, 06 May 2020 02:30:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id a67sm2275700wmc.30.2020.05.06.02.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 02:30:34 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: X86: Two fixes for KVM_SET_GUEST_DEBUG, and a
 selftest
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200505205000.188252-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a16352f2-73ef-b2fa-44e0-82b52dab8466@redhat.com>
Date:   Wed, 6 May 2020 11:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505205000.188252-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 22:49, Peter Xu wrote:
> The first two patches try to fix two issues I found (I think) with the
> selftest.  The 3rd patch is the test itself.  Note, we need below patches to be
> applied too for the test to work:
> 
>         KVM: X86: Declare KVM_CAP_SET_GUEST_DEBUG properly
>         KVM: selftests: Fix build for evmcs.h
> 
> Please review, thanks.
> 
> Peter Xu (3):
>   KVM: X86: Set RTM for DB_VECTOR too for KVM_EXIT_DEBUG
>   KVM: X86: Fix single-step with KVM_SET_GUEST_DEBUG
>   KVM: selftests: Add KVM_SET_GUEST_DEBUG test
> 
>  arch/x86/kvm/vmx/vmx.c                        |   2 +-
>  arch/x86/kvm/x86.c                            |   2 +-
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   9 +
>  .../testing/selftests/kvm/x86_64/debug_regs.c | 180 ++++++++++++++++++
>  6 files changed, 194 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/debug_regs.c
> 

Queued, thanks.

Paolo

