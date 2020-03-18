Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E8C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D7B20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCRS3R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:29:17 -0400
Received: from poy.remlab.net ([94.23.215.26]:39584 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRS3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:29:16 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
        (Authenticated sender: remi)
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 7E4E95FB07;
        Wed, 18 Mar 2020 19:29:13 +0100 (CET)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Date:   Wed, 18 Mar 2020 20:29:12 +0200
Message-ID: <8127163.Epc2VWTDuo@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20200318180630.GE94111@arrakis.emea.arm.com>
References: <20200316124046.103844-1-remi@remlab.net> <20200318175709.GD94111@arrakis.emea.arm.com> <20200318180630.GE94111@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le keskiviikkona 18. maaliskuuta 2020, 20.06.30 EET Catalin Marinas a écrit :
> On Wed, Mar 18, 2020 at 05:57:09PM +0000, Catalin Marinas wrote:
> > On Mon, Mar 16, 2020 at 02:40:44PM +0200, Rémi Denis-Courmont wrote:
> > > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > 
> > > This switches from custom instruction patterns to the regular large
> > > memory model sequence with ADRP and LDR. In doing so, the ADD
> > > instruction can be eliminated in the SDEI handler, and the code no
> > > longer assumes that the trampoline vectors and the vectors address both
> > > start on a page boundary.
> > > 
> > > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > 
> > I queued the 3 trampoline patches for 5.7. Thanks.
> 
> ... and removed. I applied them on top of arm64 for-next/asm-annotations
> and with defconfig I get:
> 
>   LD      .tmp_vmlinux1
> arch/arm64/kernel/entry.o: in function `tramp_vectors':
> arch/arm64/kernel/entry.S:838:(.entry.tramp.text+0x43c): relocation
> truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol
> `__entry_tramp_data_start' defined in .rodata section in
> 
> I haven't bisected to see which patch caused this issue.

Uho, right :-( It only builds with SDEI enabled :-$

I'll check further.

-- 
Rémi Denis-Courmont
http://www.remlab.net/



