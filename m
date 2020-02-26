Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2356EC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E7021D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgBZV73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:59:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:15949 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbgBZV73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:59:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="230571670"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 26 Feb 2020 13:59:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 110CD3011A5; Wed, 26 Feb 2020 13:59:28 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:59:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com
Subject: Re: [PATCH 2/2] x86/asm/delay: Introduce TPAUSE delay
Message-ID: <20200226215928.GU160988@tassilo.jf.intel.com>
References: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
 <1582744258-42744-3-git-send-email-kyung.min.park@intel.com>
 <20200226211040.GS160988@tassilo.jf.intel.com>
 <20200226212034.GA21102@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226212034.GA21102@agluck-desk2.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:20:34PM -0800, Luck, Tony wrote:
> On Wed, Feb 26, 2020 at 01:10:40PM -0800, Andi Kleen wrote:
> > On Wed, Feb 26, 2020 at 11:10:58AM -0800, Kyung Min Park wrote:
> > > TPAUSE instructs the processor to enter an implementation-dependent
> > > optimized state. The instruction execution wakes up when the time-stamp
> > > counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> > > The instruction execution also wakes up due to the expiration of
> > > the operating system time-limit or by an external interrupt
> > 
> > This is actually a behavior change. Today's udelay() will continue
> > after processing the interrupt. Your patches don't
> 
> The instruction level TPAUSE is called inside delay_wait()
> that checks to see of we were interrupted early and loops to issue
> another TPAUSE if needed.

Ah right. It was already solved for mwaitx. Great.

-Andi
