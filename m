Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DCAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBBF2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHJOZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:25:02 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25596 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbgHJOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:24:57 -0400
X-IronPort-AV: E=Sophos;i="5.75,457,1589234400"; 
   d="scan'208";a="463038467"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 16:24:54 +0200
Date:   Mon, 10 Aug 2020 16:24:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] documentation: coccinelle: Improve command example
 for make C={1, 2}
In-Reply-To: <20200810081914.37224551@lwn.net>
Message-ID: <alpine.DEB.2.22.394.2008101624380.2466@hadrien>
References: <ffe8c50d-0bb5-9477-a20c-96aa7bb45067@web.de> <20200810081914.37224551@lwn.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1836737229-1597069495=:2466"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1836737229-1597069495=:2466
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 10 Aug 2020, Jonathan Corbet wrote:

> On Mon, 10 Aug 2020 09:30:18 +0200
> Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > > Modify coccinelle documentation to further clarify
> > > the usage of the makefile C variable flag by coccicheck.
> >
> > How do you think about a wording variant like the following
> > for the change description?
> >
> >    Clarify the usage of the make variable “C” for coccicheck.
> >
> >
> > > +C flag is used. The C flag is a variable used by the makefile
> >
> > Can such a wording approach trigger understanding difficulties?
> > [...]
>
> Markus, please don't harass our contributors.  This patch is an
> improvement and, unless Julia disagrees, I am happy to apply it.

There will be a V3.  Thanks.

julia
--8323329-1836737229-1597069495=:2466--
