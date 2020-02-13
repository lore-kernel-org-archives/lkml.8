Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3718C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1A22082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBMXIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:08:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:52371 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMXIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:08:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 15:08:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="238187900"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 15:08:08 -0800
Date:   Thu, 13 Feb 2020 15:08:07 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the
 mce->handled bitmask
Message-ID: <20200213230807.GA22454@agluck-desk2.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-5-tony.luck@intel.com>
 <20200213170308.GM31799@zn.tnic>
 <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
 <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:27:31PM -0800, Andy Lutomirski wrote:
> On Thu, Feb 13, 2020 at 2:19 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > On Thu, Feb 13, 2020 at 06:03:08PM +0100, Borislav Petkov wrote:
> > > On Wed, Feb 12, 2020 at 12:46:51PM -0800, Tony Luck wrote:
> > > > If the handler took any action to log or deal with the error, set
> > > > a bit int mce->handled so that the default handler on the end of
> > > > the machine check chain can see what has been done.
> > > >
> > > > [!!! What to do about NOTIFY_STOP ... any handler that returns this
> > > > value short-circuits calling subsequent entries on the chain. In
> > > > some cases this may be the right thing to do ... but it others we
> > > > really want to keep calling other functions on the chain]
> > >
> > > Yes, we can kill that NOTIFY_STOP thing in the mce code since it is
> > > nasty.
> >
> > Well, there are places where we want to keep NOTIFY_STOP.
> 
> I very very strongly disagree.
> 
> >
> > 1) Default case for CEC.  We want it to "hide" the corrected error.
> >    That was one of the main goals for CEC.  We've discussed cases
> >    where CEC shouldn't hide (when internal threshold exceeded and
> >    it tries to take a page offline ... probably something related to
> >    CMCI storms ... though we didn't really come to any conclusion)
> 
> Then put this logic in do_machine_check() or in some sensible place
> that it calls via some ops structure or directly.  Don't hide it in
> some incomprehensible, possibly nondeterministic place in a notifier
> chain.

I could make the EDAC driver (and others on the chain) check to see if
CEC already handled the error record:

		if (mce->handled & MCE_HANDLED_CEC)
			return NOTIFY_DONE;

Then everyone on the chain still sees the error ... just some of them
make informed decisions based on what functions earlier in the chain
did with the error record.

> > 2) Errata. Perhaps a vendor/platform specific function at the head
> >    of the notify chain that weeds out errors that should never have
> >    been reported.
> 
> No, do this before the notifier chain please.

Ok. We don't have code that does this yet. If we need some, I'll
make sure to do the weed out before it gets to the notifier.

-Tony
