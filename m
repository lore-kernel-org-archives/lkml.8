Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB47208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgFRVIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:08:44 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59021 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgFRVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:08:43 -0400
X-IronPort-AV: E=Sophos;i="5.75,253,1589234400"; 
   d="scan'208";a="455489962"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:08:42 +0200
Date:   Thu, 18 Jun 2020 23:08:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
In-Reply-To: <202006181346.ECCBE1FC0E@keescook>
Message-ID: <alpine.DEB.2.22.394.2006182308110.2367@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <202006171103.327F86B1C@keescook> <alpine.DEB.2.22.394.2006172051280.3083@hadrien> <202006181249.8B826D9@keescook> <alpine.DEB.2.22.394.2006182155260.2367@hadrien> <202006181346.ECCBE1FC0E@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jun 2020, Kees Cook wrote:

> On Thu, Jun 18, 2020 at 09:56:18PM +0200, Julia Lawall wrote:
> > @@
> > identifier i,fld;
> > expression e;
> > @@
> >
> > \(\(i\|e.fld\|e->fld\) \& E\)
> >
> > The e will match all of the variants you are concerned about.
>
> Ah, I see! Okay, that's good. And the "& E" part is to effectively
> collect it into E (as in, both the left and right of the & must match).

Yes

> So to do the matching from earlier:
>
> @@
> identifier i, fld;
> expression e, ARG1, ARG2;
> @@
>
> array_size(\(\(i\|e.fld\|e->fld\) \& ARG1\), ARG2);

Yes, that would be fine.

julia
