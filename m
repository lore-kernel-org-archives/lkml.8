Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA809207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgIGNTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:19:47 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59063 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729430AbgIGNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:11:47 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="466412596"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 15:11:31 +0200
Date:   Mon, 7 Sep 2020 15:11:31 +0200 (CEST)
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
In-Reply-To: <477abcea-e008-e509-d03f-f2753ebdfb20@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071506350.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de> <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de> <alpine.DEB.2.22.394.2009071357140.2476@hadrien> <477abcea-e008-e509-d03f-f2753ebdfb20@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1914540151-1599484292=:2476"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1914540151-1599484292=:2476
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Sep 2020, Markus Elfring wrote:

> >> +@display depends on context@
> >> +expression base, device1, device2, index, private, resource;
> >> +@@
> >> +(
> >> +*resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +*       devm_ioremap_resource
> >> +                             (&device1->dev, resource);
> >
> > Why do you require these statements to be next to each other?
>
> I would appreciate indications for a general change acceptance
> also according to such a simple transformation approach.
> I imagine that it will become more challenging to tolerate extra
> source code between these function calls (by the specification
> of special SmPL filters).
>
>
> >> +|
> >> +*private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +*       devm_ioremap_resource
> >> +                             (device2, private->res);
> >
> > Why do you have this special case?
>
> The usage of the data structure member “res” triggers corresponding
> software design consequences.

I don't think this is a reliable rule.  You included two examples below.
They involve structures of different types. It seems unlikely that there
is a guarantee that the res field of all structures is used in the same
way.  Furthermore, this is the context case.  What is the purpose of
making the distinction?  The user will have to figure out what to do by
hand in any case.

> The expressions which are passed as the first function call parameters
> can be different.
>
>
> >> +@replacement depends on patch@
> >> +expression base, device1, device2, index, private, resource;
> >> +@@
> >> +(
> >> +-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +-       devm_ioremap_resource
> >> ++       devm_platform_get_and_ioremap_resource
> >> +                             (
> >> +-                             &
> >> +                               device1
> >> +-                                     ->dev
> >> +                              ,
> >> +-                             resource
> >> ++                             index, &resource
> >> +                             );
> >> +|
> >> +-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +-       devm_ioremap_resource
> >> ++       devm_platform_get_and_ioremap_resource
> >> +                             (device2,
> >
> > It is very suspicious that in one case you change the first argument of
> > devm_platform_get_and_ioremap_resource and in one case you don't.
>
> I noticed a few special cases during my source code analysis approach.

This is not a reasonable answer.  Does the rule work correctly or not?  If
it doesn't work correctly, it needs to be removed.

> > If you don't know how to make the change in some cases, it would be better
> > to do nothing at all.
>
> How do you think about to take another look at any update candidates?
>
> Examples:
> * mvebu_sei_probe
>   https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/irqchip/irq-mvebu-sei.c#L368
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-mvebu-sei.c?id=f4d51dffc6c01a9e94650d95ce0104964f8ae822#n368

I don't see any purpose to providing two links for everything.

julia

>
> * hi655x_pmic_probe
>   https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/mfd/hi655x-pmic.c#L92
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/hi655x-pmic.c?id=f4d51dffc6c01a9e94650d95ce0104964f8ae822#n92
>
> Regards,
> Markus
>
--8323329-1914540151-1599484292=:2476--
