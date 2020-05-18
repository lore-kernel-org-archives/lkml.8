Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC2BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD59A20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgERNds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:33:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgERNdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:33:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IDXB2t173303;
        Mon, 18 May 2020 09:33:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312bg63c9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:33:38 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IDXF2u173785;
        Mon, 18 May 2020 09:33:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312bg63c6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:33:38 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IDTqTh021606;
        Mon, 18 May 2020 13:33:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3127t5hpnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 13:33:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IDXX4C52953254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 13:33:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 196E142047;
        Mon, 18 May 2020 13:33:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CEAD4203F;
        Mon, 18 May 2020 13:33:32 +0000 (GMT)
Received: from pomme.local (unknown [9.145.67.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 May 2020 13:33:31 +0000 (GMT)
Subject: Re: [PATCH v5 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
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
 <20200422001422.232330-9-walken@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <f85da2d0-7895-5757-4586-2d0fca5ba30c@linux.ibm.com>
Date:   Mon, 18 May 2020 15:33:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-9-walken@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2020 à 02:14, Michel Lespinasse a écrit :
> Define a new initializer for the mmap locking api.
> Initially this just evaluates to __RWSEM_INITIALIZER as the API
> is defined as wrappers around rwsem.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Despite the same remark Vlastimil wrote about the (name).mmap_sem in the 
MMAP_LOCK_INITIALIZER macro,

Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>

> ---
>   arch/x86/kernel/tboot.c    | 2 +-
>   drivers/firmware/efi/efi.c | 2 +-
>   include/linux/mmap_lock.h  | 3 +++
>   mm/init-mm.c               | 2 +-
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index b89f6ac6a0c0..885058325c20 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
>   	.pgd            = swapper_pg_dir,
>   	.mm_users       = ATOMIC_INIT(2),
>   	.mm_count       = ATOMIC_INIT(1),
> -	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	MMAP_LOCK_INITIALIZER(init_mm)
>   	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>   	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
>   };
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 911a2bd0f6b7..916313ec8acb 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -54,7 +54,7 @@ struct mm_struct efi_mm = {
>   	.mm_rb			= RB_ROOT,
>   	.mm_users		= ATOMIC_INIT(2),
>   	.mm_count		= ATOMIC_INIT(1),
> -	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
> +	MMAP_LOCK_INITIALIZER(efi_mm)
>   	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
>   	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
>   	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index d1826ce42f00..9e104835a0d1 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -1,6 +1,9 @@
>   #ifndef _LINUX_MMAP_LOCK_H
>   #define _LINUX_MMAP_LOCK_H
>   
> +#define MMAP_LOCK_INITIALIZER(name) \
> +	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
> +
>   static inline void mmap_init_lock(struct mm_struct *mm)
>   {
>   	init_rwsem(&mm->mmap_sem);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 19603302a77f..fe9c03d8e07b 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -31,7 +31,7 @@ struct mm_struct init_mm = {
>   	.pgd		= swapper_pg_dir,
>   	.mm_users	= ATOMIC_INIT(2),
>   	.mm_count	= ATOMIC_INIT(1),
> -	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	MMAP_LOCK_INITIALIZER(init_mm)
>   	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>   	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>   	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
> 

