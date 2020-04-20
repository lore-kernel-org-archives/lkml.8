Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F23620A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFO6t45a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDTIt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:49:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587372597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2nctafG0roNHL3aalWgLNZ+cvN2uDJVeLDPJ2crTDE=;
        b=MFO6t45aN2joU1WFqh42kIkEbpKm09oTwfjVZ/Rf5abxlEFLP1SGgp0Is6toxtOan7af2H
        8HY3S7SkWFRvWo6A2LKrrwako5O+HLAQjvxdupOplG8dg8qbpSJSqpatUEKExbyt/pjSPc
        kydpFY2gkbTUibiUju/m127rKt9y078=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-ftmGHH9bN06YS5MxDl2HGQ-1; Mon, 20 Apr 2020 04:49:55 -0400
X-MC-Unique: ftmGHH9bN06YS5MxDl2HGQ-1
Received: by mail-wr1-f69.google.com with SMTP id p2so4651743wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=l2nctafG0roNHL3aalWgLNZ+cvN2uDJVeLDPJ2crTDE=;
        b=FdLuds4z6MWY20qoijWd8+PVa9CMvO8X0VcAV2LSYp5nNMmU+dOXSZv+l9cA/TBxva
         aos1EznQI/7En/2dhMxErA2oS1aZiVCDiu5HJaSwCCmj6x4hXjk/iUkH9T5zzrFVB0xB
         sXe0/5C+QgoKoGe5i/8tIin8RgkUBWyY7ycx87msBPkZpYYyH7m0WCZAovWCMulwKQpO
         UKxWSlRFWknvPpI1d008iYQsYClcDKtDlWVKiCkhorb+FuIr0/ihj3w0e0N4hW/5njW2
         doBMsIJs8Pnmcf0LTQVh4DaZvQMO0pQQd3RXZms6KgTc7ucmbMOxsLJKSz77oXjAlAUW
         eIfw==
X-Gm-Message-State: AGi0Puayk09veObgI/rJt0YO2FCn5th8QKPzAT/KpI/F2mpAkBSC+L0K
        0yOW6Sad1+yTnVX8bvuPu8YOCg1btYOxLGl1WDI3H136Xm2VLdPn6JnvQXxmfO3VFP7Jz5Y1ZQT
        e6QKpUG0oRP6c/E3k1OTsCpAd
X-Received: by 2002:a1c:7715:: with SMTP id t21mr15692071wmi.182.1587372594457;
        Mon, 20 Apr 2020 01:49:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJSZR71Dv0gJg7tIqGGj+fqHotFBvTdXiQ9tKzcVP0g6w5T4JQsk88hEvQGKfSKLT9N641kaA==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr15692057wmi.182.1587372594256;
        Mon, 20 Apr 2020 01:49:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v131sm483808wmb.19.2020.04.20.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:49:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 2/3] KVM: eVMCS: check if nesting is enabled
In-Reply-To: <20200417164413.71885-3-pbonzini@redhat.com>
References: <20200417164413.71885-1-pbonzini@redhat.com> <20200417164413.71885-3-pbonzini@redhat.com>
Date:   Mon, 20 Apr 2020 10:49:52 +0200
Message-ID: <877dyatubz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> In the next patch nested_get_evmcs_version will be always set in kvm_x86_ops for
> VMX, even if nesting is disabled.  Therefore, check whether VMX (aka nesting)
> is available in the function, the caller will not do the check anymore.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/evmcs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index 73f3e07c1852..48dc77de9337 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -4,6 +4,7 @@
>  #include <linux/smp.h>
>  
>  #include "../hyperv.h"
> +#include "../cpuid.h"
>  #include "evmcs.h"
>  #include "vmcs.h"
>  #include "vmx.h"
> @@ -333,7 +334,8 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
>          * maximum supported version. KVM supports versions from 1 to
>          * KVM_EVMCS_VERSION.
>          */
> -       if (vmx->nested.enlightened_vmcs_enabled)
> +       if (kvm_cpu_cap_get(X86_FEATURE_VMX) &&
> +	   vmx->nested.enlightened_vmcs_enabled)
>                 return (KVM_EVMCS_VERSION << 8) | 1;
>  
>         return 0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

