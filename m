Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9809C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E8D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgGaIpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:45:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42864
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730233AbgGaIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:45:08 -0400
X-IronPort-AV: E=Sophos;i="5.75,417,1589234400"; 
   d="scan'208";a="355689191"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 10:45:05 +0200
Date:   Fri, 31 Jul 2020 10:45:05 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: api: add kvfree script
In-Reply-To: <96a71d0e-ae6f-9355-b02a-b1a084376f1e@web.de>
Message-ID: <alpine.DEB.2.22.394.2007311044340.2439@hadrien>
References: <75532a99-4498-c64a-de34-c9033782aa9e@web.de> <alpine.DEB.2.22.394.2007302125580.2548@hadrien> <96a71d0e-ae6f-9355-b02a-b1a084376f1e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-701465646-1596185105=:2439"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-701465646-1596185105=:2439
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 31 Jul 2020, Markus Elfring wrote:

> >>> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> >>> +coccilib.org.print_todo(p[0], msg)
> >>
> >> * I find the diagnostic text insufficient.
> >
> > I also find the message not very informative.
>
> Is it interesting how quick such views can change?

Yes.  If one looks at something in context, one and understand it better
than the extract that you provided.

julia

> https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2007302214160.2548@hadrien/
> https://systeme.lip6.fr/pipermail/cocci/2020-July/008041.html
> https://lkml.org/lkml/2020/7/30/1015
>
> “…
> Actually, the message looks fine.  Sorry for the noise about that.
> …”
>
>
> Can such notifications become more helpful?
>
> Regards,
> Markus
>
--8323329-701465646-1596185105=:2439--
