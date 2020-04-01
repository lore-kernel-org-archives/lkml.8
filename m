Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21954C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2852073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgDAN0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:26:22 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:43290 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgDAN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:26:21 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992512AbgDAN0QR3HMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:26:16 +0200
Date:   Wed, 1 Apr 2020 14:26:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        "jailhouse-dev@googlegroups.com" <jailhouse-dev@googlegroups.com>
Subject: RE: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot
 path
In-Reply-To: <23147db6f0c548259357babfc22a87d3@AcuMS.aculab.com>
Message-ID: <alpine.LFD.2.21.2004011354050.3939520@eddie.linux-mips.org>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com> <601E644A-B046-4030-B3BD-280ABF15BF53@zytor.com> <87r1xgxzy6.fsf@nanos.tec.linutronix.de> <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
 <23147db6f0c548259357babfc22a87d3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, David Laight wrote:

> >  Even though we supported them by spec I believe we never actually ran MP
> > on any 486 SMP system (Alan Cox might be able to straighten me out on
> > this); none that I know of implemented the MPS even though actual hardware
> > might have used the APIC architecture.  Compaq had its competing solution
> > for 486 and newer SMP, actually deployed, the name of which I long forgot.
> > We never supported it due to the lack of documentation combined with the
> > lack of enough incentive for someone to reverse-engineer it.
> 
> I also remember one of those Compaq dual 486 boxes.
> We must have has SVR4/Unixware running on it.
> 
> I suspect that any such systems would also be too slow and not have
> enough memory to actually run anything recent.

 For reasons mentioned above I cannot speak about 486 SMP systems.

 However I have a nice Dolch PAC 60 machine, which is a somewhat rugged 
luggable computer with an embedded LCD display and a detachable keyboard, 
built around a pure EISA 486 baseboard (wiring to an external display is 
also supported).  Its original purpose was an FDDI network sniffer with a 
DOS application meant to assist a field engineer with fault isolation, and 
as you may know FDDI used to have rings up to ~100km/60mi in length, so 
people often had to travel quite a distance to get a problem tracked down.

 It used to boot current Linux with somewhat dated userland until its PSU, 
an industrial unit, failed a couple years back, taking the hard disk with 
itself due to an overvoltage condition (its +12V output went up to +18V).  
I failed to repair the PSU (I suspect a fault in the transformer causing 
its windings to short-circuit intermittently, and only the +5V output is 
regulated with the remaining ones expected to maintain fixed correlation), 
which the box has been designed around, making it difficult to be replaced 
with a different PSU.

 However I have since managed to track down and install a compatible 
replacement PSU from the same manufacturer whose only difference are 
slightly higher power ratings, and I have a replacement hard disk for it 
too, so I plan to get it back in service soon.

 With 16MiB originally installed the machine is somewhat little usable 
with current Linux indeed, however the baseboard supports up to 512MiB of 
RAM and suitable modules are still available for purchase, even brand new 
ones.  Once expanded so that constant swapping stops I expect the machine 
to perform quite well, as the performance of the CPU/RAM didn't seem to be 
a problem with this machine.  We actually keep supporting slower systems 
in the non-x86 ports.

 And as I say, the userland is not (much of) our business and can be 
matched to actual hardware; not everyone needs a heavyweight graphical 
environment with all the bells and whistles burning machine cycles.

 Again, FWIW,

  Maciej
