Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DDBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055912070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGRNaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:30:00 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8426 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgGRNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:30:00 -0400
X-IronPort-AV: E=Sophos;i="5.75,367,1589234400"; 
   d="scan'208";a="460306961"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 15:29:58 +0200
Date:   Sat, 18 Jul 2020 15:29:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org
Subject: Re: [v2 1/4] coccinelle: api: extend memdup_user transformation with
 GFP_USER
In-Reply-To: <cf2bd604-3094-f90a-52a8-ff5a44cf3850@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007181529460.2538@hadrien>
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de> <alpine.DEB.2.22.394.2007180841520.2538@hadrien> <cf2bd604-3094-f90a-52a8-ff5a44cf3850@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jul 2020, Denis Efremov wrote:

> Hi,
>
> On 7/18/20 9:45 AM, Julia Lawall wrote:
> > This on is indeed a problem.  I think it was not detected in testing,
> > because in the current kernel the rule never applies.  But Denis, in
> >
> > -  to = \(kmalloc\|kzalloc\)
> >                 (size,\(GFP_KERNEL\|GFP_USER\|
> >                       \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
> >
> > you do indeed need to put - in front of the second and third lines as
> > well.
>
> Thanks, Markus, Julia. I will send v3. Julia, is it ok with you, if I will
> drop the last patch with "selfcheck" this time?

That would be perfect, thanks.

julia
