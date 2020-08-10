Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40BAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E52206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHJUwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:52:40 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23841 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgHJUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:52:40 -0400
X-IronPort-AV: E=Sophos;i="5.75,458,1589234400"; 
   d="scan'208";a="463066759"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 22:52:38 +0200
Date:   Mon, 10 Aug 2020 22:52:37 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [Cocci] [PATCH v3] documentation: coccinelle: Improve command
 example for make C={1, 2}
In-Reply-To: <478715f8-87dd-7b4d-d3fd-01585f5f3bd7@web.de>
Message-ID: <alpine.DEB.2.22.394.2008102249570.2466@hadrien>
References: <478715f8-87dd-7b4d-d3fd-01585f5f3bd7@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1168634418-1597092758=:2466"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1168634418-1597092758=:2466
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 10 Aug 2020, Markus Elfring wrote:

> > the usage of the makefile C variable flag by coccicheck.
>
> * Can it be confusing to denote an item as a variable and a flag?
>
> * Would you really like to stress here that a flag can be variable?

This is not part of the documentation, so it doesn't really matter.

Nevertheless, Sumera, there is stail an occurrence of flag in the proposed
change to the documentation, so you could indeed change that one to
variable.

>
>
> > +This variable can be used to run scripts for …
>
> Can the scope for a make command be selected also without such a variable?

If you know something that is different than what is in the documentation,
then please say what it is.  Don't just ask questions.

> Will clarification requests for previously mentioned background information
> influence the proposed descriptions any further?

The point is to document the use of make coccicheck, not the C variables.
So the point about KBUILD_CHECK, while interesting, does not seem
appropriate for this documentation.

julia
--8323329-1168634418-1597092758=:2466--
