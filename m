Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597FCC82C08
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF4620661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD0Wqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:46:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:40986 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgD0Wqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:46:48 -0400
IronPort-SDR: e7pQAc9MveTlcpyNPNaXJGOOptyMIFT/B0Ep3wJe3ZWwu8XHRwYVCSsvLbSbeQKzEibRIFFEnf
 +oskRM6UdUTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 15:46:47 -0700
IronPort-SDR: UHVzSlXZVdNamgJeTnygmEuXY5wBVq5RZcNSoRgPwHzzqHDm3NcyQ2wPRbh+JCVXcKjUrc6TKD
 /A5HxJvcQb8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="459025738"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 15:46:46 -0700
Date:   Mon, 27 Apr 2020 15:46:46 -0700
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
Message-ID: <20200427224646.GA103955@otc-nc-03>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu6ys20d.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in.
> 
> Programmed in what?
> 
> > The #GP fault handler will initialize the current thread's PASID MSR.
> >
> > The following heuristic is used to avoid decoding the user instructions
> > to determine the precise reason for the #GP fault:
> > 1) If the mm for the process has not been allocated a PASID, this #GP
> >    cannot be fixed.
> > 2) If the PASID MSR is already initialized, then the #GP was for some
> >    other reason
> > 3) Try initializing the PASID MSR and returning. If the #GP was from
> >    an ENQCMD this will fix it. If not, the #GP fault will be repeated
> >    and we will hit case "2".
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Just for the record I also suggested to have a proper errorcode in the
> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
> instructions.

We certainly discussed the possiblity of adding an error code to 
identiy #GP due to ENQCMD with our HW architects. 

There are only a few cases that have an error code, like move to segment
with an invalid value for instance. There were a few but i don't
recall that entire list. 

Since the error code is 0 in most places, there isn't plumbing in hw to return
this value in all cases. It appeared that due to some uarch reasons it
wasn't as simple as it appears to /me sw kinds :-)

So after some internal discussion we decided to take the current
approach. Its possible that if the #GP was due to some other reason
we might #GP another time. Since this wasn't perf or speed path we took
this lazy approach. 

We will keep tabs with HW folks for future consideration. 
