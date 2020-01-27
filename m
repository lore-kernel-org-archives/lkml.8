Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A3C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90CB20702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh+1zvdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgA0I6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:58:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727464AbgA0I6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580115490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyk72xarWIQ4qzz+XnzCWWPRYXQDBN3Q30Mw1xKhGyI=;
        b=Gh+1zvdl4ZS21QmLJsEb5l99yBGvArauPxQVqWk/cUGo6EtCk27oP5MU06GBhGnghRTAeL
        Rb+B5k5SWXjVX/c7aY67m8h6EqqZLoJKW7rFtYX+chgP3s+/fLZNw9yepP8RT7fDPa9x9t
        WfcZkmepeKOQ64Uu+/rQqtREGrXr670=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-deRh1HPQP96Wuy6NTVL_3Q-1; Mon, 27 Jan 2020 03:58:09 -0500
X-MC-Unique: deRh1HPQP96Wuy6NTVL_3Q-1
Received: by mail-wr1-f71.google.com with SMTP id f10so5783905wro.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 00:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uyk72xarWIQ4qzz+XnzCWWPRYXQDBN3Q30Mw1xKhGyI=;
        b=c4R1+/QXN5ABEcXJ8OgsmfTK6kxXDoI/JqxS0C9O5FIhIPIENg6ozs+JsqfDccuQGP
         OsdIiwg937HVumPnjeWfGaEn4urBXmdB0BV0htA6xPCRYDbaqf8dmvha1NmjLNIVJquz
         yJ/DKsyoqZjBCj8tSqbBrlPi4F8xQWx21seqvaz8JMutlBopCnChHuMpaU9lI6FvuqEa
         we2trONFX/aItF/CdYUCew+I2brr0sVOQoEpJNg+EEzY6Qr5nauj69o3nQ+hNS8K2Cn5
         88uAseztjXY15FA6qd49iPLWPmdpEhdoubWwdJQFwgEU3Pij1dNChOJUjUT0x5Xn0ZZs
         7gOg==
X-Gm-Message-State: APjAAAXY9wS784DTWbi0B3VRV7XPSWKUJ40HTH2CpZiecJCEH0M1ORsw
        wTLxroTYuznPnw9cY3ovY9dfcUfbXLim4i9JzUd5cpmYK7iH1ihrCz5HZVqWuUgs3sNV9RbRoMs
        j3WklOLdV2aT4kALtcKcxThqH
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr4893813wme.129.1580115488044;
        Mon, 27 Jan 2020 00:58:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyt3OinQkUFAunpsKkT8TapyHOFDsD/NNKXyGWTg+FyCZ9rvS5eldqDIqHjZvmiWmLD4IcS9A==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr4893785wme.129.1580115487728;
        Mon, 27 Jan 2020 00:58:07 -0800 (PST)
Received: from vitty.brq.redhat.com ([195.39.4.224])
        by smtp.gmail.com with ESMTPSA id b21sm18855343wmd.37.2020.01.27.00.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 00:58:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Unexport x86_fpu_cache and make it static
In-Reply-To: <20200127001330.27741-1-sean.j.christopherson@intel.com>
References: <20200127001330.27741-1-sean.j.christopherson@intel.com>
Date:   Mon, 27 Jan 2020 09:58:09 +0100
Message-ID: <87y2ttmg2m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Make x86_fpu_cache static now that FPU allocation and destruction is
> handled entirely by common x86 code.
>

git grep on kvm/next agrees :-)

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> ---
>
> Pretty sure I meant to include this in the vCPU creation cleanup, but
> completely forgot about it.
>
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/x86.c              | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 77d206a93658..f300a250ab51 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1266,7 +1266,6 @@ struct kvm_arch_async_pf {
>  };
>  
>  extern struct kvm_x86_ops *kvm_x86_ops;
> -extern struct kmem_cache *x86_fpu_cache;
>  
>  #define __KVM_HAVE_ARCH_VM_ALLOC
>  static inline struct kvm *kvm_arch_alloc_vm(void)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7e3f1d937224..78b7e1f08845 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -227,8 +227,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  
>  u64 __read_mostly host_xcr0;
>  
> -struct kmem_cache *x86_fpu_cache;
> -EXPORT_SYMBOL_GPL(x86_fpu_cache);
> +static struct kmem_cache *x86_fpu_cache;
>  
>  static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);

-- 
Vitaly

