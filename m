Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68961C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E19B21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIBCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:02:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:33906 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIBCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:02:07 -0400
IronPort-SDR: KK7q0g97WbHRhTjZAhbJ5WcOx4KN0HmTfXVMzY+dMDLyM3hYGRHqpdAtyBmcVuBJNxQx4VC8wn
 OWCw5/fIGQsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145965554"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="145965554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:02:06 -0700
IronPort-SDR: IouVpf6JesZxkl3cSXVSgH9natnKMBzVzY5mzgu6/JjkWcq1TCGVepYVIL1IRDiiuA2w2JyULj
 LZd7nhIjmgng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="328712504"
Received: from monicak-mobl1.gar.corp.intel.com ([10.213.174.160])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2020 18:02:05 -0700
Message-ID: <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 08 Sep 2020 18:02:05 -0700
In-Reply-To: <20200908193029.GM25236@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
         <20200907100647.GB10657@zn.tnic>
         <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
         <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
         <20200908172558.GG25236@zn.tnic>
         <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
         <20200908173656.GI25236@zn.tnic>
         <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
         <20200908180112.GK25236@zn.tnic>
         <20200908191838.GA2014@sultan-box.localdomain>
         <20200908193029.GM25236@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-08 at 21:30 +0200, Borislav Petkov wrote:
> On Tue, Sep 08, 2020 at 12:18:38PM -0700, Sultan Alsawaf wrote:
> > I'd like to point out that on Intel's recent 14nm parts,
> > undervolting
> > is not so much for squeezing every last drop of performance out of
> > the
> > SoC as it is for necessity.
> 
> <snip interesting examples>
> 
> Sounds to me that this undervolting functionality should be part of
> the kernel and happen automatically. I have no clue, though, whether
> people who do it, just get lucky and undervolting doesn't cause any
> other hardware issues, or there's a real reason for this power
> madness
> and if not done, power-related failures happen only on some boxes so
> they decided to do them on all.
> 
> Or maybe BIOS is nuts, which is not a stretch.
> 
The whole OC is based on experiments to come to correct values. This
depends on whole system design not just CPUs.
https://www.intel.com/content/www/us/en/gaming/resources/how-to-overclock.html
It warns about system stability.

> Srinivas, what's the story here?
I checked and there is no public spec. There are several mailbox
commands with version dependent on the processor.

The actual OC mailbox implementation itself is implemented in Linux in
intel_turbo_max_3 driver. So that is public.
So someone can develop a driver and provide some sysfs to send mailbox
commands, but kernel can't validate commands which can cause any
security or stability issues. Not sure if this is acceptable standard.
I don't think there is any precedent of creating such blind sysfs
entries.


Thanks,
Srinivas

