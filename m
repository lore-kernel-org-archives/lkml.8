Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5DDC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE087206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgIGRbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:31:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42176
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729626AbgIGRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:31:42 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="358318231"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 19:31:40 +0200
Date:   Mon, 7 Sep 2020 19:31:40 +0200 (CEST)
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
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_Coccinelle=3A_api=3A_Add_SmPL?=
 =?UTF-8?Q?_script_=E2=80=9Cuse=5Fdevm=5Fplatform=5Fget=5Fand=5Fiorema?=
 =?UTF-8?Q?p=5Fresource=2Ecocci=E2=80=9D?=
In-Reply-To: <8fb7782c-538b-b657-af13-da71124e6afa@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071930510.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de> <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de> <4b505afc-ae48-d8eb-f4e1-8e3f7192f73d@web.de> <alpine.DEB.2.22.394.2009071900450.2476@hadrien> <8fb7782c-538b-b657-af13-da71124e6afa@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Sep 2020, Markus Elfring wrote:

> >> +++ b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> >> @@ -0,0 +1,48 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/// Simplify a function call combination by using a known wrapper function.
> >> +//
> >> +// Keywords: wrapper function conversion ioremap resources
> >> +// Confidence: High
> >
> > Shouldn't there be some options?  --no-includes and perhaps
> > --include-headers would seem reasonable.
>
> I imagine that the proposed source code transformation can work also without
> additional semantic patch command options.

It can.  But it will be more efficient and more exhaustive if you include
them.

julia
