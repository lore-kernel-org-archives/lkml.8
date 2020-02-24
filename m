Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D8BC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32B20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzzecLN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgBXNyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:54:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727339AbgBXNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582552485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LW+r1TS9T6Bhh7eIghSubKEoZWRqarxO5U8eaU3pP0c=;
        b=OzzecLN17B0sT3OqIpjSgboDkRYHmVXSDbVo4O6ChvfAk3ZzJI9IYlbUweDEEI7+8tusxN
        yTCim7S/Dti4XlFT0TUojX1h7wSgXPYPQw1ubFvNDnt5Jr/mREZvI2XrXKC7rzzjmdt+cf
        adO5jTUoUS8YPpWUVZCqCbAI61QTLhc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ynRIlkozPH65tYoeJa6MGw-1; Mon, 24 Feb 2020 08:54:41 -0500
X-MC-Unique: ynRIlkozPH65tYoeJa6MGw-1
Received: by mail-wm1-f72.google.com with SMTP id u11so2406609wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LW+r1TS9T6Bhh7eIghSubKEoZWRqarxO5U8eaU3pP0c=;
        b=halZCij2gsXgJo1jXc1+hJZkJ+frSqX+hH0dhEfUP7bloF470iqZLF1MoPrtcAZadu
         xp9mcor988NFg5U18zjDf/8iejpovWQQ1box2ybXU2S9zDPRdl61aGvPAADDL9j3/QNj
         0vvXcK7kvDa7/iJ/yTKtVrAxCRKIyk9KjYSQYH8aGrGiedjxKvA8s4C+T8py1HJ2TfKj
         PFzcLcOuowt6GF2s+Fx8RHtQj4H+qtMVzBZNrP/qZ4aFSG/6e0RWH2qhscaGWiRLg9dq
         soWjPM4PG4pBzJDqVnGOaCGEj72ARVUswVS4Lc+y9h09EYAYXohRu2d8nUKZkDnOEOSh
         TUig==
X-Gm-Message-State: APjAAAWWVj83u3eIMknaSVc0IhJZpVNb2xQeehIQYTOEbILfqgGLtlXM
        jpe6xnSJIzjc75zt3nVvMwTXVIIjBQ5Ksx7pA9yMxmqRT3LyaCWau5Zz6mq8CLy11u0WHK+5QL2
        ESaa2KCU0LkDxIJMoDrCuqdso
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr22278811wmf.124.1582552480073;
        Mon, 24 Feb 2020 05:54:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2QsmhGaqPOGdx8xFP9PBNHbqyJ9KAYea4W3w+9lGzuHMzKWCmHi+jHkgDiddCLAHlIxIclQ==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr22278791wmf.124.1582552479839;
        Mon, 24 Feb 2020 05:54:39 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h18sm19458434wrv.78.2020.02.24.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:54:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/61] KVM: x86: Add Kconfig-controlled auditing of reverse CPUID lookups
In-Reply-To: <20200201185218.24473-30-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-30-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 14:54:38 +0100
Message-ID: <87a758oztt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add WARNs in the low level __cpuid_entry_get_reg() to assert that the
> function and index of the CPUID entry and reverse CPUID entry match.
> Wrap the WARNs in a new Kconfig, KVM_CPUID_AUDIT, as the checks add
> almost no value in a production environment, i.e. will only detect
> blatant KVM bugs and fatal hardware errors.  Add a Kconfig instead of
> simply wrapping the WARNs with an off-by-default #ifdef so that syzbot
> and other automated testing can enable the auditing.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/Kconfig | 10 ++++++++++
>  arch/x86/kvm/cpuid.h |  5 +++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 840e12583b85..bbbc3258358e 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -96,6 +96,16 @@ config KVM_MMU_AUDIT
>  	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
>  	 auditing of KVM MMU events at runtime.
>  
> +config KVM_CPUID_AUDIT
> +	bool "Audit KVM reverse CPUID lookups"
> +	depends on KVM
> +	help
> +	 This option enables runtime checking of reverse CPUID lookups in KVM
> +	 to verify the function and index of the referenced X86_FEATURE_* match
> +	 the function and index of the CPUID entry being accessed.
> +
> +	 If unsure, say N.
> +
>  # OK, it's a little counter-intuitive to do this, but it puts it neatly under
>  # the virtualization menu.
>  source "drivers/vhost/Kconfig"
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 51f19eade5a0..41ff94a7d3e0 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -98,6 +98,11 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
>  static __always_inline u32 *__cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry,
>  						  const struct cpuid_reg *cpuid)
>  {
> +#ifdef CONFIG_KVM_CPUID_AUDIT
> +	WARN_ON_ONCE(entry->function != cpuid->function);
> +	WARN_ON_ONCE(entry->index != cpuid->index);
> +#endif
> +
>  	switch (cpuid->reg) {
>  	case CPUID_EAX:
>  		return &entry->eax;

Honestly, I was thinking we should BUG_ON() and even in production builds
but not everyone around is so rebellious I guess, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

