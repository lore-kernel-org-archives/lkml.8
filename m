Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0DC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CC1206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD1BIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:08:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:43127 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgD1BIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:08:09 -0400
IronPort-SDR: J+WjQwm+IMEz5n9R5AJqcxO0ZMhOOnogWwTOIIHi7hHZC3LI7BPg9pYO1Y+4gpXBi0XOSSaj8Y
 UPQPoAQVJ4zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 18:08:08 -0700
IronPort-SDR: 2YoVZ36m76ZElHEJ97QaJ9BSnZaX0q6H1YcE2h2urZ+Ix/dX43x5tEXzq+SzYZx7OAac/BP8ym
 0SsxcIBGu0dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="459058326"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 18:08:08 -0700
Date:   Mon, 27 Apr 2020 18:08:08 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
Message-ID: <20200428010808.GA18865@otc-nc-03>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de>
 <20200427224646.GA103955@otc-nc-03>
 <874kt4pgyk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kt4pgyk.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Apr 28, 2020 at 02:54:59AM +0200, Thomas Gleixner wrote:
> Ashok,
> 
> "Raj, Ashok" <ashok.raj@intel.com> writes:
> > On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
> >> Just for the record I also suggested to have a proper errorcode in the
> >> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
> >> instructions.
> >
> > We certainly discussed the possiblity of adding an error code to 
> > identiy #GP due to ENQCMD with our HW architects. 
> >
> > There are only a few cases that have an error code, like move to segment
> > with an invalid value for instance. There were a few but i don't
> > recall that entire list. 
> >
> > Since the error code is 0 in most places, there isn't plumbing in hw to return
> > this value in all cases. It appeared that due to some uarch reasons it
> > wasn't as simple as it appears to /me sw kinds :-)
> 
> Sigh.
> 
> > So after some internal discussion we decided to take the current
> > approach. Its possible that if the #GP was due to some other reason
> > we might #GP another time. Since this wasn't perf or speed path we took
> > this lazy approach.
> 
> I know that the HW people's mantra is that everything can be fixed in
> software and therefore slapping new features into the CPUs can be done
> without thinking about the consequeses.
> 
> But we all know from painful experience that this is fundamentally wrong
> unless there is a really compelling reason.

:-)... I'm still looking for the quote from Linus about RAS before
he went to behavior school.


> 
> For new features there is absolutely no reason at all.
> 
> Can HW people pretty please understand that hardware and software have
> to be co-designed and not dictated by 'some uarch reasons'. This is
> nothing fundamentally new. This problem existed 30+ years ago, is well
> documented and has been ignored forever. I'm tired of that, really.
> 
> But as this seems to be unsolvable for the problem at hand can you
> please document the inability, unwillingness or whatever in the
> changelog?

Most certainly!

> 
> The question why this brand new_ ENQCMD + invalid PASID induced #GP does
> not generate an useful error code and needs heuristics to be dealt with
> is pretty obvious.
> 

Cheers,
Ashok
