Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00E7206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B8IUPqy+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmsA1tHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgGBPO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgGBPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:14:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D33C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:14:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593702864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=AKOVYIcWkaX/V/hAAnCG+cs28AhmzZBR/oDllCvG+K8=;
        b=B8IUPqy+gsDD3bTBeQ+G4DKptxUsoSPCdbKAO/JZrJl/JtN75ayc/WAu+ZXtHdO2ZkuIFW
        DsWpomCnns21VS9IoA24JetK3pWr3JukH+TcqjQsAMYPyltQKvLE2YQMLehgA68rdwO4hW
        5sua8bDYQLCGZpODb669Uhv4jEzNQVjFX4nawJ9dUe3ql9BeFZ3YeVTwcH15YEZRrl6EKX
        QPL59CJSLd5Jagtzrf1GpcAMgFG9TjFOXW8PFDXgXeeUacGpolom73Ew8DGPoRK9wp3kGp
        VxnMc1YIA/OBudsRLG2676X10E0pOh7qXlrYTQPH06mSF/rTAM3fyjwikwc8pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593702864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=AKOVYIcWkaX/V/hAAnCG+cs28AhmzZBR/oDllCvG+K8=;
        b=zmsA1tHXa7IdUCAxVy66wOf8RimLsAuCGvAXd4WXTy0JdI1s6OG2SrjzQNoUB0utGHiqUv
        MWb6ugZsvb4aF9CQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
In-Reply-To: <20200702133219.GA27417@lenoir>
Date:   Thu, 02 Jul 2020 17:14:23 +0200
Message-ID: <87zh8irltc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> On Thu, Jul 02, 2020 at 03:21:35PM +0200, Thomas Gleixner wrote:
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> > @@ -883,7 +883,7 @@ static inline void forward_timer_base(struct timer_base *base)
>> >  	 * Also while executing timers, base->clk is 1 offset ahead
>> >  	 * of jiffies to avoid endless requeuing to current jffies.
>> >  	 */
>> > -	if ((long)(jnow - base->clk) < 2)
>> > +	if ((long)(jnow - base->clk) < 1)
>> >  		return;
>> 
>> The apparent reason is in the comment right above the condition ...
>
> Hmm, that's a comment I added myself in the patch before.

:)

> The following part:
>
>> >      * Also while executing timers, base->clk is 1 offset ahead
>> >      * of jiffies to avoid endless requeuing to current jffies.
>> >      */
>
> relates to situation when (long)(jnow - base->clk) < 0

This still is inconsistent with your changelog:

> There is no apparent reason for not forwarding base->clk when it's 2
> jiffies late

Let's do the math:

 jiffies = 4
 base->clk = 2

 4 - 2 = 2

which means it is forwarded when it's 2 jiffies late with the original
code, because 2 < 2.

The reason for this < 2 is historical and goes back to the oddities of
the original timer wheel before the big rewrite.

Thanks,

        tglx


