Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795AEC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503F9206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbgDAXcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:32:36 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37860 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAXcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:32:36 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993316AbgDAXcamxzAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:32:30 +0200
Date:   Thu, 2 Apr 2020 00:32:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
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
        jailhouse-dev@googlegroups.com
Subject: Re: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot
 path
In-Reply-To: <beefca46-ac7c-374b-e80a-4e7c3af2eb2b@citrix.com>
Message-ID: <alpine.LFD.2.21.2004012353100.4156324@eddie.linux-mips.org>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com> <601E644A-B046-4030-B3BD-280ABF15BF53@zytor.com> <87r1xgxzy6.fsf@nanos.tec.linutronix.de> <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
 <beefca46-ac7c-374b-e80a-4e7c3af2eb2b@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Andrew Cooper wrote:

> >  Even though we supported them by spec I believe we never actually ran MP 
> > on any 486 SMP system (Alan Cox might be able to straighten me out on 
> > this); none that I know of implemented the MPS even though actual hardware 
> > might have used the APIC architecture.  Compaq had its competing solution 
> > for 486 and newer SMP, actually deployed, the name of which I long forgot.  
> > We never supported it due to the lack of documentation combined with the 
> > lack of enough incentive for someone to reverse-engineer it.
> 
> :)
> 
> I chose "486-ism" based on what the MP spec said about external vs
> integrated Local APICs.  I can't claim to have any experience of those days.

 The spec is quite clear about the use of discrete APICs actually:

"5.1 Discrete APIC Configurations

"   Figure 5-1 shows the default configuration for systems that use the 
    discrete 82489 APIC.  The Intel486 processor is shown as an example; 
    however, this configuration can also employ Pentium processors.  In 
    Pentium processor systems, PRST is connected to INIT instead of to 
    RESET."

:)  And if in the way the internal local APIC in P54C processors can be
permanently disabled (causing it not to be reported in CPUID flags) via a 
reset strap, e.g. to support an unusual configuration.

 As I recall the integrated APIC would in principle support SMP configs 
beyond dual (the inter-APIC bus was serial at the time and supported 15 
APIC IDs with the P54C), but at the time the P54C processor was released 
the only compatible I/O APICs were available as a part of Intel PCI south 
bridges (the 82375EB/SB ESC and the 82379AB SIO.A).  Those chips were not 
necessarily compatible with whatever custom chipset was developed to 
support e.g. a quad-SMP P54C system.  Or there were political reasons 
preventing them from being used.

 Then the 82489DX used an incompatible protocol (supporting 254 APIC IDs 
among others, and as I recall the serial bus had a different number of 
wires even), so it couldn't be mixed with integrated local APICs.  That's 
why discrete APICs were sometimes used even with P54C processors.

 And the 82093AA standalone I/O APIC was only introduced a few years 
later, along with the Intel HX (Triton II) SMP chipset.  I still have a 
nice working machine equipped with this chipset and dual P55C processors 
@233MHz.  Even the original CPU fans are going strong. :)  Its MP table is 
however buggy and difficult to work with if the I/O APIC is to be used, 
especially if PCI-PCI bridges are involved (there's none onboard, but you 
can have these easily in multiple quantities on option cards nowadays).

  Maciej
