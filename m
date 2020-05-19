Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55874206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgESTnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:43:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:25273 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgESTnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:43:03 -0400
IronPort-SDR: BEYdU5y4tAJF19BnciXERyX7fxVh9mptmsVMNjrkKOhD2D/N6xFH/wvvQ8xupHlY+3eRDK1Z+2
 2xtDu5Ng2Sew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 12:43:02 -0700
IronPort-SDR: A8t+L6vswiT5HSLn0xcpL2/0D5XEgULGR0jwmgRysaU5UzGUhep/aaYLgBTtHfkLMDSJ1at9h2
 Rdqe6e86EiLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="282431559"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2020 12:43:01 -0700
Date:   Tue, 19 May 2020 12:43:20 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     Andreas Rammhold <andi@notmuch.email>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200519194320.GA25138@ranerica-svr.sc.intel.com>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:56:40AM -0700, Brendan Shanks wrote:
> 
> > On May 19, 2020, at 7:38 AM, Andreas Rammhold <andi@notmuch.email> wrote:
> > 
> > Hi,
> > 
> > I've been running into a weird problem with UMIP on a current Ryzen
> > 3900x with kernel 5.6.11 where a process receives a page fault after the
> > kernel handled the SLDT (or SIDT) instruction (emulation).
> > 
> > The program I am running is run through WINE in 32bit mode and tries to
> > figure out if it is running in a VMWare machine by comparing the results
> > of SLDT against well known constants (basically as shown in the
> > [example] linked below).
> > 
> > In dmesg I see the following log lines:
> >> [99970.004756] umip: Program.exe[3080] ip:4373fb sp:32f3e0: SIDT instruction cannot be used by applications.
> >> [99970.004757] umip: Program.exe[3080] ip:4373fb sp:32f3e0: For now, expensive software emulation returns the result.
> >> [99970.004758] umip: Program.exe[3080] ip:437415 sp:32f3e0: SLDT instruction cannot be used by applications.
> > 
> > Following that the process terminates with a page fault:
> >> Unhandled exception: page fault on read access to 0xffffffff in 32-bit code (0x0000000000437415).
> > 
> > Assembly at that address:
> >> 0x0000000000437415: sldt    0xffffffe8(%ebp)
> > 
> > Running the same executable on the exact same kernel (and userland) but
> > on a Intel i7-8565U doesn't crash at this point. I am guessing the
> > emulation is supposed to do something different on AMD CPUs?

I am surprised you don't see it on the Intel processor. Maybe it does
not have UMIP. Do you see umip when you do

$ grep umip /proc/cpuinfo 

?
> > 
> > On the Ryzen the code executes successfully after setting CONFIG_X86_UMIP=n.
> 
> Hi Andreas,
> 
> The problem is that the kernel does not emulate/spoof the SLDT instruction, only SGDT, SIDT, and SMSW.
> SLDT and STR weren't thought to be commonly used, so emulation/spoofing wasn’t added.
> In the last few months I have seen reports of one or two (32-bit) Windows games that use SLDT though.
> Can you share more information about the application you’re running?
> 
> Maybe the best path is to add kernel emulation/spoofing for SLDT and STR on 32 and 64-bit, just to cover all the cases. It should be a pretty simple patch, I’ll start working on it.

I have a patch for this already that I wrote for testing purposes:

https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b93be50

Perhaps it can be used as a starting point? Not sure what the spoofing
value should be, though. Perhaps 0?

Thanks and BR,
Ricardo
