Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD49207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgFOPnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:43:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59226
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727785AbgFOPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:43:09 -0400
X-IronPort-AV: E=Sophos;i="5.73,515,1583190000"; 
   d="scan'208";a="351660878"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 17:43:06 +0200
Date:   Mon, 15 Jun 2020 17:43:06 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add device_attr_show script
In-Reply-To: <1f028ee6-b014-c240-21d8-0c1950334fe6@web.de>
Message-ID: <alpine.DEB.2.22.394.2006151742090.23306@hadrien>
References: <1f028ee6-b014-c240-21d8-0c1950334fe6@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-34029661-1592235787=:23306"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-34029661-1592235787=:23306
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 15 Jun 2020, Markus Elfring wrote:

> > +// Confidence: High
>
> Would you like to add any suggestion for a possible patch message?
>
>
> …
> > +virtual report
> > +virtual org
> > +virtual context
> > +virtual patch
>
> +virtual report, org, context, patch
>
> Is such a SmPL code variant more succinct?

This doens't matter.

>
>
> …
> > +ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	<...
> > +*	return snprintf@p(...);
> > +	...>
> > +}
>
> I suggest to reconsider the selection of the SmPL nest construct.
> https://github.com/coccinelle/coccinelle/blob/e06b9156dfa02a28cf3cbf0913a10513f3d163ab/docs/manual/cocci_syntax.tex#L783
>
> Can the construct “<+... … ...+>” become relevant here?

<... ...> is fine if the only thing that will be used afterwards is what
is inside the <... ...>

julia

>
>
> Would you like to consider any further software design consequences
> around the safe application of the asterisk functionality in rules
> for the semantic patch language?
>
> Regards,
> Markus
>
--8323329-34029661-1592235787=:23306--
