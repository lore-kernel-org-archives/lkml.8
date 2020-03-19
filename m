Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62693C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279820754
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2dqLL+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCSAVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:21:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCSAVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Y0czQRAz/kOPllfphXUjXudXCZCxZCs56nRoN+fK9Zs=; b=U2dqLL+663SgPnghCMGR8BF8Y0
        CZcLj/WCyPzBCV3IAXDape2LJMGZ9E9h8mLvL93UF6xS6flxgRdFGaZ8/3EZeFY5MLpjBkVXQdM3F
        26ktVz0JuP/YjCOcMiUwXM8U/3WqY/1g/8JlnNOgitbzgKslHSBWEAMVo14KQymj5kToLM+xxIAPd
        lPVeE9cKJREw8RGyVwEvCDVMzH3khG9KgYpDhZwQ52cH4cn0i8R7SP4WibjhCrLOYKc7abcSk0Cc6
        k46Y3sU2mrcoF3pjsyU8z4kAqRfkXv0RuDgUdWhj0llbGVWPwKQDK3am5dUfZzcsQeeM023WkwPRb
        /dkivxmA==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEivf-0000pW-Gf; Thu, 19 Mar 2020 00:20:55 +0000
Subject: Re: [PATCH 4/4] hugetlbfs: clean up command line processing
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-5-mike.kravetz@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1820045d-0bf2-9a86-226d-e9c4d5928749@infradead.org>
Date:   Wed, 18 Mar 2020 17:20:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318220634.32100-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 3/18/20 3:06 PM, Mike Kravetz wrote:
> With all hugetlb page processing done in a single file clean up code.
> - Make code match desired semantics
>   - Update documentation with semantics
> - Make all warnings and errors messages start with 'HugeTLB:'.
> - Consistently name command line parsing routines.
> - Add comments to code
>   - Describe some of the subtle interactions
>   - Describe semantics of command line arguments
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 26 +++++++
>  mm/hugetlb.c                                 | 78 +++++++++++++++-----
>  2 files changed, 87 insertions(+), 17 deletions(-)


> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cc85b4f156ca..2b9bf01db2b6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c

> @@ -3214,8 +3238,15 @@ static int __init hugetlb_nrpages_setup(char *s)
>  
>  	return 1;
>  }
> -__setup("hugepages=", hugetlb_nrpages_setup);
> +__setup("hugepages=", hugepages_setup);
>  
> +/*
> + * hugepagesz command line processing
> + * A specific huge page size can only be specified once with hugepagesz.
> + * hugepagesz is followed by hugepages on the commnad line.  The global

typo:                                            command

> + * variable 'parsed_valid_hugepagesz' is used to determine if prior
> + * hugepagesz argument was valid.
> + */
>  static int __init hugepagesz_setup(char *s)
>  {
>  	unsigned long long size;


Does any of this need to be updated?  (from Documentation/admin-guide/kernel-parameters.txt)

	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
			On x86-64 and powerpc, this option can be specified
			multiple times interleaved with hugepages= to reserve
			huge pages of different sizes. Valid pages sizes on
			x86-64 are 2M (when the CPU supports "pse") and 1G
			(when the CPU supports the "pdpe1gb" cpuinfo flag).


-- 
~Randy

