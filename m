Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1D4C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BCB20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEEUHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:07:46 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47001 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEEUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:07:46 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 89F51240008;
        Tue,  5 May 2020 20:07:44 +0000 (UTC)
Date:   Tue, 5 May 2020 22:07:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        Per =?iso-8859-1?Q?N=F8rgaard?= Christensen 
        <per.christensen@prevas.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: battery switch-over detection on pcf2127
Message-ID: <20200505200744.GV34497@piout.net>
References: <a0ed6b56-33b1-b5ab-00d1-268fcd61b754@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ed6b56-33b1-b5ab-00d1-268fcd61b754@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 21:54:47+0200, Rasmus Villemoes wrote:
> Hi Bruno
> 
> I just noticed your "rtc: pcf2127: add tamper detection support"
> (03623b4b04) from 5.4. Unfortunately, clearing the BTSE bit breaks a use
> case of ours:
> 
> We rely on the battery switch-over detection to distinguish a powerfail
> during boot from a PORESET by the external watchdog (in the latter case,
> the RTC is still powered throughout, meaning there is no battery
> switch-over event). OTOH, we do not use the tamper detection - in fact,
> the TS signal is unconnected on our board.
> 
> We're currently still on 4.19, but we will eventually upgrade to a
> kernel containing the above commit. So I was wondering if we could
> figure out a way that would work for both of us - either some CONFIG
> knob, or perhaps something in the device-tree. Any ideas?
> 

Yes, I was working on a patch series last week allowing to read BF. I'm
not sure clearing BTSE is your issue but clearing BF is.

I'm going to send it tonight, I'll copy you, let me now if that works
for you. You can then read BF using the RTC_VL_READ ioctl. The
RTC_VL_BACKUP_SWITCH flag will be set if a switchover happened.
The RTC_VL_CLR ioctl can be used to clear the flag.

I think clearing BTSE is still the right thing to do.

Regards,

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
