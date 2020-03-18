Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F75C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2515A20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCRTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:48:53 -0400
Received: from poy.remlab.net ([94.23.215.26]:40956 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:48:52 -0400
Received: from roundcube.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 36FB45FB07;
        Wed, 18 Mar 2020 20:48:50 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Mar 2020 21:48:50 +0200
From:   Remi Denis-Courmont <remi@remlab.net>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Organization: Remlab Tmi
In-Reply-To: <8127163.Epc2VWTDuo@basile.remlab.net>
References: <20200316124046.103844-1-remi@remlab.net>
 <20200318175709.GD94111@arrakis.emea.arm.com>
 <20200318180630.GE94111@arrakis.emea.arm.com>
 <8127163.Epc2VWTDuo@basile.remlab.net>
Message-ID: <fb0e19c2c231a5f256303253b92e64f3@remlab.net>
X-Sender: remi@remlab.net
User-Agent: Roundcube Webmail/1.2.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2020-03-18 20:29, Rémi Denis-Courmont a écrit :
> Le keskiviikkona 18. maaliskuuta 2020, 20.06.30 EET Catalin Marinas a 
> écrit :
>> On Wed, Mar 18, 2020 at 05:57:09PM +0000, Catalin Marinas wrote:
>> > On Mon, Mar 16, 2020 at 02:40:44PM +0200, Rémi Denis-Courmont wrote:
>> > > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
>> > >
>> > > This switches from custom instruction patterns to the regular large
>> > > memory model sequence with ADRP and LDR. In doing so, the ADD
>> > > instruction can be eliminated in the SDEI handler, and the code no
>> > > longer assumes that the trampoline vectors and the vectors address both
>> > > start on a page boundary.
>> > >
>> > > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
>> >
>> > I queued the 3 trampoline patches for 5.7. Thanks.
>> 
>> ... and removed. I applied them on top of arm64 
>> for-next/asm-annotations
>> and with defconfig I get:
>> 
>>   LD      .tmp_vmlinux1
>> arch/arm64/kernel/entry.o: in function `tramp_vectors':
>> arch/arm64/kernel/entry.S:838:(.entry.tramp.text+0x43c): relocation
>> truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol
>> `__entry_tramp_data_start' defined in .rodata section in
>> 
>> I haven't bisected to see which patch caused this issue.

It's the third patch.

> Uho, right :-( It only builds with SDEI enabled :-$
> 
> I'll check further.

It seems that the SYM_DATA_START macro does not align the data on its 
natural boundary. I guess that is all fine on x86 where data needs not 
be aligned, but it leads to this kind of mischief on arm64. Though even 
then, the address is of course actually aligned correctly on an 8-bytes 
boundary, so I suppose binutils is just being pointlessly pedantic here?

-- 
Rémi Denis-Courmont
