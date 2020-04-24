Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77E2C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C231D20706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgDXQHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:07:34 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:60856 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbgDXQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:07:33 -0400
X-IronPort-AV: E=Sophos;i="5.73,311,1583190000"; 
   d="scan'208";a="446777922"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 18:07:31 +0200
Date:   Fri, 24 Apr 2020 18:07:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Dan Carpenter <error27@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: linux-kernel: Unused static inline functions
In-Reply-To: <572b03bdc3eed286c5ed20887d42f674bd93336e.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2004241806220.2344@hadrien>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>  <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>  <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>  <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com> 
 <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>  <4603e761a5f39f4d97375e1e08d20d720c526341.camel@perches.com>  <CAKwvOdnW-xvSnT3RS8MWufyp+3=NM-Mb+bv0r2u2soNnyVvXBg@mail.gmail.com>
 <572b03bdc3eed286c5ed20887d42f674bd93336e.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Apr 2020, Joe Perches wrote:

> (adding Julia Lawall and Dan Carpenter who may have ideas too)
>
> On Thu, 2020-04-23 at 11:57 -0700, Nick Desaulniers wrote:
> > I've been mulling over teaching a class internally at Google on
> > getting started contributing to the Linux kernel.  I think this idea
> > (removing dead static inline functions) is perfect for having lots of
> > small little tasks that are clear wins.  Do you have any other ideas
> > for work that there's a lot of?  Like lots of small little bite sized
> > tasks?  Maybe more fallthrough conversion? Anything else?
>
> Some generic ideas:
>
> o look for always unused/unreferenced, or always static
>   value function arguments and remove them
>
> o int function returns constrained to 0 or 1 could be
>   converted to bool.
>
> And some logging ideas:
>
> o printk to tracing conversions
>
> o removal of printks used just for function tracing
>   as ftrace works well
>
> o pr_<level> macro conversions to functions to save
>   object space
>
> o singletons for pr_fmt
>
> o default use of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   and removal of the ~1200 current defines treewide
>
> > Happy to have folks use your script and add your suggested by tag.
>
> Suggested-by doesn't have much value to me,
> especially for scripted stuff.
>
> I'd be happy enough that it gets done eventually.

Perhaps typedefs for structures?  Using standard list operations?  In
staging there are a lot of camel case and variables whose names
incorporate their type.

julia
