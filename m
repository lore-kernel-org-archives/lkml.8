Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCBE206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFVMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:19:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47296
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727852AbgFVMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:19:08 -0400
X-IronPort-AV: E=Sophos;i="5.75,266,1589234400"; 
   d="scan'208";a="352352552"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:19:06 +0200
Date:   Mon, 22 Jun 2020 14:19:06 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3] coccinelle: misc: add array_size_dup script
 to detect missed overflow checks
In-Reply-To: <e57c419b-a64a-55a1-be7a-8f45edaea3bf@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006221418110.2531@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <20200619131313.15468-1-efremov@linux.com> <alpine.DEB.2.22.394.2006212255140.2501@hadrien> <e57c419b-a64a-55a1-be7a-8f45edaea3bf@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jun 2020, Denis Efremov wrote:

> What do you think about removing duplicates warning from the rule?
>
> I mean this kind of warnings: "WARNING: same array_size (line {p1[0].line})"
>
> As for now, I think it's better to not disturb developers with this kind
> of things.

I agree.  I guess there is a small overhead for the test, but if the code
is not performance critical, being simpler is probably better.

julia


>
> Thanks,
> Denis
>
> >> +@as_dup@
> >> +expression subE1 <= as.E1;
> >> +expression subE2 <= as.E2;
> >> +expression as.E1, as.E2, E3;
> >> +assignment operator aop;
> >> +position p1, p2;
> >> +@@
> >> +
> >> +* array_size(E1, E2)@p1
> >> +  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
> >> +      when != &\(E1\|E2\|subE1\|subE2\)
> >> +* array_size(E1, E2)@p2
> >> +
> >> +@script:python depends on report@
> >> +p1 << as_dup.p1;
> >> +p2 << as_dup.p2;
> >> +@@
> >> +
> >> +coccilib.report.print_report(p2[0],
> >> +f"WARNING: same array_size (line {p1[0].line})")
> >> +
> >> +@script:python depends on org@
> >> +p1 << as_dup.p1;
> >> +p2 << as_dup.p2;
> >> +@@
> >> +
> >> +coccilib.org.print_todo(p2[0],
> >> +f"WARNING: same array_size (line {p1[0].line})")
> >> +
>
>
