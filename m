Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF92620716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1Nxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:53:43 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:40257 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgC1Nxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 09:53:43 -0400
X-IronPort-AV: E=Sophos;i="5.72,316,1580770800"; 
   d="scan'208";a="442757694"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 14:53:40 +0100
Date:   Sat, 28 Mar 2020 14:53:40 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Checking the Coccinelle
 software
In-Reply-To: <590dbec7-341a-3480-dd47-cb3c65b023c7@web.de>
Message-ID: <alpine.DEB.2.21.2003281450360.3005@hadrien>
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-6-walken@google.com> <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de> <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com> <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com> <590dbec7-341a-3480-dd47-cb3c65b023c7@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-495123161-1585403621=:3005"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-495123161-1585403621=:3005
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 28 Mar 2020, Markus Elfring wrote:

> >> How will corresponding software development resources evolve?
> >
> > I don't think I understand the question, or, actually, are you asking
> > me or the coccinelle developers ?
>
> I hope that another communication approach can eventually increase
> the chances for a better common understanding of development challenges.
>
> The code from a mentioned source file can be reduced to the following
> test file.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/mm/fault.c?id=69c5eea3128e775fd3c70ecf0098105d96dee330#n34
>
> // deleted part
> static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
> 	unsigned long address)
> {
> 	struct vm_area_struct * vma = NULL;
> 	struct task_struct *tsk = current;
> 	struct mm_struct *mm = tsk->mm;
> // deleted part
> retry:
> 	down_read(&mm->mmap_sem);
> 	vma = find_vma(mm, address);
> 	if (!vma)
> 		goto bad_area;
> // deleted part
> }
> // deleted part
>
>
> Application of the software “Coccinelle 1.0.8-00029-ga549b9f0” (OCaml 4.10.0)
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-c do_page_fault-excerpt3.c
> …
> NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
> nb good = 15,  nb passed = 1 =========> 6.25% passed
> nb good = 15,  nb bad = 0 =========> 100.00% good or passed
>
>
> The discussed transformation approach can also be reduced for a test
> to the following script for the semantic patch language.
>
> @replacement@
> expression x;
> @@
> -down_read
> +mmap_read_lock
>  (
> - &
>   x
> - ->mmap_sem
>  )
>
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch use_mmap_locking_API_3.cocci do_page_fault-excerpt3.c
>
>
> The desired diff is not generated so far.
> How would you like to fix this situation?

The problem is due to a preceding goto where the destination is expressed
as a macro name.  Maybe there should be a warning in this case.

julia

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-495123161-1585403621=:3005--
