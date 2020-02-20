Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AFDC5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FB22465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBTAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:44:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:34913 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgBTAoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:44:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 16:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="382975586"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2020 16:44:14 -0800
Date:   Thu, 20 Feb 2020 08:44:34 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal
 errors
Message-ID: <20200220004434.GA5687@intel.com>
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2>
 <20200213221100.odwg5gan3dwcpk6g@treble>
 <87sgjeghal.fsf@nanos.tec.linutronix.de>
 <20200214175758.s34rdwmwgiq6qwq7@treble>
 <CAKwvOdmJvWpmbP3GyzaZxyiuwooFXA8D7ui05QE7+f8Oaz+rXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmJvWpmbP3GyzaZxyiuwooFXA8D7ui05QE7+f8Oaz+rXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:43:39PM -0800, Nick Desaulniers wrote:
> On Fri, Feb 14, 2020 at 9:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Feb 14, 2020 at 01:10:26AM +0100, Thomas Gleixner wrote:
> > > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > > > On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > > >> The following commit has been merged into the core/objtool branch of tip:
> > > >>
> > > >> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> > > >> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> > > >> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> > > >> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> > > >> Committer:     Borislav Petkov <bp@suse.de>
> > > >> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> > > >>
> > > >> objtool: Fail the kernel build on fatal errors
> > > >>
> > > >> When objtool encounters a fatal error, it usually means the binary is
> > > >> corrupt or otherwise broken in some way.  Up until now, such errors were
> > > >> just treated as warnings which didn't fail the kernel build.
> > > >>
> > > >> However, objtool is now stable enough that if a fatal error is
> > > >> discovered, it most likely means something is seriously wrong and it
> > > >> should fail the kernel build.
> > > >>
> > > >> Note that this doesn't apply to "normal" objtool warnings; only fatal
> > > >> ones.
> > > >
> > > > Clang still has some toolchain issues which need to be sorted out, so
> > > > upgrading the fatal errors is causing their CI to fail.
> > >
> > > Good. Last time we made it fail they just fixed their stuff.
> > >
> > > > So I think we need to drop this one for now.
> > >
> > > Why? It's our decision to define which level of toolchain brokeness is
> > > tolerable.
> > >
> > > > Boris, are you able to just drop it or should I send a revert?
> > >
> > > I really want to see a revert which has a proper justification why the
> > > issues of clang are tolerable along with a clear statement when this
> > > fatal error will come back. And 'when' means a date, not 'when clang is
> > > fixed'.
> >
> > Fair enough.  The root cause was actually a bug in binutils which gets
> > triggered by a new clang feature.  So instead of reverting the above
> > patch, I think I've figured out a way to work around the binutils bug,
> > while also improving objtool at the same time (win-win).
> >
> > The binutils bug will be fixed in binutils 2.35.
> >
> > BTW, to be fair, this was less "Clang has issues" and more "Josh is
> > lazy".  I didn't test the patch with Clang -- I tend to rely on 0-day
> > bot reports because I don't have the bandwidth to test the
> > kernel/config/toolchain combinations.  Nick tells me Clang will soon be
> > integrated with the 0-day bot, which should help prevent this type of
> > thing in the future.
> 
> Hi Rong, Philip,
> Do you have any status updates on turning on the 0day bot emails to
> the patch authors in production?  It's been quite handy in helping us
> find issues, for the private mails we've been triaging daily.
Hi Nick, this is on our schedule in a new 2-3 weeks, sorry not to update
your in another mail loop earlier.

What I plan to do is to cc you for the clang reports when 0-day ci sends
to kernel patch author. If you notice something may be related to clang (since
we always integrate newer clang version), you can help filter it out. How
do you think?

> -- 
> Thanks,
> ~Nick Desaulniers
