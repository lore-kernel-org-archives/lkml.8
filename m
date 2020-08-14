Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5170BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EFB206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHNTwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:52:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:2535 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgHNTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:52:33 -0400
X-IronPort-AV: E=Sophos;i="5.76,313,1592863200"; 
   d="scan'208";a="356566291"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 21:52:13 +0200
Date:   Fri, 14 Aug 2020 21:52:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: fs/ocfs2/suballoc.c:2430:2-8: preceding lock on line 2413
In-Reply-To: <87364pkock.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.22.394.2008142148180.2441@hadrien>
References: <202008141412.mP88ccpD%lkp@intel.com> <878sehl5e4.fsf@nanos.tec.linutronix.de> <alpine.DEB.2.22.394.2008142059190.2441@hadrien> <87364pkock.fsf@nanos.tec.linutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Aug 2020, Thomas Gleixner wrote:

> Julia,
>
> On Fri, Aug 14 2020 at 21:00, Julia Lawall wrote:
> > On Fri, 14 Aug 2020, Thomas Gleixner wrote:
> >> That's clearly a false positive. Is there anything what can be done to
> >> help that cocci script here?
> >
> > I have a better version that needs to get pushed.
> >
> > But normally these pass through me.  Did you get it directly from kbuild?
>
> Yes, because I touched the affected lines last :)

Actually, that's not the point.  Normally, I get all the reports on this
case, and then I forward them if they look ok.  If I forwarded something
incorrect, then sorry about that.  If the policy has changed for this rule
to be sending the reports out directlty to the recipients, then I think it
should be changed back.  There are a lot of real bugs with lock usage, but
there are alot of false positives too.  Specifically, the rule looks for
the case with identical if tests, but only when the branches are identical
too.

Kbuild people, can this be adjusted?  Or have I misunderstood the
situation?

thanks,
julia
