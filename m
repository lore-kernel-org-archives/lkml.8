Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E33C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074F12074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGRGpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:45:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23447 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbgGRGpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:45:54 -0400
X-IronPort-AV: E=Sophos;i="5.75,366,1589234400"; 
   d="scan'208";a="460283661"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 08:45:52 +0200
Date:   Sat, 18 Jul 2020 08:45:51 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [v2 1/4] coccinelle: api: extend memdup_user transformation with
 GFP_USER
In-Reply-To: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de>
Message-ID: <alpine.DEB.2.22.394.2007180841520.2538@hadrien>
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jul 2020, Markus Elfring wrote:

> > Applied.
>
> Do you care for patch review concerns according to this SmPL script adjustment?
>
> * https://lore.kernel.org/cocci/5c0dae88-e172-3ba6-f86c-d1a6238bb4c4@web.de/
>   https://lkml.org/lkml/2020/6/9/568

This one it complete nonsense.

>
> * https://lore.kernel.org/cocci/c3464cad-e567-9ef5-b4e3-a01e3b11120b@web.de/
>   https://lkml.org/lkml/2020/6/8/637

This on is indeed a problem.  I think it was not detected in testing,
because in the current kernel the rule never applies.  But Denis, in

-  to = \(kmalloc\|kzalloc\)
                (size,\(GFP_KERNEL\|GFP_USER\|
                      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));

you do indeed need to put - in front of the second and third lines as
well.

Markus, if you would limit your comments to suggesting SmPL code that is
actually correct, ie that you have tested, and 2) stop suggesting stupid
things over and over like that putting all of the virtual declarations on
the same line would save space (it does, but who cares), then I would take
your suggestions more seriously.

julia

> Regards,
> Markus
>
