Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A165C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EF623B24
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHOVid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:38:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:62772 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgHOVid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:38:33 -0400
IronPort-SDR: 7aDkoqkccl2pA39I2vHozCLzR5T44O7sfwmIVDr1Tr6odwuvHZn58W67XKqWlYXU01q3M2GznO
 oL1kUJVpV7Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="218860632"
X-IronPort-AV: E=Sophos;i="5.76,316,1592895600"; 
   d="scan'208";a="218860632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2020 05:55:34 -0700
IronPort-SDR: CKSlF3hOH2ajsTjU/m9UYHYRy5AIEiRNAhByojGtC9bOGjvl44P4wgAUq1ZhZIDIP06WiJZfZl
 CBInzwoYTaIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,316,1592895600"; 
   d="scan'208";a="370134267"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2020 05:55:32 -0700
Date:   Sat, 15 Aug 2020 20:52:43 +0800
From:   Philip Li <philip.li@intel.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [kbuild-all] Re: fs/ocfs2/suballoc.c:2430:2-8: preceding lock on
 line 2413
Message-ID: <20200815125243.GA21882@intel.com>
References: <202008141412.mP88ccpD%lkp@intel.com>
 <878sehl5e4.fsf@nanos.tec.linutronix.de>
 <alpine.DEB.2.22.394.2008142059190.2441@hadrien>
 <87364pkock.fsf@nanos.tec.linutronix.de>
 <alpine.DEB.2.22.394.2008142148180.2441@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2008142148180.2441@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 09:52:13PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 14 Aug 2020, Thomas Gleixner wrote:
> 
> > Julia,
> >
> > On Fri, Aug 14 2020 at 21:00, Julia Lawall wrote:
> > > On Fri, 14 Aug 2020, Thomas Gleixner wrote:
> > >> That's clearly a false positive. Is there anything what can be done to
> > >> help that cocci script here?
> > >
> > > I have a better version that needs to get pushed.
> > >
> > > But normally these pass through me.  Did you get it directly from kbuild?
> >
> > Yes, because I touched the affected lines last :)
> 
> Actually, that's not the point.  Normally, I get all the reports on this
> case, and then I forward them if they look ok.  If I forwarded something
> incorrect, then sorry about that.  If the policy has changed for this rule
> to be sending the reports out directlty to the recipients, then I think it
> should be changed back.  There are a lot of real bugs with lock usage, but
> there are alot of false positives too.  Specifically, the rule looks for
> the case with identical if tests, but only when the branches are identical
> too.
> 
> Kbuild people, can this be adjusted?  Or have I misunderstood the
> situation?
Hi Julia and Thomas, pls allow us to check this further, usually all cocci
reports will be sent to kbuild@01.org for Julia to check. But there maybe
something wrong with this report. We will check the detail in next week as
we have server maintainance during the weekend.

> 
> thanks,
> julia
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
