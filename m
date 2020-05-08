Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C615C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF04218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgFaCClT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEHWJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:09:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45946 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:09:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048M3pT7098830;
        Fri, 8 May 2020 22:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=e9WYgBCMI0KkS01+P+GDEHtd1NK7qTQIe6h+j1aFO7I=;
 b=TgFaCClTZHf+stqcvIDP2Bl7jaksNxPDQr/w7CfLJoVEUXZKyCTP2NEcQFg77e9AybrD
 Vf3+/kQREb4a5vA306kuIVOO5vtgIE6GV5q+50/4zyNOo7C2bP53T8T+oBbTx0Ap5ofn
 OLkEIVLferlceZkGLq4GYWDgX+ZQWuM6nC37AcdBVOodFt1Zk/pSXB4OtYMO70kTKnd0
 jKYbUxZvFKXvZ37VCrIwmcEWl/YqsZeZtfOaOUcdLlTd8fy/TKudRInZ/zgUQ3ymKxs+
 rUqg2uj68Trkzvsxn9tnGBIqjAXsJifHxtdzQ1c8oU/nEoUFgn+IqOUHxd4HjqSmjJ5r jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30vtexwdn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 22:09:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048M6tFL128051;
        Fri, 8 May 2020 22:09:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30vtehmy9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 22:09:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 048M9c41015658;
        Fri, 8 May 2020 22:09:38 GMT
Received: from [192.168.2.157] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 15:09:37 -0700
Subject: Re: [PATCH V3 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
 <1588907271-11920-2-git-send-email-anshuman.khandual@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7db44202-0d21-d8fb-6998-0210508a488a@oracle.com>
Date:   Fri, 8 May 2020 15:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588907271-11920-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 8:07 PM, Anshuman Khandual wrote:
> Platform specific huge_ptep_get() is required only when fetching the huge
> PTE involves more than just dereferencing the page table pointer. This is
> not the case on arm64 platform. Hence huge_ptep_pte() can be dropped along
> with it's __HAVE_ARCH_HUGE_PTEP_GET subscription. Before that, it updates
> the generic huge_ptep_get() with READ_ONCE() which will prevent known page
> table issues with THP on arm64.
> 
> https://lore.kernel.org/r/1506527369-19535-1-git-send-email-will.deacon@arm.com/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/hugetlb.h | 6 ------
>  include/asm-generic/hugetlb.h    | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 2eb6c234d594..b88878ddc88b 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -17,12 +17,6 @@
>  extern bool arch_hugetlb_migration_supported(struct hstate *h);
>  #endif
>  
> -#define __HAVE_ARCH_HUGE_PTEP_GET
> -static inline pte_t huge_ptep_get(pte_t *ptep)
> -{
> -	return READ_ONCE(*ptep);
> -}
> -
>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>  					 unsigned long addr, unsigned long len)
>  {
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 822f433ac95c..40f85decc2ee 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -122,7 +122,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  #ifndef __HAVE_ARCH_HUGE_PTEP_GET
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>  {
> -	return *ptep;
> +	return READ_ONCE(*ptep);
>  }
>  #endif

I know you made this change in response to Will's comment.  And, since
changes were made to consistently use READ_ONCE in arm64 code, it makes
sense for that architecture.

However, with this change to generic code, you introduce READ_ONCE to
other architectures where it was not used before.  Could this possibly
introduce inconsistencies in their use of READ_ONCE?  To be honest, I
am not very good at identifying any possible issues this could cause.
However, it does seem possible.

Will was nervous about dropping this from arm64.  I'm just a little nervous
about adding it to other architectures.
-- 
Mike Kravetz
