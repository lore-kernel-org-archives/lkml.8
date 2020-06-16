Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20541C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083D721532
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbgFPP7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:59:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732382AbgFPP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:59:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GFxHG0023277;
        Tue, 16 Jun 2020 11:59:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pux0bwar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 11:59:41 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GFxZIv025182;
        Tue, 16 Jun 2020 11:59:41 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pux0bw9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 11:59:41 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GFvCiP005113;
        Tue, 16 Jun 2020 15:59:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 31mpe7t9b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 15:59:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GFxZdT8520138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 15:59:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0CBA11C058;
        Tue, 16 Jun 2020 15:59:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4956C11C054;
        Tue, 16 Jun 2020 15:59:35 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.3.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Jun 2020 15:59:35 +0000 (GMT)
Date:   Tue, 16 Jun 2020 17:59:33 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200616155933.GA12897@oc3871087118.ibm.com>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615222302.8452-1-peterx@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:23:02PM -0400, Peter Xu wrote:
> Use the new mm_fault_accounting() helper for page fault accounting.
> 
> Avoid doing page fault accounting multiple times if the page fault is retried.
> 
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/s390/mm/fault.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index dedc28be27ab..8ca207635b59 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -392,7 +392,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	unsigned long trans_exc_code;
>  	unsigned long address;
>  	unsigned int flags;
> -	vm_fault_t fault;
> +	vm_fault_t fault, major = 0;
> 
>  	tsk = current;
>  	/*
> @@ -428,7 +428,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	}
> 
>  	address = trans_exc_code & __FAIL_ADDR_MASK;
> -	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  	flags = FAULT_FLAG_DEFAULT;
>  	if (user_mode(regs))
>  		flags |= FAULT_FLAG_USER;
> @@ -480,6 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	 * the fault.
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
> +	major |= fault & VM_FAULT_MAJOR;
>  	if (fault_signal_pending(fault, regs)) {
>  		fault = VM_FAULT_SIGNAL;
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;
> 
> -	/*
> -	 * Major/minor page fault accounting is only done on the
> -	 * initial attempt. If we go through a retry, it is extremely
> -	 * likely that the page will be found in page cache at that point.
> -	 */
>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -		if (fault & VM_FAULT_MAJOR) {
> -			tsk->maj_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> -				      regs, address);
> -		} else {
> -			tsk->min_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> -				      regs, address);
> -		}
>  		if (fault & VM_FAULT_RETRY) {
>  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
>  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {

Seems like the call to mm_fault_accounting() will be missed if
we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
jumps to "out_up"...

> @@ -519,6 +505,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  			goto retry;
>  		}
>  	}
> +
> +	mm_fault_accounting(tsk, regs, address, major);
> +
>  	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
>  		address =  __gmap_link(gmap, current->thread.gmap_addr,
>  				       address);
> -- 
> 2.26.2
> 
