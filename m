Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E82081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406066AbgFXSto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:49:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406029AbgFXStn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:49:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OIX5IX131387;
        Wed, 24 Jun 2020 14:49:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vbn69har-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 14:49:38 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OIXB2H132081;
        Wed, 24 Jun 2020 14:49:37 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vbn69h8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 14:49:37 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OIYq9u001842;
        Wed, 24 Jun 2020 18:49:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 31uus70y14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 18:49:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05OInWjD24313934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 18:49:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B984203F;
        Wed, 24 Jun 2020 18:49:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B30442047;
        Wed, 24 Jun 2020 18:49:32 +0000 (GMT)
Received: from thinkpad (unknown [9.171.4.225])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 24 Jun 2020 18:49:31 +0000 (GMT)
Date:   Wed, 24 Jun 2020 20:49:30 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 18/26] mm/s390: Use general page fault accounting
Message-ID: <20200624204930.2445bcd6@thinkpad>
In-Reply-To: <20200619161335.9664-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
        <20200619161335.9664-1-peterx@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_15:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=711 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 12:13:35 -0400
Peter Xu <peterx@redhat.com> wrote:

> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
> 
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/s390/mm/fault.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index ab6d7eedcfab..4d62ca7d3e09 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	 * make sure we exit gracefully rather than endlessly redo
>  	 * the fault.
>  	 */
> -	fault = handle_mm_fault(vma, address, flags, NULL);
> +	fault = handle_mm_fault(vma, address, flags, regs);
>  	if (fault_signal_pending(fault, regs)) {
>  		fault = VM_FAULT_SIGNAL;
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;

There are two cases here where we skipped the accounting,
fault_signal_pending() and VM_FAULT_ERROR, similar to other archs.

fault_signal_pending() should be ok, because that only seems to be true
for fault & VM_FAULT_RETRY, in which case the new approach also skips
the accounting.

But for VM_FAULT_ERROR, the new approach would do accounting, IIUC. Is
that changed on purpose? See also my reply on [PATCH 01/26].

Regards,
Gerald
