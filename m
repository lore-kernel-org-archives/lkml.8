Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFEC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B876B21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIGO3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:29:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46885
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729786AbgIGOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:22:07 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="358301232"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 16:18:57 +0200
Date:   Mon, 7 Sep 2020 16:18:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_Coccinelle=3A_api=3A_Add_SmPL_scr?=
 =?UTF-8?Q?ipt_=E2=80=9Cuse=5Fdevm=5Fplatform=5Fget=5Fand=5Fioremap=5Fre?=
 =?UTF-8?Q?source=2Ecocci=E2=80=9D?=
In-Reply-To: <8aaa799f-0ec4-cfd0-854a-e1006d0d200a@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071618200.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de> <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de> <alpine.DEB.2.22.394.2009071357140.2476@hadrien> <477abcea-e008-e509-d03f-f2753ebdfb20@web.de> <alpine.DEB.2.22.394.2009071506350.2476@hadrien>
 <46d314d5-822e-3d73-2d70-015794556e56@web.de> <alpine.DEB.2.22.394.2009071544460.2476@hadrien> <8aaa799f-0ec4-cfd0-854a-e1006d0d200a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-540454265-1599488337=:2476"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-540454265-1599488337=:2476
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Sep 2020, Markus Elfring wrote:

> >>>>>> +@replacement depends on patch@
> >>>>>> +expression base, device1, device2, index, private, resource;
> >>>>>> +@@
> >>>>>> +(
> >>>>>> +-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> >>>>>> + base =
> >>>>>> +-       devm_ioremap_resource
> >>>>>> ++       devm_platform_get_and_ioremap_resource
> >>>>>> +                             (
> >>>>>> +-                             &
> >>>>>> +                               device1
> >>>>>> +-                                     ->dev
> >>>>>> +                              ,
> >>>>>> +-                             resource
> >>>>>> ++                             index, &resource
> >>>>>> +                             );
> >>>>>> +|
> >>>>>> +-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> >>>>>> + base =
> >>>>>> +-       devm_ioremap_resource
> >>>>>> ++       devm_platform_get_and_ioremap_resource
> >>>>>> +                             (device2,
> …
> >> Both source code change patterns from these branches of a SmPL disjunction
> >> work as I would expect it by the current Coccinelle software.
> >> Would you like to clarify any remaining related open issues?
> >
> > In one case the first argument of devm_ioremap_resource has to be changed
> > to produce the first argument of devm_platform_get_and_ioremap_resource
> > and in the other case there is no such change.  "work as I would expect"
> > is not a proper explanation of why this is correct.
>
> Would like to achieve that a SmPL script (like the one which I present here)
> can help to adjust the implementation of the functions “mvebu_sei_probe”
> and “hi655x_pmic_probe” (for example) for the desired reuse of the wrapper
> function “devm_platform_get_and_ioremap_resource”?
>
>
> > Maybe you can point to some previous commits that have made the change in this way.

I looked at some of the provided examples, but none of them leaves the
first argument of devm_ioremap_resource unchanged.

julia

>
> Not yet for these source code examples.
>
> Some patches were contributed.
> https://lore.kernel.org/patchwork/project/lkml/list/?q=devm_platform_get_and_ioremap_resource&archive=both&state=*
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=devm_platform_get_and_ioremap_resource
>
> Regards,
> Markus
>
--8323329-540454265-1599488337=:2476--
