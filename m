Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24043C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B7D206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgFZTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:54:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58724 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbgFZTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:54:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QJV3HW154613;
        Fri, 26 Jun 2020 15:54:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vvkys7k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 15:54:31 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05QJXDQv165156;
        Fri, 26 Jun 2020 15:54:30 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vvkys7jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 15:54:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QJVmxQ013667;
        Fri, 26 Jun 2020 19:54:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 31uusjk9bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 19:54:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QJr7mj62456072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 19:53:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98804A405B;
        Fri, 26 Jun 2020 19:54:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38EC1A4054;
        Fri, 26 Jun 2020 19:54:26 +0000 (GMT)
Received: from thinkpad (unknown [9.171.60.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Jun 2020 19:54:26 +0000 (GMT)
Date:   Fri, 26 Jun 2020 21:54:24 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200626215424.581d6077@thinkpad>
In-Reply-To: <20200624203412.GB64004@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
        <20200619160538.8641-2-peterx@redhat.com>
        <20200624204903.097a5a58@thinkpad>
        <20200624203412.GB64004@xz-x1>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_10:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 cotscore=-2147483648
 spamscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 16:34:12 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jun 24, 2020 at 08:49:03PM +0200, Gerald Schaefer wrote:
> > On Fri, 19 Jun 2020 12:05:13 -0400
> > Peter Xu <peterx@redhat.com> wrote:
> > 
> > [...]
> > 
> > > @@ -4393,6 +4425,38 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > >  			mem_cgroup_oom_synchronize(false);
> > >  	}
> > > 
> > > +	if (ret & VM_FAULT_RETRY)
> > > +		return ret;
> > 
> > I'm wondering if this also needs a check and exit for VM_FAULT_ERROR.
> > In arch code (s390 and all others I briefly checked), the accounting
> > was skipped for VM_FAULT_ERROR case.
> 
> Yes. I didn't explicitly add the check because I thought it's still OK to count
> the error cases, especially after we've discussed about
> PERF_COUNT_SW_PAGE_FAULTS in v1.  So far, the major reason (iiuc) to have
> PERF_COUNT_SW_PAGE_FAULTS still in per-arch handlers is to also cover these
> corner cases like VM_FAULT_ERROR.  So to me it makes sense too to also count
> them in here.  But I agree it changes the old counting on most archs.

Having PERF_COUNT_SW_PAGE_FAULTS count everything including VM_FAULT_ERROR
is OK. Just major/minor accounting should be only about successes, IIRC from
v1 discussion.

The "new rules" also say

+	 *  - faults that never even got here (because the address
+	 *    wasn't valid). That includes arch_vma_access_permitted()
+	 *    failing above.

VM_FAULT_ERROR, and also the arch-specific VM_FAULT_BADxxx, qualify
as "address wasn't valid" I think, so they should not be counted as
major/minor.

IIRC from v1, and we want to only count success as major/minor, maybe
the rule could also be made more clear about that, e.g. like

+	 *  - unsuccessful faults (because the address wasn't valid)
+	 *    do not count. That includes arch_vma_access_permitted()
+	 *    failing above.

> 
> Again, I don't have strong opinion either on this, just like the same to
> PERF_COUNT_SW_PAGE_FAULTS...  But if no one disagree, I will change this to:
> 
>   if (ret & (VM_FAULT_RETRY | VM_FAULT_ERROR))
>       return ret;
> 
> So we try our best to follow the past.

Sounds good to me, and VM_FAULT_BADxxx should never show up here.

> 
> Btw, note that there will still be some even more special corner cases. E.g.,
> for ARM64 it's also not accounted for some ARM64 specific fault errors
> (VM_FAULT_BADMAP, VM_FAULT_BADACCESS).  So even if we don't count
> VM_FAULT_ERROR, we might still count these for ARM64.  We can try to redefine
> VM_FAULT_ERROR in ARM64 to cover all the arch-specific errors, however that
> seems an overkill to me sololy for fault accountings, so hopefully I can ignore
> that difference.

Hmm, arm64 already does not count the VM_FAULT_BADxxx, but also does not
call handle_mm_fault() for those, so no change with this patch. arm (and
also unicore32) do count those, but also not call handle_mm_fault(), so
there would be the change that they lose accounting, IIUC.

I agree that this probably can be ignored. The code in arm64 also looks
more recent, so it's probably just a left-over in arm/unicore32 code.

Regards,
Gerald
