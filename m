Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05301207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SozFQuu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJJFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:05:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42149 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgGJJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594371943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBMD0sSb0w5KCpcjnu5JAG0eeG/Qn+GEjvEGuxcUNnk=;
        b=SozFQuu9Rbeq4ZU1VYXQQ6FB0HJk/FxI7fAPIm021xl02FmHy3rCA9INiNnerxJYfrJooL
        7hhbtKDIl5c0W4qY+vVowq6Phu/B/TaRek/xWje360YNz4Www/7kG/Nfglcu69HDKR03NW
        ZTMjsldZDF89A+3qPHjbdkOYOD95cEc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-I377619mP8ixTu7N3-IYNw-1; Fri, 10 Jul 2020 05:05:42 -0400
X-MC-Unique: I377619mP8ixTu7N3-IYNw-1
Received: by mail-wr1-f70.google.com with SMTP id b14so5364920wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rBMD0sSb0w5KCpcjnu5JAG0eeG/Qn+GEjvEGuxcUNnk=;
        b=NY0NZ9QMKhn2GBj219jODAfEYDohd7qVhy9atBk0L5MjnS8o+tzhxbOq4r/Qdf3kcJ
         FZMQyRiMoXD9Ktohgr/qyZapRh7Xl3B30ecp5Jw7PA+R4zLvU/19VI+EBwRt5YK9IfVZ
         l/BDxvHzWJgd1SOcxneK2V/TWdL97kXzdIliZ3FVqQUDfALFLeMGvqgHb0yP5dz8K2Th
         d8CP/VDHhVroRSVb0hdtwQ6AWGplRtH2sc6QckICuAAu40Bb8+N8DmL/f+r2HwzH2srV
         rjTvw5aageoRhAyNs4gWtbBl1OnoWocL4nrtwf1pVZGIFfHglfg/ZOkpZ5fLGuxuRk/+
         FZzg==
X-Gm-Message-State: AOAM530WgVZ9CVtel9INuj8I1+ZpyLki8vsLdb9IfB9opacK73jAgpSK
        3PT3N15wsD9YuJLafhj6W/+qFxJgsijLjwlGDpzK0T6JEMMFE4yujwitjGJ1CYpQVNqKg1K5CD0
        Q3cRNKOOTPDwtFVl92W7lGDI0
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr4339720wml.183.1594371939196;
        Fri, 10 Jul 2020 02:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxdSKxSnNl4oHDK3tCHLmcJEHYYFjHnDOEs4+Y09FVBCBpRkm8rhElrxBVkZIHFDJvwZdaGw==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr4339689wml.183.1594371938901;
        Fri, 10 Jul 2020 02:05:38 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id w14sm9373016wrt.55.2020.07.10.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:05:38 -0700 (PDT)
Date:   Fri, 10 Jul 2020 11:05:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Makarand Sonare <makarandsonare@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2] KVM: nVMX: fixes for preemption timer migration
Message-ID: <20200710090530.evy5ezrhnskywbt2@steredhat>
References: <20200709172801.2697-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709172801.2697-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On Thu, Jul 09, 2020 at 01:28:01PM -0400, Paolo Bonzini wrote:
> Commit 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration",
> 2020-06-01) accidentally broke nVMX live migration from older version
> by changing the userspace ABI.  Restore it and, while at it, ensure
> that vmx->nested.has_preemption_timer_deadline is always initialized
> according to the KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE flag.
> 
> Cc: Makarand Sonare <makarandsonare@google.com>
> Fixes: 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration")
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: coding style [Jim]
> 
>  arch/x86/include/uapi/asm/kvm.h | 5 +++--
>  arch/x86/kvm/vmx/nested.c       | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 17c5a038f42d..0780f97c1850 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -408,14 +408,15 @@ struct kvm_vmx_nested_state_data {
>  };
>  
>  struct kvm_vmx_nested_state_hdr {
> -	__u32 flags;
>  	__u64 vmxon_pa;
>  	__u64 vmcs12_pa;
> -	__u64 preemption_timer_deadline;
>  
>  	struct {
>  		__u16 flags;
>  	} smm;
> +
> +	__u32 flags;
> +	__u64 preemption_timer_deadline;
>  };
>  

Should we update also Documentation/virt/kvm/api.rst to be consistent?

Thanks,
Stefano

