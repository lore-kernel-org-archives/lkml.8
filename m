Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C65C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42A620674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbL7/Auz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBDPo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:44:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54060 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727290AbgBDPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580831068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vwXFSaSl40J1FkNNvku6P1ALhyHoP4TEE129R0MITY=;
        b=dbL7/AuzHq9bCrQ/9I4Mt0hrHh9gecgLi3gRzXmnBdGvxOY3fHwFI9CPU3IB4HYxiFNIET
        DZnWEhyVxlSyRubSkQzrqxH6WkZBtGcjH9uD6odNeMIHpt+6BI/P4Bh+rd/FWLzTiB6z+Z
        ooBNf8hHHKjWuvKhmzPOJpdiIuwY2CQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-hLpSkTMJMded1P6Xlb99fw-1; Tue, 04 Feb 2020 10:44:26 -0500
X-MC-Unique: hLpSkTMJMded1P6Xlb99fw-1
Received: by mail-wr1-f70.google.com with SMTP id 90so10466949wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0vwXFSaSl40J1FkNNvku6P1ALhyHoP4TEE129R0MITY=;
        b=GHx+xc7upegbnM6W+rb1df3FIIdOi9crFPN+3mu9Hf+NUaaMMXRK8z8xLyP6noSGi4
         5S9s7Z/r4CUxWct6RQXFz5vLoG/HzH7wKgHuxCx7nURiQ9c83hcnHERnuqQ4ieH5Y5AN
         I07GaFuKrLGhLO/s62K3YxgAod907mUSEvk/h1omx8m0oS5knuTLUAMOIec9Rek8nmci
         mHIX6z9zzjdp9ZqT3XLUgDtG497ib218afqtf9HKikq60yiFz6O9E6Dg/JHvVnKyfO7L
         W+81VmncjU5HwtKvik/HmR4Nj9z3kbyM4x+FhosnVcJYE5g7umZZoni+NwKI/fzX75iN
         +M9A==
X-Gm-Message-State: APjAAAXwyl0SjLxaOdoF4t8AWHT3oHckx05QPjUzBzSbzL1UORVO4QZ1
        YhBb1TuhrMMtP5KKXSkxmeL1d8aRGCnq3+RnCjoIby9KH3Q5P2VuEzsydBuiDNxOe04Fxq+SvhW
        xsArgkNl6gUPjna58DO4/4IUD
X-Received: by 2002:adf:f58a:: with SMTP id f10mr24341724wro.105.1580831065883;
        Tue, 04 Feb 2020 07:44:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwDx/I4vTg/SxYW41BiQRlGoEm+2lFdAFLqZEnpwiOtn/GnZl4INGu2P+XSYN73hA3IdQ/2A==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr24341714wro.105.1580831065692;
        Tue, 04 Feb 2020 07:44:25 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i204sm4499498wma.44.2020.02.04.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 07:44:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com,
        eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH v3 1/3] selftests: KVM: Replace get_gdt/idt_base() by get_gdt/idt()
In-Reply-To: <20200204150040.2465-2-eric.auger@redhat.com>
References: <20200204150040.2465-1-eric.auger@redhat.com> <20200204150040.2465-2-eric.auger@redhat.com>
Date:   Tue, 04 Feb 2020 16:44:23 +0100
Message-ID: <87r1zamk6g.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Auger <eric.auger@redhat.com> writes:

> get_gdt_base() and get_idt_base() only return the base address
> of the descriptor tables. Soon we will need to get the size as well.
> Change the prototype of those functions so that they return
> the whole desc_ptr struct instead of the address field.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/processor.h | 8 ++++----
>  tools/testing/selftests/kvm/lib/x86_64/vmx.c           | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index aa6451b3f740..6f7fffaea2e8 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -220,20 +220,20 @@ static inline void set_cr4(uint64_t val)
>  	__asm__ __volatile__("mov %0, %%cr4" : : "r" (val) : "memory");
>  }
>  
> -static inline uint64_t get_gdt_base(void)
> +static inline struct desc_ptr get_gdt(void)
>  {
>  	struct desc_ptr gdt;
>  	__asm__ __volatile__("sgdt %[gdt]"
>  			     : /* output */ [gdt]"=m"(gdt));
> -	return gdt.address;
> +	return gdt;
>  }
>  
> -static inline uint64_t get_idt_base(void)
> +static inline struct desc_ptr get_idt(void)
>  {
>  	struct desc_ptr idt;
>  	__asm__ __volatile__("sidt %[idt]"
>  			     : /* output */ [idt]"=m"(idt));
> -	return idt.address;
> +	return idt;
>  }
>  
>  #define SET_XMM(__var, __xmm) \
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
> index 85064baf5e97..7aaa99ca4dbc 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
> @@ -288,9 +288,9 @@ static inline void init_vmcs_host_state(void)
>  	vmwrite(HOST_FS_BASE, rdmsr(MSR_FS_BASE));
>  	vmwrite(HOST_GS_BASE, rdmsr(MSR_GS_BASE));
>  	vmwrite(HOST_TR_BASE,
> -		get_desc64_base((struct desc64 *)(get_gdt_base() + get_tr())));
> -	vmwrite(HOST_GDTR_BASE, get_gdt_base());
> -	vmwrite(HOST_IDTR_BASE, get_idt_base());
> +		get_desc64_base((struct desc64 *)(get_gdt().address + get_tr())));
> +	vmwrite(HOST_GDTR_BASE, get_gdt().address);
> +	vmwrite(HOST_IDTR_BASE, get_idt().address);
>  	vmwrite(HOST_IA32_SYSENTER_ESP, rdmsr(MSR_IA32_SYSENTER_ESP));
>  	vmwrite(HOST_IA32_SYSENTER_EIP, rdmsr(MSR_IA32_SYSENTER_EIP));
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

