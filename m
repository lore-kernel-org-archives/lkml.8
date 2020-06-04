Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51522C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CC0206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgFDP4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:56:53 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37481
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729216AbgFDP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:56:52 -0400
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; 
   d="scan'208";a="350606174"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 17:56:39 +0200
Date:   Thu, 4 Jun 2020 17:56:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kzfree script
In-Reply-To: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
Message-ID: <alpine.DEB.2.21.2006041755360.2577@hadrien>
References: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-914190676-1591286199=:2577"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-914190676-1591286199=:2577
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 4 Jun 2020, Markus Elfring wrote:

> > Check for memset() with 0 followed by kfree().
>
> I suggest to simplify the SmPL code a bit like the following.
>
>
> > +virtual context
> > +virtual org
> > +virtual report
> > +virtual patch
>
> +virtual context, org, report, patch

This is pointless.

>
>
> …
> > +@@
> > +
> > +(
> > +* memset(E, 0, ...);
> > +|
> > +* memset(E, '\0', ...);
> > +)
> > +* kfree(E)@p;
>
> +@@
> +*memset(E, 0, ...);
> +*kfree(E)@p;
>
>
> How does the SmPL asterisk functionality fit to the operation
> modes “org” and “report”?

make coccicheck uses the option --no-show-diff for the org and report
modes.

>
> > +@@
> > +
> > +(
> > +- memset(E, 0, ...);
> > +|
> > +- memset(E, '\0', ...);
> > +)
> > +- kfree(E);
> > ++ kzfree(E);
>
> +@@
> +-memset(E, 0, ...);
> +-kfree
> ++kzfree
> +       (E);
>
> I got the impression that the specification of a SmPL disjunction
> could be omitted because of the technical detail that the isomorphism
> “zero_multiple_format” should handle such an use case already.
>
> Would you like to tolerate any extra source code between these function calls?

I already addressed these issues.

julia
--8323329-914190676-1591286199=:2577--
