Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E4C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E002F2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA4DXFE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgBYOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:20:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38094 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730440AbgBYOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582640447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6FPpUbqRjz4gpl8i29mEumqWVf8GMxTT6jsxq0Z1Hc=;
        b=FA4DXFE8vzh0IpublXZB/DMSUfXFj2Gch4KvXq1v8cQNhmVUGkwQZ8Yw3e+YubV38bEbjb
        MQpJ0n1KLIJa5CjIXVDHPF98qO5jmLT1Lk3uywhYMlKgnSiysJY1RxHXDY5rIvfrp/9Pyu
        MipkGk8QdPw/zhfokAych96EQxvZrwg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-ddXOU298OC2AHpJyrglsrg-1; Tue, 25 Feb 2020 09:20:45 -0500
X-MC-Unique: ddXOU298OC2AHpJyrglsrg-1
Received: by mail-wr1-f72.google.com with SMTP id 90so7379096wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6FPpUbqRjz4gpl8i29mEumqWVf8GMxTT6jsxq0Z1Hc=;
        b=EmklSbB9lSDPaDNZ079WdecB2o4uq2NFSRSPQOETnS6SqP1J8J6l3zM1V+C2ZBdRMy
         z9hOJUeq8gZAOw0kevNSpZS8DaEWttUGxunVh+P552m5I5/GVZv+ljNJVsoygP4t9G2r
         ZxIPY6TLySPgCaCl2QHDf0Z2uYpnvBQ6bncYYso7zqHt9aVNplMwMNItr+mSsUEhJ4Fm
         oQs9I0fu2ENMgXVmFDk2WNcn83iyB8T7QCOEwgt5zvo3tOFsMzta8coSGFja2fGiGv0/
         TAFlNAjXHY9EobIiYwbacguvK+U1EAkLldhX6xJZWR31prIXtNtsP3xYaei7Biit+ntp
         R4Rw==
X-Gm-Message-State: APjAAAWJitpD6iHkbGzUnVg2ZG1lHfbAKF/rJdk6fK4/8oAhU4zrEyU0
        +SIyfNoOhP5sZnfHFEPTm6/q2GxEli2bShlOgyXzyH7sOy9yQi3JqPYf2WTTpjgMF8i3f65M8Kf
        5pyjdi6xe8E+FkHtp2WJJ2IfZ
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr10625466wrt.325.1582640444254;
        Tue, 25 Feb 2020 06:20:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0/r6jYINhIO7NFbSrZU8U9CXVckXX4lL7VhdkK/P9c93FiJxF+RGAU6OqxmnOGX3IqqCZYg==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr10625439wrt.325.1582640443944;
        Tue, 25 Feb 2020 06:20:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id 133sm4826515wmd.5.2020.02.25.06.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:20:43 -0800 (PST)
Subject: Re: [PATCH v2] KVM: LAPIC: Recalculate apic map in batch
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1582624061-5814-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0af6b96a-16ac-5054-7754-6ab4a239a2d4@redhat.com>
Date:   Tue, 25 Feb 2020 15:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582624061-5814-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 10:47, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> In the vCPU reset and set APIC_BASE MSR path, the apic map will be recalculated 
> several times, each time it will consume 10+ us observed by ftrace in my 
> non-overcommit environment since the expensive memory allocate/mutex/rcu etc 
> operations. This patch optimizes it by recaluating apic map in batch, I hope 
> this can benefit the serverless scenario which can frequently create/destroy 
> VMs.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * add apic_map_dirty to kvm_lapic
>  * error condition in kvm_apic_set_state, do recalcuate  unconditionally
> 
>  arch/x86/kvm/lapic.c | 29 +++++++++++++++++++----------
>  arch/x86/kvm/lapic.h |  2 ++
>  arch/x86/kvm/x86.c   |  2 ++
>  3 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index afcd30d..3476dbc 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -164,7 +164,7 @@ static void kvm_apic_map_free(struct rcu_head *rcu)
>  	kvfree(map);
>  }
>  
> -static void recalculate_apic_map(struct kvm *kvm)
> +void kvm_recalculate_apic_map(struct kvm *kvm)
>  {

It's better to add an "if" here rather than in every caller.  It should
be like:

	if (!apic->apic_map_dirty) {
		/*
		 * Read apic->apic_map_dirty before
		 * kvm->arch.apic_map.
		 */
		smp_rmb();
		return;
	}

        mutex_lock(&kvm->arch.apic_map_lock);
	if (!apic->apic_map_dirty) {
		/* Someone else has updated the map.  */
		mutex_unlock(&kvm->arch.apic_map_lock);
		return;
	}
	...
out:
        old = rcu_dereference_protected(kvm->arch.apic_map,
                        lockdep_is_held(&kvm->arch.apic_map_lock));
        rcu_assign_pointer(kvm->arch.apic_map, new);
	/*
	 * Write kvm->arch.apic_map before
	 * clearing apic->apic_map_dirty.
	 */
	smp_wmb();
	apic->apic_map_dirty = false;
        mutex_unlock(&kvm->arch.apic_map_lock);
	...

But actually it seems to me that, given we're going through all this
pain, it's better to put the "dirty" flag in kvm->arch, next to the
mutex and the map itself.  This should also reduce the number of calls
to kvm_recalculate_apic_map that recompute the map.  A lot of them will
just wait on the mutex and exit.

Paolo

