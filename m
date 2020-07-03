Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9460C20899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AREutKao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGCQQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbgGCQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593793004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFQ4g/P1Du9M9ak16zvRNbstwVtVVpspC33Mh5BHA30=;
        b=AREutKaoFkiU1rfcw+DqWUQmYJkF3FgSH4TieZAP7Hyg63pZZhpOHTcSSyhVG1r6g15AGT
        AlubtAoz8c69THQdjCU2JzDuP7rDZi08RGAaIgz++F3rxUl/7NorWEka1o7xlDgxa1RKmI
        3DjedKcwppDALx/dOITZxEU9DqsRaYY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-Jm9jVnXtP9OP9_UEdG5p-g-1; Fri, 03 Jul 2020 12:16:42 -0400
X-MC-Unique: Jm9jVnXtP9OP9_UEdG5p-g-1
Received: by mail-wr1-f71.google.com with SMTP id y18so12477768wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 09:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFQ4g/P1Du9M9ak16zvRNbstwVtVVpspC33Mh5BHA30=;
        b=Tb8WWzlxeyQzXFoS78qigk82mEjdyrLqkACF13vdM5a4iIIV22p8VHnMQh2jdz3PpL
         AizL6rHKgOmLw3knIOK9QYGmN+Y2DM/0oETRZqm0rvFCBaU0f8ByPPVqN/vBOD9v1bT/
         E5A0yYTr+w+2gL2mo/Z87rnz2dn/8jouWvBqGDdI1SgX3cJU6tXyD8AS2YkUcsZZm7AT
         SgEFn7A1Yt9dhoTtAKECugHJuq8aJ4OqyhtpV1YwasS7kYxWVzoECaq5J2RJxF2K+4o8
         bptHULl0/JDceBEGVr3CNKsutHrjuNt1RwtjHzm59Xm/0XRCamdfNwrkCv7ZKqDfuMo/
         IlHw==
X-Gm-Message-State: AOAM531VOA8ElqHLmWkwKndvvgUJX5cQc8E86xgj3/4dEXjMpbTO1sAh
        dkMad5pRCyPcN8hBxpbJMwY5ViZcE5IfKj6ewksME8w/+OK67UeJgK5yoIr7QPvtLNtHPUd+K16
        sKjNv5ndTl4+/bprG13knTMma
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr38074448wma.33.1593793000999;
        Fri, 03 Jul 2020 09:16:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy13CMAMpLfw5apomXkvwgGF3aDg9j1/6L32NZ7YIZ5bHdkHZp5VQLJwx9OgIRudyksTnzDVw==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr38074427wma.33.1593793000808;
        Fri, 03 Jul 2020 09:16:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc? ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
        by smtp.gmail.com with ESMTPSA id u65sm13711095wmg.5.2020.07.03.09.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 09:16:40 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: VMX: CR0/CR4 guest/host masks cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703040422.31536-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ad927c2-d02e-3739-f37a-2fd75a3ebb97@redhat.com>
Date:   Fri, 3 Jul 2020 18:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200703040422.31536-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/20 06:04, Sean Christopherson wrote:
> Fix a bug where CR4.TSD isn't correctly marked as being possibly owned by
> the guest in the common x86 macro, then clean up the mess that made the
> bug possible by throwing away VMX's mix of duplicate code and open coded
> tweaks.  The lack of a define for the guest-owned CR0 bit has bugged me
> for a long time, but adding another define always seemed ridiculous.
> 
> Sean Christopherson (2):
>   KVM: x86: Mark CR4.TSD as being possibly owned by the guest
>   KVM: VMX: Use KVM_POSSIBLE_CR*_GUEST_BITS to initialize guest/host
>     masks
> 
>  arch/x86/kvm/kvm_cache_regs.h |  2 +-
>  arch/x86/kvm/vmx/nested.c     |  4 ++--
>  arch/x86/kvm/vmx/vmx.c        | 13 +++++--------
>  3 files changed, 8 insertions(+), 11 deletions(-)
> 

Queued, thanks.

Paolo

