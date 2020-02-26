Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83AC4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E8D2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxraPWjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgBZRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:51:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgBZRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582739468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/GO32zOeZAgd5MebprE0rtmSJluPtmU741UPYfurz8=;
        b=gxraPWjn7VjTWDiLoxwXa2m+PTvRItOfKjHIFHaDW3wQt6Tq8fsEf/OyGN2MTklwIO4T1+
        zwy0A7Rcj/ns8lo0F502k5r3u51NRBH83DDmjcWfPAi343B3hlVM/xvRCXyDUhSeW5DTa2
        TmCg2FIEKE2QDF6JOTt6SIvoyVEqO6w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-9ryYvVYzMUOITrJBDLmGjQ-1; Wed, 26 Feb 2020 12:51:05 -0500
X-MC-Unique: 9ryYvVYzMUOITrJBDLmGjQ-1
Received: by mail-wr1-f72.google.com with SMTP id y28so69200wrd.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X/GO32zOeZAgd5MebprE0rtmSJluPtmU741UPYfurz8=;
        b=rXroG6q7V5v6wRN5IfPbNBFDMVmHtODGmLqqRunkGqSU8aydxtT1rJJ1VpUvG0tuyH
         EKfSN5Ai7f7kJa6USk2OLLPgnSb98A2QPSCIZRK2SkuWDCwDoQlDihZeH2dHxk2cFIYu
         whUGx4tSUmoIscBUOeJETjZOS9w6U3Jz3BUZRkUHgOlq1kH7PqjWjHcfrcIxL54M5pPH
         hL6kgBMZp63VNOqYHY32Itb9wsL6S8gj1gf38yJsDPpV4DUQmpEhl27ja2gB+iUGOFIt
         gyNaqAXQyRoXKEH5yzvY4+Xyso8pq9nm85ryWLTB5UYhqCS8LT0T1YOuOtrSZjIL4dod
         TrzQ==
X-Gm-Message-State: APjAAAU/IqrqFoQWWV3/aHVkZtqkDZEaZFQidnO/ujHnoRmsJLg/CoE9
        9TGATogBgezf1LKOL2aZsqYQ8xV/erHI3ulyhAww9YWiZorj7g+SSCEbvYtM/Sapr7M5CPURR/o
        1Y6EV3WrflHxhncVzhkaqwi5e
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr21661wma.87.1582739463998;
        Wed, 26 Feb 2020 09:51:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxC2qNmKsu4aQ5LkbFoKjMbr17wp+oJXxszJiSQSybBfpoQvWQmOwm0eaMUvvYJjuSRaJvQ6g==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr21648wma.87.1582739463797;
        Wed, 26 Feb 2020 09:51:03 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o9sm4307838wrw.20.2020.02.26.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:51:03 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] KVM: x86: Shrink the usercopy region of the emulation context
In-Reply-To: <20200218232953.5724-11-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-11-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 18:51:02 +0100
Message-ID: <87r1yhi6ex.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Shuffle a few operand structs to the end of struct x86_emulate_ctxt and
> update the cache creation to whitelist only the region of the emulation
> context that is expected to be copied to/from user memory, e.g. the
> instruction operands, registers, and fetch/io/mem caches.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/kvm_emulate.h |  8 +++++---
>  arch/x86/kvm/x86.c         | 12 ++++++------
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index 2f0a600efdff..82f712d5c692 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -322,9 +322,6 @@ struct x86_emulate_ctxt {
>  	u8 intercept;
>  	u8 op_bytes;
>  	u8 ad_bytes;
> -	struct operand src;
> -	struct operand src2;
> -	struct operand dst;
>  	int (*execute)(struct x86_emulate_ctxt *ctxt);
>  	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
>  	/*
> @@ -349,6 +346,11 @@ struct x86_emulate_ctxt {
>  	u8 seg_override;
>  	u64 d;
>  	unsigned long _eip;
> +
> +	/* Here begins the usercopy section. */
> +	struct operand src;
> +	struct operand src2;
> +	struct operand dst;

Out of pure curiosity, how certain are we that this is going to be
enough for userspaces?

>  	struct operand memop;
>  	/* Fields above regs are cleared together. */
>  	unsigned long _regs[NR_VCPU_REGS];
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 370af9fe0f5b..e1eaca65756b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -235,13 +235,13 @@ static struct kmem_cache *x86_emulator_cache;
>  
>  static struct kmem_cache *kvm_alloc_emulator_cache(void)
>  {
> -	return kmem_cache_create_usercopy("x86_emulator",
> -					  sizeof(struct x86_emulate_ctxt),
> +	unsigned int useroffset = offsetof(struct x86_emulate_ctxt, src);
> +	unsigned int size = sizeof(struct x86_emulate_ctxt);
> +
> +	return kmem_cache_create_usercopy("x86_emulator", size,
>  					  __alignof__(struct x86_emulate_ctxt),
> -					  SLAB_ACCOUNT,
> -					  0,
> -					  sizeof(struct x86_emulate_ctxt),
> -					  NULL);
> +					  SLAB_ACCOUNT, useroffset,
> +					  size - useroffset, NULL);
>  }
>  
>  static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);

-- 
Vitaly

