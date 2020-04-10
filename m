Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4816BC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2615E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpiKv7AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDJTQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:16:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26811 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726692AbgDJTQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586546180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwSL4Svde7cDyREN44P4y94Qc6dx9Sv2bNY13UCrEho=;
        b=TpiKv7AU4KKSXGTODAiaoZGEcnPYj42dhAehgX6C+0d44FeACe9am/ZBeaYY2Y0HLX6nvs
        aje7hc0VkcueOQWF972s1WqfK7VJHxXaYQmLBVf/Hbf1Bys9OFFevMC4W+xfldXdx2akL2
        1D51z+uSTKFqciRRK/ZhpcQWX9YDSfI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-FVebVN-fPF6G7zcf7_iFog-1; Fri, 10 Apr 2020 15:16:18 -0400
X-MC-Unique: FVebVN-fPF6G7zcf7_iFog-1
Received: by mail-qv1-f70.google.com with SMTP id x9so2391811qvj.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwSL4Svde7cDyREN44P4y94Qc6dx9Sv2bNY13UCrEho=;
        b=QlUL0dXWYntUaPSeUaX18WugKD7q+vGZRQuuMmuUVT77rMONjUIQsBEx5qG3AY5oYR
         rDsL38VDEexOMUeGUC4xBPR3JrgQANIk5c9oNfRv14+ztSqif5iAMoQBYFQYGqohJ8lR
         aWQKquDzMgV82ftBX50isQC6xO3JD7NL0UT5r2eaRlJt3j0Qzg0EDhx45bAZV8Sx5Yw0
         eQe5OzmABlx0EnwSBcMgAp9wFEPHLfigP865yjVsl2zAuECqlSfobM2HEb+9sfDe1gFh
         FS40Bs96kBCCXZnqYYL9qUKbtxZCiS7ng9hVEebGVDrQDRiMIDoyLdnREGX1OiJNia0m
         La0Q==
X-Gm-Message-State: AGi0PuZmU6THPXMrOXVGDq8RFRNLn71PXcLaqh4qw/HP9X7Cws0NLOiI
        BUupr2RX26Am5HP8OfzvoVmKzLnceftEqhve6meCegvV4UIaiZTQxVwo2cxBQMfhc54zmfZ1JTn
        +yrrq41a438bMfiYwaZs/cTAF
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr5792232qka.329.1586546177443;
        Fri, 10 Apr 2020 12:16:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLiuHO8rQfrWs/w6IUs43Srn34pCDFpZie/ieWUpJNT3bX04my6S/Xtwb+5j5ZmCFgzwIqbpg==
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr5792202qka.329.1586546177111;
        Fri, 10 Apr 2020 12:16:17 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b13sm1590230qtp.46.2020.04.10.12.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:16:16 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:16:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-ID: <20200410191613.GD3172@xz-x1>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401183819.20647-2-mike.kravetz@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:38:16AM -0700, Mike Kravetz wrote:
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 2eb6c234d594..81606223494f 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -59,6 +59,8 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>  				 pte_t *ptep, pte_t pte, unsigned long sz);
>  #define set_huge_swap_pte_at set_huge_swap_pte_at
> +bool __init arch_hugetlb_valid_size(unsigned long size);
> +#define arch_hugetlb_valid_size arch_hugetlb_valid_size

Sorry for chimming in late.

Since we're working on removing arch-dependent codes after all.. I'm
thinking whether we can define arch_hugetlb_valid_size() once in the
common header (e.g. linux/hugetlb.h), then in mm/hugetlb.c:

bool __init __attribute((weak)) arch_hugetlb_valid_size(unsigned long size)
{
	return size == HPAGE_SIZE;
}

We can simply redefine arch_hugetlb_valid_size() in arch specific C
files where we want to override the default.  Would that be slightly
cleaner?

Thanks,

-- 
Peter Xu

