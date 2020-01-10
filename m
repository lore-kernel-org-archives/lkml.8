Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86132C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E7720721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgAJMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:34:43 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18852 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728094AbgAJMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:34:43 -0500
X-IronPort-AV: E=Sophos;i="5.69,416,1571695200"; 
   d="scan'208";a="430787412"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:34:41 +0100
Date:   Fri, 10 Jan 2020 13:34:41 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
Message-ID: <alpine.DEB.2.21.2001101334160.2897@hadrien>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com> <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1162816898-1578659682=:2897"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1162816898-1578659682=:2897
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 10 Jan 2020, Markus Elfring wrote:

> > +@initialize:python@
> …
> > +def construct_warnings(str, suggested_fun):
>
> This function will be used only for the operation modes “org” and “report”.
> Thus I suggest to replace the specification “initialize” by a corresponding dependency
> which is already applied for the SmPL rule “r”.
>
>
> Can subsequent SmPL disjunctions become more succinct?
>
>
> The passing of function name variants contains a bit of duplicate Python code.
> Will a feature request like “Support for SmPL rule groups” become more interesting
> for the shown use case?
> https://github.com/coccinelle/coccinelle/issues/164

The code is fine as it is in these respects.

julia
--8323329-1162816898-1578659682=:2897--
