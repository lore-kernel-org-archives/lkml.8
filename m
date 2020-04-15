Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C9BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4601206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437233AbgDOUIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:08:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:61120 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406385AbgDOUII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:08:08 -0400
IronPort-SDR: a9i+qvlKS2MUcti8hBTD6QfEBVEOkn5e6uRprad2Vfo2HJdEKrZ2844mak7tBTNGAjytcKux2z
 N0LlRmQJAhNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 13:08:04 -0700
IronPort-SDR: bVXKlqUIpUAJd05C0gQ+TdCfPVcVuwnGhkAQOqeNR7sWe5U3Sa6vbVfPRqNjjF4dxX0JOc08Fa
 V85kyjbEHc2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="253630268"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.160])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 13:08:01 -0700
Message-ID: <c044d6001cf4ad25a8d13ba64c1d891721c16abd.camel@intel.com>
Subject: Re: [PATCH v3 3/3] x86/delay: Introduce TPAUSE delay
From:   km <kyung.min.park@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Date:   Wed, 15 Apr 2020 12:57:16 -0700
In-Reply-To: <20200414180545.GE2483@worktop.programming.kicks-ass.net>
References: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
         <1586561395-50914-4-git-send-email-kyung.min.park@intel.com>
         <20200414103106.GK20713@hirez.programming.kicks-ass.net>
         <3908561D78D1C84285E8C5FCA982C28F7F5E3E80@ORSMSX115.amr.corp.intel.com>
         <20200414180545.GE2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 2020-04-14 at 20:05 +0200, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 06:00:21PM +0000, Luck, Tony wrote:
> > > > +static inline void __tpause(u32 ecx, u32 edx, u32 eax)
> > > > +{
> > > > +	/* "tpause %ecx, %edx, %eax;" */
> > > > +	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
> > > > +		     :
> > > > +		     : "c"(ecx), "d"(edx), "a"(eax));
> > > > +}
> > > 
> > > Can we please get a comment stating from what binutils version
> > > this
> > > opcode has a mnemonic? That way, when we raise the minimum
> > > binutils
> > > version we can easily grep and find such things.
> > 
> > Or maybe use arch/x86/Kconfig.assembler to set up a
> > CONFIG_AS_TPAUSE?
> > 
> > Then the code can read something like (syntax may need fixing)
> > 
> > #ifdef CONFIG_AS_TPAUSE
> > 		asm volatile("tpause %ecx\n", : : "c"(ecx), "d"(edx),
> > "a"(eax));
> > #else
> > 		asm volatile(".byte hex gibberish ...
> > #endif
> 
> Then we still need a comment to know when we can kill that...

Thanks. I'll update in next patch.

