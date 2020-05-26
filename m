Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9151C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA452075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgEZIrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:47:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbgEZIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:47:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04Q8VqB1080618;
        Tue, 26 May 2020 04:46:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316ywmn410-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 04:46:57 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04Q8iFuh143058;
        Tue, 26 May 2020 04:46:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316ywmn407-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 04:46:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04Q8j5Cn009811;
        Tue, 26 May 2020 08:46:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 316uf85h9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 08:46:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04Q8kqK863242334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 08:46:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4891C11C04C;
        Tue, 26 May 2020 08:46:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70E7E11C058;
        Tue, 26 May 2020 08:46:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.200.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 May 2020 08:46:51 +0000 (GMT)
Date:   Tue, 26 May 2020 11:46:49 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] mm/gup: correct pin_user_pages.rst location
Message-ID: <20200526084649.GG13212@linux.ibm.com>
References: <20200526081338.179532-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526081338.179532-1-vkuznets@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-25_12:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=688 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:13:38AM +0200, Vitaly Kuznetsov wrote:
> pin_user_pages.rst lives in Documentation/core-api/, not Documentation/vm/,
> adjust all links accordingly.
> 
> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> Fixes: eddb1c228f79 ("mm/gup: introduce pin_user_pages*() and FOLL_PIN")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mm.h |  4 ++--
>  mm/gup.c           | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..1f2850465f59 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1219,7 +1219,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
>   * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
>   * scheme).
>   *
> - * For more information, please see Documentation/vm/pin_user_pages.rst.
> + * For more information, please see Documentation/core-api/pin_user_pages.rst.
>   *
>   * @page:	pointer to page to be queried.
>   * @Return:	True, if it is likely that the page has been "dma-pinned".
> @@ -2834,7 +2834,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>   * releasing pages: get_user_pages*() pages must be released via put_page(),
>   * while pin_user_pages*() pages must be released via unpin_user_page().
>   *
> - * Please see Documentation/vm/pin_user_pages.rst for more information.
> + * Please see Documentation/core-api/pin_user_pages.rst for more information.
>   */
>  
>  static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
> diff --git a/mm/gup.c b/mm/gup.c
> index 87a6a59fe667..87a3a4b400f9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2845,10 +2845,10 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>   * the arguments here are identical.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for further details.
> + * see Documentation/core-api/pin_user_pages.rst for further details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  int pin_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
> @@ -2885,10 +2885,10 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
>   * the arguments here are identical.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  			   unsigned long start, unsigned long nr_pages,
> @@ -2921,10 +2921,10 @@ EXPORT_SYMBOL(pin_user_pages_remote);
>   * FOLL_PIN is set.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
> -- 
> 2.25.4
> 

-- 
Sincerely yours,
Mike.
