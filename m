Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218AB20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEUAzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:55:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:10627 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgEUAzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:55:48 -0400
IronPort-SDR: 8duFuZPEofp/DftbcS+JS7mWFuMCyFKUzT+exsqs5owTlKw8M5F/x7a/Zg33N+KbeX6EM1iTIv
 QMXsXzPN9A+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 17:55:48 -0700
IronPort-SDR: 2H7CgkH+KoPTW4LUsgiGxEVueOh0IlvIteLGhf1tdBUrkQ1JEAx/go+VdIZAH9K5F/AmHzWA3G
 jj4jQer82PyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="255163730"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2020 17:55:47 -0700
Date:   Wed, 20 May 2020 17:56:05 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        Andreas Rammhold <andi@notmuch.email>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200521005605.GA11955@ranerica-svr.sc.intel.com>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
 <20200519194320.GA25138@ranerica-svr.sc.intel.com>
 <CALCETrXxYjrMoenqyxEoBmcitHY22tfpJQAzvS=iF_5+SEZa4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXxYjrMoenqyxEoBmcitHY22tfpJQAzvS=iF_5+SEZa4w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 05:54:53PM -0700, Andy Lutomirski wrote:
> On Tue, May 19, 2020 at 12:43 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Tue, May 19, 2020 at 11:56:40AM -0700, Brendan Shanks wrote:
> > >
> > > > On May 19, 2020, at 7:38 AM, Andreas Rammhold <andi@notmuch.email> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I've been running into a weird problem with UMIP on a current Ryzen
> > > > 3900x with kernel 5.6.11 where a process receives a page fault after the
> > > > kernel handled the SLDT (or SIDT) instruction (emulation).
> > > >
> > > > The program I am running is run through WINE in 32bit mode and tries to
> > > > figure out if it is running in a VMWare machine by comparing the results
> > > > of SLDT against well known constants (basically as shown in the
> > > > [example] linked below).
> > > >
> > > > In dmesg I see the following log lines:
> > > >> [99970.004756] umip: Program.exe[3080] ip:4373fb sp:32f3e0: SIDT instruction cannot be used by applications.
> > > >> [99970.004757] umip: Program.exe[3080] ip:4373fb sp:32f3e0: For now, expensive software emulation returns the result.
> > > >> [99970.004758] umip: Program.exe[3080] ip:437415 sp:32f3e0: SLDT instruction cannot be used by applications.
> > > >
> > > > Following that the process terminates with a page fault:
> > > >> Unhandled exception: page fault on read access to 0xffffffff in 32-bit code (0x0000000000437415).
> > > >
> > > > Assembly at that address:
> > > >> 0x0000000000437415: sldt    0xffffffe8(%ebp)
> > > >
> > > > Running the same executable on the exact same kernel (and userland) but
> > > > on a Intel i7-8565U doesn't crash at this point. I am guessing the
> > > > emulation is supposed to do something different on AMD CPUs?
> >
> > I am surprised you don't see it on the Intel processor. Maybe it does
> > not have UMIP. Do you see umip when you do
> >
> > $ grep umip /proc/cpuinfo
> >
> > ?
> > > >
> > > > On the Ryzen the code executes successfully after setting CONFIG_X86_UMIP=n.
> > >
> > > Hi Andreas,
> > >
> > > The problem is that the kernel does not emulate/spoof the SLDT instruction, only SGDT, SIDT, and SMSW.
> > > SLDT and STR weren't thought to be commonly used, so emulation/spoofing wasn’t added.
> > > In the last few months I have seen reports of one or two (32-bit) Windows games that use SLDT though.
> > > Can you share more information about the application you’re running?
> > >
> > > Maybe the best path is to add kernel emulation/spoofing for SLDT and STR on 32 and 64-bit, just to cover all the cases. It should be a pretty simple patch, I’ll start working on it.
> >
> > I have a patch for this already that I wrote for testing purposes:
> >
> > https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b93be50
> >
> > Perhaps it can be used as a starting point? Not sure what the spoofing
> > value should be, though. Perhaps 0?
> 
> Possibly SLDT should return nonzero if there's an LDT.

I guess the value should be in the same hole of the x86_64 memory map,
right? Currently sgdt and sidt return 0xfffffffffffe0000 and
0xffffffffffff0000, respectively.

Thanks and BR,
Ricardo
