Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9403C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93090214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kC1IqvAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHUFkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:40:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgHUFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:40:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07L5XCl5090697;
        Fri, 21 Aug 2020 01:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=Ndo/wsx4DSB4NS1qTcy70CYie2hiXo+pQWCA3AYcodM=;
 b=kC1IqvAM5r4XXMf/s2qI10NTJ4ckElK6fMNK9TX++qH4j9PgLCEPAQ+iOW0oPdOJ+1xV
 72Oq457P/uvGmSgJNBd/qa3CCGl1mwTDbbJidAnaK6Ifv5e0aPlYj8Qe2Dr4wFUbJpM+
 Ie5xprReXIBaX30t0arLIdoBP4qJszqgvV64YVtiZsWLmS3VF+PASzYt0QOhzXyo5hfY
 iNK9JrfxOiANpZJFSK8dBS3czrE9SMMrVb6Gxq787Z/NU/YL1Vh2ltjYEtavwKNFnX5c
 v1faFNkDsEmfBgJSTwYX38gQ7B/v+B7ocUv0PjaBJpsOdG2hjpS2dEFk+a0YRwnJsSv1 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33273psd6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 01:40:01 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07L5Y4w4095720;
        Fri, 21 Aug 2020 01:40:01 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33273psd5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 01:40:01 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L5YqaP029166;
        Fri, 21 Aug 2020 05:39:59 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3304tm1ns2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 05:39:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07L5dwv61639074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 05:39:58 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD5766A04F;
        Fri, 21 Aug 2020 05:39:58 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F1A6A04D;
        Fri, 21 Aug 2020 05:39:54 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.2.201])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 05:39:53 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org, hch@lst.de, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
In-Reply-To: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
Date:   Fri, 21 Aug 2020 11:09:51 +0530
Message-ID: <87y2m8muag.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_05:2020-08-19,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 mlxlogscore=687 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> For SMP systems using IPI based TLB invalidation, looking at
> current->active_mm is entirely reasonable. This then presents the
> following race condition:
>
>
>   CPU0			CPU1
>
>   flush_tlb_mm(mm)	use_mm(mm)
>     <send-IPI>
> 			  tsk->active_mm = mm;
> 			  <IPI>
> 			    if (tsk->active_mm == mm)
> 			      // flush TLBs
> 			  </IPI>
> 			  switch_mm(old_mm,mm,tsk);
>
>
> Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
> because the IPI lands before we actually switched.
>
> Avoid this by disabling IRQs across changing ->active_mm and
> switch_mm().
>
> [ There are all sorts of reasons this might be harmless for various
> architecture specific reasons, but best not leave the door open at
> all. ]


Do we have similar race with exec_mmap()? I am looking at exec_mmap()
runnning parallel to do_exit_flush_lazy_tlb(). We can get

	if (current->active_mm == mm) {

true and if we don't disable irq around updating tsk->mm/active_mm we
can end up doing mmdrop on wrong mm?

>
> Cc: stable@kernel.org
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>
> Sorry, I dropped the ball on this and only found it because I was
> looking at the whole membarrier things vs use_mm().
>
>
>  kernel/kthread.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 1d9e2fdfd67a..7221dcbffef3 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1241,13 +1241,15 @@ void kthread_use_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(tsk->mm);
>  
>  	task_lock(tsk);
> +	local_irq_disable();
>  	active_mm = tsk->active_mm;
>  	if (active_mm != mm) {
>  		mmgrab(mm);
>  		tsk->active_mm = mm;
>  	}
>  	tsk->mm = mm;
> -	switch_mm(active_mm, mm, tsk);
> +	switch_mm_irqs_off(active_mm, mm, tsk);
> +	local_irq_enable();
>  	task_unlock(tsk);
>  #ifdef finish_arch_post_lock_switch
>  	finish_arch_post_lock_switch();
> @@ -1276,9 +1278,11 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
> +	local_irq_disable();
>  	tsk->mm = NULL;
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
> +	local_irq_enable();
>  	task_unlock(tsk);
>  }
>  EXPORT_SYMBOL_GPL(kthread_unuse_mm);
