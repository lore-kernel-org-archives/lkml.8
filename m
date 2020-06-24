Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B434C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D692081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406008AbgFXStR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:49:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405384AbgFXStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:49:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OIXUI1058498;
        Wed, 24 Jun 2020 14:49:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31uwym1w9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 14:49:10 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OIkCUN097446;
        Wed, 24 Jun 2020 14:49:09 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31uwym1w93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 14:49:09 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OIagc6016544;
        Wed, 24 Jun 2020 18:49:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 31uus50y4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 18:49:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05OIn52A63438938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 18:49:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16F63A4051;
        Wed, 24 Jun 2020 18:49:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6F44A404D;
        Wed, 24 Jun 2020 18:49:04 +0000 (GMT)
Received: from thinkpad (unknown [9.171.4.225])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 24 Jun 2020 18:49:04 +0000 (GMT)
Date:   Wed, 24 Jun 2020 20:49:03 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200624204903.097a5a58@thinkpad>
In-Reply-To: <20200619160538.8641-2-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
        <20200619160538.8641-2-peterx@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_15:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 cotscore=-2147483648 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 12:05:13 -0400
Peter Xu <peterx@redhat.com> wrote:

[...]

> @@ -4393,6 +4425,38 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			mem_cgroup_oom_synchronize(false);
>  	}
> 
> +	if (ret & VM_FAULT_RETRY)
> +		return ret;

I'm wondering if this also needs a check and exit for VM_FAULT_ERROR.
In arch code (s390 and all others I briefly checked), the accounting
was skipped for VM_FAULT_ERROR case.

> +
> +	/*
> +	 * Do accounting in the common code, to avoid unnecessary
> +	 * architecture differences or duplicated code.
> +	 *
> +	 * We arbitrarily make the rules be:
> +	 *
> +	 *  - faults that never even got here (because the address
> +	 *    wasn't valid). That includes arch_vma_access_permitted()

Missing "do not count" at the end of the first sentence?

> +	 *    failing above.
> +	 *
> +	 *    So this is expressly not a "this many hardware page
> +	 *    faults" counter. Use the hw profiling for that.
> +	 *
> +	 *  - incomplete faults (ie RETRY) do not count (see above).
> +	 *    They will only count once completed.
> +	 *
> +	 *  - the fault counts as a "major" fault when the final
> +	 *    successful fault is VM_FAULT_MAJOR, or if it was a
> +	 *    retry (which implies that we couldn't handle it
> +	 *    immediately previously).
> +	 *
> +	 *  - if the fault is done for GUP, regs wil be NULL and

wil -> will

Regards,
Gerald
