Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6FFC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95F721741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i363Huei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBFVYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:24:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727441AbgBFVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581024278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpppjCJmC0FyN5SMr7bSEAaCj98EBVmwQP8+IcdCU94=;
        b=i363HueiuV1OWT94vJQk/U+8bVcf319Ra4HjDwMA9z/dfQ45H+j6LdkS1hPKWcaT+0t5Ey
        u3ZOOZvSshxiIuL5lJkEq2w50SVu1YcNNCw6qz4qDrNIqKr81mvqe0PrU5haoPELTCNmLg
        eBF2ZL3WoRl1yg0xTd7dtQwXXeu8Rmc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-ZjxP-FCDP6m0qqZq1tyDMA-1; Thu, 06 Feb 2020 16:24:35 -0500
X-MC-Unique: ZjxP-FCDP6m0qqZq1tyDMA-1
Received: by mail-qt1-f200.google.com with SMTP id x8so133818qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 13:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mpppjCJmC0FyN5SMr7bSEAaCj98EBVmwQP8+IcdCU94=;
        b=FHdjj5xv5R7T+1N2nzZF+E1pRkRsE9zF5OVkALHBk76VoyGIE2oZyPv1JTcSV8Hnn5
         qv6Vyc6PDB6K9MId0LxbwEZ80bWTiQJ65LiN5gGVNeZ0ot13Q0Vf9o9tw4fSfwodQUkt
         kYdH0gSInJeQ3aDpWrJBJSymFkgN692KOMQYDXIYm4PMsBdUAdVGPqZ5tGh82l73xcqM
         zVuKYxolyJNlvye+ktgiOJMIqu9GUE1h3NjvkFTonJvynxYvTnZ9PDa/4TeRVIJwUq50
         4t4B+2egFfP0eB7acNx4UY07JoQWekHMq6QyOHZl6P7VjFRHD78CUEVfG5CvbZVVYZQG
         jriA==
X-Gm-Message-State: APjAAAVVuSHr71/HZmZdWFOiCg2K6YHG+82oWcu644zv/jNDye8fZpOe
        DYGWGolmPqYLfcoQIUSjuzRw98fuReFBMh3dF71/8B/N8CG4YFZ8yYHczNtMX5vAGVQog3NlOCY
        zT7lmKLkrGhIWNmTkwVolM1OZ
X-Received: by 2002:ae9:ebd8:: with SMTP id b207mr4579996qkg.353.1581024275409;
        Thu, 06 Feb 2020 13:24:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5VOLMiLzF1LhwmvuD3bg8z0IeFMhpmxCeKGC9RcbBKEXcR3SRyFUKynAlxMw185+NrKLCqw==
X-Received: by 2002:ae9:ebd8:: with SMTP id b207mr4579963qkg.353.1581024275206;
        Thu, 06 Feb 2020 13:24:35 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id v78sm278695qkb.48.2020.02.06.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:24:34 -0800 (PST)
Date:   Thu, 6 Feb 2020 16:24:31 -0500
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
Subject: Re: [PATCH v5 15/19] KVM: Provide common implementation for generic
 dirty log functions
Message-ID: <20200206212431.GF700495@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-16-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-16-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:53PM -0800, Sean Christopherson wrote:

[...]

> @@ -1333,6 +1369,7 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  	unsigned long i, n;
>  	unsigned long *dirty_bitmap;
>  	unsigned long *dirty_bitmap_buffer;
> +	bool flush;
>  
>  	as_id = log->slot >> 16;
>  	id = (u16)log->slot;
> @@ -1356,7 +1393,9 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  	    (log->num_pages < memslot->npages - log->first_page && (log->num_pages & 63)))
>  	    return -EINVAL;
>  
> -	*flush = false;
> +	kvm_arch_sync_dirty_log(kvm, memslot);

Do we need this even for clear dirty log?

> +
> +	flush = false;
>  	dirty_bitmap_buffer = kvm_second_dirty_bitmap(memslot);
>  	if (copy_from_user(dirty_bitmap_buffer, log->dirty_bitmap, n))
>  		return -EFAULT;

-- 
Peter Xu

