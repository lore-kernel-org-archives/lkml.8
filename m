Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DD0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA0120857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgDQVTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:19:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:38311 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgDQVTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:19:33 -0400
IronPort-SDR: 26mN7AmiLqJvJ7WvQN1IZ1dnhWS9D6wopXhiNcILL2PKrbcR43X0m1m+BH+8dtk0yuqED/A4yZ
 D2xMThgzmZyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 14:19:32 -0700
IronPort-SDR: F01KeRkEMNnRLW1iLaOpUmVJUrGyabC3ouVwUCAYhHAvCpeMee1fjWrjWi65H5I5Su1D1Qb2FC
 NZxIEEricloQ==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="280573716"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 14:19:31 -0700
Date:   Fri, 17 Apr 2020 14:19:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
Message-ID: <20200417211930.GA24777@agluck-desk2.amr.corp.intel.com>
References: <877dydzvml.fsf@nanos.tec.linutronix.de>
 <873691zuqu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873691zuqu.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:07:37PM +0200, Thomas Gleixner wrote:
> Tony,
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> > "Luck, Tony" <tony.luck@intel.com> writes:
> >> Swings and roundabouts ... getting rid of the goto makes for
> >> deeper indentation. But if you really want to get rid of the
> >> goto, then your version is fine with me.
> >>
> >> Do you want me to spin it into v3?
> >
> > Nah. I tweak it myself.
> 
> as I fear that the infinite wisdom of HW folks will add yet another
> variant in the foreseeable future, I used a switch() right away and
> tweaked the comments a bit.
> 
> Can you have a look, please?

Looks like you are all ready for "case 2:" when Intel produces
a less sucky implementation of split lock detect. Don't hold your
breath waiting for that :-)

Looks good. Should be a useful template for any future
bits that show up in CORE_CAPABILITIES.

-Tony
