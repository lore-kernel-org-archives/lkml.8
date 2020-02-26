Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21BBC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098324653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBZVVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:21:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:13577 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgBZVVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:21:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="350484102"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 13:21:33 -0800
Date:   Wed, 26 Feb 2020 13:31:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, tony.luck@intel.com,
        ashok.raj@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH 2/2] x86/asm/delay: Introduce TPAUSE delay
Message-ID: <20200226213111.GB113541@romley-ivt3.sc.intel.com>
References: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
 <1582744258-42744-3-git-send-email-kyung.min.park@intel.com>
 <20200226211040.GS160988@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226211040.GS160988@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:10:40PM -0800, Andi Kleen wrote:
> On Wed, Feb 26, 2020 at 11:10:58AM -0800, Kyung Min Park wrote:
> > TPAUSE instructs the processor to enter an implementation-dependent
> > optimized state. The instruction execution wakes up when the time-stamp
> > counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> > The instruction execution also wakes up due to the expiration of
> > the operating system time-limit or by an external interrupt
> 
> This is actually a behavior change. Today's udelay() will continue
> after processing the interrupt. Your patches don't
> 
> I don't think it's a problem though. The interrupt will cause
> a long enough delay that exceed any reasonable udelay() requirements.
> 
> There would be a difference if someone did really long udelay()s, much
> longer than typical interrupts, in this case you might end up
> with a truncated udelay, but such long udelays are not something that we
> would encourage.

TPAUSE is in a loop which checks if this udelay exceeds deadline.
Coming back from interrupt, the loop checks deadline and finds
there is still left time to delay. Then udelay() goes back to TPAUSE.

Thanks.

-Fenghua
