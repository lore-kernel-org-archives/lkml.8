Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4829FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268E420674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:19:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbgERNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:19:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ID413x088391;
        Mon, 18 May 2020 09:18:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312agck66k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:18:36 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04ID4H8R090068;
        Mon, 18 May 2020 09:18:35 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312agck65j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:18:35 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IDFda7012514;
        Mon, 18 May 2020 13:18:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3127t5hpc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 13:18:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IDIUh163635458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 13:18:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC93642042;
        Mon, 18 May 2020 13:18:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB9FB4203F;
        Mon, 18 May 2020 13:18:29 +0000 (GMT)
Received: from pomme.local (unknown [9.145.67.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 May 2020 13:18:29 +0000 (GMT)
Subject: Re: [PATCH v5 01/10] mmap locking API: initial implementation as
 rwsem wrappers
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-2-walken@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <f39081c8-cbcc-4478-5f9b-4f73651bc6a7@linux.ibm.com>
Date:   Mon, 18 May 2020 15:18:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-2-walken@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_05:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 cotscore=-2147483648
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2020 à 02:14, Michel Lespinasse a écrit :
> This change wraps the existing mmap_sem related rwsem calls into a new
> mmap locking API. There are two justifications for the new API:
> 
> - At first, it provides an easy hooking point to instrument mmap_sem
>    locking latencies independently of any other rwsems.
> 
> - In the future, it may be a starting point for replacing the rwsem
>    implementation with a different one, such as range locks.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>

> ---
>   include/linux/mm.h        |  1 +
>   include/linux/mmap_lock.h | 54 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 55 insertions(+)
>   create mode 100644 include/linux/mmap_lock.h
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..051ec782bdbb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -15,6 +15,7 @@
>   #include <linux/atomic.h>
>   #include <linux/debug_locks.h>
>   #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>   #include <linux/range.h>
>   #include <linux/pfn.h>
>   #include <linux/percpu-refcount.h>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> new file mode 100644
> index 000000000000..97ac53b66052
> --- /dev/null
> +++ b/include/linux/mmap_lock.h
> @@ -0,0 +1,54 @@
> +#ifndef _LINUX_MMAP_LOCK_H
> +#define _LINUX_MMAP_LOCK_H
> +
> +static inline void mmap_init_lock(struct mm_struct *mm)
> +{
> +	init_rwsem(&mm->mmap_sem);
> +}
> +
> +static inline void mmap_write_lock(struct mm_struct *mm)
> +{
> +	down_write(&mm->mmap_sem);
> +}
> +
> +static inline int mmap_write_lock_killable(struct mm_struct *mm)
> +{
> +	return down_write_killable(&mm->mmap_sem);
> +}
> +
> +static inline bool mmap_write_trylock(struct mm_struct *mm)
> +{
> +	return down_write_trylock(&mm->mmap_sem) != 0;
> +}
> +
> +static inline void mmap_write_unlock(struct mm_struct *mm)
> +{
> +	up_write(&mm->mmap_sem);
> +}
> +
> +static inline void mmap_write_downgrade(struct mm_struct *mm)
> +{
> +	downgrade_write(&mm->mmap_sem);
> +}
> +
> +static inline void mmap_read_lock(struct mm_struct *mm)
> +{
> +	down_read(&mm->mmap_sem);
> +}
> +
> +static inline int mmap_read_lock_killable(struct mm_struct *mm)
> +{
> +	return down_read_killable(&mm->mmap_sem);
> +}
> +
> +static inline bool mmap_read_trylock(struct mm_struct *mm)
> +{
> +	return down_read_trylock(&mm->mmap_sem) != 0;
> +}
> +
> +static inline void mmap_read_unlock(struct mm_struct *mm)
> +{
> +	up_read(&mm->mmap_sem);
> +}
> +
> +#endif /* _LINUX_MMAP_LOCK_H */
> 

