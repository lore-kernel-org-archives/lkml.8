Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A750C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F0220772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgCaXfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:35:21 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:54170 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgCaXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:35:21 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991035AbgCaXfQ0q2BF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:35:16 +0200
Date:   Wed, 1 Apr 2020 00:35:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     hpa@zytor.com, Andrew Cooper <andrew.cooper3@citrix.com>,
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
In-Reply-To: <87r1xgxzy6.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.LFD.2.21.2004010001460.3939520@eddie.linux-mips.org>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com> <601E644A-B046-4030-B3BD-280ABF15BF53@zytor.com> <87r1xgxzy6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Thomas Gleixner wrote:

> >>@@ -1118,7 +1121,7 @@ static int do_boot_cpu(int apicid, int cpu,
> >>struct task_struct *idle,
> >> 		}
> >> 	}
> >> 
> >>-	if (x86_platform.legacy.warm_reset) {
> >>+	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
> >> 		/*
> >> 		 * Cleanup possible dangling ends...
> >> 		 */
> >
> > We don't support SMP on 486 and haven't for a very long time. Is there
> > any reason to retain that code at all?
> 
> Not that I'm aware off.

 For the record: this code is for Pentium really, covering original P5 
systems, which lacked integrated APIC, as well as P54C systems that went 
beyond dual (e.g. ALR made quad-SMP P54C systems).  They all used external 
i82489DX APICs for SMP support.  Few were ever manufactured and getting 
across one let alone running Linux might be tough these days.  I never 
managed to get one for myself, which would have been helpful for 
maintaining this code.

 Even though we supported them by spec I believe we never actually ran MP 
on any 486 SMP system (Alan Cox might be able to straighten me out on 
this); none that I know of implemented the MPS even though actual hardware 
might have used the APIC architecture.  Compaq had its competing solution 
for 486 and newer SMP, actually deployed, the name of which I long forgot.  
We never supported it due to the lack of documentation combined with the 
lack of enough incentive for someone to reverse-engineer it.

 FWIW,

  Maciej
