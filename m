Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C01C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE8F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCXLq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:46:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727272AbgCXLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:46:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OBYTj4028125
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:46:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywd2ry7ew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:46:55 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 24 Mar 2020 11:46:53 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 11:46:50 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02OBknrS27001084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 11:46:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3682B42042;
        Tue, 24 Mar 2020 11:46:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B05A042041;
        Tue, 24 Mar 2020 11:46:48 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.13.129])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 11:46:48 +0000 (GMT)
Date:   Tue, 24 Mar 2020 11:12:15 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/7] KVM: Fix out of range accesses to memslots
In-Reply-To: <6f62f9db-a4c5-051c-2189-670d5c8707da@de.ibm.com>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
        <20200320205546.2396-2-sean.j.christopherson@intel.com>
        <6f62f9db-a4c5-051c-2189-670d5c8707da@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032411-0028-0000-0000-000003EA8956
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032411-0029-0000-0000-000024AFF2BB
Message-Id: <20200324111215.46e4b856@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=27 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=866 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 08:12:59 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 20.03.20 21:55, Sean Christopherson wrote:
> > Reset the LRU slot if it becomes invalid when deleting a memslot to
> > fix an out-of-bounds/use-after-free access when searching through
> > memslots.
> > 
> > Explicitly check for there being no used slots in
> > search_memslots(), and in the caller of s390's approximation
> > variant.
> > 
> > Fixes: 36947254e5f9 ("KVM: Dynamically size memslot array based on
> > number of used slots") Reported-by: Qian Cai <cai@lca.pw>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c | 3 +++
> >  include/linux/kvm_host.h | 3 +++
> >  virt/kvm/kvm_main.c      | 3 +++
> >  3 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 807ed6d722dd..cb15fdda1fee 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2002,6 +2002,9 @@ static int kvm_s390_get_cmma(struct kvm *kvm,
> > struct kvm_s390_cmma_log *args,  
> 
> Adding Claudio, but
> >  	struct kvm_memslots *slots = kvm_memslots(kvm);
> >  	struct kvm_memory_slot *ms;
> >  
> > +	if (unlikely(!slots->used_slots))
> > +		return 0;
> > +  

this should never happen, as this function is only called during
migration, and if we don't have any memory slots, then we will not try
to migrate them. 

But this is something that is triggered by userspace, so we need to
protect the kernel from rogue or broken userspace.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> this looks sane and like the right fix.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> >  	cur_gfn = kvm_s390_next_dirty_cmma(slots, args->start_gfn);
> >  	ms = gfn_to_memslot(kvm, cur_gfn);
> >  	args->count = 0;
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 35bc52e187a2..b19dee4ed7d9 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1032,6 +1032,9 @@ search_memslots(struct kvm_memslots *slots,
> > gfn_t gfn) int slot = atomic_read(&slots->lru_slot);
> >  	struct kvm_memory_slot *memslots = slots->memslots;
> >  
> > +	if (unlikely(!slots->used_slots))
> > +		return NULL;
> > +
> >  	if (gfn >= memslots[slot].base_gfn &&
> >  	    gfn < memslots[slot].base_gfn + memslots[slot].npages)
> >  		return &memslots[slot];
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 28eae681859f..f744bc603c53 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -882,6 +882,9 @@ static inline void kvm_memslot_delete(struct
> > kvm_memslots *slots, 
> >  	slots->used_slots--;
> >  
> > +	if (atomic_read(&slots->lru_slot) >= slots->used_slots)
> > +		atomic_set(&slots->lru_slot, 0);
> > +
> >  	for (i = slots->id_to_index[memslot->id]; i <
> > slots->used_slots; i++) { mslots[i] = mslots[i + 1];
> >  		slots->id_to_index[mslots[i].id] = i;
> >   

