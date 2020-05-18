Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA52C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2358B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERNYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:24:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3088 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgERNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:24:53 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ID44Ux134324;
        Mon, 18 May 2020 09:24:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312wsgw03g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:24:43 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IDKR9p083024;
        Mon, 18 May 2020 09:24:40 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312wsgvyyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:24:39 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IDL6q8010481;
        Mon, 18 May 2020 13:24:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3127t5hpm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 13:24:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IDOUw9983518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 13:24:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95D7B42045;
        Mon, 18 May 2020 13:24:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EDA142041;
        Mon, 18 May 2020 13:24:29 +0000 (GMT)
Received: from pomme.local (unknown [9.145.67.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 May 2020 13:24:29 +0000 (GMT)
Subject: Re: [PATCH v5 06/10] mmap locking API: convert nested write lock
 sites
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-7-walken@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <e567f21c-3539-09f1-7435-0e46205fa168@linux.ibm.com>
Date:   Mon, 18 May 2020 15:24:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-7-walken@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 cotscore=-2147483648 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2020 à 02:14, Michel Lespinasse a écrit :
> Add API for nested write locks and convert the few call sites doing that.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>

> ---
>   arch/um/include/asm/mmu_context.h | 3 ++-
>   include/linux/mmap_lock.h         | 5 +++++
>   kernel/fork.c                     | 2 +-
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
> index 62262c5c7785..17ddd4edf875 100644
> --- a/arch/um/include/asm/mmu_context.h
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/sched.h>
>   #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>   
>   #include <asm/mmu.h>
>   
> @@ -47,7 +48,7 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
>   	 * when the new ->mm is used for the first time.
>   	 */
>   	__switch_mm(&new->context.id);
> -	down_write_nested(&new->mmap_sem, 1);
> +	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
>   	uml_setup_stubs(new);
>   	mmap_write_unlock(new);
>   }
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 97ac53b66052..a757cb30ae77 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -11,6 +11,11 @@ static inline void mmap_write_lock(struct mm_struct *mm)
>   	down_write(&mm->mmap_sem);
>   }
>   
> +static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
> +{
> +	down_write_nested(&mm->mmap_sem, subclass);
> +}
> +
>   static inline int mmap_write_lock_killable(struct mm_struct *mm)
>   {
>   	return down_write_killable(&mm->mmap_sem);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 41d3f45c058e..a5d1d20ccba7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -499,7 +499,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>   	/*
>   	 * Not linked in yet - no deadlock potential:
>   	 */
> -	down_write_nested(&mm->mmap_sem, SINGLE_DEPTH_NESTING);
> +	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
>   
>   	/* No ordering required: file already has been exposed. */
>   	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> 

