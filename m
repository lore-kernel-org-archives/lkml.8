Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AA020792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGVGYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:24:25 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:5188 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGVGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:24:25 -0400
X-IronPort-AV: E=Sophos;i="5.75,381,1589234400"; 
   d="scan'208";a="354992183"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:24:23 +0200
Date:   Wed, 22 Jul 2020 08:24:22 +0200 (CEST)
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
Subject: Re: [v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
In-Reply-To: <07a06754-94dd-60b1-1ad1-9e602c86b1f8@web.de>
Message-ID: <alpine.DEB.2.22.394.2007220823050.2918@hadrien>
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de> <alpine.DEB.2.22.394.2007211158310.2487@hadrien> <0b326e2b-723c-3482-c0ef-5d6592a9c6cb@web.de> <alpine.DEB.2.22.394.2007220801590.2918@hadrien> <07a06754-94dd-60b1-1ad1-9e602c86b1f8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jul 2020, Markus Elfring wrote:

> > Markus, you are welcome to try this since you are concerned about it.
>
> I dare to point software design variations for some reasons.
>
>
> > But it doesn't matter.
>
> Under which circumstances would you begin to care more for involved differences
> in corresponding run time characteristics?

When the difference is hours vs seconds.  In this case, there are
tradeoffs between the two options, andI don't know which would be faster,
but I think it is extremely unlikely that the difference is noticible.
But if you are concerned about it, you are welcome to try.

julia
