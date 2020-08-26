Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A2AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34852078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHZTQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:16:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:59655 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgHZTQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:16:51 -0400
IronPort-SDR: jV610tOjzDFkO8psRDOY+eELy9UGQKPX72YM+gEQlTRXV1i0o3YRU3+dgV5DWmXImtuHFBy4Eh
 JiC2ubW82ciQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136439034"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="136439034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 12:16:46 -0700
IronPort-SDR: khhe3B+e8qedoDCRPAjkMZI22badvpjZ4qjDoEltARDM6ebHLHFA9u0/yLEfPMus2TO0dNwauZ
 J2OBEGiH7nuA==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="336921169"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 12:16:46 -0700
Date:   Wed, 26 Aug 2020 12:16:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
Message-ID: <20200826191644.GC21065@sjchrist-ice>
References: <875z98jkof.fsf@nanos.tec.linutronix.de>
 <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice>
 <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice>
 <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:28:53AM -0700, Andy Lutomirski wrote:
> On Tue, Aug 25, 2020 at 10:19 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> > One thought would be to have the TDX module (thing that runs in SEAM and
> > sits between the VMM and the guest) provide a TDCALL (hypercall from guest
> > to TDX module) to the guest that would allow the guest to specify a very
> > limited number of GPAs that must never generate a #VE, e.g. go straight to
> > guest shutdown if a disallowed GPA would go pending.  That seems doable
> > from a TDX perspective without incurring noticeable overhead (assuming the
> > list of GPAs is very small) and should be easy to to support in the guest,
> > e.g. make a TDCALL/hypercall or two during boot to protect the SYSCALL
> > page and its scratch data.
> 
> I guess you could do that, but this is getting gross.  The x86
> architecture has really gone off the rails here.

Does it suck less than using an IST?  Honest question.

I will add my voice to the "fix SYSCALL" train, but the odds of that getting
a proper fix in time to intercept TDX are not good.  On the other hand,
"fixing" the SYSCALL issue in the TDX module is much more feasible, but only
if we see real value in such an approach as opposed to just using an IST.  I
personally like the idea of a TDX module solution as I think it would be
simpler for the kernel to implement/support, and would mean we wouldn't need
to roll back IST usage for #VE if the heavens should part and bestow upon us
a sane SYSCALL.
