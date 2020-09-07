Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C9C21532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgIGRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:21:18 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62077 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729667AbgIGNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:38 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="466420197"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 15:46:44 +0200
Date:   Mon, 7 Sep 2020 15:46:44 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Dejin Zheng <zhengdejin5@gmail.com>,
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
In-Reply-To: <46d314d5-822e-3d73-2d70-015794556e56@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071544460.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de> <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de> <alpine.DEB.2.22.394.2009071357140.2476@hadrien> <477abcea-e008-e509-d03f-f2753ebdfb20@web.de> <alpine.DEB.2.22.394.2009071506350.2476@hadrien>
 <46d314d5-822e-3d73-2d70-015794556e56@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>> +@replacement depends on patch@
> >>>> +expression base, device1, device2, index, private, resource;
> >>>> +@@
> >>>> +(
> >>>> +-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> >>>> + base =
> >>>> +-       devm_ioremap_resource
> >>>> ++       devm_platform_get_and_ioremap_resource
> >>>> +                             (
> >>>> +-                             &
> >>>> +                               device1
> >>>> +-                                     ->dev
> >>>> +                              ,
> >>>> +-                             resource
> >>>> ++                             index, &resource
> >>>> +                             );
> >>>> +|
> >>>> +-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> >>>> + base =
> >>>> +-       devm_ioremap_resource
> >>>> ++       devm_platform_get_and_ioremap_resource
> >>>> +                             (device2,
> >>>
> >>> It is very suspicious that in one case you change the first argument of
> >>> devm_platform_get_and_ioremap_resource and in one case you don't.
> >>
> >> I noticed a few special cases during my source code analysis approach.
> >
> > This is not a reasonable answer.  Does the rule work correctly or not?
> > If it doesn't work correctly, it needs to be removed.
>
> Both source code change patterns from these branches of a SmPL disjunction
> work as I would expect it by the current Coccinelle software.
> Would you like to clarify any remaining related open issues?

In one case the first argument of devm_ioremap_resource has to be changed
to produce the first argument of devm_platform_get_and_ioremap_resource
and in the other case there is no such change.  "work as I would expect"
is not a proper explanation of why this is correct.  Maybe you can point
to some previous commits that have made the change in this way.

julia
