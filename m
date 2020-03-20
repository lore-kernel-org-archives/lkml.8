Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE7C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BD520409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwGyZxXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgCTWr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:47:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51442 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbgCTWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584744476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WUk4FuE693/Ims71nGi8Vyb20vScmj2OBiS6y31l7rg=;
        b=LwGyZxXUJFpHnW5cjOoc6T55QewWQP3GkMxB7gXZvVyil19/aGkCZURueREfVW8+8C0+p1
        44g60SCma4gl3su7b1P1+JieV7amFtxfVFdPTJXeXZkdorLTRgX/LWdZtwZ8F4Z+KJcVg9
        9g4N+No/ShsSuYPONKZR007xBFgfvjg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-44gZuclLOOCc_8oYDoGk6g-1; Fri, 20 Mar 2020 18:47:52 -0400
X-MC-Unique: 44gZuclLOOCc_8oYDoGk6g-1
Received: by mail-wr1-f71.google.com with SMTP id v7so3378011wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WUk4FuE693/Ims71nGi8Vyb20vScmj2OBiS6y31l7rg=;
        b=QEEtNmK07yt9h39EjD11O1Bx9bMK4SwBriVGhJYIw2VhvHnWppfBUU9zvYGaRAs6rm
         P09wP88KvJVrMKm4EUIzMd48bxzKMVhrsPtU9JDiNTLIuA43vhZ7DJZAA0w9W88xenUW
         I6Cjrakg9ZE/KPi6xU+tEad8j74ImoUZzPUMsj18DdGNpUgc5voE3Tfhm7bkm3i2YTyr
         qTd5a+2tAQoK6OySgLHIseoVgNzD9xBIqkOnVedaUm1ugwF9Idz1sSr0lHfDP8wfKBI2
         vCyITPhphFTHZw6g3c+4eHjB2gZurqc5YZmw3l/CBoMc5YNoHSI2AXk+rOYkCvBe77lv
         cNIQ==
X-Gm-Message-State: ANhLgQ1VrsdzhCZvq9hryVWr0bc1f7L++ySxWsdKCnfVgyfg8ZKFwM4y
        tOtyaAgUNS00wiciFo1xV/ppsT2cKf7gjMVCThactWCB0pVlXhVGmKUANkURc+jpnpceBDW2EDa
        IenIFh7okPBO8V99unn5sVV93
X-Received: by 2002:a1c:4642:: with SMTP id t63mr12556352wma.164.1584744471136;
        Fri, 20 Mar 2020 15:47:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuPybOpKmuJb0qYlCdkGVlgmgPsG4GTfzqG4QJZsauttmA//egJ/jt8Hv5GEno+xQ6dO7QrBg==
X-Received: by 2002:a1c:4642:: with SMTP id t63mr12556341wma.164.1584744470945;
        Fri, 20 Mar 2020 15:47:50 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 61sm11285191wrn.82.2020.03.20.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:47:49 -0700 (PDT)
Date:   Fri, 20 Mar 2020 18:47:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 4/7] KVM: selftests: Add helpers to consolidate open
 coded list operations
Message-ID: <20200320224744.GG127076@xz-x1>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
 <20200320205546.2396-5-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320205546.2396-5-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 01:55:43PM -0700, Sean Christopherson wrote:
> Add helpers for the KVM sefltests' variant of a linked list to replace a
> variety of open coded adds, deletes and iterators.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 68 ++++++++++++----------
>  1 file changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 9a783c20dd26..d7b74f465570 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -19,6 +19,27 @@
>  #define KVM_UTIL_PGS_PER_HUGEPG 512
>  #define KVM_UTIL_MIN_PFN	2
>  
> +#define kvm_list_add(head, new)		\
> +do {					\
> +	if (head)			\
> +		head->prev = new;	\
> +	new->next = head;		\
> +	head = new;			\
> +} while (0)
> +
> +#define kvm_list_del(head, del)			\
> +do {						\
> +	if (del->next)				\
> +		del->next->prev = del->prev;	\
> +	if (del->prev)				\
> +		del->prev->next = del->next;	\
> +	else					\
> +		head = del->next;		\
> +} while (0)
> +
> +#define kvm_list_for_each(head, iter)		\
> +	for (iter = head; iter; iter = iter->next)
> +

I'm not sure whether we should start to use a common list, e.g.,
tools/include/linux/list.h, if we're going to rework them after all...
Even if this is preferred, maybe move to a header so kvm selftests can
use it in the future outside "vcpu" struct too and this file only?

Thanks,

-- 
Peter Xu

