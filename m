Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EC020724
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgHVHHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 03:07:37 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:29709 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgHVHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 03:07:36 -0400
X-IronPort-AV: E=Sophos;i="5.76,339,1592863200"; 
   d="scan'208";a="464294685"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 09:07:34 +0200
Date:   Sat, 22 Aug 2020 09:07:34 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <3836b482434bd0b9a609959d3696cc6113a93f2f.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008220905460.3150@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>  <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>  <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>  <alpine.DEB.2.22.394.2008201021400.2524@hadrien> 
 <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>  <alpine.DEB.2.22.394.2008201856110.2524@hadrien>  <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com>  <162653.1598067338@turing-police>
 <3836b482434bd0b9a609959d3696cc6113a93f2f.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-12852889-1598080054=:3150"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-12852889-1598080054=:3150
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 21 Aug 2020, Joe Perches wrote:

> On Fri, 2020-08-21 at 23:35 -0400, Valdis Klētnieks wrote:
> > On Fri, 21 Aug 2020 18:08:08 -0700, Joe Perches said:
> > > (forwarding on to kernel-janitors/mentees and kernelnewbies)
> > >
> > > Just fyi for anyone that cares:
> > >
> > > A janitorial task for someone might be to use Julia's coccinelle
> > > script below to convert the existing instances of commas that
> > > separate statements into semicolons.
> >
> > Note that you need to *really* check for possible changes in semantics.
> > It's *usually* OK to do that, but sometimes it's not...
> >
> > for (i=0; i++, last++; !last) {
> >
> > changing that comma to a ; will break the compile.  In other cases, it can
> > introduce subtle bugs.
>
> True enough for a general statement, though the coccinelle
> script Julia provided does not change a single instance of
> for loop expressions with commas.
>
> As far as I can tell, no logic defect is introduced by the
> script at all.

The script has a rule to ensure that what is changed is part of a top
level statement that has the form e1, e2;.  I put that in to avoid
transforming cases where the comma is the body of a macro, but it protects
against for loop headers as well.

julia
--8323329-12852889-1598080054=:3150--
