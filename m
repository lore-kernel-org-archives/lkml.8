Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53032C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DF820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMig0ZJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBFTGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:06:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbgBFTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581016008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFP4U5ATaHC0RXndwUcuwuU/AxffnBhPUu6Oesq1zsE=;
        b=CMig0ZJZRaAqHlsnvjVsEx+MtxpPk1YT3y+XGps0s9Cep+i9cLmG3DlHH0yKMMLPKiRZ3M
        eNDUCltDDuXwem3fJCR2Q5ZopVAkI88Notwq1/oPhcWp3qfH9uNYerOVhaWrrGBNDjrgyD
        /UQWaWdZZbZO+jjyoz0M6+cy1Zq9Tqc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-MPflXH8fPrmXWlnDfJ2GdA-1; Thu, 06 Feb 2020 14:06:46 -0500
X-MC-Unique: MPflXH8fPrmXWlnDfJ2GdA-1
Received: by mail-qt1-f199.google.com with SMTP id e8so4548389qtg.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vFP4U5ATaHC0RXndwUcuwuU/AxffnBhPUu6Oesq1zsE=;
        b=WYYH2MOQOc2JesdVgKJBmqK5s4u5xBKvsUR1Ajuam+lNMBpTPoQcj4k3hpNzclyMi0
         OdDFs/HqWj3MyUn/TwD/jNygJ4QyRaDU1q92DNd+pxrjiVufjfv/skUdtUb6XT55Svka
         TUAZkhnL3Y3xrifvcVQHfzvBqVl2NkuKPKWaDBhYaP84CsPIH0VSLvKaDtMpQHdoUzko
         t5ruHWfMuHdHX/eWBzmaZ+KpMuHyPGEc0w41iRxf11FIOwGZTsPSCgsSVspUiURkQNtv
         1gJFDQusGAYQB6wEq4HS0ohrmPqNWfs87QuMbtulC9FSwAet0XdwM244RCqEa3RujIhU
         johw==
X-Gm-Message-State: APjAAAVqtkuQN2ogQ8p4QgwyxWkOgV1CM72+OaBC9XE1QShSAY5yegqb
        ILLW1Mp3+RUDR8I2y79+9tFJ8avvelXwLacNqvEJgDG5XIcMZ0Y7XMg65iEsRRH2Vk3UwlksRSf
        jyY3Pq+nDySICe162H0KLUgBf
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr3831593qke.128.1581016005752;
        Thu, 06 Feb 2020 11:06:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcm5P+4dPwvjCn12J5PDi86Wcm35+8jmeWD2jbAE2DUKQO5334DVnipyStraLYLoHf0dGJ6w==
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr3831559qke.128.1581016005447;
        Thu, 06 Feb 2020 11:06:45 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id m27sm111381qta.21.2020.02.06.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:06:44 -0800 (PST)
Date:   Thu, 6 Feb 2020 14:06:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 14/19] KVM: Clean up local variable usage in
 __kvm_set_memory_region()
Message-ID: <20200206190641.GA700495@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-15-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-15-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:52PM -0800, Sean Christopherson wrote:

[...]

> @@ -1101,52 +1099,55 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
>  		return -EINVAL;
>  
> -	slot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> -	base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
> -	npages = mem->memory_size >> PAGE_SHIFT;
> -
> -	if (npages > KVM_MEM_MAX_NR_PAGES)
> -		return -EINVAL;
> -
>  	/*
>  	 * Make a full copy of the old memslot, the pointer will become stale
>  	 * when the memslots are re-sorted by update_memslots().
>  	 */
> -	old = *slot;
> +	tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> +	old = *tmp;
> +	tmp = NULL;

Shall we keep this chunk to the patch where it will be used?  Other
than that, it looks good to me.

Thanks,

-- 
Peter Xu

