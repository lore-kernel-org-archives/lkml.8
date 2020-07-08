Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F34C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E297F20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGHKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:16:49 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:63417 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgGHKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:16:49 -0400
X-IronPort-AV: E=Sophos;i="5.75,327,1589234400"; 
   d="scan'208";a="458905460"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 12:16:47 +0200
Date:   Wed, 8 Jul 2020 12:16:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
In-Reply-To: <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2007081209500.2558@hadrien>
References: <20200707195214.GA3932@embeddedor>  <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org> <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Jul 2020, Joe Perches wrote:

> On Tue, 2020-07-07 at 14:06 -0600, Shuah Khan wrote:
> > On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
> > > Replace the existing /* fall through */ comments and its variants with
> > > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > > fall-through markings when it is the case.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > >
> >
> > Is fallthrough syntax supported on our min gcc version?
>
> No.  Introduced in gcc 7.
>
> > Does checkpatch or coccicheck catch these cases?
>
> Kinda.  checkpatch isn't very good at it.
> I _believe_, though I'm not at all sure,
> that coccinelle can find these.

I would not guarantee anything about the support of Coccinelle for switch.
Coccinelle does now have the ability to match on comments.  So since there
is a distinct comment that it is to be removed, it might be possible to do
that part automatically.

Maybe it would have to look something like this:

@r1@
comments c : script:python() { code to recognize the comment };
statement S;
@@

S@c
+ fallthrough(); //or whatever is wanted

@@
statement r1.S;
@@

- S
- fallthrough();
+ S
+ fallthrough();

The second rule probably looks pretty strange, but the goal is to remove
the comments between S and fallthrough();

There is an example demos/comments.cocci that shows how to access the
comment information using both ocaml and python.

julia
