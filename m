Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C11E20899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593735145;
	bh=WS+4Jtb8oKnOh/+J4eJZfroFhwbdunk5YRezs14kUj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u/xz4S6rzPdCs8g7bXI+VJ8b6gkLqp/4fj80p+4Aj7RO3d2MRmDDjXKA5x/upKqGb
	 tYhV3z9ZO7q6Ji7c86WFdRtiqcp5s5KduhAxFdFGnMocShiQrokmIdOa41I8Ncnw/X
	 BdKmIX/mOFOSGVRACkBmzYCS9CmE0QsOS5BO/9m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGCAMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:12:24 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCCF20772;
        Fri,  3 Jul 2020 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593735143;
        bh=WS+4Jtb8oKnOh/+J4eJZfroFhwbdunk5YRezs14kUj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gmpmSRdGEmlDIoSMAJA1MIoT7pgCSEprj3os4mzKCgTkD/IA5sIrh/7UlVH1RVcM
         1lM768Ye6imd78NEmcFhKP5ofPiVNmDuD4S9hudw5HEQzA3D99vscnRn6mc27OUAql
         LF71SdfzWDkn7SrUn/ygUM3U75TNViQhLreUp7zc=
Date:   Fri, 3 Jul 2020 02:12:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
Message-ID: <20200703001219.GD27417@lenoir>
References: <20200702133219.GA27417@lenoir>
 <87zh8irltc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh8irltc.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:14:23PM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> > On Thu, Jul 02, 2020 at 03:21:35PM +0200, Thomas Gleixner wrote:
> > The following part:
> >
> >> >      * Also while executing timers, base->clk is 1 offset ahead
> >> >      * of jiffies to avoid endless requeuing to current jffies.
> >> >      */
> >
> > relates to situation when (long)(jnow - base->clk) < 0
> 
> This still is inconsistent with your changelog:

Right.

> 
> > There is no apparent reason for not forwarding base->clk when it's 2
> > jiffies late
> 
> Let's do the math:
> 
>  jiffies = 4
>  base->clk = 2
> 
>  4 - 2 = 2
> 
> which means it is forwarded when it's 2 jiffies late with the original
> code, because 2 < 2.
> 
> The reason for this < 2 is historical and goes back to the oddities of
> the original timer wheel before the big rewrite.

Ok. And is it still needed today or can we now forward even with a 1 delta?
