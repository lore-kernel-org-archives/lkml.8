Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E6C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE04921744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNXmec1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgBYO4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:56:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28338 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728981AbgBYO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/GTDDlt72QN2T+qefae0h4YDCB+SvgeS3qO+PQYb4o=;
        b=LNXmec1zWoOGGUVReLV/Fg3X6MTGkYci+sIF5ytxMyS5wTHPMyzNLHwHqG0dHggTA88kD8
        /NLRLTqojTwXeBdJyLRlzkeN6NZKrh1Vd6ItLDpm8AmJrNKRnIUMROWtLEmsyzwNtK33Wg
        EzsHSjf18pB0Ul1lFVWuNdgO5lPX/Mw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-PQ-2-6DfPS-QAANlbdMXVg-1; Tue, 25 Feb 2020 09:56:35 -0500
X-MC-Unique: PQ-2-6DfPS-QAANlbdMXVg-1
Received: by mail-wr1-f71.google.com with SMTP id d9so4211737wrv.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Y/GTDDlt72QN2T+qefae0h4YDCB+SvgeS3qO+PQYb4o=;
        b=etIVE/FcmiXMagACM+bsGLW+P2WWcyQ57SDtKKgrdst4uTy0/8qbEKWswy07Y1TrUd
         0Mjg5qCfjnSwoQsyMk3bY/4GNi7sEY17T+U57z9cLXkUdj+WQcMyaJTGDQa2w9z9TtTs
         dcG+BQroUybrg+BsdfKc3GHggM+aPYnFe+6W9ZgRKLFgbQS2ODdawMTPi1Nj63oKwzYX
         8WEeA3ND2F+8D3MKplCEbHpDiGMnXcnf0FvCaZhOnNDUBhgLH7a/oViGWhjZ2UiwB4KF
         MDauRmRTNiX7q3HvddguKP21BE+gABPikUxP6JX1dJZMZHLXXaNyOig6EUSozcPYuUgp
         3/OA==
X-Gm-Message-State: APjAAAWZE0PQ+iV5tZQZSWcRNxvT6019M8i7EjXnqPIA7N5/9EjwoXfH
        gCL6L78WNRGIwTwo0KO2JOk2JqCqJDYDxsrV6h658jMjZ6ELxxy2kQEKyzYO+X9qp3ksNIy/aVL
        TDULVh/wVhIPD14YyNMMlS+FK
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr10541451wro.204.1582642594083;
        Tue, 25 Feb 2020 06:56:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvBDqRtYQMrM8Ip0j6cyb6ZIz536smyCfSrj+e6/PDpnThv7CRNMUnxs2tXvvvIhTw7PNJDA==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr10541435wro.204.1582642593898;
        Tue, 25 Feb 2020 06:56:33 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e1sm23863230wrt.84.2020.02.25.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:56:33 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 60/61] KVM: Drop largepages_enabled and its accessor/mutator
In-Reply-To: <20200201185218.24473-61-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-61-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:56:32 +0100
Message-ID: <875zfulnq7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Drop largepages_enabled, kvm_largepages_enabled() and
> kvm_disable_largepages() now that all users are gone.
>
> Note, largepages_enabled was an x86-only flag that got left in common
> KVM code when KVM gained support for multiple architectures.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  include/linux/kvm_host.h |  2 --
>  virt/kvm/kvm_main.c      | 13 -------------
>  2 files changed, 15 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6d5331b0d937..50105b5c6370 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -683,8 +683,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				const struct kvm_memory_slot *old,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change);
> -bool kvm_largepages_enabled(void);
> -void kvm_disable_largepages(void);
>  /* flush all memory translations */
>  void kvm_arch_flush_shadow_all(struct kvm *kvm);
>  /* flush memory translations pointing to 'slot' */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index eb3709d55139..5851a8c27a28 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -149,8 +149,6 @@ static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
>  __visible bool kvm_rebooting;
>  EXPORT_SYMBOL_GPL(kvm_rebooting);
>  
> -static bool largepages_enabled = true;
> -
>  #define KVM_EVENT_CREATE_VM 0
>  #define KVM_EVENT_DESTROY_VM 1
>  static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
> @@ -1368,17 +1366,6 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  EXPORT_SYMBOL_GPL(kvm_clear_dirty_log_protect);
>  #endif
>  
> -bool kvm_largepages_enabled(void)
> -{
> -	return largepages_enabled;
> -}
> -
> -void kvm_disable_largepages(void)
> -{
> -	largepages_enabled = false;
> -}
> -EXPORT_SYMBOL_GPL(kvm_disable_largepages);
> -
>  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
>  {
>  	return __gfn_to_memslot(kvm_memslots(kvm), gfn);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

