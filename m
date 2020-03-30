Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7278C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E4A20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgC3KU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:20:29 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19894 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729809AbgC3KU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:20:27 -0400
X-IronPort-AV: E=Sophos;i="5.72,323,1580770800"; 
   d="scan'208";a="442924652"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 12:20:24 +0200
Date:   Mon, 30 Mar 2020 12:20:24 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Michel Lespinasse <walken@google.com>,
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
In-Reply-To: <a840e22a-0152-6aa2-e626-33011ef4afe0@web.de>
Message-ID: <alpine.DEB.2.21.2003301220140.2432@hadrien>
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-6-walken@google.com> <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de> <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com> <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com> <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de> <alpine.DEB.2.21.2003301046530.2432@hadrien> <a840e22a-0152-6aa2-e626-33011ef4afe0@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-683971816-1585563625=:2432"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-683971816-1585563625=:2432
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 30 Mar 2020, Markus Elfring wrote:

> >> …
> >> (ONCE) CPP-MACRO: found known macro = FNAME
> >> …
> >> parse error
> …
> >> How would you like to improve the affected software areas?
> >
> > This can be addressed by adding a macro definition to standard.h.
>
> A corresponding specification is used already.
> https://github.com/coccinelle/coccinelle/blob/fdf0b68ddd0a518cc6ca64f063bc74ed54e29a7b/standard.h#L508
>
>
> > But once the change is done, I don't see any reason to bother with this.
>
> How will the support evolve for data processing around the application
> of similar macros?

Not at all.

julia
--8323329-683971816-1585563625=:2432--
