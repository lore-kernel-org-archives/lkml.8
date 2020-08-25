Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9020AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA4220678
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHYEkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:40:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:31046 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgHYEkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:40:01 -0400
IronPort-SDR: SYzY5mU6q8dU+DfOL7cQfsumhZKZN7yLmRgIkUo8deq2OOO3F2QyJdwFCYjlix3ws+6WO2eQm6
 /5e3mMqGdgTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153461546"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="153461546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 21:40:00 -0700
IronPort-SDR: ow8rA3C33GVLkjslFqifQSALGMBU840+fzA6uJ7OHN6/wGiOXaQRjprQuRwZXZVNV7qbP1Bd57
 NqLT2RXxmOKA==
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="474190915"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 21:40:00 -0700
Date:   Mon, 24 Aug 2020 21:39:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
Message-ID: <20200825043959.GF15046@sjchrist-ice>
References: <875z98jkof.fsf@nanos.tec.linutronix.de>
 <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andy

On Mon, Aug 24, 2020 at 02:52:01PM +0100, Andrew Cooper wrote:
> And to help with coordination, here is something prepared (slightly)
> earlier.
> 
> https://docs.google.com/document/d/1hWejnyDkjRRAW-JEsRjA5c9CKLOPc6VKJQsuvODlQEI/edit?usp=sharing
> 
> This identifies the problems from software's perspective, along with
> proposing behaviour which ought to resolve the issues.
> 
> It is still a work-in-progress.  The #VE section still needs updating in
> light of the publication of the recent TDX spec.

For #VE on memory accesses in the SYSCALL gap (or NMI entry), is this
something we (Linux) as the guest kernel actually want to handle gracefully
(where gracefully means not panicking)?  For TDX, a #VE in the SYSCALL gap
would require one of two things:

  a) The guest kernel to not accept/validate the GPA->HPA mapping for the
     relevant pages, e.g. code or scratch data.

  b) The host VMM to remap the GPA (making the GPA->HPA pending again).

(a) is only possible if there's a fatal buggy guest kernel (or perhaps vBIOS).
(b) requires either a buggy or malicious host VMM.

I ask because, if the answer is "no, panic at will", then we shouldn't need
to burn an IST for TDX #VE.  Exceptions won't morph to #VE and hitting an
instruction based #VE in the SYSCALL gap would be a CPU bug or a kernel bug.
Ditto for a #VE in NMI entry before it gets to a thread stack.

Am I missing anything?
