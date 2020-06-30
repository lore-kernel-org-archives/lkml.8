Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6BE20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593501750;
	bh=AGvlLNBlx3bbxyvR44zntByoYH0BX9djo9ELlICoPJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cFZi4PEmDlQ1EAElcTTLGqSTFmMU+PdydE/sDTh1pIUXPGTtRO2ODSjR23tX4vI8K
	 qBrfHIh9a0Xu3YFhjjyn+tOAqVkErBK/tCySQw2aI28lx0mZXkvJrHrDQ1K77Wftyh
	 xpx3WJdI/sew3xM+Er5CkI6Hf2WTBdhzElkZVfEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgF3HW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbgF3HW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:22:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C8C20759;
        Tue, 30 Jun 2020 07:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593501747;
        bh=AGvlLNBlx3bbxyvR44zntByoYH0BX9djo9ELlICoPJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ot+WEl+7LPutY0WbZaf9ShIjKm24najLyECN/GK/osKG3Q/D41WMnDCzYDmTjKoVE
         HyXs0Fjf7WRV2gskteKcNP47JGRO+xZo1u+96m5BNlSDpQgVggOLihuBVtX6isZstq
         TzldNymbQVPR27djSf7i3snjb3X42AQ/VHiQmnmk=
Date:   Tue, 30 Jun 2020 08:22:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "liwei (GF)" <liwei391@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
Message-ID: <20200630072221.GA13332@willie-the-truck>
References: <20200509214159.19680-1-liwei391@huawei.com>
 <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
 <a20ee677-495b-9336-a329-eabd50dd1cad@huawei.com>
 <CAD=FV=WYBAJB_nWxUAAVgV26e4CTzJeizZtxpwus6REi3j2meA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WYBAJB_nWxUAAVgV26e4CTzJeizZtxpwus6REi3j2meA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:20:11PM -0700, Doug Anderson wrote:
> On Sat, May 16, 2020 at 1:20 AM liwei (GF) <liwei391@huawei.com> wrote:
> > On 2020/5/14 8:34, Doug Anderson wrote:
> > > On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
> > >>
> > >> This patch set is to fix several issues of single-step debugging
> > >> in kgdb/kdb on arm64.
> > >>
> > >> It seems that these issues have been shelved a very long time,
> > >> but i still hope to solve them, as the single-step debugging
> > >> is an useful feature.
> > >>
> > >> Note:
> > >> Based on patch "arm64: cacheflush: Fix KGDB trap detection",
> > >> https://www.spinics.net/lists/arm-kernel/msg803741.html
> > >>
> > >> Wei Li (4):
> > >>   arm64: kgdb: Fix single-step exception handling oops
> > >>   arm64: Extract kprobes_save_local_irqflag() and
> > >>     kprobes_restore_local_irqflag()
> > >>   arm64: kgdb: Fix single-stepping into the irq handler wrongly
> > >>   arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
> > >>
> > >>  arch/arm64/include/asm/debug-monitors.h |  6 ++++++
> > >>  arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
> > >>  arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
> > >>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
> > >>  4 files changed, 48 insertions(+), 30 deletions(-)
> > >
> > > Just an overall note that I'm very happy that you posted this patch
> > > series!  It's always been a thorn in my side that stepping and
> > > breakpoints were so broken on arm64 and I'm really excited that you're
> > > fixing them.  Now I'll have to get in the habit of using kgdb for more
> > > than just debugging crashes and maybe I can use it more for exploring
> > > how functions work more.  :-)
> > > > I'll also note that with your patch series I'm even seeing the "call"
> > > feature of gdb working now.  That has always been terribly broken for
> > > me.
> > >
> > Thanks for reviewing and testing this series.
> > Enjoy exploring the kernel with kgdb/kdb! :-)
> 
> I'm curious to know if you plan another spin.  The feedback you
> received was fairly minor so it hopefully shouldn't be too hard.  I'd
> very much like to get your patches landed and I'd be happy to try to
> address the feedback and spin them myself if you're no longer
> available for it.

I'd welcome some feedback on the proposal I sent out at the end of last
week:

https://lore.kernel.org/r/20200626095551.GA9312@willie-the-truck

which looks to solve some (all?) of these issues slightly differently,
because it turns out we need to perform some low-level surgery for
preempt-rt *anyway*...

I'm particularly keen to hear any thoughts concerning the reschedule on
return to EL1 after handling an interrupt that hit during a step.

Will
