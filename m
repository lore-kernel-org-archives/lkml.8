Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A2C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1D920732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCUBqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:46:16 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:59406 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCUBqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:46:15 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992652AbgCUBqL41114 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 02:46:11 +0100
Date:   Sat, 21 Mar 2020 01:46:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: x86/apic: Dead code in setup_local_APIC()
In-Reply-To: <0c2c3380-4e2f-5cbb-41eb-38057f008c5f@citrix.com>
Message-ID: <alpine.LFD.2.21.2003210125280.2689954@eddie.linux-mips.org>
References: <0c2c3380-4e2f-5cbb-41eb-38057f008c5f@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, Andrew Cooper wrote:

> c/s 2640da4ccc "x86/apic: Soft disable APIC before initializing it" had
> a (perhaps unintended) consequence for the setup of LVT0.
> 
> Later, LVT0's mask bit is sampled to determine whether the BSP should be
> configured to accept ExtINT messages.
> 
> Because soft reset unconditionally masks the LVT registers, the
> following patch could be taken to drop dead code:
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 5f973fed3c9f..b80032d2dfeb 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1723,8 +1723,7 @@ static void setup_local_APIC(void)
>         /*
>          * TODO: set up through-local-APIC from through-I/O-APIC? --macro
>          */
> -       value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
> -       if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
> +       if (!cpu && (pic_mode || skip_ioapic_setup)) {
>                 value = APIC_DM_EXTINT;
>                 apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n",
> cpu);
>         } else {
> 
> 
> However, the comment just out of context above says that ExtINT is
> deliberately configured even symmetric-IO mode, in case some interrupts
> are using the PIC.  If that is the intended behaviour, then 2640da4ccc
> regressed it.

 FYI, it's been a very long while since I last poke at this code, however 
the context along with my comment indicates the LVT0 mask check is there 
so as to handle virtual-wire setups correctly whether the ExtINT has been 
routed via the local or the I/O APIC.  In the latter case LVT0 will have 
been masked by the bootstrap firmware.

 This only matters for systems that do not wire the 8254 PIT IRQ natively 
(nominally to I/O APIC #0, input #2) and a suitable ExtINT interrupt has 
to be retained for the PIT IRQ to work.  Different hardware has the 8259A 
combo wired to either or both I/O APIC #0, input #0 and local APIC, input 
#0.  If only a single route is available, it has to be used according to 
how the bootstrap firmware has set the hardware up.

 As I understand it this will only matter for older systems that comply 
with the MPS rather than ACPI.  It may be difficult to verify with such a 
system these days (I do retain such a live specimen, but it's clean on the 
hardware side in that it has all the possible IRQ routings concerned here 
implemented, so all this hackery does not really matter and it can use the 
native 8254 PIT IRQ routing).  Whether we need the PIT nowadays in the 
first place is another matter.

 HTH,

  Maciej
