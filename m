Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E15C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2460020717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGRIlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 04:41:50 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:24658 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbgGRIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 04:41:49 -0400
X-IronPort-AV: E=Sophos;i="5.75,366,1589234400"; 
   d="scan'208";a="460290487"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 10:41:47 +0200
Date:   Sat, 18 Jul 2020 10:41:47 +0200 (CEST)
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
In-Reply-To: <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
Message-ID: <alpine.DEB.2.22.394.2007181034530.2538@hadrien>
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de> <alpine.DEB.2.22.394.2007180841520.2538@hadrien> <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1044091524-1595061708=:2538"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1044091524-1595061708=:2538
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 18 Jul 2020, Markus Elfring wrote:

> >>> Applied.
> >>
> >> Do you care for patch review concerns according to this SmPL script adjustment?
> >>
> >> * https://lore.kernel.org/cocci/5c0dae88-e172-3ba6-f86c-d1a6238bb4c4@web.de/
> >>   https://lkml.org/lkml/2020/6/9/568
> >
> > This one it complete nonsense.
>
> I hope that different views can be clarified for such a software situation
> in more constructive ways.

You proposed essentially  \( A \| B \) \( | C \| \)

This is not valid syntax in the semantic patch language.  The branches of
a \( \| \) have to be a valid expression, statement, type, etc, not some
random string of tokens.

> >> * https://lore.kernel.org/cocci/c3464cad-e567-9ef5-b4e3-a01e3b11120b@web.de/
> >>   https://lkml.org/lkml/2020/6/8/637
> >
> > This on is indeed a problem.
>
> I find this feedback interesting.
>
> * How does it fit to your response “Applied”?
>
> * Will it trigger any more consequences?
>
>
> > Markus, if you would limit your comments to suggesting SmPL code
> > that is actually correct, ie that you have tested,
>
> Patch reviews contain usual risks that suggestions are presented
> which can be still questionable.

These are not "usual risks".  You can easily test out your suggestion by
yourself to see if it produces valid code.  If it doesn't, then don't make
the suggestion.

>
>
> > and 2) stop suggesting stupid things over and over
>
> We come along different development views.

Whenever you propose the same thing say 10 times or more and it is
rejected every time, I thikn you should be able to conclude that if you
propose the same thing again it will be rejected.

>
> > like that putting all of the virtual declarations on
> > the same line would save space (it does, but who cares),
>
> It seems that you admit a possibly desirable effect.

No, I don't consider the effect to be desirable.

> Will any more developers care also for SmPL coding style aspects?
>
>
> > then I would take your suggestions more seriously.
>
> Your change acceptance is varying to your development mood
> (and other factors), isn't it?

Not really.  My "change acceptance" increases when the person reporting
them raises real problems that is blocking them in some work.  And it
decreases rapidly when the changes are almost all related to presumed
"efficiencies" that have no impact in practice.

julia
--8323329-1044091524-1595061708=:2538--
