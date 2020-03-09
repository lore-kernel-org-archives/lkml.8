Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A4C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521D221D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583774105;
	bh=BYb5UI0eZvZZCMUBLxom8LuT2wDeYVQflCYlJXcNK+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jDSdNecXyCc4rZSzRG68WA/bbcptMtAqLaLNNH8XFGHw0+Sr+HeXf+JSLyDtSiplX
	 I/w6K3OTPJ294BkVWk6KTLGiiARSEREY1JkpeNkNSEEXo28WnO7drR6BqHpbEGKLQt
	 FXAcbiL7FJHBA7ccvZ4jh+4iMaVN3mtgFKjPSMqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgCIRPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgCIRPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:15:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72679208C3;
        Mon,  9 Mar 2020 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583774102;
        bh=BYb5UI0eZvZZCMUBLxom8LuT2wDeYVQflCYlJXcNK+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VeORRDfU9H7K/q5AGNmxj4p6F8nUugGS7GrYLogQRxGCHeEdgd+u1v0BJ0Ab9IYw+
         iYfKXhzZUdR6BT7cGkt0+H+PvobHUz18VoYIIp0Zn0OySjuiTVfP+z2FsWW9iIBepp
         q6peI3GcHnOGwR8dQZYTYRXTqECwCfl1cYSUrtHk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBLzY-00BKsd-Na; Mon, 09 Mar 2020 17:15:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 17:15:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: avoid reading typer2 if GICv3
In-Reply-To: <20200309151425.nex3scw46sgrxu5v@rric.localdomain>
References: <20200307233442.958122-1-msalter@redhat.com>
 <20200308102756.4bae3c27@why>
 <20200309151425.nex3scw46sgrxu5v@rric.localdomain>
Message-ID: <47e631b06719415f4b3cf8ffb6b158fc@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rrichter@marvell.com, msalter@redhat.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 2020-03-09 15:14, Robert Richter wrote:
> Marc,
> 
> On 08.03.20 10:27:56, Marc Zyngier wrote:
>> Hi Mark,
>> 
>> +Robert for Marvell/Cavium
>> 
>> On Sat,  7 Mar 2020 18:34:42 -0500
>> Mark Salter <msalter@redhat.com> wrote:
>> 
>> > Trying to boot v5.6-rc1 on a ThunderX platform leads to
>> > a SEA splat when trying to read the GICv4 TYPER2 register:
>> 
>> There is no such thing as a GICv4 register. All registers exist on all
>> versions of the architecture. They all have a well defined behaviour
>> when not implemented, which is RAZ/WI. New versions of the GICv3
>> architecture (which continues to evolve in parallel to GICv4) may use
>> this register as well, and this patch would then become a problem on
>> its own.
>> 
>> Now, to the issue itself:
>> 
>> >
>> > [    0.000000] GICv3: 0 Extended SPIs implemented
>> > [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
>> > [    0.000000] Modules linked in:
>> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc4+ #11
>> > [    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
>> > [    0.000000] pstate: 60400085 (nZCv daIf +PAN -UAO)
>> > [    0.000000] pc : __raw_readl+0x0/0x8
>> > [    0.000000] lr : gic_init_bases+0x110/0x4b0
>> > [    0.000000] sp : ffff800011973dd0
>> > [    0.000000] x29: ffff800011973dd0 x28: 0000000002150018
>> > [    0.000000] x27: 0000000000000018 x26: 0000000000000000
>> > [    0.000000] x25: 0000000000000002 x24: ffff010fe7ef6700
>> > [    0.000000] x23: 0000000000000000 x22: ffff800010dc3b90
>> > [    0.000000] x21: ffff010fef138020 x20: 00000000009b0404
>> > [    0.000000] x19: ffff80001198c508 x18: 0000000000000005
>> > [    0.000000] x17: 000000006fc20c07 x16: 0000000000000001
>> > [    0.000000] x15: 0000000000000010 x14: ffffffffffffffff
>> > [    0.000000] x13: ffff800091973b4f x12: ffff800011973b5c
>> > [    0.000000] x11: ffff800011989000 x10: 0000000000000080
>> > [    0.000000] x9 : ffff8000101991e4 x8 : 0000000000040000
>> > [    0.000000] x7 : 000000000000413d x6 : 0000000000000000
>> > [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
>> > [    0.000000] x3 : 0000000000000080 x2 : ffff8000119c1f10
>> > [    0.000000] x1 : ffff800011991a40 x0 : ffff800013c9000c
>> > [    0.000000] Call trace:
>> > [    0.000000]  __raw_readl+0x0/0x8
>> > [    0.000000]  gic_of_init+0x170/0x1f8
>> > [    0.000000]  of_irq_init+0x1e4/0x3c4
>> > [    0.000000]  irqchip_init+0x1c/0x40
>> > [    0.000000]  init_IRQ+0x164/0x194
>> > [    0.000000]  start_kernel+0x334/0x4cc
>> >
>> > So avoid reading TYPER2 on GICv3.
> 
> we can confirm that access to a GIC3.0 unspecified register will cause
> a fault.

Not unspecified. It is specified as "Reserved", for which the behaviour
is perfectly defined. Does it also mean that other register in the
GICD space will suffer from the same problem? How about the 
redistributors,
the ITS?

> I have double-checked with the specification (GICv3 spec, ARM
> IHI 0069C). Rev. C of the spec includes already GICv4 parts and the
> register size is there set to 64 bit with the upper bits set to RES0
> for the GICv3 case. This would mean a violation of the spec. I don't
> have an earlier GICv3 spec at hand, but Appendix C, Revisions
> indicates the register is 64 bits from the beginning, though, I am not
> sure here.

I don't follow. My copy of IHI0096C shows:

- GICD_IIDR: Offset 8
- Reserved: Offset  0xc
- GICD_STATUSR: Offset 0x10

I can't see how you'd squeeze a 64bit register between IIDR and STATUSR.

> It could be anyway that the upper part (offset 0xc) was marked as
> Reserved in the beginning (a draft or earlier version) the same way as
> other ranges in the ITS register map (8.18 The ITS register map). An
> access to 'Reserved' ranges is defined in the Glossary as
> UNPREDICTABLE.

It's not an ITS register. This is a distributor register, and these are
always 32bit. Even the 64bit registers must support 32bit accesses
because of AArch32 (such as GICD_IROUTERn).

> So the spec might have been imprecise here in the beginning. That
> said, it might be better to check for ArchRev of GICD_PIDR2 for >= 4
> before accessing typer2, instead of checking for certain part IDs.

No, the spec has always been pretty precise. It says [IHI0069A, 8.8]:

"Unless otherwise stated in the register description, all GIC registers
are 32-bits wide."

And the reason for that is that it has to work with 32bit CPUs. So as 
far
as I can see, TX1 is violating the letter of the architecture. As for 
checking
ArchRev, that's a firm No. All registers exist on all revision of the
architecture, which is why there's a unified GICv3/v4 architecture 
document.

>> I have reported this exact problem back in October:
>> 
>> https://lore.kernel.org/lkml/20191027144234.8395-1-maz@kernel.org/
>> 
>> and proposed a patch for it:
>> 
>> https://lore.kernel.org/lkml/20191027144234.8395-11-maz@kernel.org/
> 
> There are more parts affected than with ProductID 0xa1, I will reply
> to the patch.
> 
>> I've been repeatedly asking for Marvell/Cavium to come up with a
>> description of the issue so that we know the extent of the problem. So
>> far, all I've heard is the sound of crickets, which confirm my
>> impression that this HW is dead to its manufacturer and that they 
>> don't
>> want to support it. I'm not asking much though: just tell me what is
>> wrong (again!) with this CPU, which are the affected revisions, what 
>> is
>> the errata number and I'll deal with it.
> 
> There is no errata number yet, sorry. There will be one once a spec
> violation is confirmed.

/me grabs pop-corn and waits...

>> I can't get that information. Can you?
>> 
>> I'm now proposing that we fully remove support for TX1 from the
>> mainline kernel, because every single bit of this CPU is completely
>> busted. Just look at the number of workarounds we have to carry 
>> around.
>> Without involvement from Marvell, this CPU is a liability for the rest
>> of the arm64 kernel (just look at what we have to do to enable KPTI
>> *because of TX1*, the amount of crap I added to KVM to fully emulate
>> the broken CPU interface, and plenty of other things).
> 
> This is a bit unfair, during 2015/16 timeframe this was the only
> non-ARM cpu available at all. So everything was in the beginning there
> and things may happen. But many errata have been fixed in newer
> revisions (which stops of course when newer CPUs become available).

Even XGene-1 was available before TX1, and wasn't so grossly buggy.
And even then. Having a buggy CPU is not the end of the world if
the SV works with us. Over the past 5 years, we have had to work
*despite* Cavium. Yes, I'm a bit bitter about it.

>> I intend to propose such removal once 5.7-rc1 lands.
> 
> I hope we can work on a better solution here.

How about getting Marvell to actually work with upstream? Over 5 months
between a bug being reported and the first acknowledgement that "yes,
we may have a problem here" is not exactly something that fills me
with the utmost confidence.

         M.
-- 
Jazz is not dead. It just smells funny...
