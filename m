Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138B324677
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCCCCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:02:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:22013 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCCCCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:02:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 18:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="274004683"
Received: from wtczc53028gn.jf.intel.com (HELO skl-build) ([10.54.87.17])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2020 18:02:02 -0800
Date:   Mon, 2 Mar 2020 18:01:48 -0800
From:   "Christopher S. Hall" <christopher.s.hall@intel.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com,
        x86@kernel.org, jacob.e.keller@intel.com, davem@davemloft.net,
        sean.v.kelley@intel.com
Subject: Re: [Intel PMC TGPIO Driver 0/5] Add support for Intel PMC Time GPIO
 Driver with PHC interface changes to support additional H/W Features
Message-ID: <20200303020148.GB15531@skl-build>
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
 <20200203040838.GA5851@localhost>
 <20200225233707.GA32079@skl-build>
 <20200226024707.GA10271@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226024707.GA10271@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Feb 25, 2020 at 06:47:07PM -0800, Richard Cochran wrote:
> On Tue, Feb 25, 2020 at 03:37:07PM -0800, Christopher S. Hall wrote:
> > On Sun, Feb 02, 2020 at 08:08:38PM -0800, Richard Cochran wrote:
> > > The TGPIO input clock, the ART, is a free running counter, but you
> > > want to support frequency adjustments.  Use a timecounter cyclecounter
> > > pair.
> > 
> > I'm concerned about the complexity that the timecounter adds to
> > the driver. Specifically, the complexity of dealing with any rate mismatches
> > between the timecounter and the periodic output signal. The phase
> > error between the output and timecounter needs to be zero.
> 
> If I understood correctly, the device's outputs are generated from a
> non-adjustable counter.  So, no matter what, you will have the problem
> of changing the pulse period in concert with the user changing the
> desired frequency.
> 

> > This leaves the PHC API behavior as it is currently and uses the frequency
> > adjust API to adjust the output rate.
> > 
> > > Let the user dial a periodic output signal in the normal way.
> > > 
> > > Let the user change the frequency in the normal way, and during this
> > > call, adjust the counter values accordingly.
> > 
> > Yes to both of the above.
> 
> So, why then do you need this?
> 
> +#define PTP_EVENT_COUNT_TSTAMP2 \
> +       _IOWR(PTP_CLK_MAGIC, 19, struct ptp_event_count_tstamp)
> 
> If you can make the device work with the existing user space API,
> 
> 	ioctl(fd, PTP_PEROUT_REQUEST2, ...);
> 	while (1) {
> 		clock_adjtimex(FD_TO_CLOCKID(fd), ...);
> 	}
> 
> that would be ideal.  But I will push back on anything like the
> following.
> 
> 	ioctl(fd, PTP_PEROUT_REQUEST2, ...);
> 	while (1) {
> 		clock_adjtimex(FD_TO_CLOCKID(fd), ...);
> 		ioctl(fd, PTP_EVENT_COUNT_TSTAMP, ...);
> 	}
> 
> But maybe I misunderstood?

Thank you for the feedback, but Thomas wants to see this as
an extension of GPIO. I'll work on an RFC patch for that instead.

> Thanks,
> Richard

Thanks,
Christopher
