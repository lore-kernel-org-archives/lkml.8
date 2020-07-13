Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FD0206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgGMJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:40:06 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:14486 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgGMJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:40:05 -0400
X-IronPort-AV: E=Sophos;i="5.75,347,1589234400"; 
   d="scan'208";a="459564921"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 11:39:56 +0200
Date:   Mon, 13 Jul 2020 11:39:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Takashi Iwai <tiwai@suse.de>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive
 Terminology
In-Reply-To: <s5hft9vzrgt.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2007131137330.2322@hadrien>
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com> <s5hlfjnzvu7.wl-tiwai@suse.de> <alpine.DEB.2.22.394.2007131043070.2322@hadrien> <s5hft9vzrgt.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jul 2020, Takashi Iwai wrote:

> On Mon, 13 Jul 2020 10:43:28 +0200,
> Julia Lawall wrote:
> >
> >
> >
> > On Mon, 13 Jul 2020, Takashi Iwai wrote:
> >
> > > On Wed, 08 Jul 2020 20:14:27 +0200,
> > > Dan Williams wrote:
> > > >
> > > > +Recommended replacements for 'blacklist/whitelist' are:
> > > > +    'denylist / allowlist'
> > > > +    'blocklist / passlist'
> > >
> > > I started looking through the tree now and noticed there are lots of
> > > patterns like "whitelisted" or "blacklisted".  How can the words fit
> > > for those?  Actually, there are two cases like:
> > >
> > > - Foo is blacklisted
> > > - Allow to load the non-whitelisted cards
> > >
> > > Currently I'm replacing the former with "Foo is in denylist", but not
> >
> > In the denylist?
>
> Not really, only the allowlist exists in this case.

I'm not sure to understand.  in denylist is not grammatical.  It needs "a"
or "the".

Maybe it has to be foo is denylisted?  foo is in the implicit denyList?
foo is not in the allowList?

julia
