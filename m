Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8698C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A586E21569
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgAKHok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 02:44:40 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:25507
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbgAKHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 02:44:39 -0500
X-IronPort-AV: E=Sophos;i="5.69,420,1571695200"; 
   d="scan'208";a="335474693"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 08:44:37 +0100
Date:   Sat, 11 Jan 2020 08:44:36 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
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
Subject: Re: [v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <5a9f1ad1-3881-2004-2a7b-d61f1d201cf9@web.de>
Message-ID: <alpine.DEB.2.21.2001110841140.2965@hadrien>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com> <91abb141-57b8-7659-25ec-8080e290d846@web.de> <c4ada2f2-19b0-91ef-ddf3-a1999f4209ea@linux.alibaba.com> <5a9f1ad1-3881-2004-2a7b-d61f1d201cf9@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +*do_div(f, \( l \| ul \| ul64 \| sl64 \) );
> >
> > We agree with Julia:
> > I don't se any point to this.
>
> Can the avoidance of duplicate source code (according to SmPL disjunctions)
> trigger positive effects on run time characteristics and software maintenance?

Markus.  Please stop asking this question.  You are bothering people with
this advice, why don't _you_ figure out once and for all whether the change
that you suggest has any "positive effects on the run time
characteristics"?  Hint: it will not. You don't even have to run Coccinelle
to see that.  Just use spatch --parse-cocci on your two suggestions and you
will see that they expand to the same thing.  Coccinelle has a pass that
propagates disjunctions at the sub-statement level to the statement level.

julia
