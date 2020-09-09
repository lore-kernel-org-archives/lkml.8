Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91761C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0612166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ujjv9Il8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgIIQQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbgIIQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:12:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942AFC061342
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:46:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v23so3665595ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xz5+8WmubrDpD+YU4ZdflmF/ouMNoGwItB02urwhNwc=;
        b=ujjv9Il8XroydthgCJgR3jnx5rKpJbx4SGULQm1kQebfTdqn5IJ18SR8ozAJoLmoLM
         xxX1a6U+BpvUBuLZnCrXVMERadEF2N7w4cV2YahHgtQ21pKgKljuWgVzEzm2RCbl3kcT
         pAm+ehPlEmdrJc2BPtLXQVMxj9kUyaY35QVV0pvVrHF0dwH01Zcgq8N+vjtJp09S6ZuL
         HUtDlfjyRaLqOTnVC5RvZh6cXaeYXqBcaPIvFJpYJXS82maHhUXDOy0HJoY3QBrko9Z/
         EL7ZJxdPww8QGVFifjrzTm6nWKllnKNEAb/28mgOtZocS8XO9iqBwwP7HVhVHbVJyNmH
         Qo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xz5+8WmubrDpD+YU4ZdflmF/ouMNoGwItB02urwhNwc=;
        b=TCCBv14fMIwy5yF0qh3d31vHHW6JTJznIB5b4L7fKzuZtXdZ30T2Z0OQFC6Fp5Edy/
         T34DAznntQkmwMsHhfat7ZHaRpZbbj8K0APRajSkNAb+oQnbGGBPukawyWoAlfFDgybS
         iBPGbDSlVuAbKe2gYN+VC5LKWOkDmkgAMyOtMaORE2sD4fMhQTKNBq4gUrdKFyiSqzst
         QCcKL6GCAzQ1znjJ5Ao2KW2uE0t/GrZ5tqqj0RzO1NFPj6rACXPuYHqSwTtUQ2kBR54m
         KfbC5dvnduLOQI6NI1+wEreHmp+8MasTH1pleGaZCn9nY6oDCXRjnjGDoiDQdSq00oOs
         QaOw==
X-Gm-Message-State: AOAM5307WU0EKgd9PbA0njkAB/vR4bXJ0l305c6Yry4ZG1Se0ASqHKsY
        Ylo2fcNLxWoiMFdhHGKicJjR5Q==
X-Google-Smtp-Source: ABdhPJyE9jyVO7Vu13EJEs1KyXmcml84OX7GcYE5h2aoDm/yT8nivy+RR1twiKj4OHcvbOENkXSytA==
X-Received: by 2002:a2e:8ec1:: with SMTP id e1mr2088395ljl.84.1599659213035;
        Wed, 09 Sep 2020 06:46:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v13sm592682lfo.30.2020.09.09.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:46:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A26CB1036AE; Wed,  9 Sep 2020 16:46:57 +0300 (+03)
Date:   Wed, 9 Sep 2020 16:46:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/16] mm: proc: add 1GB THP kpageflag.
Message-ID: <20200909134657.ekjjqvhds7akm2zf@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-4-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:06:15PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Bit 27 is used to identify 1GB THP.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  fs/proc/page.c                         | 2 ++
>  include/uapi/linux/kernel-page-flags.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index f3b39a7d2bf3..e4e2ad3612c9 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -161,6 +161,8 @@ u64 stable_page_flags(struct page *page)
>  			u |= BIT_ULL(KPF_ZERO_PAGE);
>  			u |= BIT_ULL(KPF_THP);
>  		}
> +		if (compound_order(head) == HPAGE_PUD_ORDER)
> +			u |= 1 << KPF_PUD_THP;
>  	} else if (is_zero_pfn(page_to_pfn(page)))
>  		u |= BIT_ULL(KPF_ZERO_PAGE);
>  
> diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
> index 6f2f2720f3ac..cdeb33ab655c 100644
> --- a/include/uapi/linux/kernel-page-flags.h
> +++ b/include/uapi/linux/kernel-page-flags.h
> @@ -36,5 +36,7 @@
>  #define KPF_ZERO_PAGE		24
>  #define KPF_IDLE		25
>  #define KPF_PGTABLE		26
> +#define KPF_PUD_THP		27
> +

Redundant newline.

>  #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
> -- 
> 2.28.0
> 
> 

-- 
 Kirill A. Shutemov
