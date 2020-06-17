Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD31207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFQO1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:27:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E5C06174E;
        Wed, 17 Jun 2020 07:27:40 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlZ2M-0002bW-7s; Wed, 17 Jun 2020 16:27:34 +0200
Date:   Wed, 17 Jun 2020 16:27:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200617142734.mxwfoblufmo6li5e@linutronix.de>
References: <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzbh482.fsf@gmx.net>
 <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net>
 <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rmesqkk.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-16 22:28:43 [+0200], Stephen Berman wrote:
> Your assessment and predictions are right on the mark!
perfect.

> I'm fine with the thermal.tzp=300 workaround, but it would be good to
> find out why this problem started with commit 6d25be57, if my git
> bisection was correct, or if it wasn't, then at least somewhere between
> 5.1.0 and 5.2.0.  Or can you already deduce why?  If not, I'd be more
> than happy to continue applying any patches or trying any suggestions
> you have, if you want to continue debugging this issue.  In any case,
> thanks for pursuing it to this point.

I have no idea why the commit in question should make any difference.
Could please apply the tracing patch on v5.1 and send the trace?

> Steve Berman

Sebastian
