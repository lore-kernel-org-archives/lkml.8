Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86354C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8192065C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFNHje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:39:34 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38782
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgFNHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:39:33 -0400
X-IronPort-AV: E=Sophos;i="5.73,510,1583190000"; 
   d="scan'208";a="351530437"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 09:39:32 +0200
Date:   Sun, 14 Jun 2020 09:39:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
In-Reply-To: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2006140932490.2849@hadrien>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jun 2020, Randy Dunlap wrote:

> Hi,
>
> OK, I've not used Coccinelle and now I am trying to use it.
> It seems that I am having a few issues.
> The primary one is when I run spatch (via 'make coccicheck' in
> the kernel source tree), it tells me:
>
> Python error: No module named coccilib.elems
>
> I do see "elems.py" in /usr/local/lib64/coccinelle/python/coccilib.
>
> I am using coccinelle-master downloaded from github on
> Friday June 12, 2020.
>
>
> I have also made the following notes while building/installing it.
>
>
> Note1: The latest coccinelle tarball is not actually available
> at the coccinelle home page although the kernel documentation says it is.

Yes, I'm aware of this problem.  We're not able to update the home page at
the moment.  This problem is being worked on.

>
> Note2: https://github.com/coccinelle/coccinelle/blob/master/install.txt
> says that 'spatch' is a script, but it seems to be a binary executable
> file.

Actually, it is a script, and the fact that you say it is a binary may be
the reason for your python problem.  Normally there is a script
(scripts/spatch) that make install puts in place that refers back to where
your Coccinelle is installed.

> Note3: https://github.com/coccinelle/coccinelle/blob/master/install.txt
> probably should say to use 'sudo make install' instead of just
> 'make install', just like 'coccinelle.rst' file in the kernel tree says.

OK.  A lot of documentation for a lot of projects seems to omit the sudo,
but I have indeed never understood why.

Maybe try again with make distclean, ./autogen, ./configure, sudo make
install?

julia

>
> thanks for any help that you can provide.
>
> --
> ~Randy
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
