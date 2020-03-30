Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7459C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53C520757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgC3Irm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:47:42 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59160
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729538AbgC3Irm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:47:42 -0400
X-IronPort-AV: E=Sophos;i="5.72,323,1580770800"; 
   d="scan'208";a="344238156"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 10:47:39 +0200
Date:   Mon, 30 Mar 2020 10:47:38 +0200 (CEST)
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
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Improving the Coccinelle
 software
In-Reply-To: <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de>
Message-ID: <alpine.DEB.2.21.2003301046530.2432@hadrien>
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-6-walken@google.com> <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de> <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com> <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com> <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-454865659-1585558059=:2432"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-454865659-1585558059=:2432
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 30 Mar 2020, Markus Elfring wrote:

> >> How will corresponding software development resources evolve?
> >
> > I don't think I understand the question, or, actually, are you asking
> > me or the coccinelle developers ?
>
> I hope that more development challenges will be picked up.
>
> The code from a mentioned source file can be reduced to the following
> test file.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kvm/mmu/paging_tmpl.h?id=7111951b8d4973bda27ff663f2cf18b663d15b48#n122
>
> // deleted part
> static inline int FNAME(is_present_gpte)(unsigned long pte)
> {
> #if PTTYPE != PTTYPE_EPT
> 	return pte & PT_PRESENT_MASK;
> #else
> 	return pte & 7;
> #endif
> }
> // deleted part
>
>
> Application of the software “Coccinelle 1.0.8-00029-ga549b9f0” (OCaml 4.10.0)
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-c paging_tmpl-excerpt1.h
> …
> (ONCE) CPP-MACRO: found known macro = FNAME
> …
> parse error
>  = File "paging_tmpl-excerpt1.h", line 2, column 41, charpos = 57
>   around = 'unsigned',
> …
> BAD:!!!!! static inline int FNAME(is_present_gpte)(unsigned long pte)
> …
> NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
> nb good = 1,  nb passed = 1 =========> 10.00% passed
> nb good = 1,  nb bad = 8 =========> 20.00% good or passed
>
>
> How would you like to improve the affected software areas?

This can be addressed by adding a macro definition to standard.h.

But once the change is done, I don't see any reason to bother with this.

julia
--8323329-454865659-1585558059=:2432--
