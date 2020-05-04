Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C50C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B03F2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxY0G9Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgEDQt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729606AbgEDQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588610997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHIFHZpMTFsS6o4C4eP4nmeKJgG/zhFL7wedsTnup60=;
        b=VxY0G9PidKrQ0eOpp/ncMeda9TwULTFan3Lqw/SGlHxy+AAh8v0h3A4L6Tcg3oOFsEXyzh
        m73/Z105RtZXPkEEO15k+jQGusrxoq0hjOfoAi+1BoML4vUls1VUMDVskTQM5UuJvZTH98
        SnFfXa3ZONlBW8tblddzHGqfGt1idNo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71--sO8lHQSPB67IiLMQPN9Lg-1; Mon, 04 May 2020 12:49:55 -0400
X-MC-Unique: -sO8lHQSPB67IiLMQPN9Lg-1
Received: by mail-wm1-f71.google.com with SMTP id v185so115034wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oHIFHZpMTFsS6o4C4eP4nmeKJgG/zhFL7wedsTnup60=;
        b=F9CBNkeZ8p5ydv09M/dlTI35M7YWvAPcL7kOZZNm+cvi5/CnCjIXwltKzQpMzDaeIS
         k9ooyvzRXQk8IPzkFA2e2YSPyxl1EDECl7bWv/7AV0HOrVXY34b7KK4lpYJ5yjV4ckdR
         fFv8Mydg32/mD47rhQPjeAoyt7BE4ocywd2BvcDpEoICFaAbIu5MdE6/ONjOkdA6nBvt
         avPncPq+0KQhJkl0YoMuII1+2OFqJGUQnUFTNyUyBJF3E2H1r22weET7kA031VAb1NyN
         nnMn5CofszXp0Ea2ahgZC9+FLZZBrp5aRjBqcKig2Cy5R2K6YXceMMbkzHHcPaOgJOHN
         Bnug==
X-Gm-Message-State: AGi0PubCFFhf0nha4EYhZEw/gBSMJ8dA3dGU3T9/APSBf1z0I4j4b9nR
        PAo7SeTuJdZhtP0X7fvqpbRGynMKcp4LAX3Tg9wS4QKURGAPpEN0n1gESMLCdhHW6yMv5GAzqzK
        YsYfaEZPwqybxca4nHZyxWy2f
X-Received: by 2002:adf:ee88:: with SMTP id b8mr174147wro.93.1588610994692;
        Mon, 04 May 2020 09:49:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLKtFHZIUv4NcG3vTVjC4T0n5A2J4iO87GdeaxTeFI/aWSAwfse461FLfDPml9gQKYkw32KGw==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr174120wro.93.1588610994397;
        Mon, 04 May 2020 09:49:54 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id d5sm19736003wrp.44.2020.05.04.09.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:49:53 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86/mmu: Use kernel's PG_LEVEL_* enums
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Barret Rhoden <brho@google.com>
References: <20200428005422.4235-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35a94d18-d6d1-78f1-aee5-0e40b5edc60b@redhat.com>
Date:   Mon, 4 May 2020 18:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428005422.4235-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 02:54, Sean Christopherson wrote:
> Drop KVM's PT_{PAGE_TABLE,DIRECTORY,PDPE}_LEVEL KVM enums in favor of the
> kernel's PG_LEVEL_{4K,2M,1G} enums, which have far more user friendly
> names.
> 
> The KVM names were presumably intended to abstract away the page size.  In
> practice, the abstraction is only useful for a single line of code, a PSE
> paging related large page check.  For everything else, the abstract names
> do nothing but obfuscate the code.
> 
> Boot tested a PSE kernel under 32-bit KVM and 64-bit KVM, with and without
> EPT enabled.  Patches 2 and 3 generate no binary difference relative to
> patch 1 when compared via "objdump -d".
> 
> Sean Christopherson (3):
>   KVM: x86/mmu: Tweak PSE hugepage handling to avoid 2M vs 4M conundrum
>   KVM: x86/mmu: Move max hugepage level to a separate #define
>   KVM: x86/mmu: Drop KVM's hugepage enums in favor of the kernel's enums
> 
>  arch/x86/include/asm/kvm_host.h |  13 +---
>  arch/x86/kvm/mmu/mmu.c          | 118 +++++++++++++++-----------------
>  arch/x86/kvm/mmu/page_track.c   |   4 +-
>  arch/x86/kvm/mmu/paging_tmpl.h  |  18 ++---
>  arch/x86/kvm/mmu_audit.c        |   6 +-
>  arch/x86/kvm/svm/svm.c          |   2 +-
>  arch/x86/kvm/vmx/vmx.c          |   6 +-
>  arch/x86/kvm/x86.c              |   4 +-
>  8 files changed, 79 insertions(+), 92 deletions(-)
> 

Queued, thanks.

Paolo

