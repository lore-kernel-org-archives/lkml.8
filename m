Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE40EC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF7A20767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDWSt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWSt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B20C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:49:57 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRgv5-0003Lu-Qo; Thu, 23 Apr 2020 20:49:55 +0200
Date:   Thu, 23 Apr 2020 20:49:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
Message-ID: <20200423184955.c7yij2hg7a2ftsfa@linutronix.de>
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
 <20200423171029.GS17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423171029.GS17661@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-23 10:10:29 [-0700], Paul E. McKenney wrote:
> > Curious if this was already on anyone's radar?
> 
> Looks like __queue_work() is attempting to acquire a normal spinlock_t
> with interrupts disabled, which -rt doesn't like much.  And I believe
> that lockdep has been upgraded to check for this.
> 
> Adding Sebastian for his thoughts.

This is known. There is more than just workqueue in this regard. Please
disable CONFIG_PROVE_RAW_LOCK_NESTING until this is fixed (see Kconfig
help). Except for workqueue, there is also printk which triggers the
same warning and isn't as easy to fix as workqueue.

> 							Thanx, Paul

Sebastian
