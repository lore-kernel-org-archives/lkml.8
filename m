Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5549220663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcHZUwlb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lgcsJg/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGIKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgGIKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:14:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E61C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:14:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594289676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/mCOxVYJ4n0oB0ZB0WRxwRIYUtbkPESeBsNlGw32VU=;
        b=JcHZUwlbAzZn59n3+yN2qodxJ3lXo0GrI5oMRjmNttGtwuZZTL+pWwyNo82Hv5YFTQcRnZ
        74wSZcrW37ELIkyKWhGUD9OUtH4KziXkYs2IUwMr9PrSxhKBvxNR57vkkSsMsupSJrvVd6
        FMz5MRSWEiEOQLIIRHcowfo8deS5AXkIPjJG10eCD3MYrMXwFSOxaCAMp+9zfFX0+omqE5
        DoSdkyZdU5EPCrZJ1eAV4dflFvt9q/4yToCBsXFm7+qTqpHnCO3HroxNuEVcxPigqrM7An
        QvS7HWWyc7ouOOxcagh3VWkY3ruryucuvLNTuOjIXFwuMyxOWX4tsrrJs7DEfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594289676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/mCOxVYJ4n0oB0ZB0WRxwRIYUtbkPESeBsNlGw32VU=;
        b=lgcsJg/Ol5HElM9gN1u7Y8VbHxigLDV3SpMTnjoW5I8C0OPC0U+CYniJVGBYfTWQ3juqq+
        x72gL/3ErLI711AA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
In-Reply-To: <20200709083323.GA572@jagdpanzerIV.localdomain>
References: <20200707145932.8752-5-john.ogness@linutronix.de> <20200709071411.GR3874@shao2-debian> <20200709083323.GA572@jagdpanzerIV.localdomain>
Date:   Thu, 09 Jul 2020 12:20:35 +0206
Message-ID: <874kqhm1v8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-09, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> On (20/07/09 15:14), kernel test robot wrote:
> [..]
>
> Took me a while to find the FAIL-ed test:
>
>> kmsg01.c:393: INFO: TEST: read returns EPIPE when messages get overwritten
>> kmsg01.c:398: INFO: first seqno: 0
>> kmsg01.c:411: INFO: first seqno now: 881
>> kmsg01.c:425: FAIL: read returned: 77: SUCCESS (0)
>
> So this is seq number related
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/logging/kmsg/kmsg01.c#L383

Excellent test.

Since the messages are above the expected average size, the dataring is
wrapping before the descriptor ring. This means that the initial
descriptors are still there, but their data is gone. Initially I would
generate an EPIPE for this, but it was changed. Here is the thread [0]
we had about this.

I have some ideas how to correctly handle this. Let me try some
alternatives and post a proposed solution.

John Ogness

[0] https://lkml.kernel.org/r/20200213090757.GA36551@google.com
