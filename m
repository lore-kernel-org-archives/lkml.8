Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78BEC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947ED206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgDFJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:46:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35203 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgDFJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:46:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0369X42t012565
        for <linux-kernel@vger.kernel.org>; Mon, 6 Apr 2020 05:46:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306pcycwh3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:46:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Mon, 6 Apr 2020 10:46:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Apr 2020 10:46:08 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0369kSTs60817466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 09:46:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4869BA405F;
        Mon,  6 Apr 2020 09:46:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A009EA405C;
        Mon,  6 Apr 2020 09:46:27 +0000 (GMT)
Received: from pomme.local (unknown [9.145.52.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Apr 2020 09:46:27 +0000 (GMT)
Subject: Re: [PATCH 7/8] mmap locking API: add MMAP_LOCK_INITIALIZER
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
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
References: <20200326070236.235835-1-walken@google.com>
 <20200326070236.235835-8-walken@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Mon, 6 Apr 2020 11:46:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326070236.235835-8-walken@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040609-4275-0000-0000-000003BA9033
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040609-4276-0000-0000-000038CFED5A
Message-Id: <1c463464-1d72-287e-e785-f077a95ccf20@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_05:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004060083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/03/2020 à 08:02, Michel Lespinasse a écrit :
> Define a new initializer for the mmap locking api.
> Initially this just evaluates to __RWSEM_INITIALIZER as the API
> is defined as wrappers around rwsem.

I can't see the benefit of this change.
The overall idea is to hide the mmap_sem name. Here the macro 
MMAP_LOCK_INITIALIZER() doesn't hide the name.

I think we can keep that in place until the real change of the mmap_sem to 
something else.

Cheers,
Laurent.

> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>   arch/x86/kernel/tboot.c    | 2 +-
>   drivers/firmware/efi/efi.c | 2 +-
>   include/linux/mmap_lock.h  | 2 ++
>   mm/init-mm.c               | 2 +-
>   4 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index b89f6ac6a0c0..4b79335624b1 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
>   	.pgd            = swapper_pg_dir,
>   	.mm_users       = ATOMIC_INIT(2),
>   	.mm_count       = ATOMIC_INIT(1),
> -	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	.mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
>   	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>   	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
>   };
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 21ea99f65113..5bdfe698cd7f 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -60,7 +60,7 @@ struct mm_struct efi_mm = {
>   	.mm_rb			= RB_ROOT,
>   	.mm_users		= ATOMIC_INIT(2),
>   	.mm_count		= ATOMIC_INIT(1),
> -	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
> +	.mmap_sem		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_sem),
>   	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
>   	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
>   	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 00d6cc02581d..7474b15bba38 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -1,6 +1,8 @@
>   #ifndef _LINUX_MMAP_LOCK_H
>   #define _LINUX_MMAP_LOCK_H
>   
> +#define MMAP_LOCK_INITIALIZER(name) __RWSEM_INITIALIZER(name)
> +
>   static inline void mmap_init_lock(struct mm_struct *mm)
>   {
>   	init_rwsem(&mm->mmap_sem);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 19603302a77f..3c128bd6a30c 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -31,7 +31,7 @@ struct mm_struct init_mm = {
>   	.pgd		= swapper_pg_dir,
>   	.mm_users	= ATOMIC_INIT(2),
>   	.mm_count	= ATOMIC_INIT(1),
> -	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
> +	.mmap_sem	= MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
>   	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>   	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>   	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
> 

