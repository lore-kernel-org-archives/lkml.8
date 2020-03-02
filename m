Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B945C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6DE246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCBG1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 01:27:18 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56252 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3091929E8B;
        Mon,  2 Mar 2020 01:26:20 -0500 (EST)
Date:   Mon, 2 Mar 2020 17:26:17 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <20200301061327.GA5229@afzalpc>
Message-ID: <alpine.LNX.2.22.394.2003021717150.8@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <20200229131553.GA4985@afzalpc> <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet> <20200301010511.GA5195@afzalpc>
 <alpine.LNX.2.22.394.2003011337590.15@nippy.intranet> <20200301061327.GA5229@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Mar 2020, afzal mohammed wrote:

> Hi,
> 
> On Sun, Mar 01, 2020 at 02:26:33PM +1100, Finn Thain wrote:
> 
> > BTW, how do you distinguish between "new code" and "legacy code"?
> 
> setup_irq() was used in olden days, nowadays request_irq(). Though there 
> are exceptions of trying to use setup_irq() even recently, but there has 
> been pushback when people notice it like Thomas had done [1], and i saw 
> recently one in mips smp support series & suggested not to use it (that 
> code iiuc they had it out of upstream for a long time).
> 
> So existence of setup_irq() in general i have considered to be legacy 
> code.
> 

I see. You're defining "legacy code" in this case to mean code that uses a 
deprecated API, that needs to be modernized.

> > And why would you choose to do that when you are writing a tree-wide 
> > semantic patch?
> 
> The way i came up with this series is that while trying to understand 
> irq internals, came across [1], so then decided to do cleanup and i 
> thought scripting it would make it easy & also had been wanting to get 
> familiar w/ cocci, so decided to try it, but also realized that i cannot 
> fully automate it (Julia said my patch is okay, so i felt cocci cannot 
> fully automate w/o investing considerable effort in cocci), so even w/ 
> this v2, there are lot of manual changes, though cocci made it easier.
> 
> > I took Geert's comments to be architecture agnostic but perhaps I 
> > misunderstood.
> 
> And Thomas suggested to make improvements over script generated o/p [2] 
> and only consider scripting as an initial first step. So the way i am 
> making changes now is to take suggestions from Thomas to be applied 
> treewide, at the same time also take care of suggestions from 
> arch/subsytem maintainer/mailing list in the relevant patches, since 
> arch maintainers are the ones owning it.
> 

Thanks for the detailed explanation.

I had assumed that your intention was to find a consensus so that the 
whole tree could be consistently and automatically improved. My mistake.

> Sometimes had a feeling as though the changes in this series is akin to 
> cutting the foot to fit the shoe ;), but still went ahead as it was 
> legacy code, easier & less error prone. But now based on the overall 
> feedback, to proceed, i had to change.
> 

Not based on feedback from me I hope -- I have no veto in this case, as 
you can see from MAINTAINERS.

> Regards
> afzal
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> [2] https://lore.kernel.org/lkml/87sgiwma3x.fsf@nanos.tec.linutronix.de/
> 
